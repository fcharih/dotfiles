import sys
import os
import subprocess as sp

import boto3

session = boto3.Session(profile_name='nuvobio')
ec2client = session.client("ec2")

class Instance(object):
    def __init__(self, instance_data):
        self.id = instance_data['InstanceId']
        self.reservation_type = 'spot' if 'SpotInstanceRequestId' in instance_data.keys() else 'reserved'
        self.instance_type = instance_data['InstanceType']
        self.name = instance_data['Tags'][0]['Value']
        self.state = instance_data['State']['Name']
        self.public_dns = instance_data['NetworkInterfaces'][0]['Association']['PublicDnsName'] if 'Association' in instance_data['NetworkInterfaces'][0] else None


def get_spot_instances():
    instance_ids = []
    spot_instance_requests = ec2client.describe_spot_instance_requests()['SpotInstanceRequests']
    for request in spot_instance_requests:
        instance_ids.append(request['InstanceId'])
    results = [x for x in ec2client.describe_instances(InstanceIds=instance_ids)["Reservations"][0]['Instances']]
    instances = [Instance(instance_data) for instance_data in results]
    return instances

def get_reserved_instances():
    results = [x["Instances"][0] for x in ec2client.describe_instances()["Reservations"]]
    reserved_results = [inst for inst in results if 'SpotInstanceRequestId' not in inst.keys()]
    instances = [Instance(instance_data) for instance_data in reserved_results]
    return instances

def get_all_instances():
    return get_reserved_instances() + get_spot_instances()

def list_instances(instances):
    print("====== INSTANCE STATUSES ========")
    for i, instance in enumerate(instances):
        line = f"{i + 1} - {instance.name} ({instance.reservation_type}) - {instance.state} - {instance.public_dns}"
        print(line)
    print("=================================")

def select_instance(instances, prompt):
    list_instances(instances)

    print(prompt)

    choice = int(input(">"))
    return instances[choice - 1]


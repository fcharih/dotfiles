#! /bin/bash -l
ssh $(squeue --me --name=tunnel --states=R -h -O NodeList)

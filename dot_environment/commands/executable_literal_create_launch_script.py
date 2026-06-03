#! /usr/bin/env python3
def create_job_script(job, gpus=0, cpus=64, time='0-12:00', memory=128000, log_path=None, modules=['python/3.11', 'apptainer']):
    script = '#! /bin/bash\n'
    script += '#SBATCH --account=def-jrgreen\n'
    script += f'#SBATCH --gpus-per-node={gpus}\n'
    script += f'#SBATCH --time={time}\n'
    script += f'#SBATCH --mem={memory}\n'
    script += f'#SBATCH --cpus-per-task={cpus}\n'

    if log_path:
        script += f'#SBATCH --output={log_path}\n'

    else:
        script += f'#SBATCH --output=$HOME/logs/%i-%j.log\n'

    script += '\n\n'
    script += 'export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK\n\n'

    script += '\n'.join(['module load ' + m for m in modules])
    script += '\n\n'

    script += job

    return script

if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument('-g', '--num_gpus', type=str, required=False, default=0, help='Number of GPUs to allocated to job.')
    parser.add_argument('-o', '--modules', type=str, required=False, nargs='*', help='Modules to load prior to running the job.')
    parser.add_argument('-t', '--time', type=str, required=False, default='0-12:00', help='Time to allocate to task (format: days-hours:minutes, default: `0-12:00`).')
    parser.add_argument('-m', '--memory', type=int, required=False, default=128000, help='Memory in MB to allocate to job.')
    parser.add_argument('-c', '--num_cpus', type=int, required=False, default=64, help='Number of CPUs to allocate to job.')
    parser.add_argument('-l', '--log_path', type=str, required=False, help='Path to the log file created for the job.')
    args = vars(parser.parse_args())

    print(create_job_script(''))

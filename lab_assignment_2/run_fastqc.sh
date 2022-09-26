#!/bin/bash --login
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --job-name run_fastqc.sh
#SBATCH --output=%x-%j.SLURMout

#change to current working directory
cd ~/plb812

#add conda environment to the path
export PATH="${HOME}/miniconda3/envs/plb812/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/miniconda3/envs/plb812/lib:${LD_LIBRARY_PATH}"

#run fastqc
fastqc -o ~/plb812 -t 6 *fastq.gz

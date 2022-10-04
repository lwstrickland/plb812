#!/bin/bash --login
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --job-name attempt_trimmomatic_fastqc.sh
#SBATCH --output=%x-%j.SLURMout

#change to current working directory
cd ~/plb812/

#add conda environment to the path
export PATH="${HOME}/miniconda3/envs/plb812/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/miniconda3/envs/plb812/lib:${LD_LIBRARY_PATH}"

#assign variable to fastq.gz datasets
Bdistachyon_fastq="SRR8618232 SRR8618233 SRR8618234 SRR8618235 SRR8618236 SRR8618237"

#use a for loop to trim using trimmomatic, then run fastqc on trimmed files
for i in ${Bdistachyon_fastq}
do
        #run trimmomatic on fastq.gz datasets
        trimmomatic PE -phred33 -threads 6 ${i}_1.fastq.gz ${i}_2.fastq.gz ${i}_1_paired.fastq.gz ${i}_1_un.fastq.gz ${i}_2_paired.fastq.gz ${i}_2_un.fastq.gz ILLUMINACLIP:~/miniconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa:2:30:10 MINLEN:30

	#run fastqc
	fastqc -o ~/plb812/lab_assignment_3 -t 6 ${i}_1_paired.fastq.gz ${i}_2_paired.fastq.gz
done

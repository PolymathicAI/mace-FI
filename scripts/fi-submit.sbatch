#!/bin/bash -l

#SBATCH -p gpu
#SBATCH -J "mace_run_full"
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
#SBATCH --gpus-per-node=8
#SBATCH --cpus-per-gpu=8
#SBATCH --mem=800G
#SBATCH --output=logs/mace-%j.log
#SBATCH --time=168:00:00

export num_workers=$(expr $SLURM_JOB_CPUS_PER_NODE - 1)
export OMP_NUM_THREADS=${SLURM_CPUS_ON_NODE}

# some debugging logs
# export WANDB_START_METHOD=thread
export NCCL_DEBUG=INFO
export CUDA_LAUNCH_BLOCKING=1.

# Load running environment
source .local/env.sh

srun $@ 

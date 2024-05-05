#!/usr/bin/env bash

function 1_pull_tensorflow_container() {
  if [ "${1:-default_gpu_option}" == 'gpu' ]
  then
    gpu_option='-gpu'
  fi
  docker pull tensorflow/tensorflow:latest$gpu_option-jupyter
}

function 2_install_packates() {
  cat ./requirements.txt | xargs poetry add
}

function 3_install_ipynb_kernel() {
  $(peotry env info --path)/bin/python -m pip install ipykernel -U --force-reinstall
}

function 4_start_tensorflow_container() {
  if [ "${1:-default_gpu_option}" == 'gpu' ]
  then
    gpu_option='-gpu'
  fi
  docker run --gpus all -p 8888:8888 tensorflow/tensorflow:latest$gpu_option-jupyter
}


# main
exec_at=$(pwd)
cd $(dirname $0)
base_dir="$(pwd)"
run_at="$base_dir"
cd - > /dev/null

# environment variables
ref_url='https://www.youtube.com/watch?v=cCDu5i6UQEM'
# enable_dry_run=True  # TODO, for dry run, default is False.  PS. Exec command by using 'cmd_helper'
# _cron_period='0 0 * * *'  # TODO, for cron set up, default period is '0 0 * * *'
# _cron_method='run_cron'  # TODO, for cron set up, default method is run_cron

default_gpu_option=""

# invoke .helper
source /usr/local/bin/.helper

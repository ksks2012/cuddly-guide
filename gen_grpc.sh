# /bin/bash
# From https://juejin.cn/post/7083780606844207117
# set python environment
export VENV_PREFIX=""
if [ -d 'venv' ] ; then
    export VENV_PREFIX="venv/bin/"
fi
if [ -d '.venv' ] ; then
    export VENV_PREFIX=".venv/bin/"
fi
if [ -d 'rtsandbox' ] ; then
    export VENV_PREFIX="rtsandbox/bin/"
fi


echo 'use venv path:' ${VENV_PREFIX}

# setting target of python auto-generated code from protobuf
target_p='grpc_common'
# setting path of protobuf
source_p='protobuf'
# setting file name of protobuf file
service_list=("book" "user")

# cleaning previous auto-generated code
rm -rf "${target_p:?}/${source_p:?}"*
# create folder
mkdir -p "${target_p:?}/${source_p:?}"

# bash process
for service in "${service_list[@]}"
do
  # generate python from each proto
  mkdir -p "${target_p:?}/${source_p:?}/${service:?}"
  echo  "### from proto file:" $source_p/"$service"/*.proto "gen proto py file to" $target_p/$source_p
  ${VENV_PREFIX}python3 -m grpc_tools.protoc \
    --mypy_grpc_out=./$target_p \
    --mypy_out=./$target_p \
    --python_out=./$target_p \
    --grpc_python_out=./$target_p \
    -I. \
    $source_p/"$service"/*.proto

  # create init file to set folder as module
  touch $target_p/$source_p/"$service"/__init__.py
  # fix grpc tools bug
  sed -i "s/from protos.$service import/from . import/" $target_p/$source_p/$service/*.py
done
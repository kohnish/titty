#!/bin/sh
set -eu
source_dir=${1:-`git rev-parse --show-toplevel`}
no_install=${2:-0}
build_dir=`pwd`

root_dir=real_root
proj_dir=$root_dir/titty
bin_dir=$root_dir/bin
dest_dir=$build_dir/pip

rm -rf $root_dir
rm -rf $dest_dir

mkdir -p $proj_dir
mkdir -p $bin_dir

cp -Rp ${source_dir}/kitty $proj_dir
cp -p ${source_dir}/__main__.py $proj_dir/
cp -p ${source_dir}/__init__.py $proj_dir/
cp -p ${source_dir}/real_setup.py $root_dir/setup.py

cp -p ${build_dir}/kitty/libkitty.so $proj_dir/kitty/fast_data_types.so
cp -p ${build_dir}/glfw/libglfw.so $proj_dir/kitty/glfw-wayland.so

if [[ $no_install != 1 ]]; then
    sh -c "cd $root_dir && python setup.py install --prefix=$dest_dir"
fi
#sh -c "cd $root_dir && python setup.py install --user"
#sh -c "cd $root_dir && python setup.py build bdist"
#sh -c "cd $root_dir && python setup.py build sdist"
#sh -c "cd $root_dir && python setup.py bdist_rpm"

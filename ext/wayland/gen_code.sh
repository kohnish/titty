#!/bin/sh
set -ex
gen_cmd=$1
in_dir=$2
out_dir=$3
project_inc_dir=$4

rm -rf $out_dir
mkdir -p $out_dir
mkdir -p $project_inc_dir

xdg_shell_protoco_path=$in_dir/stable/xdg-shell/xdg-shell.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-xdg-shell-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-xdg-shell-client-protocol.c

xdg_shell_protoco_path=$in_dir/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-xdg-decoration-unstable-v1-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-xdg-decoration-unstable-v1-client-protocol.c

xdg_shell_protoco_path=$in_dir/unstable/relative-pointer/relative-pointer-unstable-v1.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-relative-pointer-unstable-v1-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-relative-pointer-unstable-v1-client-protocol.c

xdg_shell_protoco_path=$in_dir/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-pointer-constraints-unstable-v1-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-pointer-constraints-unstable-v1-client-protocol.c

xdg_shell_protoco_path=$in_dir/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-idle-inhibit-unstable-v1-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-idle-inhibit-unstable-v1-client-protocol.c

xdg_shell_protoco_path=$in_dir/unstable/primary-selection/primary-selection-unstable-v1.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-primary-selection-unstable-v1-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-primary-selection-unstable-v1-client-protocol.c

xdg_shell_protoco_path=$in_dir/unstable/text-input/text-input-unstable-v3.xml
$gen_cmd client-header $xdg_shell_protoco_path $out_dir/wayland-text-input-unstable-v3-client-protocol.h
$gen_cmd private-code $xdg_shell_protoco_path $out_dir/wayland-text-input-unstable-v3-client-protocol.c

cp $out_dir/*.h $project_inc_dir/

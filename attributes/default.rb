#
# Cookbook Name:: osx_installer
# Attributes:: default
#
default[:osx_installer][:target] = '/'
default[:osx_installer][:cache_dir] = Chef::Config[:file_cache_path]

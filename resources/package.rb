#
# Cookbook Name:: osx_installer
# Resource:: package
#

actions [:install, :info]

attribute :name, :kind_of => String, :name_attribute => true
attribute :destination, :kind_of => String, :default => '/'
attribute :source, :kind_of => String, :default => ''
attribute :verbose, :kind_of => [TrueClass, FalseClass], :default => false
attribute :filename, :kind_of => String, :default => nil
attribute :is_remote, :kind_of => [TrueClass, FalseClass], :default => false
attribute :search_paths, :kind_of => Array, :default => [
  Chef::Config[:file_cache_path]
]
attribute :package_extension, :kind_of => String, :default => 'pkg'

def initialize(name, run_context=nil)
  super
  @action = :install
end

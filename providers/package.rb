require 'uri'
#

# Cookbook Name:: osx_installer
# Provider:: package

def load_current_resource
  new_resource.filename(new_resource.name) unless new_resource.filename
  new_resource.is_remote(true) if URI.parse(new_resource.source).scheme
end

action :install do
  add_cache_path_to_search_paths!

  Chef::Log.debug("#{self.class.name} search_paths: #{new_resource.search_paths.inspect}")

  Chef::Log.debug("#{self.class.name} installing: #{package_path}")
  Chef::Log.debug("#{self.class.name} install destination: #{new_resource.destination}")

  installer_command = "installer -pkg '#{package_path}' -target '#{new_resource.destination}'"
  installer_command << " -verbose" if new_resource.verbose
  execute "install-#{new_resource.filename}" do 
    command installer_command
    action :nothing
  end

  if new_resource.is_remote
    remote_file package_path() do
      Chef::Log.debug("#{self.class.name} fetching:  #{new_resource.source}")
      source new_resource.source
      notifies :run, resources(:remote_file => "install-#{new_resource.filename}"), :immediately
    end
  end
end

def add_cache_path_to_search_paths!
  unless new_resource.search_paths.include?(Chef::Config[:file_cache_path])
    new_resource.search_paths << Chef::Config[:file_cache_path]
  end
end

def package_path
  if new_resource.is_remote
    ::File.join(Chef::Config[:file_cache_path], new_resource.filename)
  else
    new_resource.filename
  end
end

action :info do

end

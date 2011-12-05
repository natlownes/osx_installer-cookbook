require 'uri'
#

# Cookbook Name:: osx_installer
# Provider:: package

def load_current_resource
  new_resource.filename(new_resource.name) unless new_resource.filename
end

action :install do
  Chef::Log.debug("#{self.class.name} search_paths: #{new_resource.search_paths.inspect}")

  osx_pkg_filepaths = []
  new_resource.search_paths.each do |search_path|
    search_path = ::File.expand_path(search_path)
    Dir["#{search_path}/**/*#{new_resource.package_extension}"].each do |path|
      if ::File.basename(path) == new_resource.filename
        Chef::Log.debug("#{self.class.name} found: #{path}")
        osx_pkg_filepaths << ::File.expand_path(path)
      end
    end
  end

  Chef::Log.debug("#{self.class.name} pkg NOT found...continuing...") if osx_pkg_filepaths.empty?

  osx_pkg_filepaths.each do |package_path|
    Chef::Log.debug("#{self.class.name} installing: #{package_path}")
    Chef::Log.debug("#{self.class.name} install destination: #{new_resource.destination}")

    installer_command = "installer -pkg '#{package_path}' -target '#{new_resource.destination}'"
    installer_command << " -verbose" if new_resource.verbose
    execute installer_command
  end
end

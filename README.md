Description
===========

Install OS X *pkg 

Requirements
============

Platform: Mac OS X

Resources and Providers
=======================

`osx_installer_package`
-------------

This resource will install an OSX Installer Package:  http://en.wikipedia.org/wiki/Installer_(Mac_OS_X)

# Actions:

* :install - Installs the application.

# Parameter attributes:

* `name` - This is the filename of the pkg.

* `destination` - The 'target' of the install.  **This defaults to '/'** Maps to the -target option of the installer.  From the man page, it can be:
  1. One of the domains returned by -dominfo.
  2. Device node entry.  Any entry of the form of /dev/disk*.  ex: /dev/disk2
  3. The disk identifier.  Any entry of the form of disk*.  ex: disk1s9
  4. Volume mount point.  Any entry of the form of /Volumes/Mountpoint.   ex: /Volumes/Untitled
  5. Volume UUID.  ex: 376C4046-083E-334F-AF08-62FAFBC4E352
  
* `source` - This can be a URL of a package, which will be downloaded to your file_cache_path

* `verbose` - Verbose output from `installer`.

* `filename` - Manually set the filename of the pkg.  If not set, the :name attribute is used.

* `search_paths` - Specify an array of full paths where your pkg might reside.  By default this is your `file_cache_path`.

* `package_extension` - Defaults to 'pkg'.  This default will catch packages with an mpkg or ipkg extension and can almost always be left alone.

Usage Examples
==============

Install R for OS X from the download site:

    osx_installer_package 'R-2.13.0.pkg' do
      source 'http://cran.r-project.org/bin/macosx/R-2.13.0.pkg'
      action :install
    end

Verbosely install a pkg you have downloaded to a specified search path:

    osx_installer_package 'Silverlight.pkg' do
      verbose true
      search_paths ['/Users/nat/Downloads/']
    end


To do
=====
* Allow source attribute to be a local filepath(?)


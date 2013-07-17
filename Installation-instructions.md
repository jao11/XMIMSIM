* **[Compiling from source](#compilefromsource)**
* **[Linux binary packages](#linuxpackages): [Fedora, Centos and Scientific Linux](#rpmpackages) and [Debian and Ubuntu](#debpackages)**
* **[Windows installer](#windowsbinaries)**
* **[Mac OS X](#macosx)**

## <a id="compilefromsource"></a>Compiling from source

XMI-MSIM has been successfully built on Linux (Debian/Ubuntu and RHEL/CentOS/Fedora), Mac OS X (Snow Leopard and up) and Windows 7 (with 32-bit compilers)

The following dependencies are required to build XMI-MSIM:

* fortran 2003 compiler (gfortran >= 4.4, Intel Fortran are known to work) 
* C compiler with OpenMP support (gcc highly recommended)
* GNU scientific library (GSL)
* HDF5
* libxml2
* libxslt
* Fortran GSL bindings (FGSL)
* xraylib (including Fortran bindings)
* glib2
* GTK2 and GTK-EXTRA (version 3.0.4) for the graphical user interface (optional though highly recommended)
* optional for the GUI: curl and json-glib
* MPI (OpenMPI or Intel MPI): optional. Recommended for those that want to perform brute-force simulations with a very high number of simulated photons


All dependencies should be easy to obtain, except for FGSL which is available from the Download section as well. Do not use the [official version](http://www.lrz.de/services/software/mathematik/gsl/fortran) , it will not work when used in combination with XMI-MSIM. [xraylib](http://github.com/tschoonj/xraylib) can be obtained at my repository. Windows users will have to compile most of these dependencies themselves, which will require them to install a bash shell with all basic UNIX utilities. The Windows versions of XMI-MSIM were built using MSYS (bash shell and GNU utilities) and TDM-GCC (compilers).

It is absolutely critical that all Fortran packages are compiled with exactly the same compiler, and this compiler also needs to be used when building XMI-MSIM.

### Compilation stages

Unpack the tarball:

    tar xvfz xmimsim-x.y.tar.gz
    cd xmimsim-x.y

Configure the source tree by examining the capabilities of the host system:

    ./configure

The configure command has a long list of options. You can have a look at them by executing:

    ./configure --help

A commonly used option is to change the installation destination: this can be accomplished by using the `--prefix` option.
If your Fortran compiler does not have a standard name, you may have to specify it as an option to configure such as `FC=gfortran-mp-4.4`. Packages that are not installed in default locations, may not be detected by the configure script and could result in the configure script aborting prematurely. This is particularly likely for packages like xraylib and/or fgsl that are installed in /usr/local. Such a problem can be avoided by setting the PKG_CONFIG_PATH environment variable manually:

    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

If the configure script terminates without error, try building the code by running:

    make

It is not recommended to invoke make with the -j option, as it may confuse the fortran compiler.

After compilation, install the program using:

    make install

This may have to be executed with root privileges.

### Preparing the precompiled dataset

XMI-MSIM loads, before running a simulation, datasets of precomputed physical data into memory, depending on the exact parameters in the input file. These datasets are mostly inverse cumulative distribution functions of scattering cross-sections, which would be very computationally expensive to calculate during the simulation itself based on the corresponding probability density functions.

This file is generated using the `xmimsim-db` executable, which produces a file called `xmimsimdata.h5` in the current working directory. After this file is created, which can take up to half an hour on slower machines, copy it to the data folder of your XMI-MSIM installation. Assuming the default installation destination was not altered, this would be /usr/local/share/xmimsim.

### Note on the random number generators

XMI-MSIMs random number generators are seeded on Mac OS X and Linux using high quality noise produced by /dev/urandom. The seeds can be collected in two ways:

1. The user launches the `xmimsim-harvester` daemon, which will collect seeds at frequent intervals and pass them along to XMI-MSIM when requested. The daemon is ideally started at boottime (using some initd script), or on Mac OS X, by copying the `be.ugent.xmi.harvester.plist` file from its installation location (_prefix_/Library/LaunchDaemons) to /Library/LaunchDaemons and subsequently invoking `sudo launchctl load /Library/LaunchDaemons/be.ugent.xmi.harvester.plist`. It should be noted that the daemon is buggy, and it is generally not recommended to use this solution.
2. If the daemon is not running, then a separate thread is launched in XMI-MSIM at runtime which takes care of harvesting the seeds (a bit slower, but reliable).

## <a id="linuxpackages"></a>Linux

### <a id="rpmpackages"></a>Fedora, Centos, Scientific Linux

To facilitate the installation on RPM based Linux distributions, the package includes a spec file which can be used to produce RPM packages for linux distributions that support them (Fedora, Red Hat etc). The developers have built 64-bit RPM packages of XMI-MSIM for the Fedora 16-19 and Redhat EL/CentOS/Scientific Linux 6 distributions. These can be downloaded from the RPM repository that is hosted by the X-ray Microspectroscopy and Imaging research group of Ghent University. Access to this repository can be obtained as follows for Fedora distros:

> `su -c 'rpm -Uvh http://lvserver.ugent.be/yum/xmi-repo-key-fedora.noarch.rpm`

and for Red Hat EL based distributions:

> `su -c 'rpm -Uvh http://lvserver.ugent.be/yum/xmi-repo-key-redhat.noarch.rpm`

The XMI-MSIM packages themselves can then be downloaded using yum:

> `su -c 'yum install xmimsim'`

Updates can be installed in a similar way:

> `su -c 'yum update xmimsim'`

### <a id="debpackages"></a>Debian and Ubuntu

Packages were created for Debian and Ubuntu. Currently the following flavors are supported: Debian Squeeze, Ubuntu 12.04 Precise (LTS), Ubuntu 12.10 Quantal and Ubuntu 13.04 Raring.
In order to access these packages using your favorite package manager, execute the following command to import our public key:

> `curl http://lvserver.ugent.be/apt/xmi.packages.key | sudo apt-key add -`

Next, add the package download location corresponding to your distribution to the /etc/apt/sources.list file (as root):

Debian Squeeze:

       deb http://lvserver.ugent.be/apt/debian squeeze stable
       deb-src http://lvserver.ugent.be/apt/debian squeeze stable

Ubuntu Precise 12.04:

       deb [arch=amd64] http://lvserver.ugent.be/apt/ubuntu precise stable
       deb-src http://lvserver.ugent.be/apt/ubuntu precise stable

Ubuntu Quantal 12.10:

       deb [arch=amd64] http://lvserver.ugent.be/apt/ubuntu quantal stable
       deb-src http://lvserver.ugent.be/apt/ubuntu quantal stable

Ubuntu Raring 13.04:

       deb [arch=amd64] http://lvserver.ugent.be/apt/ubuntu raring stable
       deb-src http://lvserver.ugent.be/apt/ubuntu raring stable

When the sources.list file contains the correct download locations, update the apt cache by running:

> `sudo apt-get update`

After this, one can install XMI-MSIM by executing the following command:

> `sudo apt-get install xmimsim`

## <a id="windowsbinaries"></a>Windows

An installer containing the 32-bit binaries of XMI-MSIM for the Windows platform can be found in the [Downloads](http://lvserver.ugent.be/xmi-msim) section. It will download and install _xraylib_ if necessary.

## <a id="macosx"></a>Mac OS X

A [dmg](http://lvserver.ugent.be/xmi-msim) file has been created containing an application bundle which integrates nicely within Mac OS X, through the use of some dedicated API's. The provided app will run on Mac OS X Snow Leopard, Lion and Mountain Lion (all 64-bit only).
After downloading, mount the dmg file and drag the XMI-MSIM app to the Applications folder.

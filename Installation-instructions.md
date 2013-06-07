* **[Compiling from source](#compilefromsource)**
* **[Linux binary packages](#linuxpackages): [Fedora, Centos and Scientific Linux](#rpmpackages) and [Debian and Ubuntu](#debpackages)**
* **[Windows installer](#windowsbinaries)**
* **[Mac OS X](#macosx)**

## <a id="compilefromsource"></a>Compiling from source

The followind dependencies are required to build XMI-MSIM:

* fortran 2003 compiler (gfortran >= 4.4, Intel Fortran are known to work) 
* ANSI C compiler (gcc for example)
* GNU scientific library (GSL)
* HDF5
* libxml2
* libxslt
* Fortran GSL bindings (FGSL)
* xraylib (including Fortran bindings)
* glib2
* GTK2 and GTK-EXTRA (version 3.0.4) for the graphical user interface (optional though highly recommended)
* optional for the GUI: curl and json-glib

All dependencies should be easy to obtain, except for FGSL which is available from the Download section as well. Do not use the [official version](http://www.lrz.de/services/software/mathematik/gsl/fortran) , it won't work when used in combination with XMI-MSIM.

[xraylib](http://github.com/tschoonj/xraylib) can be obtained at my repository...

A pdf has been added to the [Download section](http://lvserver.ugent.be/xmi-msim) with more complete compilation instructions.

## <a id="linuxpackages"></a>Linux

### <a id="rpmpackages"></a>Fedora, Centos, Scientific Linux

To facilitate the installation on RPM based Linux distributions, the package includes a spec file which can be used to produce RPM packages for linux distributions that support them (Fedora, Red Hat etc). The developers have built 64-bit RPM packages of XMI-MSIM for the Fedora 16/17/18 and Redhat EL/CentOS/Scientific Linux 6 distributions. These can be downloaded from the RPM repository that is hosted by the X-ray Microspectroscopy and Imaging research group of Ghent University. Access to this repository can be obtained as follows for Fedora distros:

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

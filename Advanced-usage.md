In this section, we will describe some more advanced features of XMI-MSIM, which may useful for some users with specific needs.

* **[X-ray sources](#x-ray-sources)**
* **[Batch simulations](#batch-simulations)**
* **[Generate XRMC input-files](#generate-xrmc-input-files)**
* **[XMI-MSIM file manipulation with XPath and XSLT](#xmi-msim-file-manipulation-with-xpath-and-xslt)**
* **[Custom detector response functions](#custom-detector-response-functions)**


## X-ray sources

In the [_Excitation_ section](#excitation), we have shown how one can introduce the necessary components of the X-ray excitation spectrum, through a number of discrete energies and intervals of continuous energies. XMI-MSIM tries to facilitate the process of defining the excitation spectrum through its _X-ray sources_ dialog, which can be invoked by clicking the corresponding button (with the radiation warning symbol) in the toolbar. Currently two types of sources can be defined this way: X-ray tubes and radionuclides. Switching between both types can be accomplished easily by clicking on the desired tab in the dialog.

After adjusting the required parameters of the selected source, click _Update spectrum_ to obtain a new excitation spectrum in the plot window. Using _Export spectrum_, it is possible to save the generated spectrum to an ASCII file, while _Save image_ will allow the user to save the plot window to an image file.
Clicking _About_ will display some information regarding the origins of the model or dataset. 
Using the _Ok_ button one can close the window while replacing the contents of the _Excitation_ section with the newly generated spectrum.

### X-ray tube spectrum generator

In many cases, one will perform X-ray experiments using an X-ray tube generator as source, which corresponds to a combination of discrete part (the anode element specific XRF lines) and a continuous part (the Bremsstrahlung generated through electron-nucleus interactions). Such excitation spectra are typically quite difficult to obtain experimentally and instead one relies quite often on theoretical calculations to obtain (an approximation) of the spectrum. One popular model is the one derived by Horst Ebel in his manuscripts [X-ray Spectrometry 28 (1999), 255-266](http://dx.doi.org/10.1002/(SICI)1097-4539(199907%2F08)28%3A4%3C255%3A%3AAID-XRS347%3E3.0.CO%3B2-Y) and [X-ray Spectrometry 32 (2003), 46-51](http://dx.doi.org/10.1002/xrs.610). XMI-MSIM's implementation of this model is based on the similar dialog in PyMca. The X-ray tube dialog should be similar to the following screenshot (click the _X-ray tube_ tab if the _Radionuclide_ panel showing):

![Introducing the X-ray tube parameters](../wiki/figures/26ebelgenerator.png)

By changing the different parameters to values appropriate for the X-ray tube that the user would like to simulate, one obtains an **approximate** model for the corresponding X-ray tube excitation spectrum. The following parameters can be changed:

* _Tube voltage_: the voltage in kV at which the X-ray tube is supposed to operate. This will determine the extent of the Bremsstrahlung contribution and through this which XRF lines (discrete energies) that will be present in the spectrum.
* _Tube current_: the current in mA at which the X-ray tube is supposed to operate. The this value is directly proportional to the intensity of the spectrum components.
* _Tube solid angle_: the solid angle in sr (steradian) under which the beam emerges from the X-ray tube. The default value here is determined by the _Source-slits distance_ and the _Slits size_, taken from the [_Geometry_ section].
* _Electron incidence angle_ and _X-ray tube take-off angle_: X-ray tube geometry parameters
* _Interval width_: the width of the continuous energy intervals of Bremsstahlung part of the spectrum. Decreasing this value will lead to a better simulation, but will increase the computational time.
* _Anode_: the material that the tube anode is made of. The density and the thickness become sensitive when _Transmission tube_ is activated.
* _Window_ and _Filter_: tube filtration materials. Set the thickness and/or the density to zero to ignore.
* _Transmission tube_: activating this option effectively places the tube exit-window on the opposite side of the anode with respect to the cathode, thereby operating in transmission mode.
* _Transmission efficiency file_: it is possible to load a two column ASCII file (first column energies and second column efficiencies between 0 and 1), with at least 10 lines that will be used to multiply the generated intensities and intensity densities with using interpolation of the supplied efficiencies.


### Radionuclides

A second type of X-ray sources offered by XMI-MSIM concerns radionuclides. Through xraylib's [radionuclide](https://github.com/tschoonj/xraylib/wiki/The-xraylib-API-list-of-all-functions#radionuclides) API, one can gain access to the excitation profiles (X- and gamma-rays) of several radionuclides that are commonly used as X-ray sources. After clicking on the _Radionuclide_ tab, the following dialog should be visible:

![Introducing the radionuclide parameters](../wiki/figures/34radionuclide.png)

The following parameters will determine the excitation spectrum:

* _Radionuclide_: select the desired radionuclide
* _Activity_: set the activity (disintegrations per second) of the radionuclide, as well as its unit (mCi, Ci, Bq, GBq)

Clicking the _Ok_ button will produce a dialog asking whether to add the radionuclide to the excitation spectrum or to replace it entirely. Clicking _Add_ allows the user ultimately to define a source composed of several radionuclides, which may be useful when the different sources are positioned on a ring, positioned perpendicular to the detector axis.

## Batch simulations

XMI-MSIM version 3.0 introduced the possibility to perform batch simulations.
Activate this feature by clicking the _Batch mode_ button in the toolbar. This will produce a filechooser dialog as shown in the following screenshot:

![Select one or more files to enter the batch simulation mode](../wiki/figures/28batchfileselection.png)

At this point it becomes very important to distinguish between two different possible outcomes that depend on whether the user selects either one or multiple files.

### Batch simulations: simulate a number of unrelated input-files

If the user has selected multiple files, then these files will be used as input-files for a round of successive unrelated simulations. After the file selection, the user will be presented with a dialog containing a question regarding whether the options should be set for each input-file separately. The options refer to the same options that can be seen in the [_Control panel_](#control-panel) of the main interface window. Either way, after setting the options, one will end up with the _Batch simulation controls_ window:

![Batch simulation controls](../wiki/figures/29batchcontrols.png)

Similar to the _Control panel_ of the main interface window, this widget features _Play_, _Stop_ and _Pause_ to control the execution. The number of threads that will be used for the simulations may be set using the CPUs slider. During execution, all output will be shown in the central area. The verbosity level can be changed from the default _Verbose_ to _Very verbose_ for even more information about the runs. While running the simulations, it is possible to save all output that is placed on the screen to a file that will be continuously updated. Click the _Save As_ button to choose a filename.

Afterwards, if all simulations were performed successfully, a message should be displayed confirming so.

### Batch simulations: vary one or two parameters in a single input-file

A considerably more interesting feature of the batch simulation is its second operational mode: if the user selects a single file after clicking the _Batch mode_ button, he will be presented with a new dialog in which he is asked to select either one or two parameters that will be varied during a series of simulations based on the initially selected input-file, as is seen in the following screenshot:

![Select one or two parameters to be varied](../wiki/figures/30batchselectparameters.png)

After expanding the different components of the tree structure representing the initial input-file contents, green rows will emerge: only the components lighting up are eligible as variable parameters!
Furthermore, it should be noted that within a layer, one can only select an element's _weight\_fraction_ if there are at least two elements available: this is necessary because at any given moment, the sum of the weight fractions needs to be equal to 100% after rescaling. If two weight fractions within the same layer need to te varied, then at least three elements need to be present in that layer for the same reason.

Clicking _Ok_ after selecting the required parameter(s), will cause a wizard to pop up that will guide the users through setting the other parameters necessary to start the batch. After the introduction, a page is presented containing the _General options_, as seen in the _Control panel_ of the main interface window.
The next page contains the information necessary to define the range and the number of steps that will be used to determine the parameter(s) values in the different input-files that will be produced and later on, simulated. In bold, above the _Start_, _End_ and _#Steps_ entries, are the name(s) of the selected parameter expressed in its XPath notation, which corresponds to an internal description of the parameter of its location in the XMI-MSIM input-file (see [next section](#xmi-msim-file-manipulation-with-xpath-and-xslt) for more information).
This page also contains a _Save As_ button that will launch a file chooser dialog, which will ask the user to determine the XMI-MSIM archive that will eventually be produced containing all results from the simulation. This is shown (for a case with one selected variable parameter) in the following screenshot:

![Set the range of the variable parameter(s) and the name of the XMI-MSIM archive file](../wiki/figures/31batchrangeselection.png)

After confirming the introduced values, a _Batch simulation controls_ window will appear, as was already described and shown in the preceding section. Clicking the _Play_ button will launch the simulations window. After all simulations have been successfully performed, click the _Ok_ button and wait until a window is shown that looks similar to the one in the following screenshot:

![Batch mode plot window for one variable parameter](../wiki/figures/32batchmodeplotsingle.png)

In this window, one can analyze the results of the batch simulation by selecting specific elements, lines, regions of interest etc for individual or cumulative interaction contributions. It is possible to save the plot as an image file using _Save image_, while the data that makes up the currently shown plot can be exported in a CSV file. Change the axes titles to a more appropriate description if deemed necessary.
The following screenshot shows a case where two variable parameters were chosen:

![Batch mode plot window for two variable parameters](../wiki/figures/33batchmodeplottwo.png)

All information that was produced in the batch simulation has been stored in an XMI-MSIM archive file (.xmsa extension). If one would like to inspect its contents again with the _Batch mode plot_ window, just double-click such a file from your favorite file manager, or open it from within XMI-MSIM by clicking _Open_ in the toolbar or menubar and setting the filter to _XMI-MSIM archives_, and then selecting the desired file.

## Generate XRMC input-files

Using the _Convert XMSI file to XRMC_ option from the _Tools_ menu, one can produce input-files for the [XRMC](http://github.com/golosio/xrmc/wiki) software package, a Monte Carlo simulation tool for X-ray imaging and spectroscopy experiments. This should be of particular interest to those users that are interested in a simulation that includes scattering and XRF that is generated by the collimator, which is being ignored by XMI-MSIM. Keep in mind though that simulations with XRMC typically will take considerably longer compared to XMI-MSIM for a result with equivalent statistical variance.
In order to use the produced input-files, install XRMC including its XMI-MSIM plug-in, which will be used for the detector response function.
One can also generate the XRMC input-files using the [command-line utility](#command-line-interface) `xmsi2xrmc`.

## XMI-MSIM file manipulation with XPath and XSLT

All three XMI-MSIM document types (xmsi, xmso and xmsa) are in fact XML files defined through a document type definition (DTD) file which is included and used in all XMI-MSIM installations. Due to their XML nature, it becomes quite easy to manipulate these files in a number of ways. For example, using an Extensible Stylesheet Language Transformation (XSLT) it becomes possible to extract certain parts of the XML file and convert them to any other type of output. 

XMI-MSIM uses this very technique to perform the conversions from the output-files (xmso) to the spe, html, csv and svg file formats. The stylesheets that are necessary for these operations are included with all installations and may serve the reader as a source of inspiration in developing his own XSL transformations.

The previous section on batch simulations already mentioned the concept of XPath expressions: in combination with an XML processing library such as [libxml2](www.xmlsoft.org), one can read and write parts of as well as entire XML files, which essentially explains the underlying algorithms that XMI-MSIMs batch simulation feature uses. Since advanced users may require a more complex batch simulation method than what is provided by XMI-MSIM, they may want to have a look at the following simple Perl script which produces the required input-files for a one-dimensional batch simulation, but this can be easily rewritten for far more complex applications.

```perl
use XML::LibXML;
use strict;
use Scalar::Util qw(looks_like_number);

die "Usage: perl xmi-msim-batch.pl XMSI-file ".
	"XPath-expression start-value end-value number-of-values\n" 
	if (scalar(@ARGV) != 5);

my $dom = XML::LibXML->load_xml(location => $ARGV[0],
	load_ext_dtd => 0
);

my $xpc = XML::LibXML::XPathContext->new($dom);
my @nodes = $xpc->findnodes($ARGV[1]);

die "Exactly one element should be matched by the XPath expression\n"
	if (scalar(@nodes) ne 1);

#get outputfile
my ($outputfileNode) = $xpc->findnodes("//xmimsim/general/outputfile");
my $outputfile = $outputfileNode->textContent;
$outputfile =~ s/\.xmso$//;

my $inputfile = $ARGV[0];
$inputfile =~ s/\.xmsi$//; 

print "outputfile: $outputfile\n";

#check if numeric arguments are ok
die "last three arguments must be numerical\n"
	unless(looks_like_number($ARGV[2]));
die "last three arguments must be numerical\n"
	unless(looks_like_number($ARGV[3]));
die "last three arguments must be numerical\n"
	unless(looks_like_number($ARGV[4]));

my $diff = $ARGV[3] - $ARGV[2];

die "end-value must be greater than start-value\n" if ($diff <= 0.0);
die "number-of-values must be greater than 0\n" if ($ARGV[4] <= 0.0);

for (my $i = 0 ; $i <= $ARGV[4] ; $i++) {
	$nodes[0]->removeChildNodes();
	$nodes[0]->appendText($ARGV[2]+ $i * $diff/$ARGV[4]);
	$outputfileNode->removeChildNodes();
	$outputfileNode->appendText("$outputfile"."_".$i.".xmso");
	$dom->toFile("$inputfile"."_".$i.".xmsi",1);
}
```

## Custom detector response functions

As already mentioned in [simulation options](../wiki/User-guide#options), it has become possible to use custom detector response functions in XMI-MSIM, thereby replacing its built-in routines with your own alternatives.
Basically, you will have to write your own routine called `xmi_detector_convolute_all_custom` and compile this function into a plug-in (dynamically loadable module). This routine should follow the prototype:

```c
void xmi_detector_convolute_all(xmi_inputFPtr inputFPtr, double **channels_noconv, double **channels_conv, struct xmi_main_options, struct xmi_escape_ratios *escape_ratios, int n_interactions_all, int zero_interaction);
```

or in Fortran:

```fortran
SUBROUTINE xmi_detector_convolute_all_custom(inputFPtr, channels_noconvPtr,&
channels_convPtr, options, escape_ratiosCPtr, n_interactions_all,&
zero_inter) BIND(C,NAME='xmi_detector_convolute_all_custom')
        TYPE (C_PTR), INTENT(IN), VALUE :: inputFPtr
        TYPE (C_PTR), INTENT(IN), VALUE :: channels_noconvPtr
        TYPE (C_PTR), INTENT(IN), VALUE :: channels_convPtr
        TYPE (xmi_escape_ratiosC), INTENT(IN) :: escape_ratiosCPtr
        TYPE (xmi_main_options), VALUE, INTENT(IN) :: options
        INTEGER (C_INT), VALUE, INTENT(IN) :: n_interactions_all, zero_inter
```

Clearly for this to work you will have to make use of the datatypes exposed in the headers and the fortran module files.
I recommend also to make as much as possible of the functions that are already contained within XMI-MSIM (a fully documented API will follow at some point...). For now, the best source of information would be the code itself, along with the two examples that are included in the distribution ([Fortran](https://github.com/tschoonj/xmimsim/blob/master/custom-detector-response/detector-response1.F90) and [C](https://github.com/tschoonj/xmimsim/blob/master/custom-detector-response/detector-response2.c)).

Probably it will be easiest to write such a plug-in in Fortran: you will be able to easily reuse a lot of the existing code with minimal effort. However, if you're willing to write some simple wrappers in Fortran first, you can also use all Fortran functions from C. When writing a plug-in in C, you will probably want to use the following function:

```c
void xmi_input_F2C(xmi_inputFPtr Ptr, struct xmi_input **xmi_inputC);
```

This function extracts from the Fortran datatype `TYPE (xmi_input)` (which is useless in C), the corresponding C datatype `struct xmi_input`, which contains all the easily accessable information from the simulation.

It should also be possible to write plug-ins in C++, just make sure the exported function gets the `extern "C"` attribute.  

Here are some instructions on how to compile these modules on the three supported platforms. The resulting `module.so` (Mac OS X and Linux) or `module.dll` (Windows) should be loadable by XMI-MSIM.
I recommend to make use of OpenMP as shown in the Fortran example (but possible in the C example too). If not desired, then remove the `-fopenmp` flags. 
You are of course free to make use of any other libraries that are necessary to implement your detector response functions. In this case however, do not forget to add the required header and linker flags.

### Building modules on Mac OS X

The following instructions apply to the XMI-MSIM app bundle only, and assume it is installed in `/Applications`. If compiled from source, follow the instructions for [Linux](#building-modules-on-linux) instead.

#### Fortran

The latest release of XMI-MSIM (5.0) has been compiled with gfortran 4.9, installed using MacPorts. Do not attempt to try a different fortran compiler, it won't work!

Compile your source files (to be executed for each source file separately):

```
gfortran-mp-4.9 -I/Applications/XMI-MSIM.app/Contents/Resources/include/xmimsim -fopenmp -ffree-line-length-none -c -fno-common -o object1.o source1.f90
```

Link the objects together:

```
gfortran-mp-4.9 -fopenmp -Wl,-undefined -Wl,dynamic_lookup -o module.so -bundle object1.o object2.o ...
```

#### C

Feel free to use any C compiler you want for this: the default clang, or any C compiler offered by MacPorts. Keep in mind though that clang currently doesn't support OpenMP.

Compile your source files (to be executed for each source file separately):

```
clang -I/Applications/XMI-MSIM.app/Contents/Resources/include/xmimsim -c -fno-common -o object1.o source1.c 
```

Link the objects together:

```
clang -Wl,-undefined -Wl,dynamic_lookup -o module.so -bundle object1.o object2.o ...
```

### Building modules on Linux

The following instructions assume that XMI-MSIM was installed using binary packages for selected Debian/Ubuntu and Redhat family distributions, include the development packages!. If compiled from source, you may have to set the `PKG_CONFIG_PATH` variable for the following instructions to work.

#### Fortran

Compile your source files (to be executed for each source file separately):

```
gfortran `pkg-config --cflags libxmimsim` -fopenmp -ffree-line-length-none -c -fPIC -o object1.o source1.f90
```

Link the objects together:

```
gfortran -fopenmp -shared -fPIC -Wl,-soname -Wl,module.so -o module.so object1.o object2.o ...
```

#### C

Compile your source files (to be executed for each source file separately):

```
gcc `pkg-config --cflags libxmimsim` -c -fPIC -DPIC -o object1.o source1.c
```

Link the objects together:

```
gcc -fopenmp -shared -fPIC -Wl,-soname -Wl,module.so -o module.so object1.o object2.o
```

### Building modules on Windows

**For any of the following to work, ensure you selected the SDK when asked which components to install when running the installer!!**
Assuming you didn't change the default installation path during installation, XMI-MSIM should be installed in:

* XMI-MSIM win64 installer on Windows 64 system: C:\Program Files\XMI-MSIM 64-bit
* XMI-MSIM win32 installer on Windows 64 system: C:\Program Files (x86)\XMI-MSIM 32-bit
* XMI-MSIM win32 installer on Windows 32 system: C:\Program Files\XMI-MSIM 32-bit

For the sake of convenience, let's call this installation folder _xmi\_msim_. If for some reason you picked another installation directory, assume _xmi\_msim_ represents this one.

XMI-MSIM for Windows has been compiled with MinGW-w64 compilers offered through [TDM-GCC](http://tdm-gcc.tdragon.net). In order for this to work, you will have to install the exact same compilers on your system:

* For XMI-MSIM win64: download [tdm64-gcc-4.8.1-3.exe](http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%20Installer/tdm64-gcc-4.8.1-3.exe/download)
* For XMI-MSIM win32: download [tdm-gcc-4.8.1-3.exe](http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%20Installer/tdm-gcc-4.8.1-3.exe/download)

When selecting components, make sure to select the C and Fortran compilers, and OpenMP too if you want to use it.
After installation, fire up a MinGW shell from the Start Menu entries that were just created and cd to the directory that contains your source. Depending on what language was written, follow either the Fortran or C instructions, keeping in mind that _xmi\_msim_ refers to the full path to the XMI-MSIM installation folder!!!

#### Fortran

Fortran does not have a standardized way of exporting a function from a dll. The following should work for both gfortran and Intel Fortran: include these lines just after the definition of the `xmi_detector_convolute_all_custom` function.

```fortran
#ifdef __GFORTRAN__
!GCC$ ATTRIBUTES DLLEXPORT:: xmi_detector_convolute_all_custom
#elif defined(__INTEL_COMPILER)
!DEC$ ATTRIBUTES DLLEXPORT:: xmi_detector_convolute_all_custom
#endif?
```

Compile your source files (to be executed for each source file separately):

```
gfortran -I"xmi_msim\SDK\Include" -fopenmp -ffree-line-length-none -DDLL_EXPORT -c -o object1.o source1.f90
```

Link the objects together:

```
gfortran -shared -fopenmp -Wl,--enable-auto-image-base -o module.dll object1.o object2.o ... -L"xmi_msim\SDK\Lib" -lxmimsim
```

#### C

Exporting the `xmi_detector_convolute_all_custom` requires that the definition is proceded by `__declspec(dllexport)`, as shown in the C example where this is accomplished using conditional compilation. 

Compile your source files (to be executed for each source file separately):

```
gcc -mms-bitfields -I"xmi_msim\SDK\Include" -fopenmp  -DDLL_EXPORT -c -o object1.o source1.c
```

Link the objects together:

```
gcc -mms-bitfields -shared -fopenmp -Wl,--enable-auto-image-base -o module.dll object1.o object2.o ... -L"xmi_msim\SDK\Lib" -lxmimsim
```

In theory you should also be able to compile a module from C source code using Visual Studio, but I have not tried this yet. For this, you will need the import library `libxmimsim-0.lib`, which is located in the SDK\Lib subdirectory of your XMI-MSIM installation.

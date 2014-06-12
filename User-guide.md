In this section a short manual is presented that should allow users to get started with XMI-MSIM. Although the screenshots were obtained on a Mac, they should be representative for Windows and Linux as well. Significant divergences will be indicated.
The following guide assumes that the user has already installed XMI-MSIM, according to the [Installation instructions](../wiki/Installation-instructions).


* **[Launching XMI-MSIM](#launching-xmi-msim)**
* **[Creating an input-file](#creating-an-input-file)**
* **[Saving an input-file](#saving-an-input-file)**
* **[Starting a simulation](#starting-a-simulation)**
* **[Visualizing the results](#visualizing-the-results)**
* **[Global preferences](#global-preferences)**
* **[Advanced features](#advanced-features)**
* **[Checking for updates](#checking-for-updates)**
* **[Command line interface](#command-line-interface)**
* **[Example files](#example-files)**



## Launching XMI-MSIM

For Mac users: assuming you dragged the app into the Applications folder, use Finder or Spotlight to launch XMI-MSIM.

For Windows users: an entry should have been added to the Start menu. Navigate towards it in _Programs_ and click on XMI-MSIM.

For Linux users: an entry should have been added to the Education section of your Start menu. Since this may very considerably depending on the Linux flavor that is being used, this may not be obvious at first. Alternatively, fire up a terminal and type:

> `xmimsim-gui`

Your desktop should now be embellished with a window resembling the one in the following screenshot.

![XMI-MSIM on startup](../wiki/figures/01start-window.png)

XMI-MSIM may also be started on most platforms by double clicking XMI-MSIM input-files (.xmsi extension) and output-files (.xmso extension) in your platform's file manager, thereby loading the file's contents.

The main view of the XMI-MSIM consists of three pages that each serve a well-defined purpose. The first page is used to generate inputfiles, based on a number of parameters that are defined by the user. The second page allows for the execution of these files, while the third and last page is designed to visualise the results and help in their interpretation. The purpose of the following sections is to provide an in-depth guide on how to operate these pages. 

When starting XMI-MSIM without providing a file to open, a new file will be started with default settings. The same situation can be obtained at any moment by clicking on _New_ in the toolbar.


## Creating an input-file

The first page consists of a number of frames, each designed to manipulate a particular part of the parameters that govern a simulation.

* [General](#general)
* [Composition](#composition)
* [Geometry](#geometry)
* [Excitation](#excitation)
* [Beam and detection absorbers](#beam-and-detection-absorbers)
* [Detector settings](#detector-settings)
* [Import from file](#import-from-file)

### General

The _General_ section contains 4 parameters:

* Outputfile: clicking the _Save_ button will pop up a file chooser dialog, allowing you to select the name of the outputfile that will contain the results of the simulation
* Number of photons per discrete line: the excitation spectrum as it is used by the simulation may consist of a number of discrete components with each a given energy and intensity (see [Excitation](#excitation) for more information). This parameter will determine how many photons are to be simulated per discrete line. The calculation time is directly proportional to this value
* Number of photons per interval: the excitation spectrum as it is used by the simulation may consist of a number of continuous interval components defined by the given energies and intensity densities at the beginning and the end of the intervals (see [Excitation](#excitation) for more information). This parameter will determine how many photons are to be simulated per interval. The calculation time is directly proportional to this value
* Number of interactions per trajectory: this parameter will determine the maximum number of interactions a photon can experience during its trajectory. It is not recommended to set this value to higher than 4, since the contribution of increasingly higher order interactions to the spectrum decreases fast. The calculation time is directly proportional to this value
* Comments: use this textbox to write down some notes you think are useful.

### Composition

This interface allows you to define the system that will make up your sample and possibly its environment. XMI-MSIM assumes that the system is defined as a stack of parallel layers, each defined by its composition, thickness (measured along the [Sample orientation vector](#geometry)) and density. Adding layers can be accomplished by simply clicking the _Add_ button. A dialog will pop up as seen in the following screenshot:

![Defining a new layer](../wiki/figures/03modify-layer.png)

The different elements that make up the layer are added by clicking on the _Add_ button. A small dialog will emerge, enabling you to define a compound or a single element, with its corresponding weight fraction. In the following screenshot, I used `CuSO4` with a weight fraction of 50 % to start with.

![Adding a compound](../wiki/figures/04enter-compound.png)

You may wonder at exactly which chemical formulas are accepted by the interface. Well the answer is: anything that is accepted by _xraylib_'s [CompoundParser](https://github.com/tschoonj/xraylib/wiki/The-xraylib-API-list-of-all-functions#wiki-compoundparser) function. This includes formulas with (nested) brackets such as: `Ca10(PO4)3OH` (apatite). Invalid formulas will lead to the _Ok_ button being greyed out and the _Compound_ text box gaining a red background.

After clicking ok, you should see something resembling the following screenshot:

![Adding a compound](../wiki/figures/05after-first-compound.png)

You will notice that the compound has been parsed and separated into its constituent elements, with weight fractions according to the mass fractions of the elements.
In this example I added an additional 50 % of `U3O8` to the composition and picked the values 2.5 g/cm3 and 1 cm for density and thickness, respectively, leading to a weights sum of 100 %. It is considered good practice to have the weights sum equal to 100 %. This can be accomplished by either adding/editing/removing compounds and elements from the list, or by clicking the _Normalize_ button, which will scale **all** weight fractions in order to have their sum equal to 100 %. Your dialog should match with this screenshot:

![Adding another compound](../wiki/figures/06after-second-compound.png)

Alternatively you may consider looking into the builtin catalog (press _Load from catalog_): a pop-up window will allow you to select a compound from one of two lists. The first list is generated using xraylib's [GetCompoundDataNISTList](https://github.com/tschoonj/xraylib/wiki/The-xraylib-API-list-of-all-functions#wiki-nistcatalog) function, which provides access to NISTs compound database of compositions and densities. The second one however, provides access to layers that you defined yourself: when a valid layer (i.e. composition, density and thickness) is showing in the layer dialog, click _Add to catalog_ and choose a name for the layer: this layer will show up in the catalog list next time it is opened. Keep in mind that existing layers in the list will be overwritten without warning! If you would like to delete previously defined layers from the list, use the [_Preferences_](#user-defined-layers) interface.

When satisfied with the layer characteristics, press _Ok_.

X-ray fluorescence are quite often performed under atmospheric conditions. If so, it is of crucial importance to add the atmosphere to the system for several reasons:

1. The atmosphere attenuates the beam and the X-ray fluorescence
2. The intensity of the Rayleigh and Compton scatter peaks is greatly influenced by the atmosphere
3. The photons from the beam as well as the fluorescence and the scattered photons will lead to the production of Ar-K fluorescence, a common artefact in X-ray fluorescence spectra. In some rare cases, one may even detect Xe fluorescence.

To add such a layer, click again on _Add_ button. In the _Modify layer_ dialog, add the composition, density and thickness of the air layer. This is shown in the next screenshot:

![Adding air layer](../wiki/figures/07after-adding-air-layer.png)

Alternatively, click on _Load from catalog_ and select _Air, Dry (near sea level)_ from the NIST compositions list.
Clicking the _Ok_ button should lead the following situation in the _Composition_ section:

![Wrong layer order](../wiki/figures/08layers-wrong.png)

However, the ordering of the layers in the table is wrong: **XMI-MSIM assumes that the layers are ordered according to distance from the X-ray source**. This means that the first layer is closest to the source and all subsequent layers are positioned at increasingly greater distances from the source.
This can be easily remedied by selecting a layer and then moving it around using the _Top_, _Up_, _Down_ and _Bottom_ buttons. The following screenshot shows the corrected order of the layers:

![Correct layer order](../wiki/figures/09layers-correct.png)

An important parameter in this table is the _Reference layer_. Using the toggle button, you select which layer corresponds to the one that is considered to be the first layer of the actual _sample_. In most cases, this will indicate the first non-atmospheric layer. The _Reference layer_ is also the layer that is used to calculate the _Sample-source distance_ in the [_Geometry_ section](#geometry).

Layers can be removed by selecting them and then clicking the _Remove_ button. Existing layers may be modified by either double-clicking the layer of interest or by selecting the layer, followed by clicking the _Edit_ button.

Keep in mind that the number of elements influences the computational time greatly, especially when dealing with high Z-elements that may produce L- and M-lines.

### Geometry

Scrolling down a little on the _Input parameters_ page reveals the _Geometry_ section as shown in the next screenshot:

![Geometry, excitation and beam absorbers](../wiki/figures/10geometry-excitation.png)

This sections covers the position and orientation of the system of layers, detector and slits. In order to fully appreciate the geometry parameters, it is important that I first describe the coordinate system that these position coordinates and directions are connected to:

* The coordinate system is right-handed Cartesian
* The _z_-axis is aligned with the beam direction and points from the source towards the sample.
* The _y_-axis defines, along with the _z_-axis, the horizontal plane
* The _x_-axis emerges out from the plane formed by the _y_- and _z_-axes

This is demonstrated in the following figure:

![Schematic representation of the geometry](../wiki/figures/27coordinatesystem.png)

Now with this covered, let us have a look at the different _Geometry_ parameters:

* Sample-source distance: the distance between the source and the _Reference layer_ in the system of layers as defined in the [_Composition section_](#composition)
* Sample orientation vector: the normal vector that determines the orientation of the stack of layers that define the sample and its environment. The _z_ component must be strictly positive
* Detector window position: the position of the detector window. This is seen as the point where the photons are actually detected and terminated by the detector. Keep this in mind when defining a collimator
* Detector window normal vector:  the normal vector of the detector window. Should be directed towards the sample (unless you have a very good reason not to do so)
* Active detector area: this corresponds to the area of the detector window that is capable of letting through _detectable_ photons. Should be provided by the manufacturer of your detector
* Collimator height: XMI-MSIM allows for the definition of a conical detector-collimator whose properties are determined by this parameter and the _Collimator diameter_. Setting either to zero corresponds to a situation without collimator. This height parameter is seen as the height of the cone, measured from the detector window to the opening of the collimator, along the detector window normal vector
* Collimator diameter: diameter of the opening of the conical detector collimator. The base of the collimator corresponds to the _Active detector area_
* Source-slits distance: XMI-MSIM defines a set of virtual slits, whose purpose is to define the size of the beam at a given point, based on the distance between these slits and the X-ray source, as well as the _Slits size_, defined by the next parameter. I recommend to have the _Source-slits distance_ correspond to the _Sample-source distance_, since this way the beam, upon hitting the _Reference layer_, will have exactly the dimensions specified by _Slits size_ (if using a point source!)
* Slits size: see previous parameter. Refers to the dimensions of the beam at the _Source-slits_ distance. This parameter will be ignored when dealing with a Gaussian source (see [Excitation section](#excitation))

In order to visualize these different parameters, click the _Show geometry help_ button: a new window will pop up showing the aforementioned coordinate system. Hovering the mouse over the different components in the new window will have the corresponding widgets light up in green in the main window. This works both ways: hover the mouse over the geometry widgets in the main window and little boxes will appear in the coordinate system window.

### Excitation

Next, there is the _Excitation_ section, which is used to define the X-ray beam that irradiates the sample.
The corresponding excitation spectrum may consist of a number of discrete components, each with a horizontally and vertically polarized intensity, as well as a number of parameters that define the type and the aperture of the source. Furthermore, one can also insert a number of continuous interval components, defined through a list of intensity densities, each with their horizontally and vertically polarized components. In this case, one has two insert at least two intensity densities in order to have at least one interval.

At runtime, the code will use the [_Number of photons per discrete line_](#general) and [_Number of photons per interval_](#general) parameters to determine how many photons will be simulated per discrete component and continuous energy interval component. Adding, editing and removing components is handled through the buttons in the _Excitation_ section. For example, we can change the settings of the default value by clicking the _Edit_ button.
The dialog contains the fields necessary to define a particular component:

* Energy: the energy of this particular part of the excitation spectrum, expressed in keV
* Horizontally and vertically polarized intensities: the number of photons that are polarized in the horizontal and vertical planes, respectively. A completely unpolarized beam has identical horizontal and vertical intensities (such as those produced by X-ray tubes), while synchrotron beams will have very, very low vertically polarized intensities. For information on how to convert the total number of photons given the degree of polarization to the horizontal and vertical polarized intenties, consult [Part 5 in our series of papers on Monte-Carlo simulations](../wiki/References-and-additional-resources)
* Source size _x_ and _y_: if both these values are equal to zero, then the source is assumed to be a point source, and the divergence of the beam is completely determined by the _Source-slits distance_ and _Slits size_ parameters of the [_Geometry_](#geometry) section. Otherwise the source is considered a Gaussian source, in which case the photon starting position is chosen according to Gaussian distributions in the _x_ and _y_ planes, determined by the _Source size x_ and _Source size y_ parameters
* Source divergence _x_ and _y_: if these values are non-zero, AND the source is Gaussian, then the _Source-slits distance_ takes on a new role as it becomes the distance between the actual focus and the source position. In this way a convergent beam can be defined, emitted by a Gaussian source at the origin. For the specific case of focusing on the sample the _Sample-source distance_ should be set to the _Source-slits distance_.
* Energy distribution type: additionally for the discrete components, it is possible to set the _Energy distribution type_, which may assume the values _Monochromatic_, _Gaussian_ and _Lorentzian_. The first case assumes that the discrete energy is purely monochromatic and that only the selected energy will be used in the simulation. The two other cases corrspond to a scenario in which the simulation will sample from a Gaussian or Lorentzian distribution respectively. If either of these two cases is selected, the user is expected to provide respectively the standard deviation and the scale parameter.

In this particular case, I have changed the energy to 20.0 keV, and made the beam unpolarized by equalizing both intensities, as shown in the following screen shot. The source remains a point source.

![Modifying the energy](../wiki/figures/11modify-energy.png)

The discrete energies and continuous energies widgets each contain six buttons:

* _Add_: add a new component.
* _Edit_: edit a previously defined component.
* _Remove_: delete previously components.
* _Import_: import a list of discrete lines or continuous energy intensity densities from an ASCII file. These files must consist of either two, three or seven columns, with the first column containing the energies, the second the total intensity (if only two columns are found), or the second and third the resp. horizontally and vertically polarized intensities or intensity densities. If seven columns are encountered, the last four columns are assumed to contain source sizes and divergencies. It is possible through the interface to start reading only at a certain linenumber and also to read only a set number of lines.
* _Clear_: delete all previously defined components.
* _Scale_: multiply the intensities or intensity densities with a positive real number.


### Beam and detection absorbers

The two following sections deal with absorbers, first absorbers that are optionally placed in the excitation path (for example a sheet of Al or Cu), and next the absorbers that are optionally placed in the detector path. This means that the former will reduce the intensity of the incoming beam, while the latter will reduce the intensity of the photons that hits the detector.
It is important to realize that these absorbers are only used here for their attenuating properties, they are *not* considered as objects in the simulations so they cannot contribute fluorescence lines to the eventual spectrum!
Adding, editing and removing absorbers is performed through an interface identical to the one seen in the [Composition section](#composition), but without the _Reference layer_ toggle button. New inputfiles will always have a Be detector absorber added, corresponding to the detector window commonly found in ED-XRF detectors.

### Detector settings

The last section deals with the settings of the detector and its associated electronics, as can be seein in the following screenshot:

![Detector settings](../wiki/figures/12detection-absorbers-and-detector-settings.png)

* Detector type: every detector comes with its own detector response function, which can be influenced by several detector and electronics parameters. XMI-MSIM offers some predefined detector response functions that its authors have found to be reasonably well for two detector types: Si(Li) and Si Drift Detectors. Generally speaking, our policy is to encourage users to implement their own detector response functions in the `xmi_detector_convolute` subroutine of `src/xmi_detector_f.F90` in the source code
* Live time: the actual measurement time of the simulated experiment, taking into account dead time
* Detector gain: the width of one channel of the spectrum, expressed in keV/channel
* Detector zero: the energy of the first channel in the spectrum (channel number zero)
* Detector Fano factor: measure of the dispersion of a probability distribution of the fluctuation of an electric charge in the detector. Very much detector type dependent
* Detector electronic noise: the result of random fluctuations in thermally generated leakage currents within the detector itself and in the early stages of the amplifier components. Contributes to the Gaussian broadening
* Pulse width: the time that is necessary for the electronics to process one incoming photon. This value will be used only if the user enables the pulse pile-up simulation in the [Simulation controls](#starting-a-simulation). Although this parameter is connected to several detector and electronics parameters, typically the value is obtained after trial and error
* Max convolution energy: the maximum energy that will be considered when applying the detector response function. Make sure this value is 10-20 % higher than the highest expected energy in the spectrum
* Crystal composition: the composition of the detector crystal. Adding, editing and removing absorbers is performed through an interface identical to the one seen in the [Composition section](#composition), but without the _Reference layer_ toggle button. Will be used to calculate the detector transmission and the escape peak ratios

### Import from file

In some cases it may be interesting to import part of the contents of other XMI-MSIM input-files or output-files (which also contain the corresponding input-file) into a new input-file. This can be accomplished by using the _File_ &rarr; _Import_ option in the menubar.
After choosing a file from the dialog, select the components that you would like to import from the interface. This is demonstrated in the following screenshot

![Import from file](../wiki/figures/25importfromfile.png)

## Saving an input-file

Once an acceptable inputfile is detected by the application, the _Save_ and _Save as_ buttons will become activated. If the file has not been saved before, clicking either of these buttons will launch a dialog allowing you to choose a filename for the input-file.

If the file was saved before, then clicking _Save_ will result in the file contents will be overwritten with the new file contents.

Keep in mind that XMI-MSIM input-files have the xmsi extension (blue logo), while the output-files the xmso extension (red logo).

## Starting a simulation

* [Control panel](#control-panel)
* [Executable](#executable)
* [Options](#options)
* [Export results](#export-results)
* [During a simulation](#during-a-simulation)

In order to start a simulation, the _Input parameters_ page must contain a valid input-file description. This can be obtained by either preparing a new input-file based on the instructions in [a previous section](#creating-an-input-file) (and saving it!), or by opening an existing input-file by double clicking an XMI-MSIM input-file in your file manager or opening an input-file through the _Open_ interface of XMI-MSIM.

Either way, the _Simulation controls_ page should look as shown in the following screenshot:

![Simulation controls](../wiki/figures/13simulation-controls.png)


### Control panel

The top of the page contains the actual control panel that is used to start, stop and pause the simulation, as well as a slider that allows the user to select the number of threads that will be used by the simulation.  To the right of the slider, there are three progress bars that indicate different stages of the Monte Carlo program: the calculation of the solid angle grid for the variance reduction, the simulation of the photon--matter interactions and the calculation of the escape peak ratios. More information about the status of the Monte Carlo program is presented in the adjacent log window.


### Executable

Underneath these controls is a section that contains the name of the executable that will be used to launch the simulation. Most likely, you will never have to change this value, but it could be interesting to power users, who have customized versions of the simulation program.

### Options

This section is followed by a number of options that change the behaviour of the Monte-Carlo program:

* _Simulate M-lines_: If disabled, then the code will ignore M-lines that may be produced based on the elemental composition of the sample. In such a case, the code will probably run faster. I strongly recommend to simulate M-lines
* _Simulate the radiative and non-radiative cascade effect_: the cascade effect is composed of two components, a radiative and a non-radiative one. Although these will always occur simultaneously in reality, the code allows to deactivate one or both of them. This could be interesting to those that want to investigate the contribution of both components. Otherwise, it is recommended to keep both enabled
* _Enable variance reduction techniques_: disabling this option will trigger the brute-force mode, disabling all variance reduction techniques, thereby greatly reducing the precision of the estimated spectrum and net-line intensities for a given [_Number of photons per discrete line_](#general). This reduced precision may be improved upon by greatly increasing the _Number of photons per discrete line_, but this will result in a much longer runtime of the Monte-Carlo program. Expert use only. Consider building XMI-MSIM with MPI support and running it on a cluster
* _Enable pulse pile-up simulation_: this option activates the simulation of the so-called sum peaks in a spectrum due to the pulse pile-up effect which occurs when more photons are entering the detector than it can process. The magnitude of this effect can controlled through the [_Pulse width_](#detector-settings) parameter
* _Enable Poisson noise generation_: enabling this option will result in every channel of the detector convoluted spectrum being subjected to Poisson noise, controlled by Poisson distributions with lambda equal to the number of counts in a channel
* _Enable escape peaks support_: enable this option to activate the support for escape peaks in the detector response function. Typically you will want to leave this on.
* _Enable OpenCL_: this option invokes XMI-MSIMs OpenCL plug-in that, if the platform comes with a videocard chipset that supports it, will use the GPU to perform the solid angle calculation, which could lead to a tremendous speed increase. Keep in mind that when this option is used during the solid angle calculation stage, the screen may have a noticeably lower refresh rate and may lose its responsiveness briefly. This option is only available when an OpenCL framework was found at compile-time.
* _Number of spectrum channels_: the number of channels in the produced spectrum.


### Export results

The page ends with a section that allows the user to export the output of the Monte-Carlo program at run-time to several fileformats in addition to the default XMSO fileformat.

* SPE file: the well known ASCII format, readable by PyMca and AXIL. Produces one file per additional interaction. When using the file dialog to choose the filename, make sure not to add a file extension: the Monte-Carlo program will append an underscore, the number of interactions and the .spe extension automatically
* Scalable Vector Graphics (SVG) file: produces an SVG file with vectorized images of the spectra
* Comma Separated Values (CSV) file: produces a CSV file containing several columns. The first column contains the channel number, the second one contains the corresponding channel energy and the following columns contain the intensities for increasing number of interactions
* Report HTML file: produces an html file that can be opened with most Internet Browsers (Internet Explorer being a notable exception), featuring an interactive overview of the results of the Monte-Carlo simulation, simular to the ones shown on the Results page 

It is possible to generate these files afterwards based on the XMSO file, by clicking in the menubar on _Tools_ -> _Convert XMSO file to_.

### During a simulation

When all required options are set up correctly, the simulation can be started by clicking the _Play_ button. After this, you will notice a lot of output being generated in the log window, as well as some activity in the progress bars, as shown in the next screenshot:

![Running the simulation](../wiki/figures/14calculating.png)

The first and the third progress bars will in many cases display a message that the Solid angle grid and the Escape peak ratios were loaded from file: this indicates that a simulation with similar parameters was performed before and that the relevant data was written to a file, leading to a huge increase in speed.
It is possible that some red text appears during a run, particularly with reference to Solid angle and Escape ratio HDF5 files being outdated. This only happens when you are running a new version of XMI-MSIM that introduced a new format for these files: the old files are deleted and new ones will be created and used from then onwards.

After the simulation, assuming everything went fine, the XMSO outputfile as defined in the [General section](#general) will be loaded and its contents displayed on the Results page.

## Visualizing the results

The results of a simulation are stored in an XMSO file (red logo): you should be able to open these files directly by double clicking them from your file manager.
Alternatively, you can also load these files from within XMI-MSIM by clicking the _Open_ button, and subsequently setting the filetype filter to _XMI-MSIM outputfiles_. On Linux and Windows, you can also open these files from the command-line:

> `xmimsim-gui file.xmso`

XMSO files created after a successful simulation are automatically loaded in the Results page, where the spectra and net-line intensities are represented.

* [Plot canvas](#plot-canvas)
* [Net-line intensities](#net-line-intensities)
* [Printing and exporting the plot canvas](#printing-and-exporting-the-plot-canvas)

### Plot canvas

If a simulation was performed according to the inputfile that was defined [earlier](#creating-an-input-file), you should get a result similar to the one in the following screenshot:

![Visualizing the results](../wiki/figures/19results.png)

The plot canvas shows by default the different spectra obtained after an increasing number of interactions. Individual spectra may be hidden and shown by toggling the boxes to the right of the plotting window.
Their properties of a spectrum may be modified by clicking on the _Properties_ button connected to it, which launches a dialog allowing the user to change the line width, line type and line color of the spectrum. The _Properties_ button above the coordinate entries opens a dialog with the option to switch between linear and logarithmic display of the spectra, as well as the opportunity to change the axes titles. More options will be added in future releases allowing the user to customize this further.

Zooming in on the plot canvas by dragging a rectangle with the mouse while keeping the left button clicked in. Zooming out can be accomplished by double-clicking anywhere in the canvas. While moving the mouse cursor in the plot canvas, one can track the current Energy, Channel number and Intensity in the textboxes to the right.
The size of the canvas can be changed by grabbing and moving the handle that separates the upper part from the lower part of the page.

### Net-line intensities

The lower part of the page contains a list of all the intensities of all the X-ray fluorescence lines of all elements, as shown in the following screenshot:

![Selecting XRF lines](../wiki/figures/20select-lines.png)

By clicking the arrows on the left side of the list, it is possible to expand the sections belonging to a particular element, line, and for different number of interactions, thereby revealing the individual contributions to a particular intensity.
The lines can be shown on the plot canvas by activating the _Show line_ flag for the appropriate line or element.

### Printing and exporting the plot canvas

The plot canvas can be printed and exported to several filetypes using the _Print_ and _Save as_ buttons to the right of the plot canvas. Both will result in an exact copy of the current state of the canvas: it will take into account all the changes that were made to the spectra properties, as well as any lines that were activated using the _Show line_ togglebuttons of the _Net-line intensities_ section.
Supported filetypes are PNG, EPS and PDF.

## Global preferences

Clicking the _Preferences_ button in the toolbar will launch a dialog allowing the user to set some preferences that will be preserved across sessions off XMI-MSIM. Make sure to press apply after making any changes.

* [Simulation defaults](#simulation-defaults)
* [Updates](#updates)
* [User-defined layers](#user-defined-layers)
* [Advanced](#advanced)

### Simulation defaults

The first page of the preferences window contains the same settings that are available on the [_Simulation controls_ page](#starting-a-simulation). The values that are selected here will be activated in the _Simulation controls_ page the next time that XMI-MSIM is started.

### Updates

If XMI-MSIM was compiled with support for automatic updates then this page will contain two widgets: firstly a checkbox that will determine if the program will check for updates at startup, and secondly a list of locations that will be used to download updates from.

### User-defined layers

Select layers and hit backspace to remove them from the list of user-defined layers. The layers are deleted immediately and cannot be recovered.

### Advanced

The first two options revolve around the deleting of the XMI-MSIM HDF5 files that contain the solid angle grids and the escape peak ratios, respectively. It is recommended to remove these files manually when a complete uninstall of XMI-MSIM is considered necessary (before running the uninstaller or removing the application manually), or if these files somehow got corrupted.

The following two options allow the user to import solid angle grids and escape peak ratios from external files into his own. This may be interesting if another user already has a huge collection of these and it may save a lot of time using someone elses.
In the file dialog only those files will be shown that are valid HDF5 files of the required kind and minimum version.

The last option is _Enable notifications_, which when supported at compile-time and a suitable notifications server is found, will generate messages whenever a calculation finishes. On a Mac OS X native version of XMI-MSIM this will only work on Mountain Lion and newer.

## Advanced features

* [X-ray tube spectrum generator](#x-ray-tube-spectrum-generator)
* [Batch simulations](#batch-simulations)
* [Generate XRMC input-files](#generate-xrmc-input-files)
* [XMI-MSIM file manipulation with XPath and XSLT](#xmi-msim-file-manipulation-with-xpath-and-xslt)

In this section, we will describe some more advanced features of XMI-MSIM, which may useful for some users with specific needs.

### X-ray tube spectrum generator

In the [_Excitation_ section](#excitation), we have shown how one can introduce the necessary components of the X-ray excitation spectrum, through a number of discrete energies and intervals of continuous energies.
In many cases, one will perform X-ray experiments using an X-ray tube generator as source, which corresponds to a combination of discrete part (the anode element specific XRF lines) and a continuous part (the Bremsstrahlung generated through electron-nucleus interactions). Such excitation spectra are typically quite difficult to obtain experimentally and instead one relies quite often on theoretical calculations to obtain (an approximation) of the spectrum. One popular model is the one derived by Horst Ebel in his manuscripts [X-ray Spectrometry 28 (1999), 255-266](http://dx.doi.org/10.1002/(SICI)1097-4539(199907%2F08)28%3A4%3C255%3A%3AAID-XRS347%3E3.0.CO%3B2-Y) and [X-ray Spectrometry 32 (2003), 46-51](http://dx.doi.org/10.1002/xrs.610). This model has been implemented in XMI-MSIM based on the similar feature in PyMca and can be accessed by clicking the X-ray tube button in the toolbar (with the radiation warning logo). After clicking, a new window will emerge that looks as:

![Modifying the energy](../wiki/figures/26ebelgenerator.png)

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

After adjusting the required parameters, click _Update spectrum_ to obtain a new excitation spectrum in the plot window. Using _Export spectrum_, it is possible to save the generated spectrum to an ASCII file, while _Save image_ will allow the user to save the plot window to an image file.
Clicking _About_ will present the user with the links to the Horst Ebel manuscripts.
Using the _Ok_ button one can close the window while replacing the contents of the _Excitation_ section with the newly generated spectrum.


### Batch simulations

XMI-MSIM version 3.0 introduces the option to perform batch simulations.
Activate this feature by clicking the _Batch mode_ button in the toolbar. This will produce a filechooser dialog as is shown in the following screenshot:

![Select one or more files to enter the batch simulation mode](../wiki/figures/28batchfileselection.png)

At this point it becomes very important to distinguish between two different possible outcomes that depend on whether the user selects either one or multiple files.

#### Batch simulations: simulate a number of unrelated input-files

If the user has selected multiple files, then these files will be used as input-files for a round of successive unrelated simulations. After the file selection, the user will be selected with a dialog with a question regarding whether the options should be set for each input-file separately. The options refer to the same options that can be seen in the [_Control panel_](#control-panel) of the main interface window. Either way, after setting the options, one will end up with the _Batch simulation controls_ window:

![Batch simulation controls](../wiki/figures/29batchcontrols.png)

Similar to the _Control panel_ of the main interface window, this widget features _Play_, _Stop_ and _Pause_ to control the execution. The number of threads that will be used for the simulations may be set using the CPUs slider. During execution, all output will be shown in the central area. The verbosity level can be changed from the default _Verbose_ to _Very verbose_ for even more information about the runs. While running the simulations, it is possible to save all output that is placed on the screen to a file that will be continuously updated. Click the _Save As_ button to choose a filename.

Afterwards, if all simulations were performed successfully, a message should be displayed confirming so.

#### Batch simulations: vary one or two parameters in a single input-file

A considerably more interesting feature of the batch simulation is its second operational mode: if the user selects a single file after clicking the _Batch mode_ button, he will be presented with a new dialog in which he is asked to select either one or two parameters that will be varied during a series of simulations based on the originally selected input-file, as is seen in the following screenshot:

![Select one or two parameters to be varied](../wiki/figures/30batchselectparameters.png)

After expanding the different components of the tree structure representing the original input-files contents, green rows will emerge: only the components lighting up are eligible as variable parameters!
Furthermore, it should be noted that within a layer, one can only select an elements _weight\_fraction_ if there are at least two elements available: this is necessary because at any given moment, the sum of the weight fractions needs to be equal to 100% after rescaling. If two weight fractions within the same layer need to te varied, then at least three elements need to be present in that layer for the same reason.

Clicking _Ok_ after selecting the required parameter(s), will cause a wizard to pop up that will guide the users through setting the other parameters necessary to start the batch. After the introduction, a page is presented containing the _General options_, as seen in the _Control panel_ of the main interface window.
The next page contains the information necessary to define the range and the number of steps that will be used to determine the parameter(s) values in the different input-files that will be produced and later on, simulated. In bold, above the _Start_, _End_ and _#Steps_ entries, are the name(s) of the selected parameter expressed in its XPath notation, which corresponds to an internal description of the parameter of its location in the XMI-MSIM input-file (see [next section](#xmi-msim-file-manipulation-with-xpath-and-xslt) for more information.
This page also contains a _Save As_ button that will launch a file chooser dialog, which will ask the user to determine the XMI-MSIM archive that will eventually be produced containing all results from the simulation. This is shown (for a case with one selected variable parameter) in the following screenshot:

![Set the range of the variable parameter(s) and the name of the XMI-MSIM archive file](../wiki/figures/31batchrangeselection.png)

After confirming the introduced values, a _Batch simulation controls_ window will appear, as was already described and shown in the preceding section. Clicking the _Play_ button will launch the simulations window. After all simulations have been successfully performed, click the _Ok_ button and wait until a window is shown that looks similar to the one in the following screenshot:

![Batch mode plot window for one variable parameter](../wiki/figures/32batchmodeplotsingle.png)

In this window, one can analyze the results of the batch simulation by selecting specific elements, lines, regions of interest etc for individual or cumulative interaction contributions. It is possible to save the plot as an image file using _Save image_, while the data that makes up the currently shown plot can be exported in a CSV file. Change the axes titles to a more appropriate description if deemed necessary.
The following screenshot shows a case where two variable parameters were chosen:

![Batch mode plot window for two variable parameters](../wiki/figures/33batchmodeplottwo.png)

All information that was produced in the batch simulation has been stored in an XMI-MSIM archive file (.xmsa extension). If one would like to inspect its contents again with the _Batch mode plot_ window, just double-click such a file from your favorite file manager, or open it from within XMI-MSIM by clicking _Open_ in the toolbar or menubar and setting the filter to _XMI-MSIM archives_, and then selecting the desired file.

### Generate XRMC input-files

Using the _Convert XMSI file to XRMC_ option from the _Tools_ menu, one can produce input-files for the [XRMC](http://github.com/golosio/xrmc/wiki) software package, a Monte Carlo simulation tool for X-ray imaging and spectroscopy experiments. This should be of particular interest to those users that are interested in a simulation that includes scattering and XRF that is generated by the collimator, which is being ignored by XMI-MSIM. Keep in mind though that simulations with XMI-MSIM typically will take considerably longer compared to XMI-MSIM for a result with equivalent statistical variance.
In order to use the produced input-files, install XRMC including its XMI-MSIM plug-in, which will be used for the detector response function.
One can also generate the XRMC input-files using the [command-line utility](#command-line-interface) `xmsi2xrmc`.

### XMI-MSIM file manipulation with XPath and XSLT

All three XMI-MSIM document types (xmsi, xmso and xmsa) are in fact XML files defined through a document type definition (DTD) file which is included and used in all XMI-MSIM installations. Due to their XML nature, it becomes quite easy to manipulate these files in a number of ways. For example, using an Extensible Stylesheet Language Transformation (XSLT) it becomes possible to extract certain parts of the XML file and convert them to any other type of output. 

XMI-MSIM uses this very technique to perform the conversions from the output-files (xmso) to the spe, html, csv and svg file formats. The stylesheets that are necessary for these operations are included with all installations and may serve the reader as a source of inspiration in developing his own XSL transformations.

The previous section on batch simulations already mentioned the concept of XPath expressions: in combination with an XML processing library such as [libxml2](www.xmlsoft.org), one can read and write parts of as well as entire XML files, which essentially explains the underlying algorithms that XMI-MSIMs batch simulation feature uses. Since advanced users may require a more batch simulation method than what is covered by XMI-MSIM, they may want to have a look at the following simple Perl script which produces the required input-files for a one-dimensional batch simulation, but this can be easily rewritten for far more complex applications.

```perl
use XML::LibXML;
use strict;
use Scalar::Util qw(looks_like_number);

die "Usage: perl xmi-msim-batch.pl XMSI-file ".
	"XPath-expression start-value end-value number-of-values\n" 
	if (scalar(@ARGV) ne 5);

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

## Checking for updates

For packages of XMI-MSIM that were compiled with support for automatic updates, checking for new versions will occur by default when launching the program. This can be disabled in the [Preferences window](#updates). If you would like to check explicity, then click on _Help_->_Check for updates..._ for Windows and Linux, and XMI-MSIM->_Check for updates..._ for Mac OS X.

When updates are available, a dialog will pop up, inviting the user to download the package through the interface. When the download is completed, quit XMI-MSIM and install the new version. It is highly recommended to always use the latest version of the interface.

## Command line interface

XMI-MSIM ships with a number of command line utilities that may be useful for some users. An overview:

* `xmimsim-gui`: This executable corresponds to the graphical user interface of XMI-MSIM, as described in this user guide. This will mostly be useful for Linux users or Mac OS X users that compiled from source without gtk-mac-integration support.
* `xmimsim`: The executable that actually does the hard simulations work. It is usually launched from within the graphical user interface with the _Play_, _Pause_ and _Stop_ buttons from the [control panel](#control-panel), but in some circumstances it may be useful from the command-line as well. It has a lot of options: consult them by running `xmimsim --help`. Windows users will have to use `xmimsim-cli.exe` since `xmimsim.exe` is compiled as a graphical user interface executable in order to avoid a console window from popping up during the simulation in XMI-MSIM.
* `xmimsim-db`: Used to generate the `xmimsimdata.h5` file that contains the tables of physical data (mostly inverse cumulative distribution functions) that will be used during the simulation to speed things up drastically. This executable is intended for those that compile XMI-MSIM from source.
* `xmimsim-conv`: A recently added executable that allows to extract the unconvoluted spectra from an XMSO file and apply the detector response function to it with different settings that were used initially to generate the XMSO file.
* `xmimsim-harvester`: a daemon that collects seeds for the random number generators. Read [the note on the random number generators in the installation instructions](../wiki/Installation-instructions) for more information.
* `xmso2xmsi`, `xmso2spe`, `xmso2csv`, `xmso2htm` and `xmso2svg`: utilities that allow for the conversion of XMSO files to the corresponding XMSI, SPE, CSV, HTML and SVG counterparts, providing the same functionality as obtained through _Tools_ -> _Convert XMSO file to_.
* `xmsi2xrmc`: Utility to convert an XMSI file to the corresponding XRMC input-files. Read [here](#generate-xrmc-input-files) for more information.
* `xmimsim-pymca`: The quantification plug-in that is used by PyMca.

Most of these executables have quite a few options. Consult them by passing the `--help` option to the executable.


## Example files

The example input-file that was created throughout the _[Creating an input-file section](#creating-an-input-file)_ can be downloaded at _[test.xmsi](http://github.com/tschoonj/xmimsim/wiki/test.xmsi)_.
The corresponding output-file can be found at _[test.xmso](http://github.com/tschoonj/xmimsim/wiki/test.xmso)_.

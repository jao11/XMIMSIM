On this page a short manual is presented that should allow users to get started with XMI-MSIM. Although the screenshots were obtained on a Mac, they should be representative for Windows and Linux as well. Significant divergences will be indicated.
The following guide assumes that the user has already installed XMI-MSIM, according to the [Installation instructions](../wiki/Installation-instructions).


* **[Launching XMI-MSIM](#launch)**
* **[Creating an input-file](#create)**
* **[Saving an input-file](#save)**
* **[Starting a simulation](#start)**
* **[Visualizing the results](#results)**
* **[Global preferences](#preferences)**
* **[Checking for updates](#checkforupdates)**
* **[Example files](#examplefiles)**



## <a id="launch"></a>Launching XMI-MSIM

For Mac users: assuming you dragged the app into the Applications folder, use Finder or Spotlight to launch XMI-MSIM.

For Windows users: an entry should have been added to the Start menu. Navigate towards it in _Programs_ and click on XMI-MSIM.

For Linux users: an entry should have been added to the Education section of your Start menu. Since this may very considerably depending on the Linux flavour that is being used, this may not be obvious at first. Alternatively, fire up a terminal and type:

> `xmimsim-gui`

Your desktop should now be embellished with a window resembling the one in the following screenshot.

![XMI-MSIM on startup](../wiki/figures/01start-window.png)

XMI-MSIM may also be started on most platforms by double clicking XMI-MSIM input-files and output-files in your platform's file manager, thereby loading the file's contents.

The main view of the XMI-MSIM consists of three pages that each serve a well-defined purpose. The first page is used to generate inputfiles, based on a number of parameters that are defined by the user. The second page allows for the execution of these files, while the third and last page is designed to visualise the results and help in their interpretation. The purpose of the following sections is to provide an in-depth guide on how to operate these pages. 

When starting XMI-MSIM without providing a file to open, a new file will be started with default settings. The same situation can be obtained at any moment by clicking on _New_ in the menubar.


## <a id="create"></a>Creating an inputfile

The first page consists of a number of frames, each designed to manipulate a particular part of the parameters that govern a simulation.

* [General](#general)
* [Composition](#composition)
* [Geometry](#geometry)
* [Excitation](#excitation)
* [Beam and detection absorbers](#absorbers)
* [Detector settings](#detector)

### <a id="general"></a>General

The _General_ section contains 4 parameters:

* Outputfile: clicking the _Save_ button will pop up a file chooser dialog, allowing you to select the name of the outputfile that will contain the results of the simulation
* Number of photons per discrete line: the excitation spectrum as it is used by the simulation is assumed to consist of a number of discrete energies with each a given intensity (see [Excitation](#excitation) for more information). This parameter will determine how many photons are to be simulated per discrete line. The calculation time is directly proportional to this value
* Number of interactions per trajectory: this parameter will determine the maximum number of interactions a photon can experience during its trajectory. It is not recommended to set this value to higher than 4, since the contribution of increasingly higher order interactions to the spectrum decreases fast. The calculation time is directly proportional to this value
* Comments: use this textbox to write down some notes you think are useful.

### <a id="composition"></a>Composition

This interface allows you to define the system that will make up your sample and possibly its environment. XMI-MSIM assumes that the system is defined as a stack of parallel layers, each defined by its composition, thickness (measured along the [Sample orientation vector](#geometry)) and density. Adding layers can be accomplished by simply clicking the _Add_ button. A dialog will pop up as seen in the following screenshot:

![Defining a new layer](../wiki/figures/03modify-layer.png)

The different elements that make up the layer are added by clicking on the _Add_ button. A small dialog will emerge, enabling you to define a compound or a single element, with its corresponding weight fraction. In the following screenshot, I used `CuSO4` with a weight fraction of 50 % to start with.

![Adding a compound](../wiki/figures/04enter-compound.png)

You may wonder at exactly which chemical formulas are accepted by the interface. Well the answer is: anything that is accepted by _xraylib_'s [CompoundParser](https://github.com/tschoonj/xraylib/wiki/The-xraylib-API:-list-of-all-functions#wiki-compound_parser) function. This includes formulas with (nested) brackets such as: `Ca10(PO4)6OH` (apatite). Invalid formulas will lead to the _Ok_ button being greyed out and the _Compound_ text box gaining a red background.

After clicking ok, you should see something resembling the following screenshot:

![Adding a compound](../wiki/figures/05after-first-compound.png)

You will notice that the compound has been parsed and separated into its constituent elements, with weight fractions according to the mass fractions of the elements.
In this example I added an additional 50 % of `U3O8` to the composition and picked the values 2.5 g/cm3 and 1 cm for density and thickness, respectively, leading to a weights sum of 100 %. It is considered good practice to have the weights sum equal to 100 %. This can be accomplished by either adding/editing/removing compounds and elements from the list, or by clicking the _Normalize_ button, which will scale **all** weight fractions in order to have their sum equal to 100 %. Your dialog should match with this screenshot:

![Adding another compound](../wiki/figures/06after-second-compound.png)

When satisfied with the layer characteristics, press _Ok_.

X-ray fluorescence are quite often performed under atmospheric conditions. If so, it is of crucial importance to add the atmosphere to the system for several reasons:

1. The atmosphere attenuates the beam and the X-ray fluorescence
2. The intensity of the Rayleigh and Compton scatter peaks is greatly influenced by the atmosphere
3. The photons from the beam as well as the fluorescence and the scattered photons will lead to the production of Ar-K fluorescence, a common artefact in X-ray fluorescence spectra. In some rare cases, one may even detect Xe fluorescence.

To add such a layer, click again on _Add_ button. In the _Modify layer_ dialog, add the composition, density and thickness of the air layer. This is shown in the next screenshot:

![Adding air layer](../wiki/figures/07after-adding-air-layer.png)

Clicking the _Ok_ button should lead the following situation in the _Composition_ section:

![Wrong layer order](../wiki/figures/08layers-wrong.png)

However, the ordering of the layers in the table is wrong: **XMI-MSIM assumes that the layers are ordered according to distance from the X-ray source**. This means that the first layer is closest to the source and all subsequent layers are positioned at increasingly greater distances from the source.
This can be easily remedied by selecting a layer and then moving it around using the _Top_, _Up_, _Down_ and _Bottom_ buttons. The following screenshot shows the corrected order of the layers:

![Correct layer order](../wiki/figures/09layers-correct.png)

An important parameter in this table is the _Reference layer_. Using the toggle button, you select which layer corresponds to the one that is considered to be the first layer of the actual _sample_. In most cases, this will indicate the first non-atmospheric layer. The _Reference layer_ is also the layer that is used to calculate the _Sample-source distance_ in the [_Geometry_ section](#geometry).

Layers can be removed by selecting them and then clicking the _Remove_ button. Existing layers may be modified by either double-clicking the layer of interest or by selecting the layer, followed by clicking the _Edit_ button.

Keep in mind that the number of elements influences the computational time greatly, especially when dealing with high Z-elements that may produce L- and M-lines.

### <a id="geometry"></a>Geometry

Scrolling down a little on the _Input parameters_ page reveals the _Geometry_ section as shown in the next screenshot:

![Geometry, excitation and beam absorbers](../wiki/figures/10geometry-excitation-beam-absorbers.png)

This sections covers the position and orientation of the system of layers, detector and slits. In order to fully appreciate the geometry parameters, it is important that I first describe the coordinate system that these position coordinates and directions are connected to:

* The coordinate system is right-handed Cartesian
* The _z_-axis is aligned with the beam direction and points from the source towards the sample.
* The _y_-axis defines, along with the _z_-axis, the horizontal plane
* The _x_-axis emerges out from the plane formed by the _y_- and _z_-axes

This is demonstrated in the following figure:

![Schematic representation of the geometry](../wiki/figures/coordinate_system.png)

Now with this covered, let's have a look at the different _Geometry_ parameters:

* Sample-source distance: the distance between the source and the _Reference layer_ in the system of layers as defined in the [_Composition section_](#composition)
* Sample orientation vector: the normal vector that determines the orientation of the stack of layers that define the sample and its environment. The _z_ component must be strictly positive
* Detector window position: the position of the detector window. This is seen as the point where the photons are actually detected and terminated by the detector. Keep this in mind when defining a collimator
* Detector window normal vector:  the normal vector of the detector window. Should be directed towards the sample (unless you have a very good reason not to do so)
* Active detector area: this corresponds to the area of the detector window that is capable of letting through _detectable_ photons. Should be provided by the manufacturer of your detector
* Collimator height: XMI-MSIM allows for the definition of a conical detector-collimator whose properties are determined by this parameter and the _Collimator diameter_. Setting either to zero corresponds to a situation without collimator. This height parameter is seen as the height of the cone, measured from the detector window to the opening of the collimator, along the detector window normal vector
* Collimator diameter: diameter of the opening of the conical detector collimator. The base of the collimator corresponds to the _Active detector area_
* Source-slits distance: XMI-MSIM defines a set of virtual slits, whose purpose is to define the size of the beam at a given point, based on the distance between these slits and the X-ray source, as well as the _Slits size_, defined by the next parameter. I recommend to have the _Source-slits distance_ correspond to the _Sample-source distance_, since this way the beam, upon hitting the _Reference layer_, will have exactly the dimensions specified by _Slits size_ (if using a point source!)
* Slits size: see previous parameter. Refers to the dimensions of the beam at the _Source-slits_ distance. This parameter will be ignored when dealing with a Gaussian source (see [Excitation section](#excitation))

### <a id="excitation"></a>Excitation

Next, there is the _Excitation_ section, which is used to define the X-ray beam that irradiates the sample. The corresponding excitation spectrum is assumed to consist of a number of discrete energies, each with a horizontally and vertically polarized intensity, as well as a number of parameters that define the type and the aperture of the source. At runtime, the code will use the [_Number of photons per discrete line_](#general) parameter to determine how many photons will be simulated per discrete energy. Adding, editing and removing discrete energies is handled through the buttons in the _Excitation_ section. For example, we can change the settings of the default value by clicking the _Edit_ button.
The dialog contains the fields necessary to define a particular energy:

* Energy: the energy of this particular part of the excitation spectrum, expressed in keV
* Horizontally and vertically polarized intensities: the number of photons that are polarized in the horizontal and vertical planes, respectively. A completely unpolarized beam has identical horizontal and vertical intensities (such as those produced by X-ray tubes), while synchrotron beams will have very, very low vertically polarized intensities. For information on how to convert the total number of photons given the degree of polarization to the horizontal and vertical polarized intenties, consult [Part 5 in our series of papers on Monte-Carlo simulations](../wiki/References-and-additional-resources)
* Source size _x_ and _y_: If both these values are equal to zero, then the source is assumed to be a point source, and the divergence of the beam is completely determined by the _Source-slits distance_ and _Slits size_ parameters of the [_Geometry_](#geometry) section. Otherwise the source is considered a Gaussian source, in which case the photon starting position is chosen according to Gaussian distributions in the _x_ and _y_ planes, determined by the _Source size x_ and _Source size y_ parameters
* Source divergence _x_ and _y_: If these values are non-zero, AND the source is Gaussian, then the _Source-slits distance_ takes on a new role as it becomes the distance between the actual focus and the source position. In this way a convergent beam can be defined, emitted by a Gaussian source at the origin. For the specific case of focusing on the sample the _Sample-source distance_ should be set to the _Source-slits distance_.

In this particular case, I have changed the energy to 20.0 keV, and made the beam unpolarized by equalizing both intensities, as shown in the following screen shot. The source remains a point source.

![Modifying the energy](../wiki/figures/11modify-energy.png)

### <a id="absorbers"></a>Beam and detection absorbers

The two following sections deal with absorbers, first absorbers that are optionally placed in the excitation path (for example a sheet of Al or Cu), and next the absorbers that are optionally placed in the detector path. This means that the former will reduce the intensity of the incoming beam, while the latter will reduce the intensity of the photons that hits the detector.
It is important to realize that these absorbers are only used here for their attenuating properties, they are *not* considered as objects in the simulations so they cannot contribute fluorescence lines to the eventual spectrum!
Adding, editing and removing absorbers is performed through an interface identical to the one seen in the [Composition section](#composition), but without the _Reference layer_ toggle button. New inputfiles will always have a Be detector absorber added, corresponding to the detector window commonly found in ED-XRF detectors.

### <a id="detector"></a>Detector settings

The last section deals with the settings of the detector and its associated electronics, as can be seein in the following screenshot:

![Detector settings](../wiki/figures/12detection-absorbers-and-detector-settings.png)

* Detector type: every detector comes with its own detector response function, which can be influenced by several detector and electronics parameters. XMI-MSIM offers some predefined detector response functions that its authors have found to be reasonably well for two detector types: Si(Li) and Si Drift Detectors. Generally speaking, our policy is to encourage users to implement their own detector response functions in the `xmi_detector_convolute` subroutine of `src/xmi_detector_f.F90` in the source code
* Live time: the actual measurement time of the simulated experiment, taking into account dead time
* Detector gain: the width of one channel of the spectrum, expressed in keV/channel
* Detector zero: the energy of the first channel in the spectrum (channel number zero)
* Detector Fano factor: measure of the dispersion of a probability distribution of the fluctuation of an electric charge in the detector. Very much detector type dependent
* Detector electronic noise: the result of random fluctuations in thermally generated leakage currents within the detector itself and in the early stages of the amplifier components. Contributes to the Gaussian broadening
* Pulse width: the time that is necessary for the electronics to process one incoming photon. This value will be used only if the user enables the pulse pile-up simulation in the [Simulation controls](#start). Although this parameter is connected to several detector and electronics parameters, typically the value is obtained after trial and error
* Max convolution energy: the maximum energy that will be considered when applying the detector response function. Make sure this value is 10-20 % higher than the highest expected energy in the spectrum
* Crystal composition: the composition of the detector crystal. Adding, editing and removing absorbers is performed through an interface identical to the one seen in the [Composition section](#composition), but without the _Reference layer_ toggle button. Will be used to calculate the detector transmission and the escape peak ratios


## <a id="save"></a>Saving an input-file

Once an acceptable inputfile is detected by the application, the _Save_ and _Save as_ buttons will become activated. If the file has not been saved before, clicking either of these buttons will launch a dialog allowing you to choose a filename for the input-file.

If the file was saved before, then clicking _Save_ will result in the file contents will be overwritten with the new file contents.

Keep in mind that XMI-MSIM input-files have the xmsi extension (blue logo), while the output-files the xmso extension (red logo).

## <a id="start"></a>Starting a simulation

* [Control panel](#controlpanel)
* [Executable](#executable)
* [Options](#options)
* [Export results](#exportresults)
* [During a simulation](#during)

In order to start a simulation, the _Input parameters_ page must contain a valid input-file description. This can be obtained by either preparing a new input-file based on the instructions in [a previous section](#create) (and saving it!), or by opening an existing input-file by double clicking an XMI-MSIM input-file in your file manager or opening an input-file through the _Open_ interface of XMI-MSIM.

Either way, the _Simulation controls_ page should look as shown in the following screenshot:

![Simulation controls](../wiki/figures/13simulation-controls.png)


### <a id="controlpanel"></a>Control panel

The top of the page contains the actual control panel that is used to start, stop and pause the simulation, as well as a slider that allows the user to select the number of threads that will be used by the simulation (currently broken in version 2.0, will be fixed in 2.1). To the right of the slider, there are three progress bars that indicate different stages of the Monte Carlo program: the calculation of the solid angle grid for the variance reduction, the simulation of the photon--matter interactions and the calculation of the escape peak ratios. More information about the status of the Monte Carlo program is presented in the adjacent log window. Note: the Windows version does not contain the _Pause_ button.


### <a id="executable"></a>Executable

Underneath these controls is a section that contains the name of the executable that will be used to launch the simulation. Most likely, you will never have to change this value, but it could be interesting to power users, who have customized versions of the simulation program.

### <a id="options"></a>Options

This section is followed by a number of options that change the behaviour of the Monte-Carlo program:

* Simulate M-lines: If disabled, then the code will ignore M-lines that may be produced based on the elemental composition of the sample. In such a case, the code will probably run faster. I strongly recommend to simulate M-lines
* Simulate the radiative and non-radiative cascade effect: the cascade effect is composed of two components, a radiative and a non-radiative one. Although these will always occur simultaneously in reality, the code allows to deactivate one or both of them. This could be interesting to those that want to investigate the contribution of both components. Otherwise, it is recommended to keep both enabled
* Enable variance reduction techniques: disabling this option will trigger the brute-force mode, disabling all variance reduction techniques, thereby greatly reducing the precision of the estimated spectrum and net-line intensities for a given [_Number of photons per discrete line_](#general). This reduced precision may be improved upon by greatly increasing the _Number of photons per discrete line_, but this will result in a much longer runtime of the Monte-Carlo program. Expert use only. Consider building XMI-MSIM with MPI support and running it on a cluster
* Enable pulse pile-up simulation: this option activates the simulation of the so-called sum peaks in a spectrum due to the pulse pile-up effect which occurs when more photons are entering the detector than it can process. The magnitude of this effect can controlled through the [_Pulse width_](#detector) parameter
* Enable Poisson noise generation: enabling this option will result in every channel of the detector convoluted spectrum being subjected to Poisson noise, controlled by Poisson distributions with lambda equal to the number of counts in a channel
* Number of spectrum channels: the number of channels in the produced spectrum.


### <a id="exportresults"></a>Export results

The page ends with a section that allows the user to export the output of the Monte-Carlo program at run-time to several fileformats in addition to the default XMSO fileformat.

* SPE file: the well known ASCII format, readable by PyMca and AXIL. Produces one file per additional interaction. When using the file dialog to choose the filename, make sure not to add a file extension: the Monte-Carlo program will append an underscore, the number of interactions and the .spe extension automatically
* Scalable Vector Graphics (SVG) file: produces an SVG file with vectorized images of the spectra
* Comma Separated Values (CSV) file: produces a CSV file containing several columns. The first column contains the channel number, the second one contains the corresponding channel energy and the following columns contain the intensities for increasing number of interactions
* Report HTML file: produces an html file that can be opened with most Internet Browsers (Internet Explorer being a notable exception), featuring an interactive overview of the results of the Monte-Carlo simulation, simular to the ones shown on the Results page 

It is possible to generate these files afterwards based on the XMSO file, by clicking in the menubar on _Tools_ -> _Convert XMSO file to_.

### <a id="during"></a>During a simulation

When all required options are set up correctly, the simulation can be started by clicking the _Play_ button. After this, you will notice a lot of output being generated in the log window, as well as some activity in the progress bars, as shown in the next screenshot:

![Running the simulation](../wiki/figures/14calculating.png)

The first and the third progress bars will in many cases display a message that the Solid angle grid and the Escape peak ratios were loaded from file: this indicates that a simulation with similar parameters was performed before and that the relevant data was written to a file, leading to a huge increase in speed.

After the simulation, assuming everything went fine, the XMSO outputfile as defined in the [General section](#general) will be loaded and its contents displayed on the Results page.

## <a id="results"></a>Visualizing the results

The results of a simulation are stored in an XMSO file (red logo): you should be able to open these files directly by double clicking them from your file manager.
Alternatively, you can also load these files from within XMI-MSIM by clicking the _Open_ button, and subsequently setting the filetype filter to _XMI-MSIM outputfiles_. On Linux and Windows, you can also open these files from the command-line:

> `xmimsim-gui file.xmso`

XMSO files created after a successful simulation are automatically loaded in the Results page.

* [Plot canvas](#plotwindow)
* [Net-line intensities](#netintensities)
* [Printing and exporting the plot canvas](#exportcanvas)

### <a id="plotwindow"></a>Plot canvas

If a simulation was performed according to the inputfile that was defined [earlier](#create), you should get a result similar to the one in the following screenshot:

![Visualizing the results](../wiki/figures/19results.png)

The plot canvas shows by default the different spectra obtained after an increasing number of interactions. Individual spectra may be hidden and shown by toggling the boxes to the right of the plotting window.
Their properties of a spectrum may be modified by clicking on the _Properties_ button connected to it, which launches a dialog allowing the user to change the line width, line type and line color of the spectrum.

Zooming in on the plot canvas by dragging a rectangle with the mouse while keeping the left button clicked in. Zooming out can be accomplished by double-clicking anywhere in the canvas. While moving the mouse cursor in the plot canvas, one can track the current Energy, Channel number and Intensity in the textboxes to the right.
The size of the canvas can be changed by grabbing and moving the handle that separates the upper part from the lower part of the page.

### <a id="netintensities"></a>Net-line intensities

The lower part of the page contains a list of all the intensities of all the X-ray fluorescence lines of all elements, as shown in the following screenshot:

![Selecting XRF lines](../wiki/figures/20select-lines.png)

By clicking the arrows on the left side of the list, it is possible to expand the sections belonging to a particular element, line, and for different number of interactions, thereby revealing the individual contributions to a particular intensity.
The lines can be shown on the plot canvas by activating the _Show line_ flag for the appropriate line or element.

### <a id="exportcanvas"></a>Printing and exporting the plot canvas

The plot canvas can be printed and exported to several filetypes using the _Print_ and _Save as_ buttons to the right of the plot canvas. Both will result in an exact copy of the current state of the canvas: it will take into account all the changes that were made to the spectra properties, as well as any lines that were activated using the _Show line_ togglebuttons of the _Net-line intensities_ section.
Supported filetypes are PNG, EPS and PDF.

## <a id="preferences"></a>Global preferences

Clicking the _Preferences_ button will launch a dialog allowing the user to set some preferences that will be preserved across sessions off XMI-MSIM. Make sure to press apply after making any changes.

* [Simulation defaults](#simulationdefaults)
* [Updates](#updates)
* [Advanced](#advanced)

### <a id="simulationdefaults"></a>Simulation defaults

The first page of the preferences window contains the same settings that are available on the [_Simulation controls_ page](#start). The values that are selected here will be activated in the _Simulation controls_ page the next time that XMI-MSIM is started.

### <a id="updates"></a>Updates

If XMI-MSIM was compiled with support for automatic updates then this page will contain two widgets: firstly a checkbox that will determine if the program will check for updates at startup, and secondly a list of locations that will be used to download updates from.

### <a id="advanced"></a>Advanced

Currently the _Advanced_ page contains only two entries, which both revolve around the deleting of the XMI-MSIM HDF5 files that contain the solid angle grids and the escape peak ratios, respectively. It is recommended to remove these files manually when a complete uninstall of XMI-MSIM is considered necessary (before running the uninstaller or removing the application manually), or if these files somehow got corrupted.

## <a id="checkforupdates"></a>Checking for updates

For packages of XMI-MSIM that were compiled with support for automatic updates, checking for new versions will occur by default when launching the program. This can be disabled in the [Preferences window](#updates). If you would like to check explicity, then click on _Help_->_Check for updates..._ for Windows and Linux, and XMI-MSIM->_Check for updates..._ for Mac OS X.

When updates are available, a dialog will pop up, inviting the user to download the package through the interface. When the download is completed, quit XMI-MSIM and install the new version. It is highly recommended to always use the latest version of the interface.

## <a id="examplefiles"></a>Example files

The example input-file that was created throughout the _[Creating an input-file section](#create)_ can be downloaded at _[test.xmsi](../wiki/test.xmsi)_.
The corresponding output-file can be found at _[test.xmso](../wiki/test.xmso)_.


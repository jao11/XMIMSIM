On this page a short manual is presented that should allow users to get started with XMI-MSIM. Although the screenshots were obtained on a Mac, they should be representative for Windows and Linux as well. Significant divergences will be indicated.
The following guide assumes that the user has already installed XMI-MSIM, according to the [Installation instructions](../wiki/Installation-instructions).


* **[Launching XMI-MSIM](#launch)**
* **[Creating an input-file](#create)**



## <a id="launch"></a>Launching XMI-MSIM

For Mac users: assuming you dragged the app into the Applications folder, use Finder or Spotlight to launch XMI-MSIM.

For Windows users: an entry should have been added to the Start menu. Navigate towards it in _Programs_ and click on _XMI-MSIM_.

For Linux users: an entry should have been added to the Education section of your Start menu. Since this may very considerably depending on the Linux flavour that is being used, this may not be obvious at first. Alternatively, fire up a terminal and type:

> `xmimsim-gui`

Your desktop should now be embellished with a window resembling the one in the following screenshot.

![XMI-MSIM on startup](../wiki/figures/01start%20window.png)

The main view of the XMI-MSIM consists of three pages that each serve a well-defined purpose. The first page is used to generate inputfiles, based on a number of parameters that are defined by the user. The second page allows for the execution of these files, while the third and last page is designed to visualise the results and help in their interpretation. The purpose of the following sections is to provide an in-depth guide on how to operate these pages. 


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

This interface allows you to define the system that will make up your sample and possibly its environment. _XMI-MSIM_ assumes that the system is defined as a stack of parallel layers, each defined by its composition, thickness and density. Adding layers can be accomplished by simply clicking the _Add_ button. A dialog will pop up as seen in the following screenshot:

![Defining a new layer](../wiki/figures/03modify%20layer.png)

The different elements that make up the layer are added by clicking on the _Add_ button. A small dialog will emerge, enabling you to define a compound or a single element, with its corresponding weight fraction. In the following screenshot, I used `CuSO4` with a weight fraction of 50 % to start with.

![Adding a compound](../wiki/figures/04enter%20compound.png)

You may wonder at exactly which chemical formulas are accepted by the interface. Well the answer is: anything that is accepted by _xraylib_'s [CompoundParser](https://github.com/tschoonj/xraylib/wiki/The-xraylib-API:-list-of-all-functions#wiki-compound_parser) function. This includes formulas with (nested) brackets such as: `Ca10(PO4)6(OH)2` (apatite). Invalid formulas will lead to the _Ok_ button being greyed out and the _Compound_ text box gaining a red background.

After clicking ok, you should see something resembling the following screenshot:

![Adding a compound](../wiki/figures/05after%20first%20compound.png)

You will notice that the compound has been parsed and separated into its constituent elements, with weight fractions according to the mass fractions of the elements.
In this example I added an additional 50 % of `U3O8` to the composition and picked the values 2.5 g/cm3 and 1 cm for density and thickness, respectively, leading to a weights sum of 100 %. It is considered good practice to have the weights sum equal to 100 %. This can be accomplished by either adding/editing/removing compounds and elements from the list, or by clicking the _Normalize_ button, which will scale **all** weight fractions in order to have their sum equal to 100 %. Your dialog should match with this screenshot:

![Adding another compound](../wiki/figures/06after%20second%20compound.png)

When satisfied with the layer characteristics, press _Ok_.

X-ray fluorescence are quite often performed under atmospheric conditions. If so, it is of crucial importance to add the atmosphere to the system for several reasons:

1. The atmosphere attenuates the beam and the X-ray fluorescence
2. The intensity of the Rayleigh and Compton scatter peaks is greatly influenced by the atmosphere
3. The photons from the beam as well as the fluorescence and the scattered photons will lead to the production of Ar-K fluorescence, a common artefact in X-ray fluorescence spectra. In some rare cases, one may even detect Xe fluorescence.

To add such a layer, click again on _Add_ button. In the _Modify layer_ dialog, add the composition, density and thickness of the air layer. This is shown in the next screenshot:

![Adding air layer](../wiki/figures/07after%20adding%20air%20layer.png)

Clicking the _Ok_ button should lead the following situation in the _Composition_ section:

![Wrong layer order](../wiki/figures/08layers%20wrong.png)

However, the ordering of the layers in the table is wrong: **_XMI-MSIM_ assumes that the layers are ordered according to distance from the X-ray source**. This means that the first layer is closest to the source and all subsequent layers are positioned at increasingly greater distances from the source.
This can be easily remedied by selecting a layer and then moving it around using the _Top_, _Up_, _Down_ and _Bottom_ buttons. The following screenshot shows the corrected order of the layers:

![Correct layer order](../wiki/figures/09layers%20correct.png)

An important parameter in this table is the _Reference layer_. Using the toggle button, you select which layer corresponds to the one that is considered to be the first layer of the actual _sample_. In most cases, this will indicate the first non-atmospheric layer. The _Reference layer_ is also the layer that is used to calculate the _Sample-source distance_ in the [_Geometry_ section](#geometry).

Layers can be removed by selecting them and then clicking the _Remove_ button. Existing layers may be modified by either double-clicking the layer of interest or by selecting the layer, followed by clicking the _Edit_ button.

Keep in mind that the number of elements influences the computational time greatly, especially when dealing with high Z-elements that may produce L- and M-lines.

### <a id="geometry"></a>Geometry

Scrolling down a little on the _Input parameters_ page reveals the _Geometry_ section as shown in the next screenshot:

![Geometry, excitation and beam absorbers](../wiki/figures/10geometry%20excitation%20beam%20absorbers.png)

This sections covers the position and orientation of the system of layers, detector and slits. In order to fully appreciate the geometry parameters, it is important that I first describe the coordinate system that these position coordinates and directions are connected to (picture will be added later...):

* The coordinate system is right-handed Cartesian
* The _z_-axis is aligned with the beam direction and points from the source towards the sample.
* The _y_-axis defines, along with the _z_-axis, the horizontal plane
* The _x_-axis emerges out from the plane formed by the _y_- and _z_-axes

Now with this covered, let's have a look at the different _Geometry_ parameters:

* Sample-source distance: the distance between the source and the _Reference layer_ in the system of layers as defined in the [_Composition section_](#composition)
* Sample orientation vector: the normal vector that determines the orientation of the stack of layers that define the sample and its environment. The _z_ component must be strictly positive
* Detector window position: the position of the detector window. This is seen as the point where the photons are actually detected and terminated by the detector. Keep this in mind when defining a collimator
* Detector window normal vector:  the normal vector of the detector window. Should be directed towards the sample (unless you have a very good reason not to do so)
* Active detector area: this corresponds to the area of the detector window that is capable of letting through _detectable_ photons. Should be provided by the manufacturer of your detector
* Collimator height: _XMI-MSIM_ allows for the definition of a conical detector-collimator whose properties are determined by this parameter and the _Collimator diameter_. Setting either to zero corresponds to a situation without collimator. This height parameter is seen as the height of the cone, measured from the detector window to the opening of the collimator, along the detector window normal vector
* Collimator diameter: diameter of the opening of the conical detector collimator. The base of the collimator corresponds to the _Active detector area_
* Source-slits distance: _XMI-MSIM_ defines a set of virtual slits, whose purpose is to define the size of the beam at a given point, based on the distance between these slits and the X-ray source, as well as the _Slits size_, defined by the next parameter. I recommend to have the _Source-slits distance_ correspond to the _Sample-source distance_, since this way the beam, upon hitting the _Reference layer_, will have exactly the dimensions specified by _Slits size_ (if using a point source!)
* Slits size: see previous parameter. Refers to the dimensions of the beam at the _Source-slits_ distance. This parameter will be ignored when dealing with a Gaussian source (see [Excitation section](#excitation))

### <a id="excitation"></a>Excitation

Next, there is the _Excitation_ section, which is used to define the X-ray beam that irradiates the sample. The corresponding excitation spectrum is assumed to consist of a number of discrete energies, each with a horizontally and vertically polarized intensity, as well as a number of parameters that define the type and the aperture of the source. At runtime, the code will use the [_Number of photons per discrete line_](#general) parameter to determine how many photons will be simulated per discrete energy. Adding, editing and removing discrete energies is handled through the buttons in the _Excitation_ section. For example, we can change the settings of the default value by clicking the _Edit_ button.
The dialog contains the fields necessary to define a particular energy:

* Energy: the energy of this particular part of the excitation spectrum, expressed in keV
* Horizontally and vertically polarized intensities: the number of photons that are polarized in the horizontal and vertical planes, respectively. A completely unpolarized beam has identical horizontal and vertical intensities (such as those produced by X-ray tubes), while synchrotron beams will have very, very low vertically polarized intensities. For information on how to convert the total number of photons given the degree of polarization to the horizontal and vertical polarized intenties, consult [Part 5 in our series of papers on Monte-Carlo simulations](../wiki/References-and-additional-resources)
* Source size _x_ and _y_: If both these values are equal to zero, then the source is assumed to be a point source, and the divergence of the beam is completely determined by the _Source-slits distance_ and _Slits size_ parameters of the [_Geometry_](#geometry) section. Otherwise the source is considered a Gaussian source, in which case the photon starting position is chosen according to Gaussian distributions in the _x_ and _y_ planes, determined by the _Source size x_ and _Source size y_ parameters
* Source divergence _x_ and _y_: If these values are non-zero, AND the source is Gaussian, then the _Source-slits distance_ takes on a new role as it becomes the distance between the actual focus and the source position. In this way a convergent beam can be defined, emitted by a Gaussian source at the origin. For the specific case of focusing on the sample the _Sample-source distance_ should be set to the _Source-slits distance_.

In this particular case, I have changed the energy to 20.0 keV, and made the beam unpolarized by equalizing both intensities, as shown in the following screen shot. The source remains a point source.

![Modifying the energy](../wiki/figures/11modify%20energy.png)

### <a id="absorbers"></a>Beam and detection absorbers

The two following sections deal with absorbers, first absorbers that are optionally placed in the excitation path (for example a sheet of Al or Cu), and next the absorbers that are optionally placed in the detector path. This means that the former will reduce the intensity of the incoming beam, while the latter will reduce the intensity of the photons that hits the detector.
It is important to realize that these absorbers are only used here for their attenuating properties, they are *not* considered as objects in the simulations so they cannot contribute fluorescence lines to the eventual spectrum!
Adding, editing and removing absorbers is performed through an interface identical to the one seen in the [Composition section](#composition), but without the _Reference layer_ toggle button. New inputfiles will always have a Be detector absorber added, corresponding to the detector window commonly found in ED-XRF detectors.

### <a id="detector"></a>Detector settings

The last section deals with the settings of the detector and its associated electronics, as can be seein in the following screenshot:

![Detector settings](../wiki/figures/12detection%20absorbers%20and%20detector%20settings.png)

* Detector type: every detector comes with its own detector response function, which can be influenced by several detector and electronics parameters. _XMI-MSIM_ offers some predefined detector response functions that its authors have found to be reasonably well for two detector types: Si(Li) and Si Drift Detectors. Generally speaking, our policy is to encourage users to implement their own detector response functions in the `xmi_detector_convolute` subroutine of `src/xmi_detector_f.F90` in the source code
* Live time: the actual measurement time of the simulated experiment, taking into account dead time
* Detector gain: the width of one channel of the spectrum, expressed in keV/channel
* Detector zero: the energy of the first channel in the spectrum (channel number zero)
* Detector Fano factor: measure of the dispersion of a probability distribution of the fluctuation of an electric charge in the detector. Very much detector type dependent
* Detector electronic noise): the result of random fluctuations in thermally generated leakage currents within the detector itself and in the early stages of the amplifier components. Contributes to the Gaussian broadening
* Pulse width: the time that is necessary for the electronics to process one incoming photon. This value will be used only if the user enables the pulse pile-up simulation in the Simulation controls. Although this parameter is connected to several detector and electronics parameters, typically the value is obtained after trial and error
* Max convolution energy: the maximum energy that will be considered when applying the detector response function. Make sure this value is 10-20 % higher than the highest expected energy in the spectrum
* Crystal composition: the composition of the detector crystal. Adding, editing and removing absorbers is performed through an interface identical to the one seen in the [Composition section](#composition), but without the _Reference layer_ toggle button. Will be used to calculate the detector transmission and the escape peak ratios



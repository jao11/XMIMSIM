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

An important parameter in this table is the _Reference layer_. Using the toggle button, you select which layer corresponds to the one that is considered to be the first layer of the actual _sample_. In most cases, this will indicate the first non-atmospheric layer. The _Reference layer_is also the layer that is used to calculate the _Sample-source distance_ in the _Geometry_ section.

Layers can be removed by selecting them and then clicking the _Remove_ button. Existing layers may be modified by either double-clicking the layer of interest or by selecting the layer, followed by clicking the _Edit_ button.

Keep in mind that the number of elements influences the computational time greatly, especially when dealing with high Z-elements that may produce L- and M-lines.

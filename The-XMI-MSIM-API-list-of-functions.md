(under construction)

XMI-MSIM exposes a large number of its internal functions for use in other programs. This has been used for example in the XMI-MSIM plug-in of the [**XRMC software package for X-ray imaging and spectroscopy**](https://github.com/golosio/xrmc), giving it access to the detector convolution routines, thereby enabling the simulation of ED-XRF spectrometers.

In order to access the XMI-MSIM functionality, you will need to include its headers and link against its library.
On Linux and Mac OS X (when compiled from source!), this can be most easily accomplished using our pkg-config file:

> `gcc pkg-config --cflags libxmimsim) myprogram.c $(pkg-config --libs libxmimsim)`

We intend to include a static library that includes all exported symbols in our next Windows release, allowing you to start development on this platform as well.

Make sure you include the following header in your code:

`#include <xmi_msim.h>`

The following sections show a list of all exported functions, per header. It is not recommended to include these headers directly.






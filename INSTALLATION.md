INSTALLATION
=========================

INSTALL MATLAB
-----------

The latest version of MATLAB can be installed from the [MathWorks website](http://www.mathworks.com.au/products/matlab/ "MathWorks products page").  The version used in this project was R2014a.  Ensure that all of the project files have been added to MATLAB's path. Details on how this is done can be found [here](http://www.mathworks.com.au/help/matlab/ref/addpath.html "Add files to MATLAB path"). NOTE: the text to speech function tts.m was written by Siyi Deng and can be found (here)[http://www.mathworks.com.au/matlabcentral/fileexchange/18091-text-to-speech "tts function"].  To install it simply add it to the MATLAB path.

INSTALL XBOX KINECT SOFTWARE
-----------

This guide is based off *Kinect 360 Setup for Matlab R2014a* by __P. Mahoney__ (2014).

1. Download and install the [Kinect For Windows SDK](http://www.microsoft.com/en-au/download/details.aspx?id=40278 "Kinect for Windows SDK").
2. Download the [Kinect IMAQ Adaptor](http://robotics.itee.uq.edu.au/~metr4202/kinect/kinectimaq.zip "Kinect IMAQ Adaptor"), unzip it and placece the files in a MATLAB direcotry.
3. Install the adapter in MATLAB using the command __>>imaqregister(’H:/metr4202/kinectimaq/mwkinectimaq.dll’)__.
4. Test it was installed correctly run __imaqhwinfo__.  The output should be similar to: __ans=InstalledAdaptors: {’mwkinectimaq’} MATLABVersion: ’8.3 (R2014a)’ ToolboxName: ’Image Acquisition Toolbox’ ToolboxVersion: ’4.7 (R2014a)’__.
5. To recieve input from the kinect run the command __>> vid = videoinput(’mwkinectimaq’, 1);__ which will create an object called __vid__ that can then be shown using the command __>> preview(vid);__.
6. Further documentation can be found from the [MATLAB documentation pages](http://www.mathworks.com.au/help/imaq/examples/using-the-kinect-r-for-windows-r-from-image-acquisition-toolbox-tm.html "Kinect for Windows documentation and examples").

INSTALL DYNAMIXALS
-----------

1. Download the SDK file from the [support page](http://support.robotis.com/en/software/dynamixel_sdk/sourcestructure.htm "SDK for Dynamixals download page").
2. Add the SDK file to path.
2. Connect Dynamixals servo motors using the serial cables.
2. Set the USB2Dynamixal device to TLL mode.
5. Run the initaise() fuction to initaise the dynamixal motors in the matlab environment.

RUN PROGRAM
-----------
To run the program the following functions need to be run (in order):

__kinect_on.m__ Initialises the Kinect and returns the colour and depth vid objects that can then be used to capture images.

__TakeAllCups.m__ The main script that takes all of the cups required off the turntable and fills the orders.

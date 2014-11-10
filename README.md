METR4202 Lab 3 Repository
=========================
 __Project started__ 20/10/2014.
 
 __Last edited:__  09/11/2014.

__Version:__  0.4.
 
GENERAL PROJECT NOTES
-----------
- The __Ford Prefect__ is the name given to the robot this code was written for.  It is a revolute-revolute-revolute *pick and    place* style arm.  It uses three dynamics servo motors to acctuate its limbs.
- To allow easy translation of code from this project to other robotic systems efforts to achieve modularity have been made.
- The code relies on visual input from an Xbox Kinect, and was created in MATLAB R2014a for windsows 7.  This code has not been tested on earlier versions of MATLAB and no guarantee is made that it will work on earlier ones.
- This code is providede *as is* and the developers are not liable for any problems caused by, or with, the code.

INSTALLATION
-----------
__Install MATLAB__

The latest version of MATLAB can be installed from the [MathWorks website](http://www.mathworks.com.au/products/matlab/ "MathWorks products page").

__Install Xbox Kinect Software__

This guide is based off *Kinect 360 Setup for Matlab R2014a* by __P. Mahoney__ (2014).

1. Download and install the [Kinect For Windows SDK](http://www.microsoft.com/en-au/download/details.aspx?id=40278 "Kinect for Windows SDK").
2. Download the [Kinect IMAQ Adaptor](http://robotics.itee.uq.edu.au/~metr4202/kinect/kinectimaq.zip "Kinect IMAQ Adaptor"), unzip it and placece the files in a MATLAB direcotry.
3. Install the adapter in MATLAB using the command __>>imaqregister(’H:/metr4202/kinectimaq/mwkinectimaq.dll’)__.
4. Test it was installed correctly run __imaqhwinfo__.  The output should be similar to: __ans=InstalledAdaptors: {’mwkinectimaq’} MATLABVersion: ’8.3 (R2014a)’ ToolboxName: ’Image Acquisition Toolbox’ ToolboxVersion: ’4.7 (R2014a)’__.
5. To recieve input from the kinect run the command __>> vid = videoinput(’mwkinectimaq’, 1);__ which will create an object called __vid__ that can then be shown using the command __>> preview(vid);__.
6. Further documentation can be found from the [MATLAB documentation pages](http://www.mathworks.com.au/help/imaq/examples/using-the-kinect-r-for-windows-r-from-image-acquisition-toolbox-tm.html "Kinect for Windows documentation and examples").


__Install Dynamics__

BRANDON WRITE THIS SECTION FOR ME - ty, Tom


SUPPORT
-----------
Although support is not guaranteed, users can contact any of the developers if they wish.

__Daryl D'Cruz__ daryl.dcruz1@uqconnect.edu.au.

__Brandon Lydzbinski__ brandon.lydzbinski@uqconnect.edu.au.

__Thomas O'Loughlin__ thomas.oloughlin@uqconnect.edu.au.

__James Purnell__  james.purnell1@uqconnect.edu.au.

__Albert Tate__ albert.tate@uqconnect.edu.au.


COPYRIGHT
-----------
Copyright 2014 to Group 42, METR4202, The University of Queensland.  Permission is hereby granted for the use and modification of any code from this project so long as proper reference is made to this group as the original owners.  

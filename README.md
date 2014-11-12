METR4202 Lab 3 Repository
=========================
 __Project started__ 20/10/2014.
 
 __Last edited:__  12/11/2014.

__Version:__  2.3.
 
GENERAL PROJECT NOTES
-----------
- The __Ford Prefect__ is the name given to the robot this code was written for.  It is a revolute-revolute-revolute *pick and    place* style arm.  It uses three dynamics servo motors to acctuate its limbs.
- To allow easy translation of code from this project to other robotic systems efforts to achieve modularity have been made.
- The code relies on visual input from an Xbox Kinect, and was created in MATLAB R2014a for Windows 7.  This code has not been tested on earlier versions of MATLAB and no guarantee is made that it will work on earlier ones.
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


__Install Dynamixals__

1. Download the SDK file from the [support page](http://support.robotis.com/en/software/dynamixel_sdk/sourcestructure.htm "SDK for Dynamixals download page").
2. Add the SDK file to path.
2. Connect Dynamixals servo motors using the serial cables.
2. Set the USB2Dynamixal device to TLL mode.
5. Run the initaise() fuction to initaise the dynamixal motors in the matlab environment.

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

UPDATE LOG
-----------
__0.0__    After installing all required software (as above) wrote code for taking a snapshot from above.

__0.1__    Wrote code for moving motors to a given angle.

__0.3__    Added ability to locate cups from the image taken by the kinect by detecting circles.

__0.4__    Setup a cup information array to store all of the information about the cups (centerX, centerY, radius, tStamp).

__0.5__    Implemented reverse kinematics, robot can now point to positions in the workspace.

__0.6__    Added cup tracking to allow the calculation of the angular velocity of the turntable.

__0.7__    Created cup pickup motion.

__1.0__    Integrated cup detection and cup grabbing together, allowing a single cup to be picked up autonomously.

__1.1__    Made condiment request function using text-to-speech.

__1.2__    Added code allowing arm to move cup to a set location in the workspace after picking up the cup.

__1.3__    Implemented fiducial marker detection to allow cups to be taken to the coasters.

__1.4__    Added functionality for putting down and dropping off cups.

__1.5__    Fixed bug to do with overloading max() function.

__2.0__    Changed code to allow the arm to repedatively pick up and move multiple cups off the turntable - order is distance from center of timetable.

__2.1__    Added ability to take large or small cups off (in order of closest to center if more than one present).

__2.2__    Implemented ability to take cup to a filling coaster, request to be filled and then be dropped off at an end coaster.

__2.3__    Increased modularity of cup image manipulation functions, small bug fixes.

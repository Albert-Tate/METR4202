METR4202 Lab 3 Repository
=========================
 __Project started__ 20/10/2014.
 
 __Last edited:__  12/11/2014.

__Version:__  2.6.
 
GENERAL PROJECT NOTES
-----------
- The __Ford Prefect__ is the name given to the robot this code was written for.  It is a revolute-revolute-revolute *pick and    place* style arm.  It uses three dynamics servo motors to acctuate its limbs.
- To allow easy translation of code from this project to other robotic systems efforts to achieve modularity have been made.
- The code relies on visual input from an Xbox 360 Kinect, and was created in MATLAB R2014a for Windows 7.  This code has not been tested on earlier versions of MATLAB and no guarantee is made that it will work on earlier ones.
- This code is providede *as is* and the developers are not liable for any problems caused by, or with, the code.

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
Copyright 2014 to Group 42, METR4202, The University of Queensland.  Permission is hereby granted for the use and modification of any code from this project so long as proper reference is made to this group as the original owners.  NOTE: the text to speech function tts.m was written by Siyi Deng and can be found (here)[http://www.mathworks.com.au/matlabcentral/fileexchange/18091-text-to-speech "tts function"].

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

__2.4__    Fixed numerous bugs, now picking up and moving three cups to the filling station robustly.

__2.5__    Integrated text-to-speech functions with the main functions.

__2.6__    Added glass chiming capabilities.

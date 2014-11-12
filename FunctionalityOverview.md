Functionality Overview
=========================


OVERALL
-----------
__TakeAllCups.m__ The main script that takes all of the cups required off the turntable and fills the orders.

ARM KINEMATICS
-----------
fillMe.m -> talk to Brandon


COASTER DETECTION
-----------
__fidREF.png__ Image used to detect fiducial marker in the scene. NOTE: this image might not work with a different camera or in a different environment.  It is recommended a new reference image be taken for such cases.

__getXYZ_coaster.m__ Uses the fiducial reference to locate the corresponding marker in *XYZ* space relative to the robot.

DETECTING CUPS
-----------
In our project the visual input is taken from a birds-eye view.  Thus to detect cups simple circle detection is done (with appropriate radii).  If the camera input is not vertical then a projective transform will need to be done before circle detection.  Example code of this has also been provided.  The files to do with this part of the code are:

__get_circles.m__ Detects circles in the image and records their centers, radii and the time they were detected.

PATHING
-----------
__CircleFitByPratt.m__ Takes in an array of *x* and *y* coordinates and fits a circle to them, outputting the location of the center and the radius.

__Tracking.m__ Function used to test motion planning with a single test on the turntable.

__create_model.m__ Creates a set of radii and centers for multiple cups, then uses this to detect the angular velocity of the turntable.  Utilises a weighted sum to do this, with higher weighting being given to cups further from the center as they will have less error.

__fit_circle.m__ Takes a set of positions and timestamps for a single cup in motion and will fit a circle to them and provide an angular velocity.

REQUESTING CONDIMENTS
-----------
Our team used audio to signal how many of each condiment to place in the waiting cup.  To do this a text to speech function was implemented.  The functions required to do this part are:

__tts.m__ When called with a single string argument "reads" the string out of the current output of the computer (headphones, speaker, etc).

__demand_condiments.m__ Calls tts() with set phrases depending on the amount of coffee, tea, sugar and expressos requested (each of which are an integer argument to the function).


OLD
-----------
This section contains all of the old, discontinued files that were created for the project.

__VisualServoingProofConcept.m__ Old function used to see if visual servoing could be implemented.  Discontinued when it was realised that frame rate wasn't high enough to handle fine movements.

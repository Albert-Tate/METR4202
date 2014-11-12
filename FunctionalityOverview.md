Functionality Overview
=========================


OVERALL
-----------
This section contains the main functions used in the project.

__TakeAllCups.m__ The main script that takes all of the cups required off the turntable and fills the orders.

ARM KINEMATICS
-----------
All of the files that are needed to move the arm around the workspace, as well as those used to go through predefined movements such as picking up and putting down cups.

fillMe.m -> talk to Brandon

__readMotorAngles.m__ Reads in the current angles of the three motors being used and outputs them in an array.

__setMotorAngles.m__ Takes in three angles and sets motors one, two and three to them (respectively).

__setSpeed.m__ Sets the speed of the three motors based on the three speeds input (respectively).

COASTER DETECTION
-----------
The functions that are used to detect and locate the fudicial markers that represent coasters.  The coasters are used to represent fill locations and customer pickup locations.

__fidREF.png__ Image used to detect fiducial marker in the scene. NOTE: this image might not work with a different camera or in a different environment.  It is recommended a new reference image be taken for such cases.

__machine.png__ Image used to detect the filling location (another fiducial marker reference image).

__getXYZ_coaster.m__ Uses the fiducial reference to locate the corresponding marker in *XYZ* space relative to the robot.

DETECTING CUPS
-----------
In our project the visual input is taken from a birds-eye view.  Thus to detect cups simple circle detection is done (with appropriate radii).  If the camera input is not vertical then a projective transform will need to be done before circle detection.  Example code of this has also been provided.  The files to do with this part of the code are:

__get_circles.m__ Detects circles in the image and records their centers, radii and the time they were detected.

__get_circlesIM.m__ A slight modification to get_circles that takes an image instead of a video steram.  NOTE: the time stamp is from when the functiuon is called and not when the picture was taken.

PATHING
-----------
All of the functions required to identify how the cups are moving and how long until they are in a location where they are able to be picked up.  Includes finding the angular velocity of the turntable, and creating models of its movement.

__CircleFitByPratt.m__ Takes in an array of *x* and *y* coordinates and fits a circle to them, outputting the location of the center and the radius.

__Tracking.m__ Function used to test motion planning with a single test on the turntable.

__create_model.m__ Creates a set of radii and centers for multiple cups, then uses this to detect the angular velocity of the turntable.  Utilises a weighted sum to do this, with higher weighting being given to cups further from the center as they will have less error.

__fit_circle.m__ Takes a set of positions and timestamps for a single cup in motion and will fit a circle to them and provide an angular velocity.

__get_map_canidate.m__ Provides mapping between the original model and the recently detected cups.  Internally sorts by path radius to find the outermost cup of the specified type.  We choose the outermost cup to reduce the chance of knocking over other cups.

REQUESTING CONDIMENTS
-----------
Our team used audio to signal how many of each condiment to place in the waiting cup.  To do this a text to speech function was implemented.  The functions required to do this part are:

__tts.m__ When called with a single string argument "reads" the string out of the current output of the computer (headphones, speaker, etc).

__demand_condiments.m__ Calls tts() with set phrases depending on the amount of coffee, tea, sugar and expressos requested (each of which are an integer argument to the function).


OLD
-----------
This section contains all of the old, discontinued files that were created for the project.

__VisualServoingProofConcept.m__ Old function used to see if visual servoing could be implemented.  Discontinued when it was realised that frame rate wasn't high enough to handle fine movements.

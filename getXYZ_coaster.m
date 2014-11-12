function [ COORDS, TIMEOUT ] = getXYZ_coaster( fiducialIMG, coasterIMG, ...
                                cv, coaster2Robot, K  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
elapsed = 0;
TIME_MAX = 15;
scene = getsnapshot(cv);
%% Find coaster
coasterBox = [0 0 0 0];
while(coasterBox(1) == 0),
    try
        coasterBox = get_surf_match(scene, coasterIMG);
    catch err
    end
    scene = getsnapshot(cv);
    elapsed = elapsed + 1
    if(elapsed > TIME_MAX),
        COORDS = -1;
        TIMEOUT = 1;
        return
    end
end

%% Find Marker
fidBox = [0 0 0 0];
while(fidBox(1) == 0),
    try
        fidBox = get_surf_match(scene, fiducialIMG);
    catch err
    end
    scene = getsnapshot(cv);
    elapsed = elapsed + 1
    if(elapsed > TIME_MAX),
        COORDS = -1;
        TIMEOUT = 1;
        return
    end
end

%% Find 3D location
marker3D = pixel2meat(K, coasterBox(1) + 0.5*coasterBox(3),...
                       coasterBox(3) + 0.5*coasterBox(4), 57.5);
FID3D = pixel2meat(K, fidBox(1) + 0.5*fidBox(3),...
                             fidBox(3) + 0.5*fidBox(4), 57.5);
%Reassign Axes
COORDS = [0; 0; 0];
FID3D(1) = -FID3D(1);
marker3D(1) = -marker3D(1);
COORDS = (marker3D - FID3D) - coaster2Robot;%[10.5;21;0];
COORDS(2) = - COORDS(2);
COORDS(1) = -COORDS(1);
COORDS
TIMEOUT = 0;

end


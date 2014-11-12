function [ COORDS, TIMEOUT ] = getXYZ_coaster( fiducialIMG, coasterIMG, ...
                                cv, coaster2Robot, K  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
elapsed = 0;
TIME_MAX = 15;
scene = getsnapshot(cv);
%% Find coaster
coaster = [0 0 0 0];
while(coaster(1) == 0),
    try
        coaster = get_surf_match(scene, coasterIMG);
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
fid = [0 0 0 0];
while(fid(1) == 0),
    try
        fid = get_surf_match(scene, fiducialIMG);
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
FOVy = 43*pi/180;

y = coaster(2);
Z = 57.5/(cos(abs((240-y)/240)*FOVy/2));
marker3D = pixel2meat(K, coaster(1),...
                       coaster(2), Z);
y = fid(2);
Z = 57.5/(cos(abs((240-y)/240)*FOVy/2));            
FID3D = pixel2meat(K, fid(1),...
                       fid(2), Z);
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


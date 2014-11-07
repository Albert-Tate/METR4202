function [ COORD, ID ] = ID_cups( box, Image, DepthImage, K_camera )
%ID_Cups Returns ID of cup depending on what depth variation occurs over
%box in DepthImage
%   ID = 1 ; Smallest Cup
%   ID = 2 ; Medium Cup
%   ID = 3 ; Large Cup
%   ID = 0 ; Error

%% Create and translate bounding boxes
   %Do not try to fix
grayImage = rgb2gray(Image);
depthBox(1) = round((box(1) - 1(5)*1.07418118); %transformy business 
depthBox(3) = round((box(3) + box(1)) - 15)*1.07418118) - depthBox(1);
depthBox(2) = round((box(2) + 25)*0.880541922);
depthBox(4) = box(4);%round((box(4) + 480)*0.35297548);% - depthBox(2);

%% Find angular size of box, makes assumption that box is correct
DepthImage = transpose(DepthImage);
grayImage = transpose(grayImage);
pixelheight = 480;
FOVy = 37.5*pi/180; %37.5 degrees
theta = FOVy*(abs(depthBox(4))/pixelheight);

%% Find Z at bottom of cup
zlow = 0;
i = 0;
% index depth image at center of bottom of the box and count upwards
%   |     |
%   |     |
%   | ^^^ |
%   |__x__|
while zlow == 0,
   zlow = DepthImage(round((depthBox(1) + 0.5*depthBox(3))), ...
                (depthBox(2) + depthBox(4)) - i);
   i = i + 1;
end
ZDIST = zlow;
%% Count upwards from i in bounding box until dz > tol
tol = 3;
dz = 0;
nz = 0;
oz = zlow;
while dz < tol,
   nz = DepthImage((round(depthBox(1) + 0.5*depthBox(3))), ...
                (depthBox(2) + depthBox(4)) - i);
   i = i + 1;
   dz = abs(nz - oz);
   if ( dz > tol ),
       break
   end
   if ( i > box(4)); %Trust box more than depthmap
       break
   end
   oz = nz;
end

%% Now we have zlow, nz to describe bottom and top of cup distance from camera
  %Use this to calculate height of cup in metric coords

h = (double(zlow)/K_camera(2,2))*(box(2) + box(4) - K_camera(2,3)) ...
    - (double(nz)/K_camera(2,2))*(box(2) - K_camera(2,3)); %Zb/fy*(Yb) - Zt/fy*(Yt) 
h = double(h)/1000; %metrix

%% Check this range to ID cups from height
%We know these values aren't the exact heights, but they represent the bins
tolrange = 11/1000; %mm
cupSmall = 59/1000;
cupMed = 88/1000; %93
cupLarge = 105/1000;
%Important note: These are designed with 25 degrees in mind
%as height is found Y => cupH/sin(90-ANGLE)
if (h > 0 && h < 0.1),
    ID = 1;
elseif (h < 0.114),
    ID = 2;
elseif (h < 0.14),
    ID = 3;
else
    ID = 0;
end

%% Use pixel2meat to find Metric space of cups
COORD = [0,0,0];
xp = double(box(1) + 0.5*box(3));
yp = double(box(2));
COORD = pixel2meat(K_camera, xp, yp, double(ZDIST)/1000);
COORD = [COORD(3), -COORD(1), -COORD(2)]; %Now x is from camera, right is y and height is z. from camera normal frame
end


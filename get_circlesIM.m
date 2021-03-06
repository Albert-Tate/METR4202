function [centres, radii, TSTAMP] = get_circlesIM(image, K)
%get_circles takes in a video input and returns the centres and radii of
%present circles.
%   Takes an image from the input video stream and then runs circle
%   detection on that image.  Then returns the centres and radii of
%   all of the detected circles. Undistorts image if K != 0.
%   Will fail like a Libyan Government if K is not a true cameraParams
%   matrix or 0.

%% Initial Setup
DEBUG = 0;
%if radii > about 55 we have a large cup
%this is likely to be fairly consistent once we undistort
min_rad = 50;
max_rad = 80;


%% Image Setup
timeTEMP = clock;
% image = getsnapshot(vid); %can get timestamp from video device?
%timestamp
%          MINUTES         SECONDS
TSTAMP = timeTEMP(5)*60 + timeTEMP(6);
%For obvious reasons the Timestamps will break if run time > 24 hours

%% Condition Image
if(any(K)), %If given a K matrix
    image = undistortImage(image, K);
end
I_gray = rgb2gray(image);        % Convert to grayscale.
%I_gray = image;
I_edge = edge(I_gray, 'canny');    % Edge detection.

%% Detect Circles
[centres, radii] = imfindcircles(I_edge,[min_rad max_rad], ...
        'ObjectPolarity','bright', 'Sensitivity', 0.90,...
         'Method','PhaseCode');
     
%% Graph Circles
if DEBUG,
    figure;
    imshow(I_gray);
    imshow(I_edge);
    h = viscircles(centres, radii);
end



     
end


function [centres, radii] = get_circles(vid)
%get_circles takes in a video input and returns the centres and radii of
%present circles.
%   Takes an image from the input video stream and then runs circle
%   detection on that image.  Then returns the centres and radii of
%   all of the detected circles.

%% Initial Setup
DEBUG = 0;
%if radii > about 55 we have a large cup
%this is likely to be fairly consistent once we undistort
min_rad = 50;
max_rad = 90;

%% Image Setup
image = getsnapshot(vid);

%I_scaled = image; %imresize(image, scale);  % Scale image.
I_gray = rgb2gray(image);        % Convert to grayscale.
I_edge = edge(I_gray, 'canny');    % Edge detection.
    
[centres, radii] = imfindcircles(I_edge,[min_rad max_rad], ...
        'ObjectPolarity','bright', 'Sensitivity', 0.90,...
         'Method','PhaseCode');
if DEBUG
%     figure(1);
%     imshow(image);
    figure;
    imshow(I_gray);
    imshow(I_edge);
    h = viscircles(centres, radii);
end



     
end


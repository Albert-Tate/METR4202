function [ PIXLOC ] = get_surf_match( image, refImage )
%get_surf_match Returns Bounding box of refImage in image
%   Will gravitate towards top left corner of found object

DEBUG = 1;

image = rgb2gray(image); refImage = rgb2gray(refImage);

imagePoints = detectSURFFeatures(image);
refPoints = detectSURFFeatures(refImage);

[imfeatures, impoints] = extractFeatures(image, imagePoints);
[reffeatures, refpoints] = extractFeatures(refImage, refPoints);

pairs = matchFeatures(reffeatures, imfeatures);
matchedRefPoints = refpoints(pairs(:, 1), :);
matchedImagePoints = impoints(pairs(:, 2), :);

[tform, inlierRefPoints, inlierImagePoints] = ...
    estimateGeometricTransform(matchedRefPoints, ...
    matchedImagePoints, 'affine');

box = [1, 1;...                           % top-left
        size(refImage, 2), 1;...                 % top-right
        size(refImage, 2), size(refImage, 1);... % bottom-right
        1, size(refImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon

newBox = transformPointsForward(tform, box)

%Pixloc is [xtopl, ytopl, wid, height]
PIXLOC = [newBox(1,1), newBox(1,2),...
        (newBox(2,1) - newBox(1,1)),...
        (newBox(3,2) - newBox(1,2))];
    

if DEBUG,
    figure;
    imshow(image);
    hold on;
   % line(newBox(:, 1), newBox(:, 2), 'Color', 'y');
    rectangle('Position',[PIXLOC(1),PIXLOC(2),PIXLOC(3),PIXLOC(4)], ...
        'EdgeColor','r','LineWidth',2 );
    title('Detected Tea');
end

end


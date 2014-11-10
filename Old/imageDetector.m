function [ boxes, markers ] = imageDetector( image )
%imageDetector Finds bounding boxes in pixel space of cups

%Create detector
detector = vision.CascadeObjectDetector('Detectors\pPhotos.xml');
%find boxes
boxes = step(detector, image);

detector = vision.CascadeObjectDetector('Detectors\pFid.xml');
markers = step(detector, image);

end


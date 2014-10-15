function [colourVid, depthVid  ] = kinect_on( )
%UNTITLED Summary of this function goes here
%   [colourVid, depthVid] = kinect_on()

colourVid = videoinput('mwkinectimaq', 1);
depthVid = videoinput('mwkinectimaq', 2);

start(colourVid);
start(depthVid);

end


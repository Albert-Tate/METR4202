function [ frameBpoint ] = kin2frame( translation,kinpoint, gamma, beta, alpha )
%kin2frame Transforms point from kinect frame into world frame
%   Uses Euler angles for rotation. Tx/y/z is location of Frame in kinect
%   space, X/Y/Zp is location of point in kinect frame to be translated
%   
%   translation is from kinframe to frame
%   Rotation is from frme to kinect
%rotate in z, rotate in y then rotate in x ALL AROUND ORIGINAL AXES
%how do i rotate my frame such that it meets the kinect?

aPb = makehgtform('translate', [translation(1), translation(2), translation(3)]);
aP = makehgtform('translate', [kinpoint(1), kinpoint(2), kinpoint(3)]);
% rot = transpose(makehgtform('zrotate',alpha)...
%     *makehgtform('yrotate',beta)*makehgtform('xrotate',gamma));

rot = roty(beta);

% frameBpoint = transpose(translation) + rot*transpose(kinpoint);
frameBpoint = rot*transpose(kinpoint - translation);

frameBpoint = transpose(frameBpoint);
%(aP - aPb)*inv(rot);
return

end


function [ meatspace ] = pixel2meat( K_camera, xPixel, yPixel, Zdepth )
%pixel2meat Transforms pixel image to metric given a calibration matrix and
%depth
%   K_camera is a 3*3 matrix of the form: [fx, alpha_c*fx, px; 
                                          %0, fy,          py;
                                          %0, 0,          1]
%   K_camera must be invertable k = transpose(cameraParams.IntrinsicMatrix)
%   xPixel and yPixel are measured relative to the top left of the image
%   zDepth must be in mm

%TODO: Check if zdepth is 0 or other error val

if(det(K_camera) == 0),
    fprintf('ERROR: Calibration matrix not invertible.\n');
    return;
end

%Meatspace is homogonised w.r.t Z
meatspace = K_camera\[xPixel*Zdepth; yPixel*Zdepth; Zdepth];

% Zdepth = Zdepth*1000;
% meatspace = K_camera\[xPixel*Zdepth + double(K_camera(1,1)); yPixel*Zdepth + double(K_camera(2,2)); Zdepth];
% 
% meatspace = meatspace/1000;
% In practice: (x, y, z) =
% pixel2meat(transpose(cameraParams.IntrinsicMatrix), x, y, depth(x, y))
%cannot do depth(x,y) because reasons, must pass a number
%Extra Reading: 
%http://homepages.inf.ed.ac.uk/rbf/BOOKS/BANDB/LIB/bandbA1_2.pdf

return;

end


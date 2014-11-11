function [moving] = moving()
%   moving()
%   outputs 1 if moving
%   [motor 1, motor 2, motor 3]

%% Initialise
DEFAULT_PORTNUM = 6;  %COM6
DEFAULT_BAUDNUM = 1;  %//1Mbps
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

%% Read moving bit (46)
x = calllib('dynamixel', 'dxl_read_byte', 1, 46);
y = calllib('dynamixel', 'dxl_read_byte', 2, 46);
z = calllib('dynamixel', 'dxl_read_byte', 3, 46);

%% Terminate
calllib('dynamixel', 'dxl_terminate');

moving = [x,y,z];


end

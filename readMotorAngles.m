function [y] = readMotorAngles()
%readMotorAngles()
%   reads the current position of each motor

%% Initialise
DEFAULT_PORTNUM = 6;  %COM6
DEFAULT_BAUDNUM = 1;  %//1Mbps
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

%% Read current angles
aR1 = calllib('dynamixel', 'dxl_read_word', 1, 36);
aR2 = calllib('dynamixel', 'dxl_read_word', 2, 36);
aR3 = calllib('dynamixel', 'dxl_read_word', 3, 36);

%% Terminate
calllib('dynamixel', 'dxl_terminate');

y = [aR1*0.29, aR2*0.29, aR3*0.29];


end


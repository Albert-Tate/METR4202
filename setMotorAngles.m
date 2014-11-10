function [x] = setMotorAngles( a2m1, a2m2, a2m3)
%angles2Motors(angle 1, angle 2, angle 3)
%   moves the dynamixel motor to the inputed angle
%   outputs the read angle/goal position
%   mode = 0 (joint)


%% Initalise
DEFAULT_PORTNUM = 6;  %COM6
DEFAULT_BAUDNUM = 1;  %//1Mbps
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

%% Move motors
calllib('dynamixel', 'dxl_write_word', 1, 30, a2m1/0.29);
calllib('dynamixel', 'dxl_write_word', 2, 30, a2m2/0.29);
calllib('dynamixel', 'dxl_write_word', 3, 30, a2m3/0.29);

%% Reads Goal position
aR1 = calllib('dynamixel', 'dxl_read_word', 1, 30);
aR2 = calllib('dynamixel', 'dxl_read_word', 2, 30);
aR3 = calllib('dynamixel', 'dxl_read_word', 3, 30);

%% Terminates
calllib('dynamixel', 'dxl_terminate');

x = [aR1*0.29, aR2*0.29, aR3*0.29];

end


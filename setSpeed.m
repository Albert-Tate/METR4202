function [ speed ] = setSpeed(m1, m2, m3)
%setSpeed(motor1, motor2, motor3)
%   sets the speed of the each motor
%   dynamixels take 0->1023 speed value
%   function setSpeeds takes input speed values 0->1
%   0 = no speed,  1 = 100% of its max speed
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% input  = 0->1 %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   outputs the set speed

%% Initalise
DEFAULT_PORTNUM = 6;  %COM6
DEFAULT_BAUDNUM = 1;  %//1Mbps

%% Write Speed Values
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
calllib('dynamixel', 'dxl_write_word', 1, 32, m1*1000);
calllib('dynamixel', 'dxl_write_word', 2, 32, m2*1000);
calllib('dynamixel', 'dxl_write_word', 3, 32, m3*1000);

%% Reads the set speed
s1 = calllib('dynamixel', 'dxl_read_word', 1, 32);
s2 = calllib('dynamixel', 'dxl_read_word', 2, 32);
s3 = calllib('dynamixel', 'dxl_read_word', 3, 32);

%% Terminates
calllib('dynamixel', 'dxl_terminate');

%%
speed = [s1/1000, s2/1000, s3/1000];


end


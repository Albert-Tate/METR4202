function [x]=initalise()
%initalise() 
%   Initalises the dynamixal motors and loads the dynamixel libary.

loadlibrary('dynamixel', 'dynamixel.h');
libfunctions('dynamixel');

%% Initialise
DEFAULT_PORTNUM = 6;  %COM6
DEFAULT_BAUDNUM = 1;  %//1Mbps
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

calllib('dynamixel', 'dxl_write_byte', 1, 28, 128);
calllib('dynamixel', 'dxl_write_byte', 1, 29, 128);
calllib('dynamixel', 'dxl_write_byte', 2, 28, 128);
calllib('dynamixel', 'dxl_write_byte', 2, 29, 128);
calllib('dynamixel', 'dxl_write_byte', 3, 28, 128);
calllib('dynamixel', 'dxl_write_byte', 3, 29, 128);
setSpeed(0.1, 0.1, 0.1);
calllib('dynamixel', 'dxl_terminate');


%% Only run the initialze code below when doing something with the motors
% DEFAULT_PORTNUM = 6;  %COM6
% DEFAULT_BAUDNUM = 1;  %Board Rate Mbps
% calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);


end


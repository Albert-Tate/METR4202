function shutDown()
%shutDown() 
%   Unloads the dynamixel libary and terminates the motors

calllib('dynamixel', 'dxl_terminate');
unloadlibrary('dynamixel');

end


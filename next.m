function [  ] = next( x,y,z )
%next(x,y,z)
%   input = x, y and z location of the coaster to serve the cup to the customer and repositions itself ready to pick up
%   the next cup off the turn table
%   this function is called after the cup is filled with the condiments
%   ie. after the fillMe(x,y,z) is called

setSpeed(0.1, 0.1, 0.1);
mA = inv_kin(x,y,z)
if(mA(3) >= b2c(mA(2))),
    mA(3) = b2c(mA(2));
    mA
end
cmA = readMotorAngles(); 
setMotorAngles(mA(1),cmA(2),cmA(3));
while (1),
    iM = moving();
    if(iM(1) == 0),
       break 
    end
end

setMotorAngles(mA(1),cmA(2),mA(3));
setMotorAngles(mA(1),mA(2),mA(3)+25);

while (1),
    iM = moving();
    if(iM(2) == 0),
       break 
    end
end
pause(1);
cmA = readMotorAngles();
prev = cmA(3);
cmA(3) = b2c(cmA(2))
setMotorAngles(cmA(1), cmA(2), cmA(3));
while (1),
    iM = moving();
    if(iM(3) == 0),
       break 
    end
end
% pause(6)
cmA = readMotorAngles();
cmA(3) = b2c(cmA(2))
setMotorAngles(cmA(1), cmA(2), cmA(3));
while (1),
    iM = moving();
    if(iM(3) == 0),
       break 
    end
end
% pause(6)
setSpeed(0.1, 0.1, 0.2);
setMotorAngles(cmA(1), 60, 15);
while (1),
    iM = moving();
    if(iM(2) == 0),
       break 
    end
end
%% Takes the arm back to the ready postion, ready to pick up the next cup
grabFrom1(150);

end


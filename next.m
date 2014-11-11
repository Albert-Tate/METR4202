function [  ] = next( x,y,z )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
setSpeed(0.1, 0.1, 0.1);
mA = inv_kin(x,y-3,12)
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
grabFrom1(150);

end


function [ ] = fillMe( x, y, z )
%fillMe(x,y,z)
%   input = x, y and z location of the machine that filles the cup up with coffee
%   this function is called after the cup is picked up
%   ie. after the grabFrom2(a) is called

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

%% Add coffee audio

setMotorAngles(cmA(1), cmA(2)+20, prev);
while (1),
    iM = moving();
    if(iM(3) == 0),
       break 
    end
end


end


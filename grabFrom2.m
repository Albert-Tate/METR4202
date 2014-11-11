function [ok] = grabFrom2(a)
% grabFrom2(a)
%   input = motor 1 angle
%   outputs 1 if ok
%   this function is called once the arm is in the ready position to pick up the cup off the turntable
%   ie. after grabFrom1(a) has been called


%% Grabs Cup
setSpeed(0.28,0.28,0.4);
setMotorAngles(a, 105, 100);
% pause(1)
setSpeed(0.28,0.28,0.28);
setMotorAngles(a, 150, 130);
% setSpeed(0.1,0.1,0.1);
setMotorAngles(a, 180,150);
while (1),
    temp = readMotorAngles();
    tol = 180/10; %10% tollerance
    if(~((180 - tol) > temp(2)) || ((180 + tol) < temp(2))),
       break 
    end
end

ok = 1;

end


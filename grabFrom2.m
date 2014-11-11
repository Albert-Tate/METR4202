function [ok] = grabFrom2(a)
% grabFrom2(a)
%   inputs


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
    tol = 180/10; %30
    if(~((180 - tol) > temp(2)) || ((180 + tol) < temp(2))),
       break 
    end
end

ok = 1;

end


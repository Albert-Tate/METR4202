function [ok] = grabFrom1(a)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Gets in ready position
setSpeed(0.1,0.1,0.1);
%ReadyPosition
setMotorAngles(a, 62, 2);
% pause(3)
%Stage 1
setMotorAngles(a, 84, 57);
% pause(3)
% % % % p = 'press enter to grab';
% % % % res = input(p);


end


function [ok] = grabFrom1(a)
% grabFrom1(a)
%   input = motor 1 angle
%   outputs 1 if ok
%   this function is used to get the arm in the ready postion ready to pick up the cup

%% Gets in ready position
setSpeed(0.1,0.1,0.1);
setMotorAngles(a, 62, 2);
setMotorAngles(a, 84, 57);

%% Commented code is used to manulaly control the arm for testing purposes,
% Please disreguard the follow code below in comments
% % % % p = 'press enter to grab';
% % % % res = input(p);


end


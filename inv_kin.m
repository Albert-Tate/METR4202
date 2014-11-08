function [ angles, ERR ] = inv_kin( xp, yp, zp )
%inv_kin inverse kinematics for 3R Robot arm
%   coords need to be in cm

%Robot Description
H1 = 19.1; %cm
L0 = 6.8;
L1 = 15.7;
L2 = 9;

%variables for frame for RR 2D case
dp = sqrt(xp^2 + yp^2) - L0;
zsp = zp - H1;

xp = -xp; %Because

%Rotation
th1 = (atan(xp/yp) + 150*pi/180)*180/pi;

%Evil trig in 2D case
th3_RAD = acos((dp^2 + zsp^2 - L1^2 - L2^2)/(2*L1*L2));
th3 = th3_RAD*180/pi;
%LSD required to understand
th2 = acos((dp*(L1 + L2*cos(th3_RAD)) + zsp*L2*sin(th3_RAD))/(dp^2 + zsp^2))*180/pi;

angles = [th1, th2-60, th3+50];

end


function [ time ] = time_to_grab(armPOS, cupPOS, path_C, path_R, omega )
%time_to_grab Find time until grab should be performed
%   cupPOS is current position of cup
%   path_C and path_R describe motion path of cup (see fit_circle.m)
%   omega is speed of cup (rad/s)
%   armPOS is location of arm end effector (2D)
%   Function will return time until the cup is at the location 
%   on the circle geometrically closest to armPOS

DEBUG = 1;
%First find position on circle closest to arm

%angle from centre of circle to armPOS
theta = atan((armPOS(2) - path_C(2)) / (armPOS(1) - path_C(1))); 
%2 canidates for position
xP1 = path_C(1) + path_R*cos(theta);
yP1 = path_C(2) + path_R*sin(theta);

xP2 = path_C(1) - path_R*cos(theta);
yP2 = path_C(2) - path_R*sin(theta);
%find closest match
if( sqrt((armPOS(1)-xP1)^2 + (armPOS(2)-yP1)^2) < sqrt((armPOS(1)-xP2)^2 + (armPOS(2)-yP2)^2)),
    xP = xP1;
    yP = yP1;
else
    xP = xP2;
    yP = yP2;
end

%find angular distance between cup and intercept point DOESN'T WORK
P = [xP, yP];
Pc = P - path_C;
cupPOSc = cupPOS - path_C;

%find clockwise angle
    %Magical trig
 diff = atan2( (Pc(1)*cupPOSc(2) ) - (Pc(2)*cupPOSc(1)),...
         (Pc(1)*cupPOSc(1) + Pc(2)*cupPOSc(2)));
diff = mod(diff, 2*pi);
time = diff/omega;

%should never happen but will ensure negative wait times are impossible
if(time < 0),
    time = 2*pi/omega + time;
end

if (DEBUG == 1),
    figure;
    d = path_R*2;
    px = path_C(1)-path_R;
    py = path_C(2)-path_R;
    h = rectangle('Position',[px py d d],'Curvature',[1,1]);
    daspect([1,1,1])
    hold on
    scatter(xP,yP);
    hold on
    scatter(armPOS(1),armPOS(2), 'filled');
    hold on
    scatter(cupPOS(1),cupPOS(2),  'd');
end 

end


function [ path_C, path_R, omega ] = fit_circle(POS, TSTAMPS)
%fit_circle fit circle to data POS
%   Will fit circle to data POS (structured x,y;x,y; etc
%   and will also measure speed (rad/s) from TSTAMPS (in s)
%   OUTPUTS: path_C center of circle
%            path_R radius of circle
%            omega speed of cup

DEBUG = 1;

PAR = CircleFitByPratt(POS);

path_C = [PAR(1), PAR(2)];

path_R = PAR(3);

RES = zeros(size(POS,1)-1,1);
for i = 1:(size(POS,1)-1),
   %At each point find angular distance to next point
   %Divide through by time difference to get rad/s
   ANG1 = atan((POS(i,2)-path_C(2))/(POS(i,1) - path_C(1))); %yp-yc/xp-xc
   ANG2 = atan((POS(i+1,2)-path_C(2))/(POS(i+1,1) - path_C(1)));
   
   dist = abs(ANG2 - ANG1);
   RES(i) = (dist/(TSTAMPS(i+1) - TSTAMPS(i)));
   
end
omega = mean(RES);

if(DEBUG == 1),
    figure;
    d = path_R*2;
    px = path_C(1)-path_R;
    py = path_C(2)-path_R;
    h = rectangle('Position',[px py d d],'Curvature',[1,1]);
    daspect([1,1,1])
    hold on
    scatter(POS(:,1), POS(:,2));
   %plot things 
end



end


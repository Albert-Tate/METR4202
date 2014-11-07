delete(findall(0,'Type','figure'))
%initial positions
xcup = 60 + randi(40, 1);
ycup = 100 + randi(50, 1);
vxcup = 0;
vycup = 0;

box = [140 + randi(40, 1), 80 + randi(80, 1), 20, 20];

xarm = 250;
yarm = 150;
vxarm = 0;
vyarm = 0;


figure('units','normalized','outerposition',[0 0 1 1])
grid;
scatter(xcup, ycup, 1500)
hold on
s = scatter(xarm, yarm, 800, 'filled');

%Magic constants involved:
% Distance ahead of cup in which to move to
i = -15 + randi(30, 1);
angle = 0;
theta = pi;
dt = 0.15;

cupHisx = [];
cupHisy = [];
armHisx = [];
armHisy = [];
GRAB = 0;
ticks = 0;
while(1), %tick
    if(GRAB == 0),
        vxcup = 2.5*cos(2*i*pi/180);
        vycup = 2.5*sin(2*i*pi/180);

        %find likely direction and differential angle
        dangle = angle;
        angle = atan(vycup/vxcup);
        mag = 20*sqrt((vycup)^2 + (vxcup)^2);%approximate each tick makes 20 units movement
        dangle = dangle + angle;

        %move towards intercept point of the line 2 ticks in if far away
        dist = (sqrt((xarm-xcup)^2 + (yarm-ycup)^2));
        if(dist > 40),
            futurex = (xcup + mag*dt*cos(angle + dangle)) + mag*dt*cos(angle + 2*dangle);
            futurey = (ycup + mag*dt*sin(angle + dangle)) + mag*dt*sin(angle + 2*dangle);
        elseif(dist > 0),
            futurex = (xcup + mag*dt*cos(angle + dangle));
            futurey = (ycup + mag*dt*sin(angle + dangle));
        else
            futurex = (xcup);% + mag*dt*cos(angle));
            futurey = (ycup);% + mag*dt*sin(angle));
        end

        %First order
        vxarm = vxarm/10 + (futurex - xarm)/(10); %match cup velocity
        vyarm = vyarm/10 + (futurey - yarm)/(10);

        %Get orientation of tooltip, want theta = 180 + angle
        theta = (pi + atan((yarm - ycup)/(xarm - xcup)));

        %Check if in location
        if(sqrt((xarm-xcup)^2 + (yarm-ycup)^2) < 6),
            GRAB = 1;
        end
    else
       %We now have the cup
       vxarm = vxarm/10 + ((box(1) + 0.5*box(3)) - xarm )/8 ;
       vyarm = vyarm/10 + ((box(2) + 0.5*box(4)) - yarm )/8;
       
       vxcup = vxarm;
       vycup = vyarm;
       
       dist = sqrt((xarm - (box(1) + 0.5*box(3)))^2 + ... 
           (yarm - (box(2) + 0.5*box(4)))^2);
       if dist < 2,
           break
       end
    end
    
    pause(dt);
    %Tick operation updates
    clf
    i = i + 1;
    xarm = xarm + vxarm;
    yarm = yarm + vyarm;
    armHisx = [armHisx, xarm]; armHisy = [armHisy, yarm];
    xcup = xcup + vxcup;
    ycup = ycup + vycup;
    cupHisx = [cupHisx, xcup]; cupHisy = [cupHisy, ycup];
    scatter(xcup, ycup, 1500)
    hold on
    %Plot arm
    s = scatter(xarm, yarm, 800, 'filled');
    hold on
    %plot cup velocity vector
    plot([xcup,(xcup + 15*cos(angle))], ...
        [ycup, (ycup + 15*sin(angle))])
    hold on
    %Plot arm direction
    plot([xarm, xarm + 25*cos(theta)], ...
        [yarm, yarm + 25*sin(theta)], '-ro');
    hold on
    %plot arm history
    plot(armHisx, armHisy, '-g.');
    hold on
    %plot cup history
    plot(cupHisx, cupHisy, '-.b');
    hold on
    %plot box
    rectangle('Position', box);
    axis([80, 200, 80, 200]);
    ticks = ticks + 1;
    if(ticks > 63),
        break
    end
    
    
end
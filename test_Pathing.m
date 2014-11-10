[cv, dv] = kinect_on();
i = 2;
XY = [0 0];
T = 0;
delay1 = 0;
delay2 = 0;
while(1),
   tic;
   [centers, radii, TSTAMP] = get_circles(cv, 0)
   XY = [XY; centers]; %XY(2:i,:);
   T = [T, TSTAMP]; 
   delay1 = toc;
   
   if( mod(i, 6) == 0),
       tic
      [path_C, path_R, omega] = fit_circle(XY(2:size(XY,1),:),... 
          T(2:size(T,2)));
      omega
      TIME = time_to_grab([345, 100], centers, path_C, path_R, omega)
      im = getsnapshot(cv);
      delay2 = toc;
      pause(TIME - delay1 - delay2) %delays
      GRAB = 1
      imshow(im);
        d = path_R*2;
        px = path_C(1)-path_R;
        py = path_C(2)-path_R;
        h = rectangle('Position',[px py d d],'Curvature',[1,1]);
        daspect([1,1,1])
        hold on
        scatter(XY(:,1), XY(:,2));
        hold on
        scatter(345, 100, 'd');
        break;
   end
   flushdata(cv);
   flushdata(dv);
i = i + 1
end
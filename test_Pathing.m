[cv, dv] = kinect_on();
i = 2;
XY = [0 0];
refMarker = imread('machine.png');
refFID = imread('fidREF.png');
T = 0;
delay1 = 0;
delay2 = 0;
% Get ready
putDownCup(150);
% grabFrom(150);
grabFrom1(150); 
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
      TIME = time_to_grab([320, 100], centers, path_C, path_R, omega)
      im = getsnapshot(cv);
      delay2 = toc;
      pause(TIME - delay1 - delay2) %delays
      %run grab cup
      grabFrom2(150);
      
      %run inv_kin on location of marker
      markerBox = get_surf_match(im, refMarker);
      fidBox = [0 0 0];
      while(fidBox(1) == 0),
        try 
            fidBox = get_surf_match(im, refFID);
        catch err
        end
        im = getsnapshot(cv);
        1
      end
      K = [520 0 320; 0 520 240; 0 0 1];
      
      marker3D = pixel2meat(K, markerBox(1) + 0.5*markerBox(3),...
                            markerBox(3) + 0.5*markerBox(4), 57.5)
      FID3D = pixel2meat(K, fidBox(1) + 0.5*fidBox(3),...
                            fidBox(3) + 0.5*fidBox(4), 57.5)
      arm2Marker = [0; 0; 0];
      FID3D(1) = -FID3D(1);
      marker3D(1) = -marker3D(1);
      arm2Marker = (marker3D - FID3D) - [10.5;21;0];
      arm2Marker(2) = - arm2Marker(2);
      arm2Marker(1) = -arm2Marker(1);
      arm2Marker
      %12, 9, 0]
      [temp, ERR] = inv_kin(arm2Marker(1) + 2.5, arm2Marker(2)+1, 12.5);
      if( ~ERR ),
         takeToFill(temp(1), temp(2), temp(3));
         tts('Fill me with sweet powder, bitch!');
         pause(3);
         SUCCESS = 1
      else
          % takeToFill(195,90,47);
          takeToFill(180,76,20)
      end
      putCupBack()
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
        scatter(270, 100, 'd');
        break;
   end
   flushdata(cv);
   flushdata(dv);
i = i + 1
end

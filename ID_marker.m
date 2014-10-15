function [ COORD ] = ID_marker( boxMarker, Image, DepthImage, K_camera )
%ID_marker Finds metric COORDS of fiducial marker in scene relative to
%kinect camera

          depthBox(1) = round((boxMarker(1) - 15)*1.07418118); %transformy business 
          depthBox(3) = round(((boxMarker(3) + boxMarker(1)) - 15)*1.07418118) - depthBox(1);
          depthBox(2) = round((boxMarker(2) + 25)*0.880541922);
          depthBox(4) = boxMarker(4);%round((box(4) + 480)*0.35297548);% - depthBox(2);
          
          DepthImage = transpose(DepthImage);
          
          %% Find Z at bottom of marker
            zlow = 0;
            i = 0;
            while zlow == 0,
               zlow = DepthImage(round((depthBox(1) + 0.5*depthBox(3))), ...
                            (depthBox(2) + depthBox(4)) - i);
               i = i + 1;
            end
            ZDIST = zlow;
          xp = double(boxMarker(1) + 0.5*boxMarker(3));
          yp = double(boxMarker(2));
          COORD = pixel2meat(K_camera, xp, yp, double(ZDIST)/1000);
          COORD = [COORD(3), -COORD(1), -COORD(2)];

end


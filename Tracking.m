%Track multiple cups

%[cv dv] = kinect_on();

% image = getsnapshot(cv);
%5 cups wide
CUPS = zeros(6,20); 
CUPCOUNT = 4;
while(size(centers1,1) < CUPCOUNT),
    [centers1, radii1, TSTAMP1] = get_circles(cv, 0)
end
for i = 1:size(centers1,1),
    CUPS(i, 1:2) = centers1(i,:); %fill with start values
    CUPS(i, 3) = radii1(i);
    CUPS(i, 4) = TSTAMP1;
end

images = 1;
%pictureArray = zeros(10, 480, 640, 3);
   pictureArray = cat(3,getsnapshot(cv),getsnapshot(cv),getsnapshot(cv),...
       getsnapshot(cv),getsnapshot(cv),getsnapshot(cv),getsnapshot(cv),...
   getsnapshot(cv),getsnapshot(cv),getsnapshot(cv)); 
while(1),
    
    [centers2, radii2, TSTAMP2] = get_circlesIM(pictureArray(:,:,images), 0);
    images = images + 1
    
    if(size(centers1, 1) == size(centers2, 1)),
       distance = zeros(size(centers1,1), size(centers2,1));
       for i = 1: size(centers1, 1),
           for j = 1: size(centers2, 1),
               distance(i,j) = abs(norm(CUPS(i,1:2) - centers2(j,:)));
               %min distance is the same cup
           end
           %find j value corresponding to i'th cup
           index = find(distance(i,:) == min(distance(i,:)));
           %Move values along in CUPS
           %DONT FORGET RADII
           k = size(CUPS,2)/4; %5
           while(~(k == 1)),
               CUPS(i, k*4) = CUPS(i, (k-1)*4);
               CUPS(i, k*4-1) = CUPS(i, (k-1)*4 - 1);
               CUPS(i, k*4-2) = CUPS(i, (k-1)*4 - 2);
               CUPS(i, k*4-3) = CUPS(i, (k-1)*4 - 3);
               k = k - 1;
           end
           %Assign first 4 values in cups
           CUPS(i, 1:2) = centers2(index,:);
           CUPS(i, 3) = radii2(index);
           CUPS(i, 4) = TSTAMP2;
       end
        
    end
    
    centers2
    %Once array is full
    i = 1;
    if(~(CUPS(1,20) == 0)),
        im = getsnapshot(cv);
        imshow(im);
        while(~(CUPS(i,1) == 0)),
                XY = [CUPS(i,1:2); CUPS(i,5:6); ...
                    CUPS(i,9:10); CUPS(i,13:14); CUPS(i,17:18)];
                fit_circle(XY, [0 0 0 0 0]);
            i = i + 1;
        end
        break
    end

end
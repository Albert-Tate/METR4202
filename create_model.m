function [ CUPS, path_C, path_R, OMEGA ] = create_model( cv, CUPCOUNT )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Track multiple cups

%[cv dv] = kinect_on();

% image = getsnapshot(cv);
%5 cups wide
centers1 = 0;
CUPS = zeros(6,20); %max 6 cups needs to be greater than CUPCOUNT 
%Arm Gets Ready
while(size(centers1,1) < CUPCOUNT),
    [centers1, radii1, TSTAMP1] = get_circles(cv, 0)
end

for i = 1:size(centers1,1),
    CUPS(i, 1:2) = centers1(i,:); %fill with start values
    CUPS(i, 3) = radii1(i);
    CUPS(i, 4) = TSTAMP1;
end

pictureArray = cell(10, 480, 640, 3);
TIMESTAMPS = zeros(1,10);
for i = 1:10,
    time = clock;
    TIMESTAMPS(i) = time(6) + time(5)*60;
    pictureArray{i} = getsnapshot(cv);
end

images = 1;
positives = 0;
while(1),
    
    [centers2, radii2, ~] = get_circlesIM(pictureArray{images}, 0);
    images = images + 1
    
    if(size(centers1, 1) == size(centers2, 1)),
        positives = positives + 1
       distance = zeros(size(centers1,1), size(centers2,1));
       for i = 1: size(centers1, 1),
           for j = 1: size(centers2, 1),
               distance(i,j) = abs(norm(CUPS(i,1:2) - centers2(j,:)));
               %min distance is the same cup
           end
           %find j value corresponding to i'th cup
           index = find(distance(i,:) == min(distance(i,:)));
           %Move values along in CUPS
           k = size(CUPS,2)/4; %5
           while(~(k == 1)),
               CUPS(i, k*4) = CUPS(i, (k-1)*4);
               CUPS(i, k*4-1) = CUPS(i, (k-1)*4 - 1);
               CUPS(i, k*4-2) = CUPS(i, (k-1)*4 - 2);
               CUPS(i, k*4-3) = CUPS(i, (k-1)*4 - 3);
               k = k - 1;
           end
           %Assign first 4 values in cups to new data
           CUPS(i, 1:2) = centers2(index,:);
           CUPS(i, 3) = radii2(index);
           CUPS(i, 4) = TIMESTAMPS(images);
       end
        
    end
    
    %Once array is full
    i = 1;
    if(~(CUPS(1,20) == 0) && positives > 4),
        im = getsnapshot(cv);
        imshow(im);
        OMEGA = 0;
        OM = zeros(1, size(centers2,1));
        path_R = zeros(size(centers2,1), 1);
        path_C = zeros(size(centers2,1), 2);
        while(~(CUPS(i,1) == 0)),
                XY = [CUPS(i,1:2); CUPS(i,5:6); ...
                    CUPS(i,9:10); CUPS(i,13:14); CUPS(i,17:18)];
                TIME = [CUPS(i,20), CUPS(i,16), CUPS(i,12),...
                    CUPS(i,8), CUPS(i,4)];
               [ path_C(i,:), path_R(i), OM(i) ] =  fit_circle(XY, TIME)
            i = i + 1;
        end
        
        for(i = 1:size(OM,2)),
           OMEGA = OMEGA + OM(i)*path_R(i); %weighted sum
        end
        OMEGA = OMEGA/sum(path_R);
        return
        
    else
        if (images > 10),
            FAILED_MODEL = 1
            CUPS = -1; path_C = -1; path_R = -1; OMEGA = -1;
            return
        end
    end

end



end


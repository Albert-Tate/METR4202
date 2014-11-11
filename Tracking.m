%Track multiple cups

%[cv dv] = kinect_on();

% image = getsnapshot(cv);
%5 cups wide
centers1 = 0;
CUPS = zeros(6,20); 
CUPCOUNT = 3;
%Arm Gets Ready
putDownCup(150);
grabFrom1(150);
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
    
    [centers2, radii2, TSTAMP2] = get_circlesIM(pictureArray{images}, 0);
    images = images + 1
    
    if(size(centers1, 1) == size(centers2, 1)),
        positives = positives + 1;
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
           CUPS(i, 4) = TIMESTAMPS(images);
       end
        
    end
    
    centers2
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
           OMEGA = OMEGA + OM(i)*path_R(i);
        end
        OMEGA = OMEGA/sum(path_R);
        
        for i = 1:5,
            pause(1)
            wait = 1
        end
        
        %Match new cups to old data
        centers = 0;
        while(size(centers,1) < CUPCOUNT),
            tic
            image = getsnapshot(cv);
            [centers, rad, ~] = get_circlesIM(image, 0);
        end
        dist = zeros(1, size(path_C,1));
        mapping = zeros(size(path_C,1), 1);
        for k = 1:size(centers,1),
           dist(k) = abs(norm(centers(k,:) - path_C(1,:)));
        end
        
        delay = 0;
        %% Take off cup, delete its data, decrement cupcount
        % and retake image
        for j = 1:CUPCOUNT,
            max_R = find(dist == max(dist));
            max_Rprime = find(path_R == max(path_R));
            %max_R in centers maps to max_Rprime in path_R, path_C, CUPS

            TIME = time_to_grab([320, 100], centers(max_R,:), ...
                path_C(max_Rprime,:), path_R(max_Rprime), OMEGA)

            delay = delay + toc;
            tic;
            if(delay > TIME),
                pause(2*pi/OMEGA  - (delay - TIME))
            else
                pause(TIME - delay);
            end
            GRAB = 1
            grabFrom2(150);
            takeToFill(180,76,20)
            putCupBack()

            %0 CUPS, 0 centers and zero path_C and path_R
            CUPS(max_Rprime,:) = 0;
            centers(max_R,:) = 0;
            path_C(max_Rprime,:) = 0;
            path_R(max_Rprime) = 0;
        end
        
        break
    end

end

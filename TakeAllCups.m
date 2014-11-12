%[cv dv] = kinect_on();

CUPCOUNT = 3;
ORDER_SIZES = [1 2 1];

fidREF = imread('fidREF.png');
macREF = imread('machine.png');

K = [520 0 320; 0 520 240; 0 0 1];
% get the paths
[CUPS, path_C, path_R, OMEGA] = create_model(cv, CUPCOUNT);

%preview(cv);


order_count = 1;
while(CUPCOUNT > 0),
    tic
    % get new circles
    centers = zeros(6,2);
    while(centers(CUPCOUNT,1) == 0),
        image = getsnapshot(cv);
        [centers, radii, TSTAMP] = get_circlesIM(image, 0);
        if(size(centers,1) < CUPCOUNT),
            centers = zeros(6,2);
        end
    end

    [ind, ind_p] = get_map_canidate(CUPS, path_R, path_C,...
                centers, ORDER_SIZES(order_count))

    TIME = time_to_grab([320, 100], centers(ind,:), path_C(ind_p,:), ...
                        path_R(ind_p), OMEGA )

    delay = toc

    pause(TIME - delay);
    GRAB = 1 %Move to location, demand condiments, tell pun etc
    %pick up cup
    [COORDS, TIMEOUT] = getXYZ_coaster(fidREF, macREF, cv, [10.5;21;0], K)
    [angles, ERR] = inv_kin(COORDS(1), COORDS(2), COORDS(3))

    for i = 1:5,
        pause(1);
        waiting = 1
    end

    %Delete that datapoint
    centers(ind,:) = 0;
    path_C(ind_p,:) = 0;
    path_R(ind_p) = 0;
    CUPS(ind_p,:) = 0;
    CUPCOUNT = CUPCOUNT - 1;
    order_count = order_count + 1;
end
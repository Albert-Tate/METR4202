function [ COORDS, ID, MARKER_FOUND  ] = get_cups_instant( K_camera, colourVid, depthVid )
%get_cups_instant get coords and ID of all cups in scene
%Relative to kinect camera if MARKER_FOUND = 0
%   COORDS = [cup1x, cup1y, cup1z   ID = [cup1ID
%             cup2x, cup2y, cup2z         cup2ID
%                    ...                   ...
%             cupnx, cupny, cupnz]        cupnID]
%
    %Take photos
    image = getsnapshot(colourVid);
    depthImage = getsnapshot(depthVid);
    
    %Find bounding boxes of all cups
    [boxes, markers] = imageDetector(image);
    if(size(markers,1) > 0),
        MARKER_FOUND = 1;
    else
        MARKER_FOUND = 0;
    end
    
    %% Get Marker's COORDS (kinect frame)
    COORD_MARKER = [];
    for i = 1: size(markers, 1),
        try
            [COORD_MARKER] = ID_marker(markers(i,:), image, depthImage, ...
                K_camera);
        catch err
            continue
        end
    end
    
    %% Get boxes coordinates and ID
    COORD_BOXES = [];
    ID_BOXES = [];
    for i = 1 : size(boxes,1), 
        try
            [COORD, ID] = ID_cups(boxes(i,:), ...
                image, depthImage, K_camera);
            COORD_BOXES = [COORD_BOXES; COORD];
            ID_BOXES = [ID_BOXES; ID];
        catch err
            continue;
        end
    end
    
    %% Translate supported COORD points to world frame
    ANGLE = 35;
    for i = 1:size(COORD_BOXES, 1),
       if size(COORD_MARKER,2) == 3, %Make sure we detected a marker
         COORD_BOXES(i,1:3) = kin2frame(COORD_MARKER(1:3), COORD_BOXES(i,1:3), 0, ANGLE, 0);
       end
    end
    
    COORDS = COORD_BOXES;
    ID = ID_BOXES;
    
        %% Make sure windows doesn't shoot us
    flushdata(colourVid);
    flushdata(depthVid);

end


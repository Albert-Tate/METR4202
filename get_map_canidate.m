function [ index, index_prime ] = get_map_canidate( CUPS, path_R,...
                            path_C, centers, order_size)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%index maps to centers, index_prime maps corresponding cup to CUPS, path_R
%etc

%% Get Radius List
centers
dist = zeros(1, size(centers,1));
for k = 1:size(centers,1),
    dist(k) = abs(norm(centers(k,:) - path_C(1,:)));
end
dist
%% Find the cup closest to the edge and check if it is the right type
%  If not, simply look at the next closest
while(1),
   %sanity check
   if max(path_R) == 0,
       index = -1; index_prime = -1;
       return
   end
   
   %Find cup closest to edge
   index = find(dist == max(dist));
   index_prime = find(path_R == max(path_R));
   
   %ID cup type
   if(CUPS(index_prime, 3) < 60),
       type_dex = 1;
   else
       type_dex = 2;
   end
   
   if(type_dex == order_size),
      return 
   end
   %if we get here that wasn't the right cup!
   % so lets delete that cup from calculation
   % note: pass by reference so we don't delete in the main scope of
   % function!
   centers(index,:) = 0;
   path_R(index_prime,:) = 0;
   dist(index) = 0;
   
end


end


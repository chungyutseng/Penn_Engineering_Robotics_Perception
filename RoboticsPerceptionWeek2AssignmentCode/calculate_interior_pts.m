function [ interior_pts ] = calculate_interior_pts( image_size, corners )
% calculate_interior_pts takes in the size of an image and a set of corners
% of a shape inside that image, and returns all (x,y) points in that image
% within the corners
% Written for the University of Pennsylvania's Robotics:Perception course

% YOU SHOULDN'T NEED TO CHANGE THIS
% image_size(2) = 1280
% image_size(1) = 720
% for example
% x = 1 : 3
% y = 1 : 5
% [X, Y] = meshgrid(x, y);
% X = [1 2 3;
%      1 2 3;
%      1 2 3;
%      1 2 3;
%      1 2 3];
% Y = [1 1 1;
%      2 2 2;
%      3 3 3;
%      4 4 4;
%      5 5 5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x = 1 : 1280
% y = 1 : 720
% [X, Y] = meshgrid(x, y);
% X and Y are both 720x1280 matrice
% X = [1 2 3 ... 1280;
%      1 2 3 ... 1280;
%      1 2 3 ... 1280;
%      .
%      .
%      .             ];
% Y = [1   1   1   ... 1;
%      2   2   2   ... 2;
%      .
%      .
%      720 720 720 ... 720];
[X, Y] = meshgrid(1:image_size(2), 1:image_size(1));

%make it all in one row
X=X(:);
Y=Y(:);

interior_inds = inpolygon(X,Y,corners(:,1), corners(:,2));
interior_pts = [X(interior_inds),...
    Y(interior_inds)];
end


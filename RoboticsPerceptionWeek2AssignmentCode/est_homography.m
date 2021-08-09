function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE
H = [];
syms f(x1, x2, x1p, x2p);
f(x1, x2, x1p, x2p) = [-x1 -x2 -1  0   0   0 x1*x1p x2*x1p x1p;
                        0   0   0 -x1 -x2 -1 x1*x2p x2*x2p x2p];
A = [f(video_pts(1, 1),  video_pts(1, 2), logo_pts(1, 1), logo_pts(1, 2));
     f(video_pts(2, 1),  video_pts(2, 2), logo_pts(2, 1), logo_pts(2, 2));
     f(video_pts(3, 1),  video_pts(3, 2), logo_pts(3, 1), logo_pts(3, 2));
     f(video_pts(4, 1),  video_pts(4, 2), logo_pts(4, 1), logo_pts(4, 2))];
[U, S, V] = svd(A);
H = reshape(V(:, end), [3 3])';
end


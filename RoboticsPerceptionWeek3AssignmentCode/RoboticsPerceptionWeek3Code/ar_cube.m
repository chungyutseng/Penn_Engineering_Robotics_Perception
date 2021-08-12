function [proj_points, t, R] = ar_cube(H,render_points,K)
%% ar_cube
% Estimate your position and orientation with respect to a set of 4 points on the ground
% Inputs:
%    H - the computed homography from the corners in the image
%    render_points - size (N x 3) matrix of world points to project
%    K - size (3 x 3) calibration matrix for the camera
% Outputs: 
%    proj_points - size (N x 2) matrix of the projected points in pixel
%      coordinates
%    t - size (3 x 1) vector of the translation of the transformation
%    R - size (3 x 3) matrix of the rotation of the transformation
% Written by Stephen Phillips for the Coursera Robotics:Perception course

% YOUR CODE HERE: Extract the pose from the homography

% YOUR CODE HERE: Project the points using the pose

% render_points is a 8x3 matrix

R_prime = [H(:, 1) H(:, 2) cross(H(:, 1), H(:, 2))];
[U, S, V] = svd(R_prime);
R = U * [1 0 0; 0 1 0; 0 0 det(U * V')] * V';
t = H(:, 3) / norm(H(:, 1));
% t = H(:, 3) / ((H(1, 1))^2 + (H(2, 1))^2 + (H(3, 1))^2)^0.5;
render_points = render_points';
% proj_points = ones(2, length(render_points(:, 1));
for i = 1 : 1 : length(render_points(1, :))
    Xc = K * (R * render_points(:, i) + t);
    proj_points(1, i) = Xc(1) / Xc(3);
    proj_points(2, i) = Xc(2) / Xc(3);
end
proj_points = proj_points';
% Xc = K * (R * render_points + t);
% for i = 1 : 1 : 8
%    Xc(1, i) = Xc(1, i) / Xc(3, i);
%    Xc(2, i) = Xc(2, i) / Xc(3, i);
% end
% Xc = Xc';
% proj_points = [Xc(:, 1), Xc(:, 2)];

end

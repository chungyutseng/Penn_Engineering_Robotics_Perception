function X = LinearTriangulation(K, C1, R1, C2, R2, x1, x2)
%% LinearTriangulation
% Find 3D positions of the point correspondences using the relative
% position of one camera from another
% Inputs:
%     C1 - size (3 x 1) translation of the first camera pose
%     R1 - size (3 x 3) rotation of the first camera pose
%     C2 - size (3 x 1) translation of the second camera
%     R2 - size (3 x 3) rotation of the second camera pose
%     x1 - size (N x 2) matrix of points in image 1
%     x2 - size (N x 2) matrix of points in image 2, each row corresponding
%       to x1
% Outputs: 
%     X - size (N x 3) matrix whos rows represent the 3D triangulated
%       points
P1 = K*[R1 -R1*C1];
P2 = K*[R2 -R2*C2];
iter = length(x1(:, 1));
X = zeros(iter, 3);
for i = 1 : 1 : iter
    A_1 = [0 -1 x1(i, 2); 1 0 -x1(i, 1); -x1(i, 2) x1(i, 1) 0] * P1;
    A_2 = [0 -1 x2(i, 2); 1 0 -x2(i, 1); -x2(i, 2) x2(i, 1) 0] * P2;
    A = [A_1; A_2];
    [~, ~, V] = svd(A);
%     X(i, :) = V(:, 3)';
    X(i, :) = [V(1,4)/V(4, 4) V(2, 4)/V(4, 4) V(3, 4)/V(4, 4)];
end



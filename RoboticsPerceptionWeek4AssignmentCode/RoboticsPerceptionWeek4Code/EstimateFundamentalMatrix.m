function F = EstimateFundamentalMatrix(x1, x2)
%% EstimateFundamentalMatrix
% Estimate the fundamental matrix from two image point correspondences 
% Inputs:
%     x1 - size (N x 2) matrix of points in image 1
%     x2 - size (N x 2) matrix of points in image 2, each row corresponding
%       to x1
% Output:
%    F - size (3 x 3) fundamental matrix with rank 2

% x1: 429 X 2
% x2: 429 X 2
F = [];
iter = length(x1(:, 1));
A = zeros(iter, 9);
syms f(u2, v2, u1, v1);

% x1 = (u1, v1), x2 = (u2, v2)
f(u2, v2, u1, v1) = [u1*u2 u1*v2 u1 v1*u2 v1*v2 v1 u2 v2 1];
for i = 1 : 1 : iter
    A(i, :) = f(x2(i, 1), x2(i, 2), x1(i, 1), x1(i, 2));
%     u2 = x2(i, 1);
%     v2 = x2(i, 2);
%     u1 = x2(i, 1);
%     v1 = x2(i, 2);  
%     A(i, :) = [];
end
[U, D, V] = svd(A);
F = reshape(V(:, end), [3 3])';
[U_f D_f V_f] = svd(F);
D_f(end, end) = 0;
F = U_f * D_f * V_f';
F = F./norm(F);

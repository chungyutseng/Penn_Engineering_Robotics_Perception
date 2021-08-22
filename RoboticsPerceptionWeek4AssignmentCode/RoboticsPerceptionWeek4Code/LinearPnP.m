function [C, R] = LinearPnP(X, x, K)
%% LinearPnP
% Getting pose from 2D-3D correspondences
% Inputs:
%     X - size (N x 3) matrix of 3D points
%     x - size (N x 2) matrix of 2D points whose rows correspond with X
%     K - size (3 x 3) camera calibration (intrinsics) matrix
% Outputs:
%     C - size (3 x 1) pose transation
%     R - size (3 x 1) pose rotation
%
% IMPORTANT NOTE: While theoretically you can use the x directly when solving
% for the P = [R t] matrix then use the K matrix to correct the error, this is
% more numeically unstable, and thus it is better to calibrate the x values
% before the computation of P then extract R and t directly
%%
iter = length(x(:, 1));
x_c = zeros(iter, 3);
for i = 1 : 1 : iter
    temp_1 = K \ [x(i, 1); x(i, 2); 1];
    x_c(i, 1) = temp_1(1);
    x_c(i, 2) = temp_1(2);
    x_c(i, 3) = temp_1(3);
end
A = [];
for i = 1 : 1 : iter
    skew_m = [0        -x_c(i, 3) x_c(i, 2);
              x_c(i, 3) 0        -x_c(i, 1);
             -x_c(i, 2) x_c(i, 1) 0];
    world_c = [X(i, 1) X(i, 2) X(i, 3) 1 0       0       0       0 0       0       0       0;
               0       0       0       0 X(i, 1) X(i, 2) X(i, 3) 1 0       0       0       0;
               0       0       0       0 0       0       0       0 X(i, 1) X(i, 2) X(i, 3) 1];
    A = [A; skew_m*world_c];
end
[U, D, V] = svd(A);
sol = V(:, end);
P = [sol(1) sol(2)  sol(3)  sol(4);
     sol(5) sol(6)  sol(7)  sol(8);
     sol(9) sol(10) sol(11) sol(12)];
R = [sol(1) sol(2)  sol(3);
     sol(5) sol(6)  sol(7);
     sol(9) sol(10) sol(11)];
t = [sol(4);
     sol(8);
     sol(12)];
[U_R, D_R, V_R] = svd(R);
if abs(det(U_R * V_R') - 1) < 0.01
    R_c = U_R * V_R';
    t_c = t / D_R(1, 1);
else
    R_c = -U_R * V_R';
    t_c = -t / D_R(1, 1);
end
R = R_c;
C = -R_c' * t_c;
% x = zeros(iter, 3);
% for i = 1 : 1 : iter
%     temp_2 = K \ [x_c(i, 1); x_c(i, 2); 1];
%     x(i, 1) = temp_2(1);
%     x(i, 2) = temp_2(2);
%     x(i, 3) = 1;
% end 
%%
% iter = length(x(:, 1));
% x = [x ones(iter, 1)];
% x_c = x / K';
% x = x_c(:, 1:2);
% %
% syms f(X1, X2, X3, u, v)
% f(X1, X2, X3, u, v) = [0  0  0  0 X1 X2 X3 1 -v*X1 -v*X2 -v*X3 -v;
%                        X1 X2 X3 1 0  0  0  0 -u*X1 -u*X2 -u*X3 -u];
% % A = zeros(iter*2, 12);
% for i = 1 : 1 : iter
%     A(2*i-1:2*i, :) = f(X(i, 1), X(i, 2), X(i, 3), x(i, 1), x(i, 2));
% %     A() = f(X(i, 1), X(i, 2), X(i, 3), x(i, 1), x(i, 2));
% end
% [~, ~, V] = svd(A);
% P = reshape(V(:, end), [4 3])';
% P = K \ P;
% Rt = K \ P;
% R = Rt(:, (1:3));
% t = Rt(:, 4);
% [U, D, V] = svd(R);
% if det(U * V') == 1
% % if abs(det(U * V') - 1) < 0.0001
%     R_c  = U * V';
%     t_c = t / D(1, 1);
% else
%     R_c = -U * V';
%     t_c = -t / D(1, 1);
% end
% R = R_c;
% C = -R' * t_c;
%%
% iter = length(x(:, 1));
% xx = [x ones(iter, 1)];
% x_c = xx / K';
% % x_c = xx * pinv(K');
% x = x_c(:, 1:2);
% x = [x'; ones(1, iter)];
% X = [X'; ones(1, iter)];
% A = [];
% for i = 1 : 1 : iter
%     temp = (K \ x(:, i))';
%     temp_temp = [0 -temp(3) temp(2); temp(3) 0 -temp(1); -temp(2) temp(1) 0];
%     temp_X = [X(:, i)' zeros(1, 8); zeros(1,4) X(:, i)' zeros(1,4); zeros(1,8) X(:, i)'];
%     A_temp = temp_temp*temp_X;
%     A = [A; A_temp];
% end
% %%
% [~, ~, V] = svd(A);
% % P = reshape(V(:, end), [4 3])';
% V_end = V(:, end)/V(end, end);
% P = [V_end(1) V_end(2) V_end(3) V_end(4); 
%      V_end(5) V_end(6) V_end(7) V_end(8); 
%      V_end(9) V_end(10) V_end(11) V_end(12)];
% % P = K \ P;
% Rt = P;
% R = Rt(:, (1:3));
% t = Rt(:, 4);
% [U, D, V] = svd(R);
% % if det(U * V') == 1
% if abs(det(U * V') - 1) < 0.1
%     R_c  = U * V';
%     t_c = t / D(1, 1);
% else
%     R_c = -U * V';
%     t_c = -t / D(1, 1);
% end
% % C = -R' * t_c;
% R = R_c;
% C = -R_c' * t_c;
% end

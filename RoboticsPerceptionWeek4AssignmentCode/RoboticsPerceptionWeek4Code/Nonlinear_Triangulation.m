function X = Nonlinear_Triangulation(K, C1, R1, C2, R2, C3, R3, x1, x2, x3, X0)
%% Nonlinear_Triangulation
% Refining the poses of the cameras to get a better estimate of the points
% 3D position
% Inputs: 
%     K - size (3 x 3) camera calibration (intrinsics) matrix
%     x
% Outputs: 
%     X - size (N x 3) matrix of refined point 3D locations 
for i = 1 : 1 : 2
    iter = length(x1(:, 1));
    for i = 1 : 1 : iter
        X(i, :) = Single_Point_Nonlinear_Triangulation(K, C1, R1, C2, R2, C3, R3, x1(i, :), x2(i, :), x3(i, :), X0(i, :)');
    end
    X0 = X;
end
X = X0;
end

function X = Single_Point_Nonlinear_Triangulation(K, C1, R1, C2, R2, C3, R3, x1, x2, x3, X0)
    X_T = X0;
    J1 = Jacobian_Triangulation(C1, R1, K, X_T);
    J2 = Jacobian_Triangulation(C2, R2, K, X_T);
    J3 = Jacobian_Triangulation(C3, R3, K, X_T);
    JJ = [J1 J2 J3]';
    uvw1 = K*R1*(X_T-C1);
    uvw2 = K*R2*(X_T-C2);
    uvw3 = K*R3*(X_T-C3);
    b = [x1(1,1) x1(1,2) x2(1,1) x2(1,2) x3(1,1) x3(1,2)]';
    f_of_X = [uvw1(1)/uvw1(3) uvw1(2)/uvw1(3) uvw2(1)/uvw2(3) uvw2(2)/uvw2(3) uvw3(1)/uvw3(3) uvw3(2)/uvw3(3)]';
    delta_x = (JJ'*JJ)\JJ'*(b - f_of_X);
    X = X_T + delta_x;
    X = X';
end

function J = Jacobian_Triangulation(C, R, K, X)
    f = K(1, 1);
    px = K(1, 3);
    py = K(2, 3);
    uvw = K*R*(X-C);
    pupx = [f*R(1,1)+px*R(3,1) f*R(1,2)+px*R(3,2) f*R(1,3)+px*R(3,3)];
    pvpx = [f*R(2,1)+py*R(3,1) f*R(2,2)+py*R(3,2) f*R(2,3)+py*R(3,3)];
    pwpx = [R(3,1) R(3,2) R(3,3)];
    pfpx = [(uvw(3)*pupx - uvw(1)*pwpx)/(uvw(3)^2); (uvw(3)*pvpx - uvw(2)*pwpx)/(uvw(3)^2)]; % 2X3
    J = pfpx'; % 3X2
end
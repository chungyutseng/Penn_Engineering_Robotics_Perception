% % A = imread('images/barcaReal/BarcaReal001.jpg');
% % imshow(A);
% % axis on;
% % hold on;
% % AA = video_pts(:,:,test_images(1))
% % xv = AA(:, 1);
% % yv = AA(:, 2);
% % for i = 1 : 1 : 4
% %    plot(xv(i), yv(i),  'o', 'MarkerFaceColor', [0 0 1], 'MarkerEdgeColor', [0 0 1]); 
% % end
% % % plot([i], [ACC1_Minus_ACC2_Start(i)], 'o', 'MarkerFaceColor', [0 0 1], 'MarkerEdgeColor', [0 0 1]);
% % [interior_inds_x, interior_inds_y] = inpolygon(X,Y,xv, yv);
% % AGGx = X(interior_inds_x);
% % AGGy = Y(interior_inds_x);
% % for i = 1 : 1 : 10
% %    plot(_x(i)), Y(interior_inds_x(i)),  'o', 'MarkerFaceColor', [0 1 1], 'MarkerEdgeColor', [0 1 0]); 
% % end
% % %%
% % % project_logo.m is the test file for the University of
% % % Pennsylvania's Coursera course Robotics:Perception, week 2 assignment, to
% % % project a logo onto a given area in a target image
% % % Written for the University of Pennsylvania's Robotics:Perception course
% % 
% % % Note: You don't have to change this script for the assignment, but you
% % % can if you'd like to change the images or other parameters
% % 
% % % Load logo image. Replace with your image as desired.
% % logo_img = imread('images/logos/penn_engineering_logo.png');
% % %%
% % % Generate logo points (they are just the outer corners of the image)
% % % logoy is the number of rows of the matrix logo_imag
% % % logox is the number of columns of the matrix logo_imag
% % % logoy = 400; logox = 990
% % [logoy, logox, ~] = size(logo_img);
% % %%
% % % logo_pts = [0          0;
% % %             990(logox) 0
% % %             990(logox) 400(logoy)
% % %             0          400(logoy)];
% % logo_pts = [0 0; logox 0; logox logoy; 0 logoy];
% % %%
% % % Load the points that the logo corners will map onto in the main image
% % load data/BarcaReal_pts.mat
% % %%
% % % video_pts is a 4 by 2 by 129 3 - dimensioanl array
% % % num_ima = 129
% % num_ima = size(video_pts, 3);
% % %%
% % % Set of images to test on
% % % test_images is a 1 by 129 array
% % test_images = 1:num_ima;
% % %%
% % % To only test on images 1, 4 and 10, use the following line (you can edit
% % % it for your desired test images)
% % % test_images = [1,4,10];
% % % num_test is 129
% % num_test = length(test_images);
% % %%
% % % Initialize the images
% % video_imgs = cell(num_test, 1);
% % projected_imgs = cell(num_test, 1);
% %%
% % project_logo.m is the test file for the University of
% % Pennsylvania's Coursera course Robotics:Perception, week 2 assignment, to
% % project a logo onto a given area in a target image
% % Written for the University of Pennsylvania's Robotics:Perception course
% 
% % Note: You don't have to change this script for the assignment, but you
% % can if you'd like to change the images or other parameters
% 
% % Load logo image. Replace with your image as desired.
% logo_img = imread('images/logos/penn_engineering_logo.png');
% %%
% % Generate logo points (they are just the outer corners of the image)
% % logoy is the number of rows of the matrix logo_imag
% % logox is the number of columns of the matrix logo_imag
% % logoy = 400; logox = 990
% [logoy, logox, ~] = size(logo_img);
% %%
% % logo_pts = [0          0;
% %             990(logox) 0
% %             990(logox) 400(logoy)
% %             0          400(logoy)];
% logo_pts = [0 0; logox 0; logox logoy; 0 logoy];
% %%
% % Load the points that the logo corners will map onto in the main image
% load data/BarcaReal_pts.mat
% %%
% % video_pts is a 4 by 2 by 129 3 - dimensioanl array
% % num_ima = 129
% num_ima = size(video_pts, 3);
% %%
% % Set of images to test on
% % test_images is a 1 by 129 array
% test_images = 1:num_ima;
% %%
% % To only test on images 1, 4 and 10, use the following line (you can edit
% % it for your desired test images)
% % test_images = [1,4,10];
% % num_test is 129
% num_test = length(test_images);
% %%
% % Initialize the images
% video_imgs = cell(num_test, 1);
% projected_imgs = cell(num_test, 1);
% % Process all the images
% for i=1:1:1
%     % Read the next video frame
%     video_imgs{i} = imread(sprintf('images/barcaReal/BarcaReal%03d.jpg', i));
%     
%     % Find all points in the video frame inside the polygon defined by
%     % video_pts
%     % size(video_imgs{i}) = [720 1280 3];
%     [ interior_pts ] = calculate_interior_pts(size(video_imgs{i}),...
%         video_pts(:,:,test_images(i)));
%     
%     % Warp the interior_pts to coordinates in the logo image
% %     warped_logo_pts = warp_pts(video_pts(:,:,test_images(i)),...
% %         logo_pts,...
% %         interior_pts);
%     
%     % Copy the RGB values from the logo_img to the video frame
% %     projected_imgs{i} = inverse_warping(video_imgs{i},...
% %         logo_img,...
% %         interior_pts,...
% %         warped_logo_pts); 
% end
% imshow(video_imgs{1});
% axis on;
% hold on;
% for i = 1 : 1 : 4
%    plot(corners(:,1), corners(:,2),  'o', 'MarkerFaceColor', [0 0 1], 'MarkerEdgeColor', [0 0 1]); 
% end
% for i = 1 : 1 : 720
%     plot(1, i,  'o', 'MarkerFaceColor', [0 0 1], 'MarkerEdgeColor', [0 0 1]); 
% end
% syms f(x, y)
% f(x, y) = [x 2*x 3*x;
%            y -2*y 3*y];
warped_pts = [];
warped_pts()
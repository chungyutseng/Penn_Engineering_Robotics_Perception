test_imgs = generated_imgs;
% test_imgs{1} = imread('warped_images/warped_img1.png');
% test_imgs{2} = imread('warped_images/warped_img2.png');
% test_imgs{3} = imread('warped_images/warped_img3.png');
writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = 30;
secsPerImage = ones(length(test_imgs),1);
open(writerObj);
for u=1:length(test_imgs)
     % convert the image to a frame
     frame = im2frame(test_imgs{u});
     for v=1:secsPerImage(u) 
        writeVideo(writerObj, frame);
     end
 end
 % close the writer object
 close(writerObj);
%% Written by Yuan Tao.
img=im2double(rgb2gray(imread('data/simpsons.jpg')));
imshow(img);
[x,y]=ginput(2); 
patch=img(floor(y(1)):ceil(y(2)),floor(x(1)):ceil(x(2)));
figure
imshow(patch)
%corr=imfilter(img,patch); % the teacher's recommendation
corr=normxcorr2(patch,img); % well, if you want to be lazy and use the built-in normalization
figure
imagesc(corr)
colormap jet
colorbar
title('correlation');
threshold = 0.5;
L = (corr(2:end-1,2:end-1) > corr(2:end-1,1:end-2)); 
R = (corr(2:end-1,2:end-1) > corr(2:end-1,3:end)); 
U=(corr(2:end-1,2:end-1)>corr(1:end-2,2:end-1));
B=(corr(2:end-1,2:end-1)>corr(3:end,2:end-1));
LU=(corr(2:end-1,2:end-1) > corr(1:end-2,1:end-2));
LB=(corr(2:end-1,2:end-1) > corr(3:end,1:end-2)); 
RU=(corr(2:end-1,2:end-1) > corr(1:end-2,3:end));
RB=(corr(2:end-1,2:end-1) > corr(3:end,3:end));
T = (corr(2:end-1,2:end-1) > threshold); 
maxima = R & L & U & B & LU & LB & RU & RB & T;
[loc_x,loc_y]=find(maxima>0);
[patch_H,patch_W]=size(patch);
figure
imshow(img)
hold on;
num=size(loc_x,1);
for i=1:num
    rectangle('Position',[loc_y(i)-patch_W,loc_x(i)-patch_H,patch_W,patch_H],'EdgeColor','r') 
end
%% Written by Yuan Tao.
img=im2double(rgb2gray(imread('data/simpsons.jpg')));
imshow(img)
[x,y]=ginput(2);
patch=img(floor(y(1)):ceil(y(2)),floor(x(1)):ceil(x(2)));
figure
imshow(patch)
patch=rot90(patch,2);
IT=conv2(img,patch,'same');
Tsquared = sum(sum(patch.^2));
Isquared = conv2(img.^2,ones(size(patch)),'same');
squareddiff = -(Isquared - 2*IT + Tsquared);
figure
imagesc(squareddiff)
colormap jet
colorbar
title('ssd');
threshold = -13;
L = (squareddiff(2:end-1,2:end-1) > squareddiff(2:end-1,1:end-2)); 
R = (squareddiff(2:end-1,2:end-1) > squareddiff(2:end-1,3:end)); 
U=(squareddiff(2:end-1,2:end-1)>squareddiff(1:end-2,2:end-1));
B=(squareddiff(2:end-1,2:end-1)>squareddiff(3:end,2:end-1));
LU=(squareddiff(2:end-1,2:end-1) > squareddiff(1:end-2,1:end-2));
LB=(squareddiff(2:end-1,2:end-1) > squareddiff(3:end,1:end-2)); 
RU=(squareddiff(2:end-1,2:end-1) > squareddiff(1:end-2,3:end));
RB=(squareddiff(2:end-1,2:end-1) > squareddiff(3:end,3:end));
T = (squareddiff(2:end-1,2:end-1) > threshold); 
maxima = R & L & U & B & LU & LB & RU & RB & T;
[loc_x,loc_y]=find(maxima>0);
[patch_H,patch_W]=size(patch);
figure
imshow(img)
hold on;
num=size(loc_x,1);
for i=1:num
    rectangle('Position',[loc_y(i)+1-patch_W/2,loc_x(i)+1-patch_H/2,patch_W,patch_H],'EdgeColor','r') 
end
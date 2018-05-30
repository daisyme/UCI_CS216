% load a training example image
Itrain = im2double(rgb2gray(imread('../signtest/test2.jpg')));

%have the user click on some training examples.  
% If there is more than 1 example in the training image (e.g. faces), you could set nclicks higher here and average together
nclick = 1;
figure(1); clf;
imshow(Itrain);
[x,y] = ginput(nclick); %get nclicks from the user

%compute 8x8 block in which the user clicked
blockx = round(x/8);
blocky = round(y/8); 

%
% the following code assumes the template is 128x128 pixels  
%   (16x16 hog blocks) so you will want to eventually modify
%   it to handle different sized templates.
%

%visualize image patches that the user clicked on
figure(2); clf;
hht = 8;
hwt = 8;
for i = 1:nclick
  patch = Itrain(8*blocky(i)+(-hht*8+1:hht*8),8*blockx(i)+(-hwt*8+1:hwt*8));
  figure(2); subplot(3,2,i); imshow(patch);
  imwrite(patch,strcat('../figure/patch_',num2str(i),'.jpg'),'JPEG');
end

% compute the hog features
f = hog(Itrain);

% compute the average template for where the user clicked
template = zeros(2*hht,2*hwt,9);
for i = 1:nclick
  template = template + f(blocky(i)+(-hht+1:hht),blockx(i)+(-hwt+1:hwt),:); 
end
template = template/nclick;

%
% load a test image
%
Ntest='test3';
Itest= im2double(rgb2gray(imread(['../signtest/',Ntest,'.jpg'])));

% find top 5 detections in Itest
ndet = 5;
[x,y,score] = detect(Itest,template,ndet);

%display top ndet detections
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-hwt*8 y(i)-hht*8 hwt*16 hht*16],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
print(['../figure/detect_',Ntest,'.jpg'],'-djpeg');

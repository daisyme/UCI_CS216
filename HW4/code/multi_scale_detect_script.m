% load a training example image
Ntrain='russia';
Itrain = im2double(rgb2gray(imread(['../multiscale/',Ntrain,'.jpeg'])));

%have the user click on some training examples.  
% If there is more than 1 example in the training image (e.g. faces), you could set nclicks higher here and average together
nclick = 1;
figure(1); clf;
imshow(Itrain);
for i=1:nclick
  [x,y] = ginput(2); %get nclicks from the user
%compute 8x8 block in which the user clicked
  blockx = round(x(1)/8);
  blocky = round(y(1)/8); 
  figure(2); clf;
  hht = abs(round((y(2)-y(1))/16));
  hwt = abs(round((x(2)-x(1))/16));
  patch = Itrain(8*blocky(i)+(1:hht*16),8*blockx(i)+(1:hwt*16));
  figure(2); subplot(3,2,i); imshow(patch);
  imwrite(patch,strcat('../figure/ms_patch_',Ntrain,num2str(i),'.jpg'),'JPEG');
end

% compute the hog features
f = hog(Itrain);

% compute the average template for where the user clicked
template = zeros(2*hht,2*hwt,9);
for i = 1:nclick
  template = template + f(blocky(i)+(1:2*hht),blockx(i)+(1:2*hwt),:); 
end
template = template/nclick;

%
% load a test image
%
Ntest='russia';
Itest= im2double(rgb2gray(imread(['../multiscale/',Ntest,'.jpeg'])));


% find top 5 detections in Itest
ndet = 5;
[rects,score] = multi_scale_detect(Itest,template,ndet);

%display top ndet detections
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',rects(i,:),'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
print(['../figure/ms_detect_',Ntrain,'_',Ntest,'.jpg'],'-djpeg');
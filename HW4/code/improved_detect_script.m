% parameters set here
dataset = 'facetest';
Ntrain = 'faces5';
Ntest = 'faces2';
nPos = 1;
nNeg = 0;
% load a training example image
Itrain = im2double(rgb2gray(imread(['../',dataset,'/', Ntrain,'.jpg'])));
%% POS template
%have the user click on some training examples.  
% If there is more than 1 example in the training image (e.g. faces), you could set nclicks higher here and average together
rects = zeros(4,nPos);
figure(1); clf;
imshow(Itrain);
for i = 1:nPos
    rects(:,i) = floor(getrect()); %get nclicks from the user
end

[w,h] = average_boxes(rects);
bh = round(h/8);
bw = round(w/8);
hht = round(bh/2);
hwt = round(bw/2);
patches = zeros(h,w,nPos);
temp_pos = zeros(bh,bw,9);

for i = 1:nPos
    patches(:,:,i) = imresize(Itrain(rects(2,i)+(1:rects(4,i)),rects(1,i)+(1:rects(3,i))),[h,w]);
    % compute the hog features
    temp_pos = temp_pos + hog(patches(:,:,i)); 
end
temp_pos = temp_pos/nPos;
%visualize image patches that the user clicked on
figure(2); clf; montage(patches);
print(['../figure/id_p',num2str(nPos),'_',Ntrain,'.jpg'],'-djpeg');
%% NEG template
temp_neg = zeros(bh,bw,9);
if nNeg ~= 0
    f = hog(Itrain);
    [fh,fw,~] = size(f);
    figure(1); clf;
    imshow(Itrain);
    [x,y] = ginput(nNeg); %get nclicks from the user

    %compute 8x8 block in which the user clicked
    blockx = round(x/8);
    blocky = round(y/8); 
    %visualize image patches that the user clicked on
    patches_neg = zeros(h,w,nNeg);
    for i = 1:nNeg
        if blocky(i)-hht < 0
            blocky(i) = hht+1;
        elseif blocky(i)+hht >= fh
                blocky(i) = fh - hht -1;
        end
        if blockx(i)-hwt < 0
            blockx(i) = hwt+1;
        elseif blockx(i)+hwt >= fw
                blockx(i) = fh - hwt -1;
        end        
        patches_neg(:,:,i) = Itrain(8*blocky(i)+(-hht*8+(1:h)),8*blockx(i)+(-hwt*8+(1:w)));
        temp_neg = temp_neg + f(blocky(i)-hht+(1:bh),blockx(i)-hwt+(1:bw),:); 
    end
    figure(2); clf; montage(patches_neg);
    print(['../figure/id_n',num2str(nNeg),'_',Ntrain,'.jpg'],'-djpeg');
    temp_neg = temp_neg/nNeg;
end
%% POS-NEG
template = temp_pos - temp_neg;
%%
%
% load a test image
%
Itest= im2double(rgb2gray(imread(['../',dataset,'/',Ntest,'.jpg'])));

% Single detect
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
print(['../figure/id_p',num2str(nPos),'n',num2str(nNeg),'_tr_',Ntrain,'_t_',Ntest,'.jpg'],'-djpeg');

% Multi-scale detect
% find top 5 detections in Itest
ndet = 5;
[rects,score] = multi_scale_detect(Itest,template,ndet);

%display top ndet detections
figure(4); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  handle = rectangle('Position',rects(i,:),'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
print(['../figure/ms_p',num2str(nPos),'n',num2str(nNeg),'_tr_',Ntrain,'_t_',Ntest,'.jpg'],'-djpeg');

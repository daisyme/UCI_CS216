%% Written by Yuan Tao.
function[]=detect_edge(file,sigma)
    img=im2double(rgb2gray(imread(['data/',file,'.jpg'])));
    img_smooth=imgaussfilt(img,sigma);
    Gx=[-1,0,1;-2,0,2;-1,0,1];
    Gy=Gx';
    img_dx=conv2(img_smooth,Gx,'same');
    img_dy=conv2(img_smooth,Gy,'same');
    gradient_magnitude=sqrt(img_dx.^2+img_dy.^2);
    figure
    imagesc(gradient_magnitude);
    colormap gray
    colorbar
    title('gradient magnitude');
    print(['figure/',file,'_',num2str(sigma),'_gm.jpg'],'-djpeg');
    orient=atan(img_dy./img_dx);
    imagesc(orient);
    title('orientation');
    print(['figure/',file,'_',num2str(sigma),'_ort.jpg'],'-djpeg');
    
end
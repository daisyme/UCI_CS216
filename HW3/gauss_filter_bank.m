%% Written by Yuan Tao.

function[h_d,v_d]=gauss_filter_bank(file,sigma)
%file='girl_in_flowers';
%sigma=2;
    img = im2double(imread(['data/',file,'.jpg']));
    if size(img, 3) == 3
        img=rgb2gray(img);
    end
    G = fspecial('gaussian',16,sigma);
    [Gx,Gy] = gradient(G);
    h_d=conv2(img,Gx,'same');
    v_d=conv2(img,Gy,'same');
%     imagesc(h_d);
%     colormap gray
%     print(['figure/',file,'_sigma_horizontal_',num2str(sigma),'.jpg'],'-djpeg');
%     imagesc(v_d);
%     colormap gray
%     print(['figure/',file,'_sigma_vertical_',num2str(sigma),'.jpg'],'-djpeg');
%     imagesc(Gx);
%     colormap gray
%     print(['figure/gaussian_sigma_horizontal_',num2str(sigma),'.jpg'],'-djpeg');
%     imagesc(Gy);
%     colormap gray
%     print(['figure/gaussian_sigma_vertical_',num2str(sigma),'.jpg'],'-djpeg');
end
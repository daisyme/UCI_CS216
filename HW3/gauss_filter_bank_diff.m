%% Written by Yuan Tao.

function[diff]=gauss_filter_bank_diff(file,sigma1,sigma2)
%file='girl_in_flowers';
%sigma=2;    
    img = im2double(imread(['data/',file,'.jpg']));
    if size(img, 3) == 3
        img=rgb2gray(img);
    end
    G1 = fspecial('gaussian',16,sigma1);
    G2 = fspecial('gaussian',16,sigma2);
    G = G2 - G1;
    diff=conv2(img,G,'same');
%     imagesc(diff);
%     colormap gray
%     print(['figure/',file,'_sigma_diff_',num2str(sigma1),num2str(sigma2),'.jpg'],'-djpeg');
%     imagesc(G);
%     colormap gray
%     print(['figure/gaussian_sigma_diff_',num2str(sigma1),num2str(sigma2),'.jpg'],'-djpeg');
end
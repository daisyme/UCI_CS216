%% Written by Yuan Tao.

function[]=km_img_scale(file,k,s)
%  file='girl_in_flowers';
%  k=3;
    img = im2double(imread(['data/',file,'.jpg']));
    [m,n,~] = size(img);
    img(:,:,1) = img(:,:,1)*s;
    img_data = reshape(img(:),[],3); % return MN-by-3 matrix
    [idx, C] = kmeans(img_data, k);
    less_color_img = C(idx,:);
    new_img = reshape(less_color_img,m,n,3);
    new_img(:,:,1) = new_img(:,:,1)/s;
    imagesc(new_img);
    print(['figure/',file,'_colors_',num2str(k),'_scale_',num2str(s),'.jpg'],'-djpeg');
end
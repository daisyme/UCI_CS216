%% Written by Yuan Tao.

%% 1. Color quantization
km_img('girl_in_flowers',2);
km_img('girl_in_flowers',5);
km_img('girl_in_flowers',10);
% try to scale one of the feature coordinates
km_img_scale('girl_in_flowers',2,1000);
km_img_scale('girl_in_flowers',2,0.001);
%% 2. Filterbank
gauss_filter_bank('girl_in_flowers',1);
gauss_filter_bank('girl_in_flowers',2);
gauss_filter_bank('girl_in_flowers',4);
% gaussian diff
gauss_filter_bank_diff('girl_in_flowers',1,2);
gauss_filter_bank_diff('girl_in_flowers',2,4);
%% 3. Filter Distribution
img = im2double(rgb2gray(imread('data/zebra_small.jpg')));
imshow(img)
patch_sets = {'neck','tree','grass'};
response = zeros(3,8);
for i = 1:3
    [x, y] = ginput(1);
    size = 40;
    patch = img(floor(y)-size/2:floor(y)+size/2-1,floor(x)-size/2:floor(x)+size/2-1);
    imwrite(patch,strcat('data/patch_',patch_sets{i},'.jpg'),'JPEG');
    [h_1, v_1] = gauss_filter_bank(['patch_',patch_sets{i}],1);
    [h_2, v_2] = gauss_filter_bank(['patch_',patch_sets{i}],2);
    [h_4, v_4] = gauss_filter_bank(['patch_',patch_sets{i}],4);
    [diff12] = gauss_filter_bank_diff(['patch_',patch_sets{i}],1,2);
    [diff24] = gauss_filter_bank_diff(['patch_',patch_sets{i}],2,4);
    response(i,:) = [mean(abs(h_1(:))), mean(abs(h_2(:))), mean(abs(h_4(:))), mean(abs(v_1(:))), mean(abs(v_2(:))), mean(abs(v_4(:))), mean(abs(diff12(:))), mean(abs(diff24(:)))];
end
bar(response)
set(gca, 'XTickLabel', patch_sets)
legend('h, sigma=1','h, sigma=2', 'h, sigma=4', 'v, sigma=1', 'v, sigma=2', 'v, sigma=4', 'G2-G1', 'G4-G2')
print('figure/distributions.jpg','-djpeg');

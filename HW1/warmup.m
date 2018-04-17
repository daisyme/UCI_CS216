%% Written by Yuan Tao.
A = rgb2gray(imread('figure/avatar.jpg'));
A = A(251:350,321:420);
A = im2double(A);
figure
imshow(A)
colorbar
print('figure/gray.jpg','-djpeg')
%% a
x = A(:);
x = sort(x);
figure
plot(x)
print('figure/2a.jpg','-djpeg')
%% b
figure
histogram(A,32)
print('figure/2b.jpg','-djpeg')
%% c
t = 0.65;
Abin = zeros(100);
Abin(A>t) = 1;
figure
imshow(Abin)
colorbar
print('figure/2ccb.jpg','-djpeg')
%% d
[r,c] = size(A);
Abr = A(r/2:r,c/2:c);
figure
imshow(Abr)
colorbar
print('figure/2dcb.jpg','-djpeg')
%% e
Anorm = A-mean(A(:));
Anorm(Anorm<0) = 0;
figure
imshow(Anorm)
colorbar
print('figure/2ecb.jpg','-djpeg')
%% f
Aflip = A(:, end:-1:1);
figure
imshow(Aflip)
colorbar
print('figure/2fcb.jpg','-djpeg')
%% g
x = min(A(:));
[r,c] = find(A==x);
%% h
v = [1 8 8 2 1 3 9 8];
num = length(unique(v));
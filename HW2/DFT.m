%% Written by Yuan Tao.
%% a
ips = zeros(100,1);
ips(50) = 1;
dft = fft(ips);
magnitude = abs(dft);
figure;
plot(magnitude);
title('magnitude of the spectrum (impulse)');
print('figure/4a.jpg','-djpeg');
%% b
box = zeros(100,1);
for bnum=5:5:10
    box(50-round(bnum/2):50-round(bnum/2)+bnum-1) = ones(bnum,1);
    dft = fftshift(fft(box));
    magnitude = abs(dft);
    figure;
    plot(magnitude);
    title(strcat('magnitude of the spectrum (box',num2str(bnum),')'));
    print(strcat('figure/4b_',num2str(bnum),'.jpg'),'-djpeg');
end

%% c
X = -49:50;
for sigma = 1:2
    gauss = 1/(sqrt(2*pi)*sigma) * exp(- X.^2/(2*sigma^2));
    dft = fftshift(fft(gauss));
    magnitude = abs(dft);
    figure;
    plot(magnitude);
    title(strcat('magnitude of the spectrum ?Gaussian function ?=',num2str(sigma),')'));
    print(strcat('figure/4c_',num2str(sigma),'.jpg'),'-djpeg');
end
%% d 
%load the img
img1 = im2double(rgb2gray(imread('data/zebra1.jpg')));
img2 = im2double(rgb2gray(imread('data/zebra2.jpg')));
[m,n,~] = size(img2);
img1 = imresize(img1,[m n]);

%% Calculate 2D-FFT of image1 and image2
img1_fft = fft2(img1);
img1_mgt = abs(img1_fft);
img1_phs = angle(img1_fft);
colormap(gray)
imagesc(log(abs(fftshift(img1_fft))))
print('figure/zebra1_magnitude.jpg','-djpeg');
imwrite(fftshift(img1_phs),'figure/zebra1_phase.jpg','JPEG');

img2_fft = fft2(img2);
img2_mgt = abs(img2_fft);
img2_phs = angle(img2_fft);
colormap(gray)
imagesc(log(abs(fftshift(img2_fft))))
print('figure/zebra2_magnitude.jpg','-djpeg');
imwrite(img2_phs,'figure/zebra2_phase.jpg','JPEG');

%% combine phase from img1 with magnitude from img2
new_zebra_fft = img2_mgt .* exp(img1_phs .*1i);
new_zebra = ifft2(new_zebra_fft);
imwrite(new_zebra,'figure/new_zebra.jpg','JPEG');

%% extra interesting functions
X = -49:50;
sinplus = sin(X)+0.2*X;
dft = fftshift(fft(sinplus));
magnitude = abs(dft);
figure;
plot(magnitude);
title('magnitude of the spectrum of sin(x)+0.2x');
print('figure/4e.jpg','-djpeg');
figure;
plot(sinplus);
title('sin(x)+0.2x');
print('figure/4f.jpg','-djpeg');
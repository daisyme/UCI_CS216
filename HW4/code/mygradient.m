function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%

dx = imfilter(I,[-1 1]);
dy = imfilter(I,[-1 1]');

mag = abs(dx+dy.*1i);
ori = atan(dy./dx);


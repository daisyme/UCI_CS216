
function [x,y,score] = detect(I,template,ndet)
%
% return top ndet detections found by applying template to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%

% compute the feature map for the image
f = hog(I);

[h2,~,nori] = size(f);
[ht,wt,~] = size(template);

% cross-correlate template with feature map to get a total response
R = zeros(size(f,1),size(f,2));
for i = 1:nori
  R = R + imfilter(f(:,:,i),template(:,:,i));
end

% now return locations of the top ndet detections

% sort response from high to low
[val,ind] = sort(R(:),'descend');

% this is the non-maximum suppression loop.
% work down the sorted list of responses, 
%   only add a detection if it doesn't overlap previously selected detections
%
x = zeros(ndet,1);
y = zeros(ndet,1);
score = zeros(ndet,1);
i = 1;
detcount = 1;
while ((detcount <= ndet) && (i <= length(ind)))
  % convert ind(i) back to (i,j) values to get coordinates of the block
  [yblock,xblock] = deal(mod(ind(i)-1,h2)+1, ceil(ind(i)/h2));
  

  assert(val(i)==R(yblock,xblock)); %make sure we did the indexing correctly

  % now convert yblock,xblock to pixel coordinates 
  ypixel = yblock*8;
  xpixel = xblock*8;

  % check if this detection overlaps any detections which we've already added to the list
  % (e.g. check to see if the distance between this detection and the other detections
  %   collected in the arrays x,y is less than half the template width/height)
  overlap = sum((abs(y-ypixel) < ht*4) | (abs(x-xpixel) < wt*4));

  % if no overlap, then add this detection location and score to the list we return
  if (~overlap)
    x(detcount) = xpixel;
    y(detcount) = ypixel;
    score(detcount) = val(i);
    detcount = detcount+1;
  end
  i = i + 1;
end



function [rects,score] = multi_scale_detect(I,template,ndet)
%
% return top ndet detections found by applying template to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%
bigger = 1;
scale = 0.7;
[ht,wt,~] = size(template);
J = I;
iter = 1;
x = zeros(1,ndet);
y = zeros(1,ndet);
score = zeros(1,ndet);
while bigger
  [xtemp,ytemp,score(iter,:)] = detect(J,template,ndet);
  J = imresize(J,scale);
  x(iter,:) = ceil((xtemp-wt*4)/(scale^(iter-1)));
  y(iter,:) = ceil((ytemp-ht*4)/(scale^(iter-1)));
  [hj,wj,~] = size(J);
  bigger = (hj > 8*ht) & (wj > 8*wt);
  iter = iter+1;
end

% now return locations of the top ndet detections

% sort response from high to low
[val,ind] = sort(score(:),'descend');

% this is the non-maximum suppression loop.
% work down the sorted list of responses, 
%   only add a detection if it doesn't overlap previously selected detections
%
xf = zeros(ndet,1);
yf = zeros(ndet,1);
scoref = zeros(ndet,1);
rects = zeros(ndet,4);
i = 1;
detcount = 1;
while ((detcount <= ndet) && (i <= length(ind)))
  % convert ind(i) back to (i,j) values to get coordinates of the block
  [ii,id] = deal(mod(ind(i)-1,(iter-1))+1, ceil(ind(i)/(iter-1)));
  

  assert(val(i)==score(ii,id)); %make sure we did the indexing correctly

  % now convert to pixel coordinates rectangle
  rect_n = [x(ii,id),y(ii,id),wt*8/(scale^(ii-1)),ht*8/(scale^(ii-1))];

  % check if this detection overlaps any detections which we've already added to the list
  % (e.g. check to see if the distance between this detection and the other detections
  %   collected in the arrays x,y is less than half the template width/height)
  overlap = 0;
  for j=1:detcount-1
    overlap = overlap | (rectint(rect_n,rects(j,:)) >= wt*ht*16);
  end
  % if no overlap, then add this detection location and score to the list we return
  if (~overlap)
    xf(detcount) = x(ii,id);
    yf(detcount) = y(ii,id);
    scoref(detcount) = val(i);
    rects(detcount,:) = rect_n;
    detcount = detcount+1;
  end
  i = i + 1;
end
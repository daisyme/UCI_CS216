%% Written by Yuan Tao.

function[output] = MRF_segment(file, lambda, place)
%file = 'girl_in_flowers';
    img = im2double(imread(['data/',file,'.jpg']));
    img = imresize(img, 0.25);
    [H,W,~] = size(img);
    N = H*W;
    imshow(img);
    [ix,iy] = ginput(2);
    seed = 10;
    foreground = img(floor(iy(1))-seed/2:floor(iy(1))+seed/2-1, floor(ix(1))-seed/2:floor(ix(1))+seed/2-1,:);
    fg_rgb = mean(reshape(foreground,[],3));
    background = img(floor(iy(2))-seed/2:floor(iy(2))+seed/2-1, floor(ix(2))-seed/2:floor(ix(2))+seed/2-1,:);
    bg_rgb = mean(reshape(background,[],3));

    imgdata = reshape(img,[],3);
    segclass = zeros(N,1);
    segclass((floor(ix(1))-1)*H+floor(iy(1))) = 0;
    segclass((floor(ix(2))-1)*H+floor(iy(2))) = 1;
    %pairwise = sparse(N,N);
    pairwise = spalloc(N,N,4*N-2*H-2*W);
    unary = pdist2(imgdata,[fg_rgb;bg_rgb])';
    unary(:,(floor(ix(1))-1)*H+floor(iy(1))) = [0,3];
    unary(:,(floor(ix(2))-1)*H+floor(iy(2))) = [3,0];

    %add all horizontal links
    for x = 1:W-1
      for y = 1:H
        node  = 1 + (y-1) + (x-1)*H;
        right = 1 + (y-1) +x*H;
        pairwise(node,right) = pdist2(imgdata(node,:),imgdata(right,:));
        pairwise(right,node) = pairwise(node,right);
      end
    end

    %add all vertical nbr links
    for x = 1:W
      for y = 1:H-1
        node = 1 + (y-1) + (x-1)*H;
        down = 1 + y + (x-1)*H;
        pairwise(node,down) = pdist2(imgdata(node,:),imgdata(down,:));
        pairwise(down,node) = pairwise(node,down);
      end
    end
    
    % Define binary classification problem
    labelcost = [0 1;1 0]*lambda;
    [labels E Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),1);
    output = reshape(labels,[H W]);
    figure;
    ax1=subplot(211);
    imagesc(img);
    title('Original image');
    hold on
    plot(ix,iy,'o','MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
    pbaspect(ax1,[W H 1]);
    ax2=subplot(212);
    imagesc(output);
    title('Min-cut');
    pbaspect(ax2,[W H 1]);
    print(['figure/',file,'_lambda_',num2str(lambda),'_',place,'.jpg'],'-djpeg');

end
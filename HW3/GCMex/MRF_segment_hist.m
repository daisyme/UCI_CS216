%% Written by Yuan Tao.

function[output] = MRF_segment_hist(file, lambda, place)
%file = 'girl_in_flowers';
%file = 'segtest1';
%%
    img = im2double(imread(['data/',file,'.jpg']));
%    img = imresize(img, 0.25);
    [H,W,~] = size(img);
    N = H*W;
    imshow(img);
    seed = 16;
    [ix, iy] = ginput(2);
%     patch1 = img(floor(iy(1))-seed/2:floor(iy(1))+seed/2-1,floor(ix(1))-seed/2:floor(ix(1))+seed/2-1,:);
%     [h_1,h_2,h_4,v_1,v_2,v_4,diff12,diff24] = gauss_filter_hist(patch1);      
%     ground(1,:) = [mean(abs(h_1(:))), mean(abs(h_2(:))), mean(abs(h_4(:))), mean(abs(v_1(:))), mean(abs(v_2(:))), mean(abs(v_4(:))), mean(abs(diff12(:))), mean(abs(diff24(:)))];
%     patch2 = img(floor(iy(2))-seed/2:floor(iy(2))+seed/2-1,floor(ix(2))-seed/2:floor(ix(2))+seed/2-1,:);
%     [h_1,h_2,h_4,v_1,v_2,v_4,diff12,diff24] = gauss_filter_hist(patch2);      
%     ground(2,:) = [mean(abs(h_1(:))), mean(abs(h_2(:))), mean(abs(h_4(:))), mean(abs(v_1(:))), mean(abs(v_2(:))), mean(abs(v_4(:))), mean(abs(diff12(:))), mean(abs(diff24(:)))];

    [h_1,h_2,h_4,v_1,v_2,v_4,diff12,diff24] = gauss_filter_hist(img);
    imgdata1 = [abs(h_1(:)),abs(h_2(:)),abs(h_4(:)),abs(v_1(:)),abs(v_2(:)),abs(v_4(:)),abs(diff12(:)),abs(diff24(:))];
    %%
    response = reshape(imgdata1,H,W,8);
    fore = response(floor(iy(1))-seed/2:floor(iy(1))+seed/2-1,floor(ix(1))-seed/2:floor(ix(1))+seed/2-1,:);
    fc = mean(abs(reshape(fore,[],8)));
    back = response(floor(iy(2))-seed/2:floor(iy(2))+seed/2-1,floor(ix(2))-seed/2:floor(ix(2))+seed/2-1,:);
    bc = mean(abs(reshape(back,[],8)));
    ground = [fc;bc];
    %%
    segclass = zeros(N,1);
    segclass((floor(ix(1))-1)*H+floor(iy(1))) = 0;
    segclass((floor(ix(2))-1)*H+floor(iy(2))) = 1;
%     %%
%     [imageData,c]=kmeans(imgdata1,20);
%     %%
%     imageData=reshape(imageData,[H,W]);
%     figure
%     imagesc(imageData)
%     colormap jet
    %%
    
    unary = pdist2(imgdata1,ground);
    %%
    a = reshape(unary,H,W,2);
    figure
    imshow((a(:,:,1)-a(:,:,2))*100)
    %%
    unary = unary';
    unary(:,(floor(ix(1))-1)*H+floor(iy(1))) = [0,1];
    unary(:,(floor(ix(2))-1)*H+floor(iy(2))) = [1,0];

    %% neighbouring edge
    %add all horizontal links
    imgdata2 = reshape(img,[],3);
    pairwise = spalloc(N,N,4*N-2*H-2*W);
    for x = 1:W-1
      for y = 1:H
        node  = 1 + (y-1) + (x-1)*H;
        right = 1 + (y-1) +x*H;
        pairwise(node,right) = pdist2(imgdata2(node,:),imgdata2(right,:));
        pairwise(right,node) = pairwise(node,right);
      end
    end

    %add all vertical nbr links
    for x = 1:W
      for y = 1:H-1
        node = 1 + (y-1) + (x-1)*H;
        down = 1 + y + (x-1)*H;
        pairwise(node,down) = pdist2(imgdata2(node,:),imgdata2(down,:));
        pairwise(down,node) = pairwise(node,down);
      end
    end
    
    %%
    % Define binary classification problem
    labelcost = [0 1;1 0]*lambda;
    [labels E Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),0);
    output = reshape(labels,[H W]);
    figure;
    ax1=subplot(211);
    imagesc(img);
    title('Original image');
    hold on
    rectangle('Position',[ix(1)-seed/2,iy(1)-seed/2,seed,seed],'EdgeColor','r');
    rectangle('Position',[ix(2)-seed/2,iy(2)-seed/2,seed,seed],'EdgeColor','g');
    %%
    pbaspect(ax1,[W H 1]);
    %%
    ax2=subplot(212);
    imagesc(output);
    title('Min-cut');
    pbaspect(ax2,[W H 1]);
    print(['figure/',file,'_hist_lambda_',num2str(lambda),'_',place,'.jpg'],'-djpeg');
%%
end
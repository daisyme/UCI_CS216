%% Written by Yuan Tao.
sets = {'set1','set2'};
for k = 1:2
    setname = char(sets(k));
    folder=strcat('avg/',setname,'/');
    imgfiles = dir(strcat(folder,'*.jpg'));
    num_img = length(imgfiles);
    for i = 1:num_img
        name = imgfiles(i).name;
        img = im2double(imread(strcat(folder,name)));
        imgr = imresize(img,[215,300]);
        p = rand(1);
        if i == 1
            sumrgb = imgr;
            sumgry = rgb2gray(imgr);
            sumflip = imgr(:,end:-1:1,:)*(p>0.5) + imgr*(p<=0.5);
        else
            sumrgb = sumrgb + imgr;
            sumgry = sumgry + rgb2gray(imgr);
            sumflip = sumflip + imgr(:,end:-1:1,:)*(p>0.5) + imgr*(p<=0.5);
        end
    end
    avggry = sumgry/num_img;
    avgrgb = sumrgb/num_img;
    avgflip = sumflip/num_img;
    figure
    imshow(avggry)
    imwrite(avggry,strcat('figure/',setname,'_avggry.jpg'),'JPEG');
    figure
    imshow(avgrgb)
    imwrite(avgrgb,strcat('figure/',setname,'_avgrgb.jpg'),'JPEG');
    figure
    imshow(avgflip)
    imwrite(avgflip,strcat('figure/',setname,'_avgflip.jpg'),'JPEG');
end
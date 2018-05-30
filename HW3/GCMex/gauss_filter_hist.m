%% Written by Yuan Tao.

function[h_1,h_2,h_4,v_1,v_2,v_4,diff12,diff24] = gauss_filter_hist(img)
    img = rgb2gray(img);
    G1 = fspecial('gaussian',16,1);
    [Gx,Gy] = gradient(G1);
    h_1 = conv2(img,Gx,'same');
    v_1 = conv2(img,Gy,'same');
    G2 = fspecial('gaussian',16,2);
    [Gx,Gy] = gradient(G2);
    h_2 = conv2(img,Gx,'same');
    v_2 = conv2(img,Gy,'same');
    G4 = fspecial('gaussian',16,4);
    [Gx,Gy] = gradient(G4);
    h_4 = conv2(img,Gx,'same');
    v_4 = conv2(img,Gy,'same');
    diff12 = conv2(img,G2-G1,'same');
    diff24 = conv2(img,G4-G2,'same');
    %output = [mean(abs(h_1(:))), mean(abs(h_2(:))), mean(abs(h_4(:))), mean(abs(v_1(:))), mean(abs(v_2(:))), mean(abs(v_4(:))), mean(abs(diff12(:))), mean(abs(diff24(:)))];
end
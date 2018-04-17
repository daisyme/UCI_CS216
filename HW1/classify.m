%% Written by Yuan Tao.
test = load('cifar-10-batches-mat/test_batch.mat');
meta = load('cifar-10-batches-mat/batches.meta.mat');
train1 = load('cifar-10-batches-mat/data_batch_1.mat');
train2 = load('cifar-10-batches-mat/data_batch_2.mat');
train3 = load('cifar-10-batches-mat/data_batch_3.mat');
train4 = load('cifar-10-batches-mat/data_batch_4.mat');
train5 = load('cifar-10-batches-mat/data_batch_5.mat');
training = [train1.data;train2.data;train3.data;train4.data;train5.data];
training_labels = [train1.labels;train2.labels;train3.labels;train4.labels;train5.labels];
label_names = meta.label_names;
label_num = length(label_names);
test_num = length(test.labels);
test_data = test.data;
%% 1
airplane_label = find(strcmp(label_names,'airplane'))-1;
first_airplane_idx = find(test.labels==airplane_label,1);
first_airplane = permute(reshape(test.data(first_airplane_idx,:),[32,32,3]),[2 1 3]);
figure
imshow(first_airplane)
imwrite(first_airplane,'figure/first_airplane.jpg','JPEG');
%% 2
i = 7;
pred = KNN(test.data(i,:),training,training_labels,1);
test.labels(i); 
%% 3
predict_label = KNN(test_data,training,training_labels,1); 
% it takes me about 15 minutes to run this, and, to be honest, I would
% suggest you to not write it as a function and to sort the pdist matrix once,
% then keep using that computed distance matrix for the next question.
[Mcc_1,~] = CCM(test.labels,predict_label,label_num);
figure
imagesc(Mcc_1)
colorbar
colormap(summer) % summer is coming! cheers!
print('figure/33.jpg','-djpeg');
%% 4
%predict1 = KNN(test_data,training,training_labels,1); 
% actually, we've already got the predict for k=1 in the previous section
predict3 = KNN(test_data,training,training_labels,3);
predict5 = KNN(test_data,training,training_labels,5);
[Mcc_3,~] = CCM(test.labels,predict3,label_num);
figure
imagesc(Mcc_3)
colorbar
colormap(summer) % summer is coming! cheers!
print('figure/343.jpg','-djpeg');
[Mcc_5,~] = CCM(test.labels,predict5,label_num);
figure
imagesc(Mcc_5)
colorbar
colormap(summer) 
print('figure/345.jpg','-djpeg');
%% 5 
% KNN_cosine
% I am going to check k from 1 to 20, and this time I will save the
% computed matrix for further use
[~,IDX] = pdist2(training,test_data,'cosine','Smallest',20);
%%
predict_label = training_labels(IDX(1:1,:));
[~,crt_rate] = CCM(test.labels,predict_label,label_num);
crt_rates = zeros(20,1);
crt_rates(1) = crt_rate;
% emm, when k=1, the vector seems to have different property under mode()...
for i = 2:20
    predict_label = mode(training_labels(IDX(1:i,:)),1)';
    [~,crt_rate] = CCM(test.labels,predict_label,label_num);
    crt_rates(i) = crt_rate;
end
figure
plot(crt_rates);
print('figure/35cosine_plot.jpg','-djpeg');
[~, I] = max(crt_rates);
%%
predict_label = training_labels(IDX(1:I,:));
[Mcc_opt,~] = CCM(test.labels,predict_label,label_num);
figure
imagesc(Mcc_opt)
colorbar
colormap(summer) 
print('figure/35cosine.jpg','-djpeg');
%%
% normalized correlation
[~,IDX] = pdist2(training,test_data,'correlation','Smallest',20);
%%
predict_label = training_labels(IDX(1:1,:));
[~,crt_rate] = CCM(test.labels,predict_label,label_num);
crt_rates = zeros(20,1);
crt_rates(1) = crt_rate;
% emm, when k=1, the vector seems to have different property under mode()...
for i = 2:20
    predict_label = mode(training_labels(IDX(1:i,:)),1)';
    [~,crt_rate] = CCM(test.labels,predict_label,label_num);
    crt_rates(i) = crt_rate;
end
figure
plot(crt_rates);
print('figure/35correlation_plot.jpg','-djpeg');
[~, I] = max(crt_rates);
%%
predict_label = mode(training_labels(IDX(1:I,:)),1)';
[Mcc_opt,~] = CCM(test.labels,predict_label,label_num);
figure
imagesc(Mcc_opt)
colorbar
colormap(summer) 
print('figure/35correlation.jpg','-djpeg');
%% 6
Mcc_pairs=Mcc_opt+Mcc_opt';
[Most_Mcc,II]=sort(Mcc_pairs,1);
II(end:-1:end-1,:); % these are the most confused pairs
%%
dogs = find(mode(training_labels(IDX(1:6,:)),1)'==5); %remember that the label is started from 0
fake_dogs = dogs(test.labels(dogs)==3);
for i = 1:30
    fake_dog = permute(reshape(test.data(fake_dogs(i),:),[32,32,3]),[2 1 3]);
    figure
    imshow(fake_dog)
    imwrite(fake_dog,strcat('figure/fake_dog_',num2str(i),'.jpg'),'JPEG');
end
%% 7
% Well, let me play it... Since there's only 20 min to the ddl...
mainM = reshape(1:3072,[32,32,3]);
subM = mainM(6:25,6:25,:);
%%
[~,IDX] = pdist2(training(:,subM(:)),test_data(:,subM(:)),'correlation','Smallest',14);
%% 
%%
predict_label = training_labels(IDX(1:1,:));
[~,crt_rate] = CCM(test.labels,predict_label,label_num);
crt_rates = zeros(14,1);
crt_rates(1) = crt_rate;
% emm, when k=1, the vector seems to have different property under mode()...
for i = 2:14
    predict_label = mode(training_labels(IDX(1:i,:)),1)';
    [~,crt_rate] = CCM(test.labels,predict_label,label_num);
    crt_rates(i) = crt_rate;
end
figure
plot(crt_rates);
print('figure/37sub_plot.jpg','-djpeg');
[~, I] = max(crt_rates);
%%
predict_label = mode(training_labels(IDX(1:I,:)),1)';
[Mcc_opt,~] = CCM(test.labels,predict_label,label_num);
figure
imagesc(Mcc_opt)
colorbar
colormap(summer) 
print('figure/37sub.jpg','-djpeg');
%% KNN
function predict_label_knn = KNN(test_knn, training_knn, training_labels_knn, k)
    [~,IDX] = pdist2(training_knn,test_knn,'euclidean','Smallest',k);
    predict_label_knn = mode(training_labels_knn(IDX),1)';
end
%% Class Confusion Matrix
function [Mcc,crt_rate] = CCM(fact, predict,label_num)
    Mcc = zeros(label_num);
    for i = 1:length(predict)
        Mcc(fact(i)+1,predict(i)+1) = Mcc(fact(i)+1,predict(i)+1)+1;
    end
    Mcc = Mcc./sum(Mcc,2);
    crt_rate = sum(diag(Mcc))/label_num;
    disp(strcat("Classification_rate: ", num2str(crt_rate)));
    disp(strcat("Misclassification_rate: ", num2str(1-crt_rate)));
end
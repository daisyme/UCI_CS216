## HW3 by Yuan Tao
#### 1 Color quantization
The figure that I use for this question:
![](data/girl_in_flowers.jpg)
The clustering with k = 2:
![](figure/girl_in_flowers_colors_2.jpg)

The clustering with k = 5:
![](figure/girl_in_flowers_colors_5.jpg)
The clustering with k = 10:
![](figure/girl_in_flowers_colors_10.jpg)

If I scale one of the feature coordinates,
red by factor of 1000:
![](figure/girl_in_flowers_colors_2_scale_1000.jpg)
by factor of 0.001:
![](figure/girl_in_flowers_colors_2_scale_0.001.jpg)

We can see from the two different scale, that by giving red a different weight during clustering, the result will differ. So it's very important to do data normalization.

#### 2 Filterbank
I use the zebra\_small image,
![](data/zebra_small.jpg)
And the filter kernels are:
h\_1
![](figure/gaussian_sigma_horizontal_1.jpg)
h\_2
![](figure/gaussian_sigma_horizontal_2.jpg)
h\_4
![](figure/gaussian_sigma_horizontal_4.jpg)
v\_1
![](figure/gaussian_sigma_vertical_1.jpg)
v\_2
![](figure/gaussian_sigma_vertical_2.jpg)
v\_4
![](figure/gaussian_sigma_vertical_4.jpg)
G2-G1
![](figure/gaussian_sigma_diff_12.jpg)
G4-G2
![](figure/gaussian_sigma_diff_24.jpg)
The filter response images are:
h\_1
![](figure/girl_in_flowers_sigma_horizontal_1.jpg)
h\_2
![](figure/girl_in_flowers_sigma_horizontal_2.jpg)
h\_4
![](figure/girl_in_flowers_sigma_horizontal_4.jpg)
v\_1
![](figure/girl_in_flowers_sigma_vertical_1.jpg)
v\_2
![](figure/girl_in_flowers_sigma_vertical_2.jpg)
v\_4
![](figure/girl_in_flowers_sigma_vertical_4.jpg)
G2-G1
![](figure/girl_in_flowers_sigma_diff_12.jpg)
G4-G2
![](figure/girl_in_flowers_sigma_diff_24.jpg)

#### 3 Filter Distribution
The 3 different patches:
Neck: ![](data/patch_neck.jpg)    Tree: ![](data/patch_tree.jpg) Grass: ![](data/patch_grass.jpg)
The distrubution is:
![](figure/distributions.jpg)
We can see that the distribution is quite different according to different feature.
In the neck patch, the horizontal mean features are very high because the zebra's pattern in the neck are mostly verticle stripes.
In the tree patch, the pattern is kind of vague, so the 8 features are are very average.

Well, I didn't rescale the figure at all, since I picked good patches. I think the rescale would help us to get the representative patches more easily.

#### 4 MRF Segmentation
##### a
On testImage1:
![](GCMex/data/segtest1.jpg)
There are 3 objects on the background in this figure. I tested it with different objects.
![](GCMex/figure/segtest1_lambda_1_brown.jpg)
![](GCMex/figure/segtest1_lambda_4_green.jpg)
![](GCMex/figure/segtest1_lambda_4_zebra.jpg)
On testImage2:
![](GCMex/data/segtest2.jpg)
![](GCMex/figure/segtest2_lambda_4_fig.jpg)
![](GCMex/figure/segtest2_lambda_4_orange.jpg)
![](GCMex/figure/segtest2_lambda_4_green_orange.jpg)
On my image:
I choose clothes and hair and the background as different elements.
![](GCMex/data/girl_in_flowers.jpg)
![](GCMex/figure/girl_in_flowers_lambda_4_hair.jpg)
![](GCMex/figure/girl_in_flowers_lambda_3_clothes.jpg)
##### b 
I add the texture feature to the original function:
The texton looks like this:
the final result:
The texton of the zebra stripe:
![](GCMex/figure/segtest1_hist_lambda_1_gray.jpg)
![](GCMex/figure/segtest1_hist_lambda_4_gray.jpg)

The texton of black:
![](GCMex/figure/black.jpg)
![](GCMex/figure/segtest2_hist_lambda_0.04_green_orange.jpg)
The texton of hair:
![](GCMex/figure/hair.jpg)
![](GCMex/figure/girl_in_flowers_hist_lambda_3_hair.jpg)
This image is actually hard to segment, since the texture are very alike.

A good lambda here can make the result very good. We can see that by adding more features, the result is getting better.

The successes are mostly from those figures with good features that can be easily distinguished from the background. Also what seed to choose is very important. The failures are for similar reasons. I didn't do anything to process the edges, which is another reason.

Actually I think the physical distance are important too and would help in my figure.
#### 5 Project Proposal
I am interested in one of the project in the online competition platform Kaggle, which is called "CVPR 2018 WAD Video Segmentation Challenge". The goal is to segment each objects within image frames captured by vehicles. It is important to quickly tell the difference between a person vs. a stop sign for autonomous vehicles so that they can drive in a much safer way.

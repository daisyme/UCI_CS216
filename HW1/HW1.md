## HW1 by Yuan Tao
### A: Matlab Warmup
#### 1
a). x is a row vector which contains a random permutation of the integers from 1 to 5.

b). a is a 3-by-3 matrix.  
b is a row vector which is the entire second row of matrix a. [4 5 6]

c). f is a row vector which contains the integers from 1501 to 2000.  
g is a row vector which contains the index of numbers that are bigger than 1850 in f. [351:500]  
h is a row vector which is the sub-vector of f that bigger than 1850. [1851:2000]

d). x is an 1-by-10 array of 22.
y is the sum of all the elements in x, which is 22x1x10. 220

e). a is a row vector which contains the integers from 1 to 100.  
b is a row vector which is the sub-vector of a that index from the end to 1 with step -1. [100:-1:1] => [100 99 98 ... 1]

<div STYLE="page-break-after: always;"></div>

#### 2
My avatar:
![](figure/avatar.jpg)
The subregion in gray:
<div style="text-align:center" markdown="1">
![](figure/gray.jpg)
</div>

<div STYLE="page-break-after: always;"></div>

**2a** The intensities plot:
<div style="text-align:center" markdown="1">
![](figure/2a.jpg)
</div>

<div STYLE="page-break-after: always;"></div>

**2b** The histogram:
<div style="text-align:center" markdown="1">
![](figure/2b.jpg)
</div>
**2c** The binary image:(I set the threshold as 0.7)
<div style="text-align:center" markdown="1">
![](figure/2ccb.jpg)
</div>
**2d** The bottom right quadrant:
<div style="text-align:center" markdown="1">
![](figure/2dcb.jpg)
</div>

<div STYLE="page-break-after: always;"></div>

**2e** The darker image:
<div style="text-align:center" markdown="1">
![](figure/2ecb.jpg)
</div>
**2f** The mirror-flipped image:
<div style="text-align:center" markdown="1">
![](figure/2fcb.jpg)
</div>
**2g** The result:
<div style="text-align:center" markdown="1">
![](figure/2g.jpg)
</div>
**2h** The result:
<div style="text-align:center" markdown="1">
![](figure/2h.jpg)
</div>

<div STYLE="page-break-after: always;"></div>

### B: Computing average images
#### The 6 image:
Set1 in the left and Set2 in the right,
<div style="text-align:center" markdown="1">
![](figure/set1_avggry.jpg)![](figure/set2_avggry.jpg)
![](figure/set1_avgrgb.jpg)![](figure/set2_avgrgb.jpg)
![](figure/set1_avgflip.jpg)![](figure/set2_avgflip.jpg)
</div>
The results from step2 and step3 look different because step3 randomly flip the image. So the average computed result from step3 would be somehow more symmetrical than step2 assuming all the figures in one data set have some similarities.
<div STYLE="page-break-after: always;"></div>

### C: Image classification
#### 1
The first airplane:
<div style="text-align:center" markdown="1">
![](figure/first_airplane.jpg)
</div>
#### 2
I randomly picked the 7th image in the test dataset to predict. Using my written KNN function and set the k equals to 1, it predicted the image as class 6 while it's label is class 1.
#### 3
Well, for the k = 1, we can see:
![](figure/33.jpg)

>Classification\_rate: 0.3539
Misclassification\_rate: 0.6461

<div STYLE="page-break-after: always;"></div>

#### 4
For k = 1, it's in last question.
For k = 3,
![](figure/343.jpg)
>Classification\_rate: 0.3303
Misclassification\_rate: 0.6697

<div STYLE="page-break-after: always;"></div>

For k = 5,
![](figure/345.jpg)
>Classification\_rate: 0.3398
Misclassification\_rate: 0.6602

<div STYLE="page-break-after: always;"></div>

#### 5
##### Using cosine
![](figure/35cosine_plot.jpg)

And we could see the best result happens when k=1, which is quite weird... As we could realize it, the result highly depends on how the most common label is computed when k is small. 

<div STYLE="page-break-after: always;"></div>

And the corresponding class confusion matrix is:
![](figure/35cosine.jpg)
>Classification\_rate: 0.3672
Misclassification\_rate: 0.6328

<div STYLE="page-break-after: always;"></div>

##### Using correlation
![](figure/35correlation_plot.jpg)
We see that the best result comes when k=14, with:
>Classification\_rate: 0.4459
Misclassification\_rate: 0.5541

And the class-confusion matrix is:
![](figure/35correlation.jpg)

<div STYLE="page-break-after: always;"></div>

#### 6
Well, if only considering what we have so far, the best performance come from `K=14,'correlation'`, where the accuracy is 44.59%. Since the classification rate is the highest and the distance function itself shows more stability than the other distance functions. And the size of K is proper where too small K makes it not stable, too big K makes the performance start to going down.  
And the pair of classes that tend to get confused with each other are:
(1,9) (2,10) (3,5) and (4,6), which correspond to:
(airplane,ship), (automobile,truck), (bird,deer) and (cat,dog) which make sense.  
Some examples of cats that mis-classified as dogs:
<div style="text-align:center" markdown="1">
![](figure/fake_dog_1.jpg)![](figure/fake_dog_2.jpg)![](figure/fake_dog_3.jpg)![](figure/fake_dog_4.jpg)![](figure/fake_dog_5.jpg)![](figure/fake_dog_6.jpg)![](figure/fake_dog_7.jpg)![](figure/fake_dog_8.jpg)![](figure/fake_dog_9.jpg)![](figure/fake_dog_10.jpg)![](figure/fake_dog_11.jpg)![](figure/fake_dog_12.jpg)![](figure/fake_dog_13.jpg)![](figure/fake_dog_14.jpg)![](figure/fake_dog_15.jpg)![](figure/fake_dog_16.jpg)![](figure/fake_dog_17.jpg)![](figure/fake_dog_18.jpg)![](figure/fake_dog_19.jpg)![](figure/fake_dog_20.jpg)![](figure/fake_dog_21.jpg)![](figure/fake_dog_22.jpg)![](figure/fake_dog_23.jpg)![](figure/fake_dog_24.jpg)![](figure/fake_dog_25.jpg)![](figure/fake_dog_26.jpg)![](figure/fake_dog_27.jpg)![](figure/fake_dog_28.jpg)![](figure/fake_dog_29.jpg)![](figure/fake_dog_30.jpg)
</div>
Well, it's hard to tell. Usually cats and dogs have similar size and color. Also the figure is so low-quality which may lead to these cats closed to some of the dog's figures.

<div STYLE="page-break-after: always;"></div>

#### 7
Given the fact that usually the important information is in the mid of the figure, I was thinking about given the pixels in the middle more weight. I simply implemented it by only consider the mid 20-by-20 matrix with rgb color. Well, it's not that good. But I think it might help if you adjust the parameter a little bit.
![](figure/37sub_plot.jpg)
And the best performance:
>Classification\_rate: 0.4175
Misclassification\_rate: 0.5825

![](figure/37sub.jpg)

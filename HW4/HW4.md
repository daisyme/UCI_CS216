## HW4 by Yuan Tao
#### (a) Single scale detector output
//A FAILED attempts using peggy pig...
And human faces are not that easy task too.
##### i. template extracted from 1 positive example
![](figure/id_p1_faces5.jpg)
![](figure/id_p1n0_tr_faces5_t_faces1.jpg)
![](figure/id_p1n0_tr_faces5_t_faces2.jpg)
##### ii. template which is average of 5 positive examples
![](figure/id_p5_faces5.jpg)
![](figure/id_p5n0_tr_faces5_t_faces1.jpg)
![](figure/id_p5n0_tr_faces5_t_faces2.jpg)##### iii. template which is average of 5 positive examples minus average of 100 negative examples
negative examples:
![](figure/id_n100_faces5.jpg)
![](figure/id_p5n100_tr_faces5_t_faces1.jpg)
![](figure/id_p5n100_tr_faces5_t_faces2.jpg)
#### (b) Multi-scale detector output using whichever template works the best
![](figure/ms_p5n100_tr_faces5_t_faces2.jpg)
![](figure/ms_p5n0_tr_faces5_t_faces1.jpg)




## MY FUNCTIONS ACTUALLY WORK IN SOME EASY DATASET
#### (a) Single scale detector output

##### i. template extracted from 1 positive example
![](figure/id_p1_test3.jpg)
![](figure/id_p1n0_tr_test3_t_test1.jpg)
![](figure/id_p1n0_tr_test3_t_test2.jpg)
##### ii. template which is average of 5 positive examples 
VERY BAD RESULT!
![](figure/id_p5_test3.jpg)
![](figure/id_p5n0_tr_test3_t_test1.jpg)
![](figure/id_p5n0_tr_test3_t_test2.jpg)##### iii. template which is average of 5 positive examples minus average of 100 negative examples
VERY BAD RESULT!!
![](figure/id_p5n100_tr_test3_t_test1.jpg)
![](figure/id_p5n100_tr_test3_t_test2.jpg)
I have to admit that seems the detector is good at capturing those fragments with a pillar-shape item across them in the vertical direction. This may be caused by the feature maps.
#### (b) Multi-scale detector output using whichever template works the best
Here, I chose the matryoshka as the object to show that this is really a multi-scale detector.
![](multiscale/russia.jpeg)
##### i. template extracted from 1 positive example
![](figure/ms_patch_russia_l1.jpg)
![](figure/ms_detect_russia_russia_l1.jpg)
![](figure/ms_patch_russia_l2.jpg)
![](figure/ms_detect_russia_russia_l2.jpg)
![](figure/ms_patch_russia_l3.jpg)
![](figure/ms_detect_russia_russia_l3.jpg)

## Some sentences to compare the current detection with the previous one
Well, the main difference is that right now we've computed a few feature map and used cross-correlation on the features rather than the graph itself. Although the results are still not that good, since the template is limited and the feature maps that we extracted seem not to be very representative. But for some simple cases like the Russian toy, it works well. And we didn't try any rotation and more normalization of the figure, which also makes the results not robust.

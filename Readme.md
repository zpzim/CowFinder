Where's Waldo
=============
The goal of this project is to sucesfully identify waldo in any Where is Waldo image using datamining techniques. The key components of this project are as follows.

  - Create a classifier that finds waldo in large images
  - Evaluate the algorithm with ROC curves
  - Write a report
 
 Matlab example code
 --------------------

 EDU>>imdata=imread('plane.jpg');
 EDU>>image(imdata)
 EDU>>[y,x]=ginput(1)

 y= 643.8095
 x= 250.2208

 EDU>>red=imdata(round(x),round(y),1);
 EDU>>green=imdata(round(x),round(y),2);
 EDU>>blue=imdata(round(x),round(y),3);
 EDU>>figure;
 EDU>>patch(px,py,double([red green blue])/255)




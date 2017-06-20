# knowFaceClass
recognize different faces by processing and openCV based on kNN

This application is written by processing

##What it can do
It can learn to recognize two different objects immediately with a acceptable accuracy. 

##how it work
This application is based on openCV library in Processing, so you should make sure if you have both video and openCV libraries
in your PC. I also added serial to make it connect to arduino board, 
but it was not used in this case and it is alright to delete. 

Face detection is based on openCV's library, what I have done is to extract the most different parts of objects and save them, 
then recognize them by kNN algorythim. 
First I extract 100 points in such FACE AREA, well most of points are same even for different objects. 
Then I extract most 10 

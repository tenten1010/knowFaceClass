class Detector {
  Detector() {
  }
 
  void update(String cascade, int R, int G, int B, int num) {
    int x = 0; int y = 0; int w= 0; int h = 0;
    opencv.loadCascade(cascade);
    Rectangle[] objects = opencv.detect();
    //String objName[] = split(cascade, "_");
    //String fancyName[] = split(objName[objName.length - 1], ".");
 
    for ( int i=0; i<objects.length; i++ ) {
      stroke(R, G, B);
      if(objects[i].width>w){
        x = objects[i].x;
        y = objects[i].y;
        w = objects[i].width;
        h = objects[i].height;
      }
      //textSize(11);
      //text(fancyName[0]+": "+objects[i].width, column*70, (i+1)*10);
    }
    Recognize Recognize = new Recognize();
    rect(x,y,w,h);
    float[][] learnData = new float[10][100];
    float[] testData = gainLearnData(x,y,w,h);
    float[] data = gainData(x,y,w,h);
    if(w > 0){   
      if(num<4){
        learnData[num]=testData;
        printOnScreen(num+1);
        isFace = 0;
      }else if(num < 5){
        learnData[num]=testData;
        printOnScreen(num+1);
        delay(1);
        println("Change object");
        text("Change object", width/5, height/2);
        isFace = 0;
      }else if(num < 9){
        learnData[num]=testData;
        printOnScreen(num-4);
        isFace = 0;
      }else if(num < 10){
        learnData[num]=testData;
        printOnScreen(num-4);
        sample = gainSample(learnData);
        isFace = 0;
      }else{
        println();
        print("testing data.It's a ");
        Recognize.recognize(data);
        isFace = 0;
      }
    }else{
      println();
      println(num+" not found");
      text("Face Not Found", width/5, height/2);
      isFace = 1;
      //serial.write("N");
    }
  }
  void printOnScreen(int a){
    println();
    println("The No."+a+" is collected");
    text("The No."+a+" is collected", width/5, height/2);
  }
  float[] gainLearnData(int x,int y,int w,int h){
    color c;
    float[] arr = new float[100];
    int k = 0;
     for(int i=1;i<11;i++){
        for(int j=1;j<11;j++){
           c=get(x+i*w/10-w/20,y+j*h/10-h/20);
           arr[k]=brightness(c);
           //println(arr[k]);
           //print(arr[k]+" ");
           ellipse(x+i*w/10-w/20,y+j*h/10-h/20,1,1);
           k++;
        }
     }
     return arr;
  }
  float[][] gainSample(float[][] learnData){
    float[][] arr = new float[10][3];
    float[] a = new float[100];
    float[] b = new float[100];
    for(int i=0;i<10;i++){
      for(int j=0;j<100;j++){
        if(i<5){
          a[j] = a[j] + learnData[i][j];
        }else{
          b[j] = b[j] + learnData[i][j];
        }
      }
    }
    getOrder(a,b);
    for(int h=0;h<10;h++){
      arr[h][0]=learnData[h][int((order[0][0]))];
      arr[h][1]=learnData[h][int((order[1][0]))];
      arr[h][2]=learnData[h][int((order[2][0]))];
    }
    return arr;
  }
  void getOrder(float[] a,float[] b){
    for(int k=0;k<a.length;k++){
      if(abs(a[k]-b[k])>order[0][1]){
        order[2][0]=order[1][0];
        order[2][1]=order[1][1];
        order[1][0]=order[0][0];
        order[1][1]=order[0][1];
        order[0][0]=k;
        order[0][1]=abs(a[k]-b[k]);
      }else if(abs(a[k]-b[k])>order[1][1]){
        order[2][0]=order[1][0];
        order[2][1]=order[1][1];
        order[1][0]=k;
        order[1][1]=abs(a[k]-b[k]);
      }else{
        order[2][0]=k;
        order[2][1]=abs(a[k]-b[k]);
      }
    }
  }
  
  float[] gainData(int x,int y,int w,int h){
    color c;
    float[] arr = new float[100];
    float[] res = new float[3];
    int k = 0;
     for(int i=1;i<11;i++){
        for(int j=1;j<11;j++){
           c=get(x+i*w/10-w/20,y+i*h/10-w/20);
           arr[k]=brightness(c);
           //println(arr[k]);
           //print(arr[k]+" ");
           ellipse(x+i*w/10-w/20,y+j*h/10-h/20,1,1);
           k++;
        }
     }
     res[0]=arr[int(order[0][0])];
     res[1]=arr[int(order[1][0])];
     res[2]=arr[int(order[2][0])];
     print("data:"+res[0]+" "+res[1]+" "+res[2]);
     return res;
  }
}
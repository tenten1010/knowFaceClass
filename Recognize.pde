class Recognize {
  Recognize(){}
  
    void recognize(float[] arr){ 
    float sum = 0;
    float[][] min = {{100,0},{100,0},{100,0}};
    float[] distance = new float[10];
    float result;
     //print(sample[0][0]);
    for(int i=0;i<10;i++){
      for(int j=0;j<arr.length;j++){
        sum = (sample[i][j]-arr[j])*(sample[i][j]-arr[j]);
        //print(sum+"  ");
      }
      distance[i]=sqrt(sum);
      print(distance[i]+"  ");
      if(distance[i]<min[0][0]){
        min[2][0]=min[1][0];
        min[2][1]=min[1][1];
        min[1][0]=min[0][0];
        min[1][1]=min[0][1];
        min[0][0]=distance[i];
        min[0][1]=judge(i);
        //print("judge"+min[0][1]+".");
      }else if(distance[i]<min[1][0]){
        min[2][0]=min[1][0];
        min[2][1]=min[1][1];
        min[1][0]=distance[i];
        min[1][1]=judge(i);
      }else if(distance[i]<min[2][0]){
        min[2][0]=distance[i];
        min[2][1]=judge(i);
      }
    }
    result = min[0][1]*0.5+min[1][1]*0.3+min[2][1]*0.2;
    println("which"+min[0][1],min[1][1],min[2][1]);
    if(result>=0.5){
      //serial.write("H");
      println("Object 1");
      text("Object 1", width/5, height/2);
      //serial.write("s");
    }else{
      //serial.write("A");
      println("Object 2");
      text("Object 2", width/5, height/2);
      //serial.write("s");
    }  
  }
  
  float judge(int a){
    if(a<5){
      return 1.0;
    }else{
      return 0.0;
    }
  }
}
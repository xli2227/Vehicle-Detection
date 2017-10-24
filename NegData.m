clear all; close all;
disp('======= 9840 Project DataPrepare Process =======');

%directory sets
root_dir = 'F:\Program Files\MATLAB\My Workspace\Project\';
data_set = 'training';
cam = 2; % 2 = left color camera
image_dir = fullfile(root_dir,[data_set '\image_' num2str(cam)]);
label_dir = fullfile(root_dir,[data_set '\label_' num2str(cam)]);
outnum=0;
%number of images
nimages = length(dir(fullfile(image_dir, '*.png')));
for img_idx=60:80 %0-50 for Training,60-80 for testing.
%img_idx=10;
% load labels
objects = readLabels(label_dir,img_idx);
num=length(objects);
car=[];
for i=1:num
  src=sprintf('%s/%06d.png',image_dir,img_idx);
  img=imread(src);
  img=rgb2gray(img);
  Width = size(img, 2);
  Height = size(img, 1);
    if(strcmp(objects(i).type,'Car'))
        x1=round(objects(i).x1);
        x2=round(objects(i).x2);
        y1=round(objects(i).y1);
        y2=round(objects(i).y2);
        temp=[x1,x2,y1,y2];
        car=[car;temp];
    end   
end
  number=0;
  %%define a number that randomly choose from the image.
  while(number<=25)
      rx1=round(rand*Width);
      ry1=round(rand*Height);
      rx2=rx1+100;
      ry2=ry1+100;
      if rx1==0
          rx1=1;
      end
      if ry1==0
          ry1=1;
      end
      if rx2-Width>0
          continue;
      end
      if ry2-Height>0
          continue;
      end
      count=0;
      [a b]=size(car);
      for k=1:a
         newx1 = max(rx1,car(k,1));
         newy1 = max(ry1,car(k,3)); 
         newx2 = min(rx2,car(k,2));  
         newy2 = min(ry2,car(k,4));
         if(newx1>newx2 || newy1>newy2)
             count=count+1;
         end
      end
      if(count==a)
          windows=img(ry1:ry2,rx1:rx2);
          Newimage=imresize(windows,[100 100]);
          %imwrite(Newimage,['F:\Program Files\MATLAB\My Workspace\Project\NewData1\Negative\',num2str(outnum),'.png']);
          imwrite(Newimage,['F:\Program Files\MATLAB\My Workspace\Project\NewTest1\Negative\',num2str(outnum),'.png']);
          outnum=outnum+1;
          number=number+1;
      end    
  end
end

    
        

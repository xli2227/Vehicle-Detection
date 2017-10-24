clear all; close all;
disp('======= 9840 Project DataPrepare Process =======');

%directory sets
root_dir = 'F:\Program Files\MATLAB\My Workspace\Project\';
data_set = 'training';
cam = 2; % 2 = left color camera
image_dir = fullfile(root_dir,[data_set '\image_' num2str(cam)]);
label_dir = fullfile(root_dir,[data_set '\label_' num2str(cam)]);

%number of images
nimages = length(dir(fullfile(image_dir, '*.png')));
count=0;
for img_idx=60:80 %0-30 for Training,50-90 for testing.
%img_idx=10;
% load labels
objects = readLabels(label_dir,img_idx);
num=length(objects);
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
        twidth=x2-x1;
        theight=y2-y1;
        s1=x1-round(twidth/4);
        s2=y1-round(theight/4);
        e1=x1+round(twidth/4);
        e2=y1+round(theight/4);
        if s1<=0
            s1=1;
        end
        if s2<=0
            s2=1;
        end
        if e1+twidth>Width
            e1=Width-twidth;
        end
        if e2+theight>Height
            e2=Height-theight;
        end
        stepx=round(twidth/5);
        stepy=round(theight/5);
        for x=s1:stepx:e1
            for y=s2:stepy:e2
        out=img(y:y+theight,x:x+twidth);
        out=imresize(out,[100,100]);
        %imwrite(out,['F:\Program Files\MATLAB\My Workspace\Project\NewData1\Positive\',num2str(count),'.png']);
        imwrite(out,['F:\Program Files\MATLAB\My Workspace\Project\NewTest1\Positive\','Exam',num2str(count),'.png']);
        count=count+1;
            end
        end
     end
  end
end

    
        

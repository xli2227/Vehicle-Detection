
% clear and close everything
clear all; close all;
disp('======= 9840 Project Feature Extracting Process =======');
%file_path =  'F:\Program Files\MATLAB\My Workspace\Project\Data';
%file_path =  'F:\Program Files\MATLAB\My Workspace\Project\Test';
file_path =  'F:\Program Files\MATLAB\My Workspace\Project\NewData';
%file_path =  'F:\Program Files\MATLAB\My Workspace\Project\NewTest';
dir_path_list = dir(file_path);
dir_num = length(dir_path_list);

% Cellsize=10:20:40;
% rescale=50:100:250;
% Orientation=4:2:14;
count=1;
Train=[];
Label=[];
% Test=[];
% TestLabel=[];
if dir_num>0
  %  for ii=1:length(Cellsize)
       % for jj=1:length(rescale)
         %   for kk=1:length(Orientation)
   for k=3:dir_num
       image_path=dir_path_list(k).name;
       workpath=strcat(file_path,'\',image_path,'\');
       img_path_list = dir(strcat(workpath,'*.png'));
       img_num=length(img_path_list);
    if img_num > 0 
         for j = 1:img_num 
            image_name = img_path_list(j).name;
            image =  imread(strcat(workpath,image_name));
%            define the heat map, however, it's result is not satisfied. 
%             Newimage=imresize(image,[150 150]);%[rescale(jj) rescale(jj)]);
%             cellSize=30;%Cellsize(ii);
%             orientation=14;%Orientation(kk);
%             temphog=vl_hog(single(Newimage),cellSize,'NumOrientations',orientation);
%             [a,b,c]=size(temphog);
%             Len=a*b*c;
%             temp=reshape(temphog,[1,Len]);
            [temphog,visualization] = extractHOGFeatures(image,'CellSize',[10 10]);        
             Train(:,count)=temphog';
             %Test(:,count)=temphog';
            if k==3;
            Label(1,count)=-1;
            %TestLabel(1,count)=-1;
            end
            if k==4
            Label(1,count)=1;
            %TestLabel(1,count)=1;   
            end  
            count=count+1;
         end
     end
   end
end

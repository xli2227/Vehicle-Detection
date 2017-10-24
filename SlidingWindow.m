

%image = imread('image_0510.jpg');
%image = imread('002183.png');
%image = imread('image_0107.jpg');
%image = imread('image_0509.jpg');
image = imread('image_0362.jpg');


tic
imageWidth = size(image, 2);
imageHeight = size(image, 1);
BoxSize=[30,50,80,100,200];
Final=[];
imshow(image);

fc=[];
for n=1:1
windowWidth = BoxSize(n);
windowHeight = BoxSize(n);

for j = 1:5:imageHeight - windowHeight + 1
    for i = 1:5:imageWidth - windowWidth + 1
        window = image(j:j + windowHeight - 1, i:i + windowWidth - 1, :);
        window=imresize(window,[100 100]);
        [temphog,visualization] = extractHOGFeatures(window,'CellSize',[10 10]); 
        data=[temphog,i,j,windowWidth,windowHeight]; 
        Final=[Final;data];   
    end
end

Test=Final(:,1:2916)';
pos=Final(:,2917:2920);
Test=Test';
[pc,score,latent,tsquare] = princomp(Test(1:100,:));
tranMatrix = pc(:,1:800);
Test=Test*tranMatrix;
Test=Test';

ResultM = sign(Classify(MLearners, MWeights, Test));

%collecting the centers.
Box=[];
cluster=8;
center=[];
for r=1:length(ResultM)
    if  ResultM(r)==1
    Box=[Box;pos(r,:)];
    end
end


for t=1:length(Box)
    center(t,1)=Box(t,1)+ Box(t,3)/2 -1;
    center(t,2)=Box(t,2)+ Box(t,4)/2 -1;

end
[idx,C] = kmeans(center,cluster);
C=round(C);
fc=[fc;C];


end


%Making clusters.
[idx,hc] = kmeans(fc,cluster);

%repredict & puting bouding box.
ttest=[];
for c=1:length(fc)
twindow=image(fc(c,2)-50:fc(c,2)+50,fc(c,1)-50:fc(c,1)+50);
twindow=imresize(twindow,[100 100]);
[thog,visualization] = extractHOGFeatures(twindow,'CellSize',[10 10]); 
ttest=[ttest;thog];
end

[pc,score,latent,tsquare] = princomp(ttest(1:cluster,:));
tranMatrix = pc(:,1:800);
ttest=ttest*tranMatrix;
ttest=ttest';

predict = sign(Classify(MLearners, MWeights, ttest));
% for c=1:length(hc)
% rectangle('Position',[hc(c,1)-50,hc(c,2)-50,100,100]);
% end
for d=1:length(fc)
    if predict(d)==1
        rectangle('Position',[fc(d,1)-40,fc(d,2)-40,80,80]);
    end
end
toc
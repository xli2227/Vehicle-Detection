Box=[];
cluster=5;
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
bw=zeros(1,5);
bh=zeros(1,5);
numw=zeros(1,5);
numh=zeros(1,5);
for p=1:length(idx)
   bw(idx(p))=bw(idx(p))+Box(p,3);
   numw(idx(p))=numw(idx(p))+1;
   bh(idx(p))=bh(idx(p))+Box(p,4);
   numh(idx(p))=numh(idx(p))+1;
end
bw=round(bw./numw);
bh=round(bh./numh);
imshow(image);
for c=1:cluster
rectangle('Position',[C(c,1)-50,C(c,2)-50,100,100]);
end

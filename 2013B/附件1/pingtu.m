img0=zeros(1980,1368);cmap0=zeros(256,19*3);img=zeros(1980,1368);
for i=1:19%��ȡ������ֽƬ
    [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(num2str(i-1),'bmp');
end

deta255=zeros(19);
for i=1:19
    for j=1:19 %deta255(i,j)i���Ҳ��j�����
        deta255(i,j)=abs(sum(abs((img0(:,i*72)-img0(:,j*72-71)))));
    end
end
%abs(length(find(img0(:,i*72)==255))-length(find(img0(:,j*72-71)==255)));
%9...7
img(:,1:72)=img0(:,9*72-71:9*72);
now=9;
for i=2:19
    now=find(deta255(now,:)==min(deta255(now,:)));
    img(:,i*72-71:i*72)=img0(:,now*72-71:now*72);
end
image(img);
colormap(cmap);
%abcdefghijklmnopqrstuvwxyz

num=19;
sign=[72	18	28	34	61	16	81	84	86	133	134	153	157	166	171	199	201	203	206
];
for i=1:num  %读取所有碎纸片
    if sign(i)<11
        [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(strcat('00',num2str(sign(i)-1)),'bmp');
    elseif sign(i)<101
        [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(strcat('0',num2str(sign(i)-1)),'bmp');
    else
        [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(num2str(sign(i)-1),'bmp');
    end
end
img1=im2double(img0)*255;

for i=1:19
    for j=1:19 %deta255(i,j)i的右侧和j的左侧
        deta255(i,j)=sum(abs(img1(:,i*72)-img1(:,j*72-71)));
    end
end
%deta255(13,7)=inf;deta255(13,6)=inf;deta255(8,7)=inf;
now=1;
img(:,1:72)=img0(:,now*72-71:now*72);
shunxu(1)=sign(now);
for i=2:19
    deta255(:,now)=inf;
    now=find(deta255(now,:)==min(deta255(now,:)))
    shunxu(i)=sign(now);
    img(:,i*72-71:i*72)=img0(:,now*72-71:now*72);
end
%figure;
image(img);
colormap(cmap0(:,1:3));



%分类，一类为一行
num=209;

for i=1:num  %读取所有碎纸片
    if i<11
        [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(strcat('00',num2str(i-1)),'bmp');
    elseif i<101
        [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(strcat('0',num2str(i-1)),'bmp');
    else
        [img0(:,i*72-71:i*72),cmap0(:,i*3-2:i*3)]=imread(num2str(i-1),'bmp');
    end
end

biaozhun=zeros(1,num);
for i=1:num
    temp=img0(:,72*i-71:72*i);
    temp2=zeros(180,1);
    for j=1:180
        if(sum(temp(j,:))==72*255)
            temp2(j)=255;
        end
    end
    for j=1:180
        if(temp2(j+1)==255 && temp2(j)~=255) %寻找第一个变为255的行数(黑变白)
            b=j;
            break;
        end
    end
    biaozhun(i)=b;
end
%特殊的处理
biaozhun(30)=biaozhun(30)-68;
biaozhun(59)=biaozhun(59)+18;
biaozhun(90)=biaozhun(90)-68;
biaozhun(72)=biaozhun(72)-68;
biaozhun(15)=biaozhun(15)-68;

biaozhunpaixu=sort(biaozhun);
fenlei=zeros(11,19);
for i=1:11
    fenlei(i,:)=find(biaozhun<=biaozhunpaixu(i*19) & biaozhun>=biaozhunpaixu(i*19-18));
end

%寻找第一片
diyipian=zeros(1,11);
k=1;
for i=1:209
    if(sum(sum(img0(:,i*72-71:i*72-62)))==255*180*10)
        diyipian(k)=i;
        k=k+1;
    end
end
%把实际第一片换到第一位  30有问题
for i=1:11
    [m,n]=find(fenlei==diyipian(i));
    fenlei(m,n)=fenlei(m,1);
    fenlei(m,1)=diyipian(i);
end

%{
for k=2:11

deta255=zeros(19);
for i=1:19
    for j=1:19 %deta255(i,j)i的右侧和j的左侧
        deta255(i,j)=abs(sum(abs(img0(:,fenlei(k,i)*72)-img0(:,fenlei(k,j)*72-71))));
    end
end


now=fenlei(k,1);

img(:,1:72)=img0(:,now*72-71:now*72);
for i=2:19
    now2=find(fenlei(k,:)==now);
    now=find(deta255(now2,:)==min(deta255(now2,:)));
    img(:,i*72-71:i*72)=img0(:,now*72-71:now*72);
end
figure;
image(img);
colormap(cmap0(:,1:3));

end
%}

gehang=[20	195	94	142	89	122	127	106	156	115	177	183	152	23	58	203	72	166	83
21	42	109	117	137	74	37	208	136	16	77	44	200	46	174	80	162	180	144
71	85	61	15	69	175	138	196	9	48	173	157	97	24	100	123	91	186	110
82	78	129	201	132	53	126	141	194	88	90	49	73	13	178	125	1	103	116
87	52	108	30	41	159	187	99	25	118	151	6	60	59	93	31	38	47	128
133	182	96	70	168	164	167	189	112	145	207	4	131	35	14	111	26	28	179
160	140	2	130	64	139	154	54	39	124	121	176	86	51	161	188	98	204	32
172	43	67	206	11	158	75	146	84	135	56	19	57	36	17	10	184	153	45
192	76	12	155	191	185	3	105	181	65	107	5	150	33	205	66	40	68	148
202	149	171	197	199	95	114	165	79	104	92	81	102	27	101	7	18	29	147
209	22	8	50	62	120	34	143	169	63	170	55	193	134	119	190	163	198	113
];

img_gehang=zeros(180*11,72*19);
img0=zeros(180*11,72*19);
cmap0=zeros(180*11,72*19);
for i=1:11
for j=1:19  %读取所有碎纸片
    if gehang(i,j)<11
        [img0(180*i-179:180*i,j*72-71:j*72),cmap0(256*i-255:256*i,j*3-2:j*3)]=imread(strcat('00',num2str(gehang(i,j)-1)),'bmp');
    elseif gehang(i,j)<101
        [img0(180*i-179:180*i,j*72-71:j*72),cmap0(256*i-255:256*i,j*3-2:j*3)]=imread(strcat('0',num2str(gehang(i,j)-1)),'bmp');
    else
        [img0(180*i-179:180*i,j*72-71:j*72),cmap0(256*i-255:256*i,j*3-2:j*3)]=imread(num2str(gehang(i,j)-1),'bmp');
    end
end
end
image(img0);
colormap(cmap0(1:256,1:3));
touying=zeros(1980,1);
touying(find(sum(img0,2)==1368*255))=255;


for i=1:180
    for j=1:11
        touying1(i,j)=touying((j-1)*180+i);
    end
end



%{
for kk=1:11
    
num=19;
sign=gehang(kk,:);
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
now=1;
img(:,1:72)=img0(:,now*72-71:now*72);
shunxu(1)=sign(now);
for i=2:19
    deta255(:,now)=inf;
    now=find(deta255(now,:)==min(deta255(now,:)));
    shunxu(i)=sign(now);
    img(:,i*72-71:i*72)=img0(:,now*72-71:now*72);
end

img_gehang(180*kk-179:180*kk,:);
%subplot(11,1,kk);
figure
image(img);
colormap(cmap0(:,1:3));

end

%}
function [R,RUV]=finish_3_30_1(file_name,mian_value,a_num)
%fit_try try_3_13 IAfit find_best 最终版程序
%% 单变量响应拟合
%% 导入数据
[~, ~, raw] = xlsread(file_name,'Sheet1','B1:H4');
%% 创建输出变量
xy = reshape([raw{:}],size(raw));
clearvars raw;
[~, ~, raw] = xlsread(file_name,'Sheet1','B7:I14');
 xyz= reshape([raw{:}],size(raw));
clearvars raw;
[~, ~, raw] = xlsread(file_name,'Sheet1','B6:I6');

%% 将非数值元胞替换为 0.0
R = cellfun(@(x) (~isnumeric(x) && ~islogical(x)) || isnan(x),raw); % 查找非数值元胞
raw(R) = {0.0}; % 替换非数值元胞
%% 创建输出变量
x = reshape([raw{:}],size(raw));
%% 清除临时变量
clearvars raw R;
[~, ~, raw] = xlsread(file_name,'Sheet1','A7:A14');

%% 创建输出变量
y = reshape([raw{:}],size(raw));

%% 清除临时变量
clearvars raw;
y1=xy(2,:); %第一组数据的响应值
x1=xy(1,:);%浓度
y2=xy(4,:);
x2=xy(3,:);
x1_qu_zhi_fan_wei=[-inf inf 0.9;80 100 90;0  1   0.33];%取值范围 最低 最高 开始点 参数 a  k t 
x2_qu_zhi_fan_wei=[-inf inf 0.9;80 100 90;0  1  0.32];%取值范围 最低 最高 开始点 参数 a  k t
[R1, gof1]=fit_try(x1,y1,1,1,x1_qu_zhi_fan_wei);%A1单一值的响应
[R2, gof2]=fit_try(x2,y2,2,1,x2_qu_zhi_fan_wei);%A2单一值的响应
 % z1是实验的结果响应
% x=[0.5	0.25	0.125	0.0625	0.03125	0.015625	0.0078125 0 ]; %变量浓度 
% y=[ 0.5	0.25	0.125	0.0625	0.03125	0.015625	0.0078125 0 ]; %变量浓度
% z=[95.29	95.81	95.43	95.89	95.43	95.44	95.44	95.46
% 95.63	95.49	95.42	95.41	95.65	95.47	94.83	95.41
% 95.63	95.43	95.42	76.18	68.88	64.62	61.63	48.12
% 95.59	95.40	61.00	50.28	34.43	30.63	28.06	28.53
% 95.62	95.51	63.92	38.43	30.59	23.32	19.44	15.04
% 95.32	95.57	54.83	29.80	16.80	14.55	13.40	8.86
% 95.56	95.41	56.85	27.44	19.59	13.39	10.18	7.98
% 95.51	85.16	40.00	20.58	7.45	7.90	5.88	0.00];
% x=[2:1:5];
% y=[2:1:5];
% z=[655	710	710	600
% 570	660	650	600
% 710	670	640	625
% 690	680	635	620
% ];
z=xyz;
% z=round(z);向上取整
% pan_duan_xuanzhuang=input('数据是否需要进行反转...1 向上反转 2 旋转90° 3不进行旋转 ....='); %判断是否旋转
pan_duan_xuanzhuang= mian_value.pan_duan_xuanzhuang;
if pan_duan_xuanzhuang==1
        z1=flip(z,1);%转换矩阵，将矩阵向上翻转 转90度 
    elseif  pan_duan_xuanzhuang==2
        z1=rot90(z); % 转90度 
    elseif  pan_duan_xuanzhuang==3
        z1=z; %不进行变换
end
%% 数据输入与判定归一化
%pan_duan_bia0_zhuan_hua=input('变量浓度是否已经标准化 1是 , 2需要标准化.....=');
pan_duan_bia0_zhuan_hua=mian_value.pan_duan_bia0_zhuan_hua;
if pan_duan_bia0_zhuan_hua==2
    x=mapminmax(x,0,1);
    y=mapminmax(y,0,1);
end
hh=x;
%% 将矩阵的浓度和响应值相加 测试
zz=zeros(length(x));
R1Y=R1(x);
R2Y=R2(x);
for i=1:length(x)
    for j=1:length(x)
        zz(i,j)=R1Y(i)+R2Y(j);
        if zz(i,j)>=110 %但相加浓度大于最大能力时，设定为最大浓度
            zz(i,j)=110;  
        end
    end
end
%% 对浓度进行两种方式的拟合
AI_qu_zhi_fan_wei=[-inf inf 0.9;a_num.min , a_num.max , a_num.star;0  , 10 , 0.1; 0 , 1 ,  0.1];
[IAfitresult,IAgof]=IAfit(x, y, z1,1,1,AI_qu_zhi_fan_wei);%%浓度增加效应
%% 进行扰动计算
 qu_zhi_fan_wei=[-inf inf 5;0   10   1;0   10    1; a_num.min , a_num.max , a_num.star;0   10  0.5; 0  1   0.1];%取值范围 最低 最高 开始点 参数 a b c k p t 
BB=zeros(6,2);%初始的扰动值
R2_22=0.1; %初始的联合效应r^2
R2_2=0.1; %迭代过程的初始的联合效应r^2
 R2_all=zeros(6);%扰动值初始化
for i1=1:6
    i1;
    [BB(i1,1), BB(i1,2),fitresult11, gof11]=try_3_13(x,y,z1,i1,qu_zhi_fan_wei);
    R2_11=gof11.rsquare;
     R2_all(i1)=gof11.rsquare;                           %储存方程的R^2
               if R2_22<=R2_11                            %寻找最高r^2
                   R2_22=R2_11;
                   fitresult112=fitresult11;            %记录最优的方程
                   gof12=gof11;                         %记录最优的r^2
                   best_r=i1;
               end
end 
%% 定义迭代过程的参数
kpt=[80   100   90;0   10   0.1; 0  1    0.1];a=[-1 1 0.9]; %取值范围 最低 最高 开始点 参数 k p t  a
c=find(BB~=0); %寻找显著的干扰项
[t1, t2]=size(c); 
[n,m]=size(BB); % 6列 2行
vv=[]; %初始化迭代参数
for i=1:t1
     h=nchoosek(c,i);%combntns(c,i)
     vv=zeros(n*m,3);%生成和参数数目相同的零矩阵 作为参数矩阵
     [n1,m2]=size(h);
     for j=1:n1
         m1=m2;
       try %删除
         while m1~=0 %满足矩阵的每行进行设定参数
             j;
             vv(h(j,m1),:)=BB(h(j,m1)); 
             m1=m1-1;
             m1;
         end
           zuhe_qu_zhi_fan_wei=[a;vv;kpt]; %设定参数
               [fitresult1, gof1]=find_best(x,y,z1, zuhe_qu_zhi_fan_wei);%计算不同参数组合的 r^2与拟合曲线
               R2_1=gof1.rsquare;
               if R2_2<=R2_1
                   R2_2=R2_1;
                   gof_find=gof1;
                   fitresult=fitresult1;
               end
       end  %删除
     end
end
%%
% [CAfitresult,CAgof]=CAfit(x, y, z1,1);%%联合效应
IAfitresult(0:1,0:1);
[x,y,z]=meshgrid(linspace(0,1,200));
    %plot( CAfitresult);
    plot(fitresult112) %交互作用拟合
hold on
    plot(IAfitresult);%浓度相加
[xData, yData, zData] = prepareSurfaceData( hh, hh, z1 );
h=scatter3(xData, yData, zData,'k');
hold off

%% 判断作用类型
sv1=dblquad(fitresult112,0,1,0,1);  %计算联合效果
svIN=dblquad(IAfitresult,0,1,0,1); %计算浓度相加效应
RUV=100*(sv1-svIN)/sv1; %计算评价效果
if RUV>0
    display(strcat('RUV=',num2str(RUV),'%   2种物质为联合作用'))
elseif RUV==0
    display(strcat('RUV=',num2str(RUV),'%   2种物质为无相关作用'))
else
    display(strcat('RUV=',num2str(RUV),'%   2种物质为拮抗作用'))
end
%% 结果展示
%c=input('请输入是否显示：1 显示  2不显示  ===');
c_chose=mian_value.c;
if c_chose==1
   figure
    [xData, yData, zData] = prepareSurfaceData( hh, hh, z1 );
    scatter3(xData, yData, zData,'k');
    hold on
     plot(IAfitresult);%浓度相加
    title(strcat('浓度相加与原始数据图'))
    xlabel A1浓度
    ylabel A2浓度
    zlabel 清除率
    hold off 
    figure
     [xData, yData, zData] = prepareSurfaceData( hh, hh, z1 );
    h=scatter3(xData, yData, zData,'k');
    hold on
     plot(fitresult112);%浓度相加
    title(strcat('联合作用与原始数据图'))
     xlabel A1浓度
    ylabel A2浓度
    zlabel 清除率
    hold off 
end
R.gof12=gof12;
R.IAgof=IAgof;
R.IAfitresult=IAfitresult;
R.fitresult112=fitresult112;
R.best_r=best_r;
R.gof_find=gof_find;
save fitresult112 fitresult112
save IAfitresult IAfitresult
disp('-------------分割线-------------------')
display(strcat('浓度相加的拟合r^2=    ',num2str(IAgof.rsquare)))
disp('浓度相加的拟合方程')
display(IAfitresult)
disp('-------------分割线-------------------')
display(strcat('浓度联合的最佳拟合r^2=    ',num2str(gof12.rsquare)))
disp('浓度联合的最佳拟合方程');
display(fitresult112);
disp('-------------分割线-------------------')
display(strcat('拟合最佳方程=    ',num2str(best_r)))
display(strcat('浓度联合的迭代拟合=    ',num2str(gof_find.rsquare)))
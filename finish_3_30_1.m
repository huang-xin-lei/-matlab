function [R,RUV]=finish_3_30_1(file_name,mian_value,a_num)
%fit_try try_3_13 IAfit find_best ���հ����
%% ��������Ӧ���
%% ��������
[~, ~, raw] = xlsread(file_name,'Sheet1','B1:H4');
%% �����������
xy = reshape([raw{:}],size(raw));
clearvars raw;
[~, ~, raw] = xlsread(file_name,'Sheet1','B7:I14');
 xyz= reshape([raw{:}],size(raw));
clearvars raw;
[~, ~, raw] = xlsread(file_name,'Sheet1','B6:I6');

%% ������ֵԪ���滻Ϊ 0.0
R = cellfun(@(x) (~isnumeric(x) && ~islogical(x)) || isnan(x),raw); % ���ҷ���ֵԪ��
raw(R) = {0.0}; % �滻����ֵԪ��
%% �����������
x = reshape([raw{:}],size(raw));
%% �����ʱ����
clearvars raw R;
[~, ~, raw] = xlsread(file_name,'Sheet1','A7:A14');

%% �����������
y = reshape([raw{:}],size(raw));

%% �����ʱ����
clearvars raw;
y1=xy(2,:); %��һ�����ݵ���Ӧֵ
x1=xy(1,:);%Ũ��
y2=xy(4,:);
x2=xy(3,:);
x1_qu_zhi_fan_wei=[-inf inf 0.9;80 100 90;0  1   0.33];%ȡֵ��Χ ��� ��� ��ʼ�� ���� a  k t 
x2_qu_zhi_fan_wei=[-inf inf 0.9;80 100 90;0  1  0.32];%ȡֵ��Χ ��� ��� ��ʼ�� ���� a  k t
[R1, gof1]=fit_try(x1,y1,1,1,x1_qu_zhi_fan_wei);%A1��һֵ����Ӧ
[R2, gof2]=fit_try(x2,y2,2,1,x2_qu_zhi_fan_wei);%A2��һֵ����Ӧ
 % z1��ʵ��Ľ����Ӧ
% x=[0.5	0.25	0.125	0.0625	0.03125	0.015625	0.0078125 0 ]; %����Ũ�� 
% y=[ 0.5	0.25	0.125	0.0625	0.03125	0.015625	0.0078125 0 ]; %����Ũ��
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
% z=round(z);����ȡ��
% pan_duan_xuanzhuang=input('�����Ƿ���Ҫ���з�ת...1 ���Ϸ�ת 2 ��ת90�� 3��������ת ....='); %�ж��Ƿ���ת
pan_duan_xuanzhuang= mian_value.pan_duan_xuanzhuang;
if pan_duan_xuanzhuang==1
        z1=flip(z,1);%ת�����󣬽��������Ϸ�ת ת90�� 
    elseif  pan_duan_xuanzhuang==2
        z1=rot90(z); % ת90�� 
    elseif  pan_duan_xuanzhuang==3
        z1=z; %�����б任
end
%% �����������ж���һ��
%pan_duan_bia0_zhuan_hua=input('����Ũ���Ƿ��Ѿ���׼�� 1�� , 2��Ҫ��׼��.....=');
pan_duan_bia0_zhuan_hua=mian_value.pan_duan_bia0_zhuan_hua;
if pan_duan_bia0_zhuan_hua==2
    x=mapminmax(x,0,1);
    y=mapminmax(y,0,1);
end
hh=x;
%% �������Ũ�Ⱥ���Ӧֵ��� ����
zz=zeros(length(x));
R1Y=R1(x);
R2Y=R2(x);
for i=1:length(x)
    for j=1:length(x)
        zz(i,j)=R1Y(i)+R2Y(j);
        if zz(i,j)>=110 %�����Ũ�ȴ����������ʱ���趨Ϊ���Ũ��
            zz(i,j)=110;  
        end
    end
end
%% ��Ũ�Ƚ������ַ�ʽ�����
AI_qu_zhi_fan_wei=[-inf inf 0.9;a_num.min , a_num.max , a_num.star;0  , 10 , 0.1; 0 , 1 ,  0.1];
[IAfitresult,IAgof]=IAfit(x, y, z1,1,1,AI_qu_zhi_fan_wei);%%Ũ������ЧӦ
%% �����Ŷ�����
 qu_zhi_fan_wei=[-inf inf 5;0   10   1;0   10    1; a_num.min , a_num.max , a_num.star;0   10  0.5; 0  1   0.1];%ȡֵ��Χ ��� ��� ��ʼ�� ���� a b c k p t 
BB=zeros(6,2);%��ʼ���Ŷ�ֵ
R2_22=0.1; %��ʼ������ЧӦr^2
R2_2=0.1; %�������̵ĳ�ʼ������ЧӦr^2
 R2_all=zeros(6);%�Ŷ�ֵ��ʼ��
for i1=1:6
    i1;
    [BB(i1,1), BB(i1,2),fitresult11, gof11]=try_3_13(x,y,z1,i1,qu_zhi_fan_wei);
    R2_11=gof11.rsquare;
     R2_all(i1)=gof11.rsquare;                           %���淽�̵�R^2
               if R2_22<=R2_11                            %Ѱ�����r^2
                   R2_22=R2_11;
                   fitresult112=fitresult11;            %��¼���ŵķ���
                   gof12=gof11;                         %��¼���ŵ�r^2
                   best_r=i1;
               end
end 
%% ����������̵Ĳ���
kpt=[80   100   90;0   10   0.1; 0  1    0.1];a=[-1 1 0.9]; %ȡֵ��Χ ��� ��� ��ʼ�� ���� k p t  a
c=find(BB~=0); %Ѱ�������ĸ�����
[t1, t2]=size(c); 
[n,m]=size(BB); % 6�� 2��
vv=[]; %��ʼ����������
for i=1:t1
     h=nchoosek(c,i);%combntns(c,i)
     vv=zeros(n*m,3);%���ɺͲ�����Ŀ��ͬ������� ��Ϊ��������
     [n1,m2]=size(h);
     for j=1:n1
         m1=m2;
       try %ɾ��
         while m1~=0 %��������ÿ�н����趨����
             j;
             vv(h(j,m1),:)=BB(h(j,m1)); 
             m1=m1-1;
             m1;
         end
           zuhe_qu_zhi_fan_wei=[a;vv;kpt]; %�趨����
               [fitresult1, gof1]=find_best(x,y,z1, zuhe_qu_zhi_fan_wei);%���㲻ͬ������ϵ� r^2���������
               R2_1=gof1.rsquare;
               if R2_2<=R2_1
                   R2_2=R2_1;
                   gof_find=gof1;
                   fitresult=fitresult1;
               end
       end  %ɾ��
     end
end
%%
% [CAfitresult,CAgof]=CAfit(x, y, z1,1);%%����ЧӦ
IAfitresult(0:1,0:1);
[x,y,z]=meshgrid(linspace(0,1,200));
    %plot( CAfitresult);
    plot(fitresult112) %�����������
hold on
    plot(IAfitresult);%Ũ�����
[xData, yData, zData] = prepareSurfaceData( hh, hh, z1 );
h=scatter3(xData, yData, zData,'k');
hold off

%% �ж���������
sv1=dblquad(fitresult112,0,1,0,1);  %��������Ч��
svIN=dblquad(IAfitresult,0,1,0,1); %����Ũ�����ЧӦ
RUV=100*(sv1-svIN)/sv1; %��������Ч��
if RUV>0
    display(strcat('RUV=',num2str(RUV),'%   2������Ϊ��������'))
elseif RUV==0
    display(strcat('RUV=',num2str(RUV),'%   2������Ϊ���������'))
else
    display(strcat('RUV=',num2str(RUV),'%   2������Ϊ�׿�����'))
end
%% ���չʾ
%c=input('�������Ƿ���ʾ��1 ��ʾ  2����ʾ  ===');
c_chose=mian_value.c;
if c_chose==1
   figure
    [xData, yData, zData] = prepareSurfaceData( hh, hh, z1 );
    scatter3(xData, yData, zData,'k');
    hold on
     plot(IAfitresult);%Ũ�����
    title(strcat('Ũ�������ԭʼ����ͼ'))
    xlabel A1Ũ��
    ylabel A2Ũ��
    zlabel �����
    hold off 
    figure
     [xData, yData, zData] = prepareSurfaceData( hh, hh, z1 );
    h=scatter3(xData, yData, zData,'k');
    hold on
     plot(fitresult112);%Ũ�����
    title(strcat('����������ԭʼ����ͼ'))
     xlabel A1Ũ��
    ylabel A2Ũ��
    zlabel �����
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
disp('-------------�ָ���-------------------')
display(strcat('Ũ����ӵ����r^2=    ',num2str(IAgof.rsquare)))
disp('Ũ����ӵ���Ϸ���')
display(IAfitresult)
disp('-------------�ָ���-------------------')
display(strcat('Ũ�����ϵ�������r^2=    ',num2str(gof12.rsquare)))
disp('Ũ�����ϵ������Ϸ���');
display(fitresult112);
disp('-------------�ָ���-------------------')
display(strcat('�����ѷ���=    ',num2str(best_r)))
display(strcat('Ũ�����ϵĵ������=    ',num2str(gof_find.rsquare)))
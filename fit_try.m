function [fitresult, gof,R]=fit_try(x,y,cc,iMshow, qu_zhi_fan_wei)

[h , ~, ~, ~]=adtest(y,'distribution','weibull');%�ж��Ƿ����weibll�ֲ�
if h~=0
    disp('���ݲ�����weibll�ֲ�')
end

parmhat=wblfit(x,y);%weibll�ֲ����
%% ����������ߵ�r^2
y1=max(y)*(1-exp(-(x./parmhat(1))).^parmhat(2)); 
R=corrcoef(y,y1);%��������R^2
%��ͼ�л������ߺ�ԭʼ����
plot([0 x],[0 y],'.');
hold on
plot([0 x],[0 y1],'r')
title(strcat('��ϵ�A',num2str(cc),'��weibull�ֲ�'))
hold off
 x5=0:0.1:max(x);
y2=max(y)*(1-exp(-(x5./parmhat(1))).^parmhat(2));
% plot(y1,'.');



%% �����Ӧ����
% syms A
% f=fittype('k*exp(-(log(2))*((A/t).^a))','independent','A','coefficients',{'k','a','t'});
% cfun=fit(x5',y2',f);%'StartPoint', [0.1,30,0]
% xg=0:0.1:1;
% hh=cfun(xg');
[xData, yData] = prepareCurveData( x5, y2 );

% Set up fittype and options.
ft = fittype( 'k*(1-exp(-log(2)*(x/t)^a))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

if nargin==4
    qu_zhi_fan_wei=[-inf inf 0.9;
                    80 100 90;
                    0  16   13]; %ȡֵ��Χ ��� ��� ��ʼ�� ���� a  k p 
end
opts.Lower = qu_zhi_fan_wei(:,1)'; %���� a b c k p t 
opts.StartPoint = qu_zhi_fan_wei(:,3)';%���� a b c k p t 
opts.Upper = qu_zhi_fan_wei(:,2)';%���� ���� a b c k p t 
% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.


h = plot( fitresult, xData, yData );
legend( h, 'y2 vs. x5', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes

title(strcat('��ϵ�A',num2str(cc),'������ͼ'))
xlabel x2
ylabel y2
grid on
display(strcat('��ϵ�A',num2str(cc),'����Ӧ����'))
 disp(fitresult)
disp(gof)
figure
 plot(fitresult)
hold on
plot(x,y,'.');
title(strcat('��ϵ�A',num2str(cc),'������ͼ��ԭʼ����'))
hold off
if iMshow ==1
    close
end
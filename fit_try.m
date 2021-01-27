function [fitresult, gof,R]=fit_try(x,y,cc,iMshow, qu_zhi_fan_wei)

[h , ~, ~, ~]=adtest(y,'distribution','weibull');%判断是否符合weibll分布
if h~=0
    disp('数据不符合weibll分布')
end

parmhat=wblfit(x,y);%weibll分布拟合
%% 计算拟合曲线的r^2
y1=max(y)*(1-exp(-(x./parmhat(1))).^parmhat(2)); 
R=corrcoef(y,y1);%计算曲线R^2
%在图中绘制曲线和原始数据
plot([0 x],[0 y],'.');
hold on
plot([0 x],[0 y1],'r')
title(strcat('拟合第A',num2str(cc),'的weibull分布'))
hold off
 x5=0:0.1:max(x);
y2=max(y)*(1-exp(-(x5./parmhat(1))).^parmhat(2));
% plot(y1,'.');



%% 拟合响应曲线
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
                    0  16   13]; %取值范围 最低 最高 开始点 参数 a  k p 
end
opts.Lower = qu_zhi_fan_wei(:,1)'; %参数 a b c k p t 
opts.StartPoint = qu_zhi_fan_wei(:,3)';%参数 a b c k p t 
opts.Upper = qu_zhi_fan_wei(:,2)';%参数 参数 a b c k p t 
% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.


h = plot( fitresult, xData, yData );
legend( h, 'y2 vs. x5', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes

title(strcat('拟合第A',num2str(cc),'个方程图'))
xlabel x2
ylabel y2
grid on
display(strcat('拟合第A',num2str(cc),'的响应曲线'))
 disp(fitresult)
disp(gof)
figure
 plot(fitresult)
hold on
plot(x,y,'.');
title(strcat('拟合第A',num2str(cc),'个方程图与原始数据'))
hold off
if iMshow ==1
    close
end
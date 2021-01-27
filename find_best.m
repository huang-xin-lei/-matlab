function [fitresult, gof]=find_best(x,y,zz,qu_zhi_fan_wei)
[xData, yData, zData] = prepareSurfaceData( x, y, zz);
if qu_zhi_fan_wei==1
     qu_zhi_fan_wei=[];
end
%qu_zhi_fan_wei 取值范围 最低 最高 开始点 参数 a b c k p t 
ft = fittype( 'k*((1+x*b1)/(1+x*c1))*((1+y*b2)/(1+y*c2))*[1-exp(-log(2)*((p*x*((1+y*b3)/(1+y*c3))+y*((1+x*b4)/(1+x*c4)))/(t*((1+x*b5)/(1+x*c5))*((1+y*b6)/(1+y*c6))))^a)]',...
  'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = qu_zhi_fan_wei(:,1)'; %参数a,b1,b2,b3,b4,b5,b6,c1,c2,c3,c4,c5,c6,k,p,t
opts.StartPoint = qu_zhi_fan_wei(:,3)';%参数a,b1,b2,b3,b4,b5,b6,c1,c2,c3,c4,c5,c6,k,p,t
opts.Upper = qu_zhi_fan_wei(:,2)';%参数a,b1,b2,b3,b4,b5,b6,c1,c2,c3,c4,c5,c6,k,p,t
% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );
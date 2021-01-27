function [fitresult, gof]=CAfit(x, y, z1,IMSHOW )

%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( x, y, z1 );
hh=[0 0 0];
% Set up fittype and options.

ft = fittype( 'k*((1+b2*x)/(1+c2*x))*((1+b1*y)/(1+c1*y))*exp(-log(2)*((p*x*((1+b2*x)/(1+c2*x))+y*((1+b1*y)/(1+c1*y)))/(t)*((1+b2*x)/(1+c2*x))*((1+b1*y)/(1+c1*y)))^a)', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [ -Inf -2 -2 -2 -2 100 0 0];%A1,A2,a,b1,b2,c1,c2,k,p,t
opts.StartPoint = [ 0.6 0.75 0.7 0.39 0.65 0.17 0.70 0.031];%A1,A2,a,b1,b2,c1,c2,k,p,t
opts.Upper = [Inf 2 1 3 1 115 1 Inf];%A1,A2,a,b1,b2,c1,c2,k,p,t
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );
% Plot fit with data.
if IMSHOW~=1
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, [xData, yData], zData );
    legend( h, 'untitled fit 1', 'z1 vs. x, y', 'Location', 'NorthEast' );
    % Label axes
    xlabel x
    ylabel y
    zlabel z1
    grid on
    view( -42.7, 3.6 );
end
cc=gof.rsquare; %获取r^2

close all

display(strcat('拟合的联合作用第A',num2str(cc),'的响应曲线'))
 disp(fitresult)
disp(gof)

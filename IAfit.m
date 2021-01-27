function [fitresult, gof]=IAfit(x, y, zz,cc,IMshow,qu_zhi_fan_wei)
%CREATEFIT(X,Y,ZZ)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Input : y
%      Z Output: zz
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  ������� FIT, CFIT, SFIT.

%  �� MATLAB �� 07-Mar-2019 11:00:52 �Զ�����


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( x, y, zz);

% Set up fittype and options.
ft = fittype( 'k*(1-exp(-log(2)*((p*x+y)/t)^a))', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
if nargin==5
    qu_zhi_fan_wei=[-inf inf 0.9;
                    80   100   90;
                     0   5   0.1; 
                      0  1    0.1]; %ȡֵ��Χ ��� ��� ��ʼ�� ���� a k p t 
end
opts.Lower = qu_zhi_fan_wei(:,1)'; %���� a  k p t 
opts.StartPoint = qu_zhi_fan_wei(:,3)';%���� a k p t 
opts.Upper = qu_zhi_fan_wei(:,2)';%���� ���� a k p t 
% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );
if IMshow~=1
% Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, [xData, yData], zData );
    legend( h, 'untitled fit 1', 'zz vs. x, y', 'Location', 'NorthEast' );
    % Label axes
    xlabel x
    ylabel y
    zlabel zz
    grid on
end
display(strcat('��ϵ�Ũ����ӵ�A',num2str(cc),'����Ӧ����'))
 disp(fitresult)
disp(gof)



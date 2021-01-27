%% 2019/5/10 等高线图生成
%% 完整功能 原始版本，调试版
%% 寻找等高线上最先满足要求的点，并记录出曲线
    clc
    clear
    close all 
     ddd=input('是否按默认值进行——1.自定义 2.默认参数= '); %默认值为 1
    if ddd==1
        ccc=input('请输入Y轴范围——= '); %默认值为 1
        bbb=input('请输入X轴范围——= ');  %默认值为 2
        aaaa=input('请输入需要寻找的界限值——10~max(方程)= '); %% 需要寻找的界限值上的最优点 默认为 90
        jjj=input('是否展示极值点的位置——1展示 2 不显示=');
    else
        aaaa=90; %
        ccc=1; %默认值为 [0 1]
        bbb=1; %默认值为 [0 1]
        jjj=1; %默认展示
    end
% ccc=1; %
% 生成曲线图
%     load(IAfitresult.mat)
%     HF=@(A1,A2) 95.73*(1-exp(-log(2)*(((0.5183*A1+A2)*(1+2.216*A1))/(0.4171))^(1.069/(1+0.0984*A1))))
load('fitresult112.mat')
cc_num=fitresult112;
a_1=coeffvalues(cc_num);
a=a_1(1);
b=a_1(2);
c=a_1(3);
k=a_1(4);
p=a_1(5);
t=a_1(6);
HF=@(x,y)k*[1-exp(-log(2)*((p*x+y)/t*((1+x*b)/(1+x*c)))^a)];
    h=fcontour(HF,[0 bbb 0 ccc],'Fill','off');
    h.LineWidth = 1;
    h.LineStyle = '-';
    h.LevelList = aaaa ; %标记的边界线
    cc=h.ContourMatrix;
    colorbar
    hold on
% 寻找曲线上的和最小的点
    x_1=cc(1,find(cc(1,:)~=0));
    y_1=cc(2,find(cc(1,:)~=0));
    xy=x_1+y_1;
    jj=find(xy==min(xy(2:end)));
    x_min=x_1(jj);
    y_min=y_1(jj);
    colorbar('Ticks',[-5,-2,1,4,7],'TickLabels',{'Cold','Cool','Neutral','Warm','Hot'})
    hold on
%% 标记出点的位置
    plot(x_1(2:end),y_1(2:end),'o');
%% 保存点的坐标与曲线的坐标
    save  linx x_1 y_1 
    save max_xy x_min y_min aaaa bbb ccc jjj HF
    hold off

%% 重新生成等高线图 
    clc
    clear
    close all
% 数据载入
    load max_xy.mat
    load linx.mat
% 等高线图生成
% HF=@(A1,A2) 95.73*(1-exp(-log(2)*(((0.5183*A1+A2)*(1+2.216*A1))/(0.4171))^(1.069/(1+0.0984*A1))))
    figure('Tag','Print CFTOOL to Figure',...
        'Colormap',[0.929411764705882 0.141176470588235 0.149019607843137;0.893765617681719 0.141436340527268 0.174654519028774;0.858321709664156 0.14219894067563 0.199969845480876;0.823082021231061 0.143438756530217 0.224957042153093;0.7880485329603 0.145130273587922 0.249607563999074;0.75322322542974 0.147247977345641 0.273912865972467;0.718608079217246 0.149766353300269 0.297864403026921;0.684205074900687 0.152659886948702 0.321453630116085;0.650016193057928 0.155903063787833 0.344672002193608;0.616043414266836 0.159470369314558 0.367510974213139;0.582288719105278 0.163336289025771 0.389962001128326;0.548754088151119 0.167475308418369 0.412016537892818;0.515441501982228 0.171861912989245 0.433666039460265;0.482352941176471 0.176470588235294 0.454901960784314;0.447320553226747 0.182882373814046 0.475673410744107;0.408894041651553 0.192464015073651 0.495968299266413;0.36815172106715 0.20486855604694 0.515836282876323;0.3261719060898 0.219749040766741 0.535327018098928;0.284032911335764 0.236758513265885 0.55449016145932;0.242813051421303 0.255550017577201 0.57337536948259;0.203590640962678 0.275776597733518 0.592032298693829;0.167443994576151 0.297091297767666 0.610510605618129;0.135451426877982 0.319147161712474 0.62885994678058;0.108691252484433 0.341597233600772 0.647129978706274;0.0882417860117654 0.36409455746539 0.665370357920302;0.0751813420762397 0.386292177339157 0.683630740947755;0.0705882352941176 0.407843137254902 0.701960784313725;0.0730457936740441 0.431511800928367 0.721519643322979;0.080055638799646 0.459565471755541 0.7430259286684;0.0910735256496573 0.490911603289629 0.765868479957254;0.105555209202812 0.524457649083836 0.78943613679681;0.122956444437843 0.559111062691364 0.813117738794332;0.142732986333485 0.593779297665419 0.836302125557088;0.164340589868472 0.627369807559205 0.858378136692345;0.187235010021537 0.658790045925925 0.87873461180737;0.210872001771415 0.686947466318783 0.896760390509428;0.234707320096839 0.710749522290984 0.911844312405786;0.258196719976543 0.729103667395733 0.923375217103713;0.28079595638926 0.740917355186232 0.930741944210473;0.301960784313725 0.745098039215686 0.933333333333333;0.322503220932295 0.745098039215686 0.923587018142822;0.34358970933387 0.745098039215686 0.896227775964063;0.365207643357001 0.745098039215686 0.854075161886222;0.387344416840237 0.745098039215686 0.799948730998464;0.409987423622129 0.745098039215686 0.736668038389952;0.433124057541227 0.745098039215686 0.667052639149852;0.456741712436082 0.745098039215686 0.593922088367329;0.480827782145243 0.745098039215686 0.520095941131547;0.505369660507261 0.745098039215686 0.448393752531669;0.530354741360685 0.745098039215686 0.381635077656863;0.555770418544067 0.745098039215686 0.32263947159629;0.581604085895956 0.745098039215686 0.274226489439118;0.607843137254902 0.745098039215686 0.23921568627451;0.634596597354862 0.74540326827135 0.211930212659109;0.661972188035458 0.746286826064062 0.185015351826023;0.68995534879374 0.747700518532402 0.158773857879118;0.718531519126755 0.749596151614947 0.133508484922256;0.747686138531553 0.751925531250279 0.109521987059302;0.777404646505183 0.754640463376976 0.0871171183941192;0.807672482544694 0.757692753933617 0.0665966330305718;0.838475086147135 0.761034208858782 0.0482632850725233;0.869797896809555 0.764616634091051 0.0324198286238375;0.901626354029002 0.768391835569002 0.0193690177883786;0.933945897302526 0.772311619231216 0.00941360667001012;0.966741966127176 0.77632779101627 0.00285634937259593;1 0.780392156862745 0],...
        'Color',[0.941176470588235 0.941176470588235 0.941176470588235]);
    fcontour(HF,[0 bbb 0 ccc],'Fill','on','LevelList',[10 20 30 40 50 60 70 80 90 100 ]) %原始
    %fcontour(HF,[0 1 0 1],'Fill','on','LevelList',[5:1:105]) %测试
    colorbar 
    hold on
%绘制最小点图
    plot(x_1(2:end),y_1(2:end),'Color',[0 0 0],'LineWidth',1.5); 
% 和最小点标记
    if jjj==1 
        plot(x_min,y_min,'.','MarkerSize',25,'MarkerEdgeColor','r'); %生成最大最小的点
    end
    jjj=[];
      hold off
 %plot(HF)
 %% 绘制方程的原始3维图
    figure('Tag','Print CFTOOL to Figure',...
        'Colormap',[0.929411764705882 0.141176470588235 0.149019607843137;0.893765617681719 0.141436340527268 0.174654519028774;0.858321709664156 0.14219894067563 0.199969845480876;0.823082021231061 0.143438756530217 0.224957042153093;0.7880485329603 0.145130273587922 0.249607563999074;0.75322322542974 0.147247977345641 0.273912865972467;0.718608079217246 0.149766353300269 0.297864403026921;0.684205074900687 0.152659886948702 0.321453630116085;0.650016193057928 0.155903063787833 0.344672002193608;0.616043414266836 0.159470369314558 0.367510974213139;0.582288719105278 0.163336289025771 0.389962001128326;0.548754088151119 0.167475308418369 0.412016537892818;0.515441501982228 0.171861912989245 0.433666039460265;0.482352941176471 0.176470588235294 0.454901960784314;0.447320553226747 0.182882373814046 0.475673410744107;0.408894041651553 0.192464015073651 0.495968299266413;0.36815172106715 0.20486855604694 0.515836282876323;0.3261719060898 0.219749040766741 0.535327018098928;0.284032911335764 0.236758513265885 0.55449016145932;0.242813051421303 0.255550017577201 0.57337536948259;0.203590640962678 0.275776597733518 0.592032298693829;0.167443994576151 0.297091297767666 0.610510605618129;0.135451426877982 0.319147161712474 0.62885994678058;0.108691252484433 0.341597233600772 0.647129978706274;0.0882417860117654 0.36409455746539 0.665370357920302;0.0751813420762397 0.386292177339157 0.683630740947755;0.0705882352941176 0.407843137254902 0.701960784313725;0.0730457936740441 0.431511800928367 0.721519643322979;0.080055638799646 0.459565471755541 0.7430259286684;0.0910735256496573 0.490911603289629 0.765868479957254;0.105555209202812 0.524457649083836 0.78943613679681;0.122956444437843 0.559111062691364 0.813117738794332;0.142732986333485 0.593779297665419 0.836302125557088;0.164340589868472 0.627369807559205 0.858378136692345;0.187235010021537 0.658790045925925 0.87873461180737;0.210872001771415 0.686947466318783 0.896760390509428;0.234707320096839 0.710749522290984 0.911844312405786;0.258196719976543 0.729103667395733 0.923375217103713;0.28079595638926 0.740917355186232 0.930741944210473;0.301960784313725 0.745098039215686 0.933333333333333;0.322503220932295 0.745098039215686 0.923587018142822;0.34358970933387 0.745098039215686 0.896227775964063;0.365207643357001 0.745098039215686 0.854075161886222;0.387344416840237 0.745098039215686 0.799948730998464;0.409987423622129 0.745098039215686 0.736668038389952;0.433124057541227 0.745098039215686 0.667052639149852;0.456741712436082 0.745098039215686 0.593922088367329;0.480827782145243 0.745098039215686 0.520095941131547;0.505369660507261 0.745098039215686 0.448393752531669;0.530354741360685 0.745098039215686 0.381635077656863;0.555770418544067 0.745098039215686 0.32263947159629;0.581604085895956 0.745098039215686 0.274226489439118;0.607843137254902 0.745098039215686 0.23921568627451;0.634596597354862 0.74540326827135 0.211930212659109;0.661972188035458 0.746286826064062 0.185015351826023;0.68995534879374 0.747700518532402 0.158773857879118;0.718531519126755 0.749596151614947 0.133508484922256;0.747686138531553 0.751925531250279 0.109521987059302;0.777404646505183 0.754640463376976 0.0871171183941192;0.807672482544694 0.757692753933617 0.0665966330305718;0.838475086147135 0.761034208858782 0.0482632850725233;0.869797896809555 0.764616634091051 0.0324198286238375;0.901626354029002 0.768391835569002 0.0193690177883786;0.933945897302526 0.772311619231216 0.00941360667001012;0.966741966127176 0.77632779101627 0.00285634937259593;1 0.780392156862745 0],...
        'Color',[0.941176470588235 0.941176470588235 0.941176470588235]); %颜色变化
    fsurf(HF,[0 1 0 1])
    colorbar('Ticks',[-5,-2,1,4,7],'TickLabels',{'Cold','Cool','Neutral','Warm','Hot'})
%%
%%
%% 其他功能 寻找最佳点
% clc
% clear
% close all
% HF=@(A1,A2) 95.73*(1-exp(-log(2)*(((0.5183*A1+A2)*(1+2.216*A1))/(0.4171))^(1.069/(1+0.0984*A1))))
% h=fcontour(HF,[0 1],'Fill','off');
% h.LineWidth = 1;
% h.LineStyle = '-';
% h.LevelList = [90 ];
% colorbar
% hold on
% cc=h.ContourMatrix;
% x_1=cc(1,:);
% y_1=cc(2,:);
% xy=x_1+y_1;
% jj=find(xy==min(xy(2:end)));
% x=x_1(jj);
% y=y_1(jj);
% colorbar('Ticks',[-5,-2,1,4,7],'TickLabels',{'Cold','Cool','Neutral','Warm','Hot'})
% hold on
% x=0:1;
% y=x;
% plot(x_1(2:end),y_1(2:end),'o');
%  plot(x,y,'o');
%  save  linx x_1 y_1
%  save max_xy x y 
%  hold off
% %% 2019/5/10 等高线图生成 1.1版本
% %% 完整功能 
% %% 寻找等高线上最先满足要求的点，并记录出曲线
%     clc
%     clear
%     close all 
%     HF=@(A1,A2) 95.73*(1-exp(-log(2)*(((0.5183*A1+A2)*(1+2.216*A1))/(0.4171))^(1.069/(1+0.0984*A1)))); %%输入方程
%     ddd=input('是否按默认值进行——1.自定义 2.默认参数= '); %默认值为 1
%         if ddd==1
%             ccc=input('请输入Y轴范围——= '); %默认值为 1
%             bbb=input('请输入X轴范围——= ');  %默认值为 2
%             aaaa=input('请输入需要寻找的界限值——10~max(方程)= '); %% 需要寻找的界限值上的最优点 默认为 90
%             jjj=input('是否展示极值点的位置——1展示 2 不显示=');
%             fff=input('是否展示方程3维图——1展示 2 不显示=');
%         else
%             aaaa=90; %
%             ccc=1; %默认值为 [0 1]
%             bbb=1; %默认值为 [0 1]
%             jjj=1; %默认展示
%             fff=1; %默认展示
%         end
% %% 生成曲线图
%     h=fcontour(HF,[0 bbb 0 ccc],'Fill','off');
%     h.LineWidth = 1;
%     h.LineStyle = '-';
%     h.LevelList = aaaa ; %标记的边界线
%     cc=h.ContourMatrix;
%     colorbar
%     hold on
% %% 寻找曲线上的和最小的点
%     x_1=cc(1,cc(1,:)~=0);
%     y_1=cc(2,cc(1,:)~=0);
%     xy=x_1+y_1;
%     jj=find(xy==min(xy(2:end)));
%     x_min=x_1(jj);
%     y_min=y_1(jj);
%     colorbar('Ticks',[-5,-2,1,4,7],'TickLabels',{'Cold','Cool','Neutral','Warm','Hot'})
%     hold on
% %% 标记出点的位置
%     plot(x_1(2:end),y_1(2:end),'o');
% %% 保存点的坐标与曲线的坐标、方程、相关参数设定
%     save  linx x_1 y_1 
%     save max_xy x_min y_min aaaa bbb ccc jjj fff HF
%     hold off
% %% 重新生成等高线图 
%     clc
%     clear
%     close all
%     load max_xy.mat ; load linx.mat     %%数据载入
%     figure('Tag','Print CFTOOL to Figure',...
%         'Colormap',[0.929411764705882 0.141176470588235 0.149019607843137;0.893765617681719 0.141436340527268 0.174654519028774;0.858321709664156 0.14219894067563 0.199969845480876;0.823082021231061 0.143438756530217 0.224957042153093;0.7880485329603 0.145130273587922 0.249607563999074;0.75322322542974 0.147247977345641 0.273912865972467;0.718608079217246 0.149766353300269 0.297864403026921;0.684205074900687 0.152659886948702 0.321453630116085;0.650016193057928 0.155903063787833 0.344672002193608;0.616043414266836 0.159470369314558 0.367510974213139;0.582288719105278 0.163336289025771 0.389962001128326;0.548754088151119 0.167475308418369 0.412016537892818;0.515441501982228 0.171861912989245 0.433666039460265;0.482352941176471 0.176470588235294 0.454901960784314;0.447320553226747 0.182882373814046 0.475673410744107;0.408894041651553 0.192464015073651 0.495968299266413;0.36815172106715 0.20486855604694 0.515836282876323;0.3261719060898 0.219749040766741 0.535327018098928;0.284032911335764 0.236758513265885 0.55449016145932;0.242813051421303 0.255550017577201 0.57337536948259;0.203590640962678 0.275776597733518 0.592032298693829;0.167443994576151 0.297091297767666 0.610510605618129;0.135451426877982 0.319147161712474 0.62885994678058;0.108691252484433 0.341597233600772 0.647129978706274;0.0882417860117654 0.36409455746539 0.665370357920302;0.0751813420762397 0.386292177339157 0.683630740947755;0.0705882352941176 0.407843137254902 0.701960784313725;0.0730457936740441 0.431511800928367 0.721519643322979;0.080055638799646 0.459565471755541 0.7430259286684;0.0910735256496573 0.490911603289629 0.765868479957254;0.105555209202812 0.524457649083836 0.78943613679681;0.122956444437843 0.559111062691364 0.813117738794332;0.142732986333485 0.593779297665419 0.836302125557088;0.164340589868472 0.627369807559205 0.858378136692345;0.187235010021537 0.658790045925925 0.87873461180737;0.210872001771415 0.686947466318783 0.896760390509428;0.234707320096839 0.710749522290984 0.911844312405786;0.258196719976543 0.729103667395733 0.923375217103713;0.28079595638926 0.740917355186232 0.930741944210473;0.301960784313725 0.745098039215686 0.933333333333333;0.322503220932295 0.745098039215686 0.923587018142822;0.34358970933387 0.745098039215686 0.896227775964063;0.365207643357001 0.745098039215686 0.854075161886222;0.387344416840237 0.745098039215686 0.799948730998464;0.409987423622129 0.745098039215686 0.736668038389952;0.433124057541227 0.745098039215686 0.667052639149852;0.456741712436082 0.745098039215686 0.593922088367329;0.480827782145243 0.745098039215686 0.520095941131547;0.505369660507261 0.745098039215686 0.448393752531669;0.530354741360685 0.745098039215686 0.381635077656863;0.555770418544067 0.745098039215686 0.32263947159629;0.581604085895956 0.745098039215686 0.274226489439118;0.607843137254902 0.745098039215686 0.23921568627451;0.634596597354862 0.74540326827135 0.211930212659109;0.661972188035458 0.746286826064062 0.185015351826023;0.68995534879374 0.747700518532402 0.158773857879118;0.718531519126755 0.749596151614947 0.133508484922256;0.747686138531553 0.751925531250279 0.109521987059302;0.777404646505183 0.754640463376976 0.0871171183941192;0.807672482544694 0.757692753933617 0.0665966330305718;0.838475086147135 0.761034208858782 0.0482632850725233;0.869797896809555 0.764616634091051 0.0324198286238375;0.901626354029002 0.768391835569002 0.0193690177883786;0.933945897302526 0.772311619231216 0.00941360667001012;0.966741966127176 0.77632779101627 0.00285634937259593;1 0.780392156862745 0],...
%         'Color',[0.941176470588235 0.941176470588235 0.941176470588235]);% 等高线图生成
%     fcontour(HF,[0 bbb 0 ccc],'Fill','on','LevelList',[10 20 30 40 50 60 70 80 90 100 ]) %原始
%     colorbar 
%     hold on
%     plot(x_1(2:end),y_1(2:end),'Color',[0 0 0],'LineWidth',1.5); %绘制最小点图
%     if jjj==1 
%         plot(x_min,y_min,'.','MarkerSize',25,'MarkerEdgeColor','r'); %生成最大最小的点% 和最小点标记
%     end
%     jjj=[];
%       hold off
%  %% 绘制方程的原始3维图
%  if fff==1
%     figure('Tag','Print CFTOOL to Figure',...
%         'Colormap',[0.929411764705882 0.141176470588235 0.149019607843137;0.893765617681719 0.141436340527268 0.174654519028774;0.858321709664156 0.14219894067563 0.199969845480876;0.823082021231061 0.143438756530217 0.224957042153093;0.7880485329603 0.145130273587922 0.249607563999074;0.75322322542974 0.147247977345641 0.273912865972467;0.718608079217246 0.149766353300269 0.297864403026921;0.684205074900687 0.152659886948702 0.321453630116085;0.650016193057928 0.155903063787833 0.344672002193608;0.616043414266836 0.159470369314558 0.367510974213139;0.582288719105278 0.163336289025771 0.389962001128326;0.548754088151119 0.167475308418369 0.412016537892818;0.515441501982228 0.171861912989245 0.433666039460265;0.482352941176471 0.176470588235294 0.454901960784314;0.447320553226747 0.182882373814046 0.475673410744107;0.408894041651553 0.192464015073651 0.495968299266413;0.36815172106715 0.20486855604694 0.515836282876323;0.3261719060898 0.219749040766741 0.535327018098928;0.284032911335764 0.236758513265885 0.55449016145932;0.242813051421303 0.255550017577201 0.57337536948259;0.203590640962678 0.275776597733518 0.592032298693829;0.167443994576151 0.297091297767666 0.610510605618129;0.135451426877982 0.319147161712474 0.62885994678058;0.108691252484433 0.341597233600772 0.647129978706274;0.0882417860117654 0.36409455746539 0.665370357920302;0.0751813420762397 0.386292177339157 0.683630740947755;0.0705882352941176 0.407843137254902 0.701960784313725;0.0730457936740441 0.431511800928367 0.721519643322979;0.080055638799646 0.459565471755541 0.7430259286684;0.0910735256496573 0.490911603289629 0.765868479957254;0.105555209202812 0.524457649083836 0.78943613679681;0.122956444437843 0.559111062691364 0.813117738794332;0.142732986333485 0.593779297665419 0.836302125557088;0.164340589868472 0.627369807559205 0.858378136692345;0.187235010021537 0.658790045925925 0.87873461180737;0.210872001771415 0.686947466318783 0.896760390509428;0.234707320096839 0.710749522290984 0.911844312405786;0.258196719976543 0.729103667395733 0.923375217103713;0.28079595638926 0.740917355186232 0.930741944210473;0.301960784313725 0.745098039215686 0.933333333333333;0.322503220932295 0.745098039215686 0.923587018142822;0.34358970933387 0.745098039215686 0.896227775964063;0.365207643357001 0.745098039215686 0.854075161886222;0.387344416840237 0.745098039215686 0.799948730998464;0.409987423622129 0.745098039215686 0.736668038389952;0.433124057541227 0.745098039215686 0.667052639149852;0.456741712436082 0.745098039215686 0.593922088367329;0.480827782145243 0.745098039215686 0.520095941131547;0.505369660507261 0.745098039215686 0.448393752531669;0.530354741360685 0.745098039215686 0.381635077656863;0.555770418544067 0.745098039215686 0.32263947159629;0.581604085895956 0.745098039215686 0.274226489439118;0.607843137254902 0.745098039215686 0.23921568627451;0.634596597354862 0.74540326827135 0.211930212659109;0.661972188035458 0.746286826064062 0.185015351826023;0.68995534879374 0.747700518532402 0.158773857879118;0.718531519126755 0.749596151614947 0.133508484922256;0.747686138531553 0.751925531250279 0.109521987059302;0.777404646505183 0.754640463376976 0.0871171183941192;0.807672482544694 0.757692753933617 0.0665966330305718;0.838475086147135 0.761034208858782 0.0482632850725233;0.869797896809555 0.764616634091051 0.0324198286238375;0.901626354029002 0.768391835569002 0.0193690177883786;0.933945897302526 0.772311619231216 0.00941360667001012;0.966741966127176 0.77632779101627 0.00285634937259593;1 0.780392156862745 0],...
%         'Color',[0.941176470588235 0.941176470588235 0.941176470588235]); %颜色变化
%     fsurf(HF,[0 1 0 1])
%     colorbar('Ticks',[-5,-2,1,4,7],'TickLabels',{'Cold','Cool','Neutral','Warm','Hot'})
%  end
% %% 结果展示
% clc
% disp('---------------------------------------------------------------------------------------------------------')
%     disp('结果展示')
% disp('---------------------------------------------------------------------------------------------------------')
%     disp('绘制的方程')
%     disp(HF)
% disp('---------------------------------------------------------------------------------------------------------')
%     disp(strcat('满足在最先达到(—',num2str(aaaa),'-)上最优的组合为','....y =',num2str(y_min),'....','x = ',num2str(x_min),'......','(',num2str(x_min),',',num2str(y_min),')'))
% disp('---------------------------------------------------------------------------------------------------------')
%     jiguo=HF(x_min,y_min);
%     disp(strcat('最小值带入方程的计算结果=',num2str(jiguo)))
% disp('---------------------------------------------------------------------------------------------------------')
% %% 完成日期 2019/5/10/17：52  黄鑫磊





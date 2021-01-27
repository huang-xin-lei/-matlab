function a_num=fun_num(file_name)
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
z=xyz;
a_num.min=min(min(z));
a_num.max=max(max(z));
a_num.star=mean(mean(z));

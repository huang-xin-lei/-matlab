function a_num=fun_num(file_name)
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
z=xyz;
a_num.min=min(min(z));
a_num.max=max(max(z));
a_num.star=mean(mean(z));

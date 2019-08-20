function materials = problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
% d(i,j)��ʾRGV��CNC(i)��CNC(j)����Ҫ���˶�ʱ��(��)
% load_time(i)��ʾRGVΪCNC(i)���һ������������Ҫ��ʱ��
% clean_time��ʾ���һ�����ϵ���ϴ��ҵʱ��
% process_time��ʾ�ӹ�һ����������Ҫ��ʱ��
% work_hours��ʾϵͳ��������ʱ��

% d(i,j)��ʾRGV��CNC(i)��CNC(j)����Ҫ���˶�ʱ��(��)
% d =[0 0 23 23 41 41 59 59;
%     0 0 23 23 41 41 59 59 ;
%     23 23 0 0 23 23 41 41 ;
%     23 23 0 0 23 23 41 41 ;
%     41 41 23 23 0 0 23 23 ;
%     41 41 23 23 0 0 23 23 ;
%     59 59 41 41 23 23 0 0 ;
%     59 59 41 41 23 23 0 0 ;
%     ];

% load_time(i)��ʾRGVΪCNC(i)���һ������������Ҫ��ʱ��
% load_time =[27 32 27 32 27 32 27 32];
% n��ʾCNC��̨��
n = length(load_time);

% ���һ�����ϵ���ϴ��ҵʱ��
% clean_time = 30;

% ϵͳ���ܹ���ʱ��
% work_hours = 8;

% �ӹ���һ����������Ҫ��ʱ��
% process1_time = 455;
% �ӹ��ڶ�����������Ҫ��ʱ��
% process2_time = 182;
% �ӹ���һ�������CNC����
% cnc_set1 = [1,3,5,7];
% �ӹ��ڶ��������CNC����
cnc_set2 = setdiff(1:n, cnc_set1);

n1 = length(cnc_set1);
n2 = n-n1;

% material_list1��ʾ�����У���1���������
% ��1�б�ʾ���ϵı��
% ��2�б�ʾ�����ϵ�1�������CNC���
% ��3�б�ʾ�����ڵ�1����������Ͽ�ʼʱ��
% ��4�б�ʾ�����ڵ�1����������Ͻ���ʱ��
% ��5�б�ʾ�����ڵ�1����������Ͽ�ʼʱ��
% ��6�б�ʾ�����ڵ�1����������Ͻ���ʱ��
% ��7�б�ʾ�����ڵ�1������ļӹ�����ʱ��
material_list1 = [];

% material_list2��ʾ�����б���2���������
% ��1�б�ʾ���ϵı��
% ��2�б�ʾ�����ϵ�2�������CNC���
% ��3�б�ʾ�����ڵ�2����������Ͽ�ʼʱ��
% ��4�б�ʾ�����ڵ�2����������Ͻ���ʱ��
% ��5�б�ʾ�����ڵ�2����������Ͽ�ʼʱ��
% ��6�б�ʾ�����ڵ�2����������Ͻ���ʱ��
% ��7�б�ʾ�����ڵ�2������ļӹ�����ʱ��
material_list2 = [];
finished_list1 = [];
finished_list2 = [];

material_number = 0; %���ϱ��

%%
% RGV����ʼλ��
rgv_location = 1;
% ʱ��ĳ�ʼֵ
t = 0;

%% ������cnc_set1����   (��ʼ��)
wait_cnc_set1 = cnc_set1;
while ~isempty(wait_cnc_set1)
    m = length(wait_cnc_set1);
    wait_time_cnc_set1 = zeros(1,m);
    for i = 1:m
        wait_time_cnc_set1(i) = d(rgv_location,wait_cnc_set1(i)) + load_time(wait_cnc_set1(i));
    end
    [min_wait_time,kk] = min(wait_cnc_set1);
    t = t + d(rgv_location,wait_cnc_set1(kk)); %���Ͽ�ʼʱ��
    
    rgv_location = wait_cnc_set1(kk);
    material_number = material_number + 1;
    material_list1 = [material_list1;
        [rgv_location, 1, material_number, t, t+load_time(rgv_location),inf,inf,t+load_time(rgv_location)+process1_time]];
    t = t + load_time(rgv_location); %�������ʱ��
    wait_cnc_set1(kk) = [];
end

%% �ȴ���1�����Ʒ
t1 = min(material_list1(:,8));  %��1�����Ʒ�����ʱ��
if t < t1
    t = t1;
end
%% ��ʼ��material_list2
material_list2 = [cnc_set2', zeros(n2,7)];

%% �����Ʒ�����2������CNC
while t<3600*work_hours
    wait_cnc_set1 = material_list1(material_list1(:,8)<=t,1);
    m1 = length(wait_cnc_set1);
    if m1==0
        t1 = min(material_list1(material_list1(:,8)>0,8));
        if t<t1;
            t=t1;
            wait_cnc_set1 = material_list1(material_list1(:,8)<=t,1);
            m1 = length(wait_cnc_set1);
        end
    end
    
    wait_cnc_set2 = union(material_list2(material_list2(:,2)==0,1),material_list2(material_list2(:,8)<=t,1));
    m2 = length(wait_cnc_set2);
    if m2==0
        t1 = min(material_list2(material_list2(:,8)>0,8));
        if t<t1;
            t=t1;
            wait_cnc_set2 = union(material_list2(material_list2(:,2)==0,1),material_list2(material_list2(:,8)<=t,1));
            m2 = length(wait_cnc_set2);
        end
    end
    wait_time = inf*ones(m1,m2);
    for i = 1:m1
        for j = i:m2
            wait_time(i,j) = d(wait_cnc_set1(i),rgv_location) + ...
                load_time(wait_cnc_set1(i)) + d(wait_cnc_set1(i),wait_cnc_set2(j)) + ...
                load_time(wait_cnc_set2(j));
        end
    end

    [r1,c1] = findminlocation(wait_time);
    r2 = wait_cnc_set1(r1);
    c2 = wait_cnc_set2(c1);

    %% �ѱ��Ϊr2��CNC�ϵİ��Ʒ���˵����Ϊc2��CNC��
    % ��material_list1�в��ұ��Ϊr2�ļ�¼λ�ã�����r3
    r3 = find(material_list1(:,1)==r2);
    % ��material_list2�в��ұ��Ϊc2�ļ�¼λ�ã�����c3
    c3 = find(material_list2(:,1)==c2);

    t = t+d(rgv_location,r2); %��1���˶�ʱ��
    material_list1(r3,6) = t; %��1�������Ͽ�ʼʱ��
    t = t+load_time(r2);
    material_list1(r3,7) = t; %��1�������Ͻ���ʱ��
    finished_list1 = [finished_list1;
        material_list1(r3,[3,1,4:8])];

    t = t + d(r2,c2);         %��2���˶�ʱ��
    if material_list2(c3,2)==0  %c3��CNC���ڳ�ʼ״̬
        material_list2(c3,2) = 1;
        material_list2(c3,3) = material_list1(r3,3);  
        material_list2(c3,4) = t;
        t = t + load_time(c2);
        material_list2(c3,5) = t;
        material_list2(c3,[6,7]) = [inf,inf];
        material_list2(c3,8) = t+process2_time;
    else
        material_list2(c3,[6,7]) = [t,t+load_time(c2)];
        t = t+load_time(c2); %��2�������Ͻ���ʱ��

        finished_list2 = [finished_list2;
            material_list2(c3,[3,1,4:8])];
        
        material_list2(c3,3) = material_list1(r3,3);
        material_list2(c3,[4,5]) = material_list2(c3,[6,7]);
        material_list2(c3,[6,7]) = [inf,inf];
        material_list2(c3,8) = t+process2_time;
        t = t + clean_time;  %��ϴʱ��
    end
    rgv_location = c2;
    material_number = material_number + 1;
    material_list1(r3,[3,4,5]) = [material_number,material_list1(r3,[6,7])];
    material_list1(r3,[6,7,8]) = [inf,inf,material_list1(r3,5)+process1_time];
end

finished_list2 = sortrows(finished_list2,1)
finished_list1 = sortrows(finished_list1,1)
finished_numbers = size(finished_list2,1);
finished_list = [finished_list1(1:finished_numbers,:),finished_list2(:,2:7)];
csvwrite('Case2_result.csv',finished_list)

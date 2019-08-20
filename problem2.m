function materials = problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
% d(i,j)表示RGV从CNC(i)至CNC(j)所需要的运动时间(秒)
% load_time(i)表示RGV为CNC(i)完成一次上下料所需要的时间
% clean_time表示完成一个物料的清洗作业时间
% process_time表示加工一道工序所需要的时间
% work_hours表示系统工作的总时间

% d(i,j)表示RGV从CNC(i)至CNC(j)所需要的运动时间(秒)
% d =[0 0 23 23 41 41 59 59;
%     0 0 23 23 41 41 59 59 ;
%     23 23 0 0 23 23 41 41 ;
%     23 23 0 0 23 23 41 41 ;
%     41 41 23 23 0 0 23 23 ;
%     41 41 23 23 0 0 23 23 ;
%     59 59 41 41 23 23 0 0 ;
%     59 59 41 41 23 23 0 0 ;
%     ];

% load_time(i)表示RGV为CNC(i)完成一次上下料所需要的时间
% load_time =[27 32 27 32 27 32 27 32];
% n表示CNC的台数
n = length(load_time);

% 完成一个物料的清洗作业时间
% clean_time = 30;

% 系统的总工作时间
% work_hours = 8;

% 加工第一道工序所需要的时间
% process1_time = 455;
% 加工第二道工序所需要的时间
% process2_time = 182;
% 加工第一道工序的CNC集合
% cnc_set1 = [1,3,5,7];
% 加工第二道工序的CNC集合
cnc_set2 = setdiff(1:n, cnc_set1);

n1 = length(cnc_set1);
n2 = n-n1;

% material_list1表示物料列，第1道工序情况
% 第1列表示物料的编号
% 第2列表示物料上第1道工序的CNC编号
% 第3列表示物料在第1道工序的上料开始时间
% 第4列表示物料在第1道工序的上料结束时间
% 第5列表示物料在第1道工序的下料开始时间
% 第6列表示物料在第1道工序的下料结束时间
% 第7列表示物料在第1道工序的加工结束时间
material_list1 = [];

% material_list2表示物料列表，第2道工序情况
% 第1列表示物料的编号
% 第2列表示物料上第2道工序的CNC编号
% 第3列表示物料在第2道工序的上料开始时间
% 第4列表示物料在第2道工序的上料结束时间
% 第5列表示物料在第2道工序的下料开始时间
% 第6列表示物料在第2道工序的下料结束时间
% 第7列表示物料在第2道工序的加工结束时间
material_list2 = [];
finished_list1 = [];
finished_list2 = [];

material_number = 0; %物料编号

%%
% RGV的起始位置
rgv_location = 1;
% 时间的初始值
t = 0;

%% 给所有cnc_set1上料   (初始化)
wait_cnc_set1 = cnc_set1;
while ~isempty(wait_cnc_set1)
    m = length(wait_cnc_set1);
    wait_time_cnc_set1 = zeros(1,m);
    for i = 1:m
        wait_time_cnc_set1(i) = d(rgv_location,wait_cnc_set1(i)) + load_time(wait_cnc_set1(i));
    end
    [min_wait_time,kk] = min(wait_cnc_set1);
    t = t + d(rgv_location,wait_cnc_set1(kk)); %上料开始时间
    
    rgv_location = wait_cnc_set1(kk);
    material_number = material_number + 1;
    material_list1 = [material_list1;
        [rgv_location, 1, material_number, t, t+load_time(rgv_location),inf,inf,t+load_time(rgv_location)+process1_time]];
    t = t + load_time(rgv_location); %上料完成时间
    wait_cnc_set1(kk) = [];
end

%% 等待第1件半成品
t1 = min(material_list1(:,8));  %第1件半成品的完成时间
if t < t1
    t = t1;
end
%% 初始化material_list2
material_list2 = [cnc_set2', zeros(n2,7)];

%% 将半成品放入第2道工序CNC
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

    %% 把编号为r2的CNC上的半成品搬运到编号为c2的CNC上
    % 在material_list1中查找编号为r2的记录位置，记作r3
    r3 = find(material_list1(:,1)==r2);
    % 在material_list2中查找编号为c2的记录位置，记作c3
    c3 = find(material_list2(:,1)==c2);

    t = t+d(rgv_location,r2); %第1次运动时间
    material_list1(r3,6) = t; %第1工序，下料开始时间
    t = t+load_time(r2);
    material_list1(r3,7) = t; %第1工序，下料结束时间
    finished_list1 = [finished_list1;
        material_list1(r3,[3,1,4:8])];

    t = t + d(r2,c2);         %第2次运动时间
    if material_list2(c3,2)==0  %c3号CNC处于初始状态
        material_list2(c3,2) = 1;
        material_list2(c3,3) = material_list1(r3,3);  
        material_list2(c3,4) = t;
        t = t + load_time(c2);
        material_list2(c3,5) = t;
        material_list2(c3,[6,7]) = [inf,inf];
        material_list2(c3,8) = t+process2_time;
    else
        material_list2(c3,[6,7]) = [t,t+load_time(c2)];
        t = t+load_time(c2); %第2工序，下料结束时间

        finished_list2 = [finished_list2;
            material_list2(c3,[3,1,4:8])];
        
        material_list2(c3,3) = material_list1(r3,3);
        material_list2(c3,[4,5]) = material_list2(c3,[6,7]);
        material_list2(c3,[6,7]) = [inf,inf];
        material_list2(c3,8) = t+process2_time;
        t = t + clean_time;  %清洗时间
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

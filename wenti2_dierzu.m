d =[0 0 23 23 41 41 59 59;
    0 0 23 23 41 41 59 59 ;
    23 23 0 0 23 23 41 41 ;
    23 23 0 0 23 23 41 41 ;
    41 41 23 23 0 0 23 23 ;
    41 41 23 23 0 0 23 23 ;
    59 59 41 41 23 23 0 0 ;
    59 59 41 41 23 23 0 0 ;
    ];

% load_time(i)表示RGV为CNC(i)完成一次上下料所需要的时间
load_time =[30 35 30 35 30 35 30 35];;
% n表示CNC的台数
n = length(load_time);

% 完成一个物料的清洗作业时间
clean_time = 30;

% 系统的总工作时间
work_hours = 8;

% 加工第一道工序所需要的时间
process1_time = 280;
% 加工第二道工序所需要的时间
process2_time = 500;
% 加工第一道工序的CNC集合
cnc_set1 = [1,3,5,];

problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
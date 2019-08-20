d =[0 0 18 18 32 32 46 46;
    0 0 18 18 32 32 46 46 ;
    18 18 0 0 18 18 32 32 ;
    18 18 0 0 18 18 32 32;
    32 32 18 18 0 0 18 18 ;
    32 32 18 18 0 0 18 18;
    46 46 32 32 18 18 0 0;
    46 46 32 32 18 18 0 0;
    ];

% load_time(i)表示RGV为CNC(i)完成一次上下料所需要的时间
load_time =[27 32 27 32 27 32 27 32];
% n表示CNC的台数
n = length(load_time);

% 完成一个物料的清洗作业时间
clean_time = 25;

% 系统的总工作时间
work_hours = 8;

% 加工第一道工序所需要的时间
process1_time = 455;
% 加工第二道工序所需要的时间
process2_time = 182;
% 加工第一道工序的CNC集合
cnc_set1 = [1,3,5,7];

problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
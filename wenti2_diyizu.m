d= [0 0 20 20 33 33 46 46;
       0 0 20 20 33 33 46 46;
       20 20 0 0 20 20 33 33;
       20 20 0 0 20 20 33 33;
       33 33 20 20 0 0 20 20;
       33 33 20 20 0 0 20 20;
       46 46 33 33 20 20 0 0;
       46 46 33 33 20 20 0 0;
    ];
load_time =[28,31,28,31,28,31,28,31];
% n表示CNC的台数
n = length(load_time);

% 完成一个物料的清洗作业时间
clean_time =25;

% 系统的总工作时间
work_hours = 8;

% 加工第一道工序所需要的时间
process1_time = 400;
% 加工第二道工序所需要的时间
process2_time = 378;
% 加工第一道工序的CNC集合
cnc_set1 = [1,3,5,7];

problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
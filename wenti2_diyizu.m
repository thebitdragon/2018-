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
% n��ʾCNC��̨��
n = length(load_time);

% ���һ�����ϵ���ϴ��ҵʱ��
clean_time =25;

% ϵͳ���ܹ���ʱ��
work_hours = 8;

% �ӹ���һ����������Ҫ��ʱ��
process1_time = 400;
% �ӹ��ڶ�����������Ҫ��ʱ��
process2_time = 378;
% �ӹ���һ�������CNC����
cnc_set1 = [1,3,5,7];

problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
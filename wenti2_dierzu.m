d =[0 0 23 23 41 41 59 59;
    0 0 23 23 41 41 59 59 ;
    23 23 0 0 23 23 41 41 ;
    23 23 0 0 23 23 41 41 ;
    41 41 23 23 0 0 23 23 ;
    41 41 23 23 0 0 23 23 ;
    59 59 41 41 23 23 0 0 ;
    59 59 41 41 23 23 0 0 ;
    ];

% load_time(i)��ʾRGVΪCNC(i)���һ������������Ҫ��ʱ��
load_time =[30 35 30 35 30 35 30 35];;
% n��ʾCNC��̨��
n = length(load_time);

% ���һ�����ϵ���ϴ��ҵʱ��
clean_time = 30;

% ϵͳ���ܹ���ʱ��
work_hours = 8;

% �ӹ���һ����������Ҫ��ʱ��
process1_time = 280;
% �ӹ��ڶ�����������Ҫ��ʱ��
process2_time = 500;
% �ӹ���һ�������CNC����
cnc_set1 = [1,3,5,];

problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
d =[0 0 18 18 32 32 46 46;
    0 0 18 18 32 32 46 46 ;
    18 18 0 0 18 18 32 32 ;
    18 18 0 0 18 18 32 32;
    32 32 18 18 0 0 18 18 ;
    32 32 18 18 0 0 18 18;
    46 46 32 32 18 18 0 0;
    46 46 32 32 18 18 0 0;
    ];

% load_time(i)��ʾRGVΪCNC(i)���һ������������Ҫ��ʱ��
load_time =[27 32 27 32 27 32 27 32];
% n��ʾCNC��̨��
n = length(load_time);

% ���һ�����ϵ���ϴ��ҵʱ��
clean_time = 25;

% ϵͳ���ܹ���ʱ��
work_hours = 8;

% �ӹ���һ����������Ҫ��ʱ��
process1_time = 455;
% �ӹ��ڶ�����������Ҫ��ʱ��
process2_time = 182;
% �ӹ���һ�������CNC����
cnc_set1 = [1,3,5,7];

problem2(d,load_time,clean_time,process1_time,process2_time,work_hours,cnc_set1)
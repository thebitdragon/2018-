function wuliaobiao = problem1(dis,sxl,qxsj,gxsj,hours)

% dis = [0 0 20 20 33 33 46 46;
%        0 0 20 20 33 33 46 46;
%        20 20 0 0 20 20 33 33;
%        20 20 0 0 20 20 33 33;
%        33 33 20 20 0 0 20 20;
%        33 33 20 20 0 0 20 20;
%        46 46 33 33 20 20 0 0;
%        46 46 33 33 20 20 0 0;
%     ];
% sxl = [28,31,28,31,28,31,28,31];
% qxsj = 25;
% gxsj = 560;
rgv_loc = 1;
cnc_ddjh = 1:8;
t = 0;
wuliaobiao = [];
wuliaobianhao = 0;

while length(cnc_ddjh)>0
    fuwushijian = zeros(1,length(cnc_ddjh));
    for i = 1:length(cnc_ddjh)
        fuwushijian(i) = dis(rgv_loc,cnc_ddjh(i))+ sxl(cnc_ddjh(i));
    end

    [fw_min,pos] = min(fuwushijian);

    fuwuduixiang = cnc_ddjh(pos);
    cnc_ddjh(pos) = [];
    t = t + dis(rgv_loc,fuwuduixiang);
    wuliaobianhao = wuliaobianhao+1;
    wuliaobiao = [wuliaobiao
        wuliaobianhao, fuwuduixiang, t, t+sxl(fuwuduixiang),inf,t+sxl(fuwuduixiang)+gxsj];
    t = t + sxl(fuwuduixiang);
    rgv_loc = fuwuduixiang;
end
while t<3600*hours
    if isempty(find(wuliaobiao(:,5)>=inf & wuliaobiao(:,6)<=t))
        t = min(wuliaobiao(find(wuliaobiao(:,5)>=inf & wuliaobiao(:,6)>t),6));
    end
    
    cnc_ddjh = wuliaobiao(find(wuliaobiao(:,5)>=inf & wuliaobiao(:,6)<=t),2);
    
    fuwushijian = zeros(1,size(cnc_ddjh,2));
    
    for i = 1:length(cnc_ddjh)
        fuwushijian(i) = dis(rgv_loc,cnc_ddjh(i))+ sxl(cnc_ddjh(i));
    end
    
    [fw_min,pos] = min(fuwushijian);
    fuwuduixiang = cnc_ddjh(pos);
    
    t = t + dis(rgv_loc,fuwuduixiang);
    wuliaobiao(find(wuliaobiao(:,5)>=inf & wuliaobiao(:,2)==fuwuduixiang),5)=t;
    
    wuliaobianhao = wuliaobianhao+1;
    wuliaobiao = [wuliaobiao
        wuliaobianhao, fuwuduixiang, t, t+sxl(fuwuduixiang),inf,t+sxl(fuwuduixiang)+gxsj];
    
    t = t + sxl(fuwuduixiang);
    t = t + qxsj;
    rgv_loc = fuwuduixiang;

end

wuliaobiao(find(wuliaobiao(:,5)==inf),:)=[]
end

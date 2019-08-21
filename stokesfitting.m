function P = stokesfitting(dF, IG)

% developed by Ibrahim Issah
% IG is the initial guess of the function 
% dF is the value of the function gained from the experiment

caseNr=1;


if(caseNr==1)
    saveName='choose the right name ';
elseif(caseNr==2)
    saveName='';
elseif(caseNr==3)
    saveName='';
elseif(caseNr==4)
    saveName='';
end
load([saveName,'.mat']);

maxvalue=max(data(:,5));

case0M=data(:,5)/maxvalue;
case1M=data(:,1)/maxvalue;
case2M=data(:,2)/maxvalue;
case3M=data(:,3)/maxvalue;
case4M=data(:,4)/maxvalue;

x = case0M;  
y1 = case1M; 
y2 = Case2M; 
y3 = case3M; 
y4 = case4M;


    function [merit_function] = fit(IG)
        
        a = IG(1); 
        b = IG(2); 
        c = IG(3); 
        d = IG(4); 
        
        f = (a.*exp(x.*b + c)+ d); 
        
        merit_function = sum(abs(f-y)); 
    end 

P = fminsearch(@fit, IG); 



end
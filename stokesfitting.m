function P = stokesfitting(data, IG)

% developed by Ibrahim Issah
% IG is the initial guess of the function 
% dF is the value of the function gained from the experiment

caseNr=1;

% 
% if(caseNr==1)
%     saveName='choose the right name ';
% elseif(caseNr==2)
%     saveName='';
% elseif(caseNr==3)
%     saveName='';
% elseif(caseNr==4)
%     saveName='';
% end
% load([saveName,'.mat']);

maxvalue=max(data(:,2));

case0M=data(:,1)/maxvalue;
case1M=data(:,2)/maxvalue;
% case2M=data(:,2)/maxvalue;
% case3M=data(:,3)/maxvalue;
% case4M=data(:,4)/maxvalue;

x = case0M;  
y = case1M; 
% y2 = Case2M; 
% y3 = case3M; 
% y4 = case4M;


    function [merit_function] = fit(IG)
        
        Ein = IG(1); 
        wp_angle_sample1 = IG(2); 
        retardance_sample1 = IG(3); 
        pol_angle_sample1 = IG(4);
        px_sample = IG(5); 
        py_sample = IG(6);  
        px_analyzer = IG(7); 
        py_analyzer = IG(8);
        for ind = 1: length(analyzer_angles)
            f =  Ecase1(Ein, wp_angle_sample1, retardance_sample1,...
                pol_angle_sample1,px_sample, py_sample,...
                analyzer_angles(ind), px_analyzer, py_analyzer); 
            
             
        end
        merit_function = sum(abs(f-y));
    end 

P = fminsearch(@fit, IG); 



end
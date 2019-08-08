clear
% close all

caseNr=4;

folderName='C:\Users\hpartane\OneDrive - University of Eastern Finland\measurements\Polarizer rotation\IR_new';
if(caseNr==1)
    saveName='S_1';
elseif(caseNr==2)
    saveName='S_2';
elseif(caseNr==3)
    saveName='S_3';
elseif(caseNr==4)
    saveName='S_4';
end
load([folderName,'\',saveName,'.mat']);

maxvalue=max(data(:,5));

case0M=data(:,5)/maxvalue;
case1M=data(:,1)/maxvalue;
case2M=data(:,2)/maxvalue;
case3M=data(:,3)/maxvalue;
case4M=data(:,4)/maxvalue;



positionsShift=positions+7;


analyzer_angles=linspace(min(positionsShift),max(positionsShift),500);
Ein=[0;1];
px_analyzer = 0.0;
py_analyzer = 1;

Wp_shift=2;

% % not ideal parameters
px_sample = 0.2; 
py_sample = 0.95;
pol_angle_sample1 = 10;
retardance_sample1 = pi/2 * 0.70;
wp_angle_sample1 = pol_angle_sample1 + Wp_shift + 45;

pol_angle_sample2 = 90+14;
retardance_sample2 = retardance_sample1;
wp_angle_sample2 = pol_angle_sample2 + Wp_shift + 45;

pol_angle_sample3 = 45+10;
retardance_sample3 = retardance_sample1;
wp_angle_sample3 = pol_angle_sample3 + Wp_shift + 45;

% pol_angle_sample4 = 45;
% retardance_sample4 = pi/2 * 1.0;
% wp_angle_sample4 = pol_angle_sample4 + 0 + 45;

Iref=zeros(size(analyzer_angles));
Iout1=zeros(size(analyzer_angles));
Iout2=zeros(size(analyzer_angles));
Iout3=zeros(size(analyzer_angles));
Iout4=zeros(size(analyzer_angles));

for ind=1:length(analyzer_angles)
    Eref =  linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
            Ein;
    
    if(caseNr==1)
        Eout1=Ecase1(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase1(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase1(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    elseif(caseNr==2)
        Eout1=Ecase2(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase2(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase2(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    elseif(caseNr==3)
        Eout1=Ecase3(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase3(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase3(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    elseif(caseNr==4)
        Eout1=Ecase4(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase4(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase4(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    end

        
%     Eout1 = wp_t(wp_angle_sample1, retardance_sample1) *... 
%             linpol_tp(pol_angle_sample1, px_sample, py_sample) *... 
%             linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
%             Ein;    
%         
%     Eout2 = wp_t(wp_angle_sample2, retardance_sample1) *... 
%             linpol_tp(pol_angle_sample2, px_sample, py_sample) *... 
%             linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
%             Ein;    
%         
%         
%     Eout3 = wp_t(wp_angle_sample3, retardance_sample1) *... 
%             linpol_tp(pol_angle_sample3, px_sample, py_sample) *... 
%             linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
%             Ein;    
        
    Iref(ind) = sum(abs(Eref).^2); 
    Iout1(ind) = sum(abs(Eout1).^2);
    Iout2(ind) = sum(abs(Eout2).^2);
    Iout3(ind) = sum(abs(Eout3).^2);
end    

% 
figure
hold on
plot(analyzer_angles,Iref, 'k-')
plot(analyzer_angles,Iout1, 'r-')
plot(analyzer_angles,Iout2, 'g-')
plot(analyzer_angles,Iout3, 'b-')
plot(positionsShift,case0M, 'ko')
plot(positionsShift,case1M, 'ro')
plot(positionsShift,case2M, 'go')
plot(positionsShift,case3M, 'bo')

legend('analyzer','1','2','3')
title(['case ', num2str(caseNr)])

xlabel('polarizer orientation [degrees]')
ylabel('power [W]')
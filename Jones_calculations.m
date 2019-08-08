clear
% close all

analyzer_angles=linspace(0,360*1,500);
Ein=[1;0];
px_analyzer = 0.0;
py_analyzer = 1;

% % Ideal parameters
% px_sample = 0.0; 
% py_sample = 1.0;
% pol_angle_sample = 0;
% retardance_sample = pi/2 * 1.0;
% wp_angle_sample = pol_angle_sample + 0 + 45;

% % not ideal parameters
px_sample = 0.3; 
py_sample = 0.8;
% pol_angle_sample = 10;
pol_angle_sample = 45;
retardance_sample = pi/2 * 1.3;
% retardance_sample = pi/2 * 0;
wp_angle_sample = pol_angle_sample + 6 + 45;

Iref=zeros(size(analyzer_angles));
Iout1=zeros(size(analyzer_angles));
Iout2=zeros(size(analyzer_angles));
Iout3=zeros(size(analyzer_angles));
Iout4=zeros(size(analyzer_angles));

CPL_Jones=wp_t(wp_angle_sample, retardance_sample) *... 
            linpol_tp(pol_angle_sample, px_sample, py_sample)

for ind=1:length(analyzer_angles)

  
    Eref =  linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
            Ein;
    
    Eout1 = wp_t(wp_angle_sample, retardance_sample) *... 
            linpol_tp(pol_angle_sample, px_sample, py_sample) *... 
            linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
            Ein;

      Eout2 = linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
              wp_t(wp_angle_sample, retardance_sample) *... 
              linpol_tp(pol_angle_sample, px_sample, py_sample) *... 
              Ein;
         
      Eout3 = linpol_tp(180-pol_angle_sample, px_sample, py_sample) *... 
              wp_t(180-wp_angle_sample, retardance_sample) *...
              linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
              Ein;

      Eout4 = linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
              linpol_tp(180-pol_angle_sample, px_sample, py_sample) *... 
              wp_t(180-wp_angle_sample, retardance_sample) *... 
              Ein;
    
    Iref(ind) = sum(abs(Eref).^2);     
    Iout1(ind) = sum(abs(Eout1).^2);
    Iout2(ind) = sum(abs(Eout2).^2);
    Iout3(ind) = sum(abs(Eout3).^2);
    Iout4(ind) = sum(abs(Eout4).^2);
end

lineWidth=2;
curveFig=figure;
hold on
xlabel('analyzer orientation [degrees]')
ylabel('intensity')

plot(analyzer_angles,Iref,'-','lineWidth',lineWidth);
plot(analyzer_angles,Iout1,'-','lineWidth',lineWidth);
plot(analyzer_angles,Iout2,'--','lineWidth',lineWidth);
plot(analyzer_angles,Iout3,'-.','lineWidth',lineWidth);
plot(analyzer_angles,Iout4,':','lineWidth',lineWidth);
ylim([0,1])
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');

set(myLegend, 'fontsize', 10);

set(curveFig, 'position', [680   716   560   262]);
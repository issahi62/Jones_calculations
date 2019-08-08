disp('open motor')
sysctrl=actxcontrol('MG17SYSTEM.MG17SystemCtrl.1');
% start control
sysctrl.StartCtrl;
% get the serial numbers of the units
[tmp,serial1]=sysctrl.GetHWSerialNum(6,0,0);
disp(['Serial number of the unit 1: ' num2str(serial1)]);
% start motor control
motorctrl1=actxcontrol('MGMotor.MGMotorCtrl.1');
motorctrl1.StartCtrl;
set(motorctrl1, 'HWSerialNum', serial1);
motorctrl1.Identify; 
pause(3);
% %load motor settings, to allow full area
% motorctrl1.LoadParamSet('goniometer');
if(homeMotorOrNot==1)
    disp('Driving motors home.');
    motorctrl1.MoveHome(0,1);
end
clear
close all


Nfilter=5; %number of polarizerr to be measures, or Arduino positions
Nx=100; % number of analyzer positions
positions=linspace(0,360,Nx); %analyzer angle positions

pauseTime=0.3; % pause time between movements (seconds)

saveName='';

comPortName='COM5';

homeMotorOrNot=1;
OpenMotor;
OpenPowerMeter;

tic

serialPort=serial(comPortName);
disp('open serial port to Arduino')
fopen(serialPort);
checkIfMovementReady
pause(2)
disp('Arduino is ready')

data=zeros(Nx,Nfilter);
for indS=1:Nfilter
    fprintf(serialPort, [num2str(indS-1),'F,']); % 
    checkIfMovementReady
    pause(2)
    disp('Filter wheel ready')
    for ind=1:Nx
        ind
    %     pause(0.1)
        motorctrl1.MoveAbsolute(0,1);
        pause(pauseTime)
        data(ind,indS) = str2double( query(obj1, 'READ?') );
    %     pause(0.1)
    end
end

timeUsed=toc;

save([saveName,'.mat'],  'positions', 'data', 'timeUsed');


disp('measurement done, close serial port, detector and motor')
fclose(serialPort);
CloseMotor;
% Disconnect from instrument object, obj1.
fclose(obj1);

disp(['Time used ', num2str(timeUsed)])

figure
timeuse= linspace(0, timeUsed, Nx);
plot(timeuse,data)
xlabel('polarizer orientation [degrees]')
ylabel('power [W]')
ylim([0,max(data)])
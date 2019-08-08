% variables

close all;
clc; 

name = 'Green'; 
E_filter1 =[];
E_filter2 =[];
E_filter3 =[];
E_filter4 =[];
E_filter5 =[];


% section for loading the files 
myFolder = '/Users/kobbyTilly/Downloads/Polarizer_rotation/Green_532nm'; 
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, 'S_*');
matFiles = dir(filePattern);
[~, ind] = sort([matFiles.datenum]);
matFiles = matFiles(ind);

for k = 1:length(matFiles)
  matFilename = fullfile(myFolder, matFiles(k).name);
  matData=load(matFilename);
  
  hasField = isfield(matData, 'timeUsed');
  if ~hasField
       warningMessage = sprintf('Data is not in %s\n', matFilename);
    uiwait(warndlg(warningMessage));
    continue; 
  end
  
  data = matData.data;
  positions = matData.positions; 

   E_filter1 = [(E_filter1), data(:, 1)];
   E_filter2 = [(E_filter2), data(:, 2)];
   E_filter3 = [(E_filter3), data(:, 3)];
   E_filter4 = [(E_filter4), data(:, 4)];
   E_filter5 = [(E_filter5), data(:, 5)];
  
end

E_filterA = [E_filter5(:,2),E_filter1];
E_filterB = [E_filter5(:,2),E_filter2]; 
E_filterC = [E_filter5(:,2),E_filter3]; 
E_filterD = [E_filter5(:,2),E_filter4]; 

lineWidth=2;

curveFig =figure(1);
plot(positions,E_filterA, 'lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
xlabel('analyzer orientation [degrees]')
ylabel('intensity')
title('Filter1')

curveFig =figure(2);
plot(positions,E_filterB, 'lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
xlabel('analyzer orientation [degrees]')
ylabel('intensity')
title('Filter2')

curveFig =figure(3);
plot(positions,E_filterC, 'lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
title('Filter3')
xlabel('analyzer orientation [degrees]')
ylabel('intensity')

curveFig = figure(4);
plot(positions,E_filterD, 'lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
title('Filter4')
xlabel('analyzer orientation [degrees]')
ylabel('intensity')

P={zeros(4)}; 
fh = figure('Name', name,'NumberTitle','off');
screenfig = 4; 
for ii = 1:screenfig
    subplot(2,2,ii)
    P{ii} = get(gca,'pos');
end
clf
F = findobj('type','figure');
for ii = 2:5
    ax = findobj(F(ii),'type','axes');
    set(ax,'parent',fh,'pos',P{6-ii})
    close(F(ii))
end
          
% tic
areWeReady=0;
while(areWeReady==0)
%     readData=fscanf(serialPort);
    readData=fgetl(serialPort);
    comparison=sum(readData=='R');
    if(comparison>0)
        areWeReady=1;
%         aiktimeTook = toc;
%         disp(['movement done, time it took' num2str(aiktimeTook)]);
        
    end
end
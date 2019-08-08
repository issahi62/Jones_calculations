function cam = THopen;
%function id = THopen
%
%Initializes Thorlabs DCC1545 and DCC1645 USB cameras.
%
%id        Camera id. Use this value for other TH camera comands.
%
%Workfow with TH functions:
%id=THopen;                   %Open the camera and provide a camera id
%THinfo(id);                  %Optionally print camera information
%f=THset(id,'ExposureTime',5) %Select 5 ms exposure and show the actual value
%img=THimage(id);             %Grab an image
%THclose(id);                 %Close the camera after use
%
%See also: THget, THinfo, THset, THimage, THclose.
%
%MEX function for Win32 by Pertti 29.6.2010


currentFolder = pwd;
NET.addAssembly([currentFolder,'\uc480DotNet.dll']);


cam = uc480.Camera; % Create camera object handle
cam.Init(0); % Open the 1st available camera


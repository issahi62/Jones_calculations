function Data = THimage(cam);
%function img = THimage(id)
%
%Downloads an image from a Thorlabs DCC1545 or DCC1645 USB camera.
%
%id        Camera id as resulted by THopen command
%
%img       Raw uint8 image using the settings by THset command.
%
%Monochrome camera produces a 2 dimensional matrix
%Color camera produces a 3 dimensional array with separate R, G, and B
%channels.
%
%See also: THopen, THinfo, THget, THset, THclose.
%
%Reverce engineered from Pertti's code by Henri 6.7.2017



% take the picture

[~, MemId] = cam.Memory.Allocate(true); % Allocate image memory
[~, Width, Height, Bits, ~] = cam.Memory.Inquire(MemId); % Obtain image information
cam.Acquisition.Freeze(uc480.Defines.DeviceParameter.Wait); % Acquire image
[~, tmp] = cam.Memory.CopyToArray(MemId); % Copy image from memory

% Data=tmp;

% Bits

% % % Reshape image
% Data = reshape(uint8(tmp), [Bits/8, Width, Height]);
% Data = Data(1:3, 1:Width, 1:Height);
% Data = permute(Data, [3,2,1]);
% Data = Data(:,:,1);

% % Reshape image
Data = reshape(uint8(tmp), [Width, Height]);
Data = permute(Data, [2,1]);
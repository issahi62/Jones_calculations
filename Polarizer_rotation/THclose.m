function THclose(cam);
%function THclose(id)
%
%Closes a Thorlabs DCC1545 or DCC1645 USB camera.
%
%id        Camera id as resulted by THopen command
%
%See also: THopen, THinfo, THget, THset, THimage.
%
%MEX function for Win32 by Pertti 29.6.2010

cam.Exit;
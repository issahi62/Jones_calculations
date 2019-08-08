function varargout = THget(varargin);
%function [res1,res2,...] = THget(id,'Property1','Property2',...)
%
%Getting properties of Thorlabs DCC1545 and DCC1645 USB cameras. Multiple
%camera properties may be get simultaneously.
%
%id        Camera id as resulted by THopen command
%Property  Camera property to be set (see below)
%
%res       Result value of a property
%
%Currently supported camera properties:
%'ExposureTime' vector  Exposure time range in milliseconds
%'FrameRate'    vector  Frame rate range in frames/sec
%'PixelClock'   vector  Pixel clock range in MHz
%'CameraGain'   scalar  Camera gain setting:
%                       0 means 1x gain, 100 means 13x gain
%
%See also: THopen, THinfo, THset, THimage, THclose.
%
%MEX function for Win32 by Pertti 29.6.2010

cam=varargin{1};

varargout={};

for k=2:1:nargin,
	prop = varargin{k};
	if     (strncmp(prop,'ExposureTime' ,12))
        [~,ExposureOut] = cam.Timing.Exposure.Get(); 
        varargout{end+1}  = ExposureOut;
	elseif (strncmp(prop,'FrameRate'    ,9))    
        [~,FrameRateOut] = cam.Timing.Framerate.Get();
        varargout{end+1}  = FrameRateOut;
	elseif (strncmp(prop,'PixelClock'   ,10)) 
        [~,PixelClockOut] = cam.Timing.PixelClock.Get();
        varargout{end+1}  = PixelClockOut;
	elseif (strncmp(prop,'CameraGain'   ,10))   
        [~,GainOut]=cam.Gain.Hardware.Scaled.GetMaster();
        varargout{end+1}  = GainOut;
	elseif (strncmp(prop,'SubSampling'  ,11)) % ei vielä asetettu
    elseif (strncmp(prop,'ImageSize'    ,9))    
        varargout{end+1}=ImageSize;
    elseif (strncmp(prop,'ImagePos'     ,8)) 
        varargout{end+1}=ImagePos;
    end
end
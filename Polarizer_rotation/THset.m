function varargout = THset(varargin);
%function [res1,res2,...] = THset(id,'Property1',val1,'Property2',val2,...)
%
%Setting properties of Thorlabs DCC1545 and DCC1645 USB cameras. Multiple
%camera properties may be set simultaneously in the given order.
%
%id        Camera id as resulted by THopen command
%Property  Camera property to be set (see below)
%val       Camera property set value or values
%
%res       Result value(s) of a property (may differ from the set value)
%
%Currently supported camera properties:
%'ExposureTime' scalar  Exposure time in milliseconds
%'FrameRate'    scalar  Frame rate in frames/sec
%'PixelClock'   scalar  Pixel clock in MHz
%'CameraGain'   scalar  Camera gain setting:
%                       0 means 1x gain, 100 means 13x gain
%'SubSampling'  vector  Horizontal and vertical pixel subsampling:
%                       1, 2, 4 or 8 (DCC cameras do not support binning)
%'ImageSize'    vector  Image width and height to be read
%'ImagePos'     vector  Image position from left and top of the sensor
%
%Possible ExposureTime range is a combination of FrameRate PixelClock,
%SubSampling, and ImageSize settings. Reduce FrameRate and/or PixelClock 
%to increase possible ExposureTime. Setting FrameRate or ExposureTime 
%outside of valid limits does not give an error message but sets the value 
%to it's closest limit.
%
%Image must be fit into the camera sensor. ImageSize may not be set larger
%if ImagePos is set nonzero. Set ImagePos first to [0,0] and then ImageSize
%to, e.g., [1280,1024] (may be set in the same command).
%Image width and height has the same meaning as with Matlab IMAGE command.
%
%Sample command:
%[v1,v2,v3,v4]=THset(id,'PixelClock',5,'FrameRate',0.1,'ExposureTime',6,'CameraGain',1)
%
%See also: THopen, THinfo, THget, THimage, THclose.
%
%MEX function for Win32 by Pertti 29.6.2010

cam=varargin{1};

ExposureTime  = nan;
FrameRate     = nan;
PixelClock    = nan;
CameraGain    = nan;
SubSampling   = nan;
ImageSize     = nan;
ImagePos      = nan;

for k=2:2:nargin,
	prop = varargin{k};
	val  = varargin{k+1};
	if     strncmp(prop,'ExposureTime' ,12),   ExposureTime  = val;
	elseif strncmp(prop,'FrameRate'    ,9),    FrameRate     = val;
	elseif strncmp(prop,'PixelClock'   ,10),   PixelClock    = val;
	elseif strncmp(prop,'CameraGain'   ,10),   CameraGain    = val;
	elseif strncmp(prop,'SubSampling'  ,11),   SubSampling   = val; % ei vielä asetettu
    elseif strncmp(prop,'ImageSize'    ,9),    ImageSize     = val;
    elseif strncmp(prop,'ImagePos'     ,8),    ImagePos     = val;
    end
end

% if(~isnan(ExposureTime))
%     
% end

pause_time=0.1;

if(~isnan(ImageSize) & ~isnan(ImagePos))
    PosX=int32(ImagePos(1)); 
    PosY=int32(ImagePos(2));
    Width=int32(ImageSize(1)); 
    Height=int32(ImageSize(2));
    cam.Size.AOI.Set(PosX, PosY, Width, Height);
end
pause(pause_time)

if(~isnan(PixelClock))
    cam.Timing.PixelClock.Set(PixelClock);
end
pause(pause_time)

if(~isnan(FrameRate))
    cam.Timing.Framerate.Set(FrameRate);
end
pause(pause_time)

if(~isnan(ExposureTime))
    cam.Timing.Exposure.Set(ExposureTime);
end
pause(pause_time)

if(~isnan(CameraGain))
    if(CameraGain==0)
        cam.Gain.Hardware.Boost.SetEnable(false); %disable hardware gain
    else
        cam.Gain.Hardware.Boost.SetEnable(true); %disable hardware gain 
        cam.Gain.Hardware.Scaled.SetMaster(CameraGain);
    end
end
pause(pause_time)


% cam.Display.Mode.Set(uc480.Defines.DisplayMode.DiB); % Set display mode to bitmap (DiB)
% cam.PixelFormat.Set(uc480.Defines.ColorMode.RGBA8Packed); % Set color mode to 8-bit RGB
cam.PixelFormat.Set(uc480.Defines.ColorMode.Mono8); % Set color mode to 8-bit RGB

cam.Trigger.Set(uc480.Defines.TriggerMode.Software); % Set trigger mode to software (single image acquisition)


% Set gamma correction off (100 corresponds to gamma = 1.0)
% cam.Lut.SetEnable(false);
% cam.Lut.SetPreset(uc480.Defines.LutPreset.Identity);
% cam.Gamma.Software.Set(50);



varargout={};

for k=2:2:nargin,
	prop = varargin{k};
	val  = varargin{k+1};
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

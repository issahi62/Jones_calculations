%% Instrument Connection

% Find a VISA-USB object.
obj1 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1313::0x8070::P0000462::0::INSTR', 'Tag', '');

% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = visa('NI', 'USB0::0x1313::0x8070::P0000462::0::INSTR');
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Connect to instrument object, obj1.
fopen(obj1);
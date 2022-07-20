using DisableDevice;

bool enable;
if (args.Length == 0)
{
    Console.WriteLine("Toggling not supported");
    return 1;
}

else if (args.Length != 1)
{
    Console.WriteLine("Expected 1 argument, true or false");
    return 1;
}
else
{
    enable = bool.Parse(args[0]);
}


var (deviceGuid, instancePath) = ConfigurationExtensions.GetConfig();

DeviceHelper.SetDeviceEnabled(deviceGuid, instancePath, enable);

return 0;



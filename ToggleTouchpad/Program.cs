using DisableDevice;

if (args.Length > 1)
{
    Console.WriteLine("Expected 0 or 1 argument");
    return 1;
}

var (deviceGuid, instancePath) = ConfigurationExtensions.GetConfig();

if (args.Length == 0)
{
    DeviceHelper.ToggleDeviceEnabled(deviceGuid, instancePath);
}
else
{
    bool enable = bool.Parse(args[0]);
    //DeviceHelper.SetDeviceEnabled(deviceGuid, instancePath, enable);
    throw new NotSupportedException();
}

return 0;



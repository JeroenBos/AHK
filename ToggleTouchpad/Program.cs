using DisableDevice;

if (!AdminPrivilege.ProgramIsElevated)
{
    Console.WriteLine("Error: the program must be executed with admin rights");
    return 1;
}
if (args.Length > 1)
{
    Console.WriteLine("Error: Expected 0 or 1 argument");
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



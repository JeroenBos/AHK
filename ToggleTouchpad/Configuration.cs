using System.Configuration;

public static class ConfigurationExtensions
{
    public static (Guid DeviceGuid, string InstancePath) GetConfig()
    {
        return (Guid.Parse("745a17a0-74d3-11d0-b6fe-00a0c90f57da"), @"HID\SYNHIDMINI&COL02\1&B12C6D1&2&0001");

        string ? deviceGuid_s = ConfigurationManager.AppSettings.Get("deviceGuid");
        if (deviceGuid_s == null)
        {
            throw new ConfigurationErrorsException("Configuration 'deviceGuid' not found in app.config");
        }
        var deviceGuid = Guid.Parse(deviceGuid_s);



        // get this from the properties dialog box of this device in Device Manager

        string? instancePath = ConfigurationManager.AppSettings.Get("instancePath");
        if (instancePath == null)
        {
            throw new ConfigurationErrorsException("Configuration 'instancePath' not found in app.config");
        }

        return (deviceGuid, instancePath);
    }
}
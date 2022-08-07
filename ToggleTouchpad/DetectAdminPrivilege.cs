using System.Security.Principal;

static class AdminPrivilege
{
    public static bool ProgramIsElevated
    {
        get
        {
            // implementation copied from: https://stackoverflow.com/a/5953294/308451
            bool isElevated;
            using (WindowsIdentity identity = WindowsIdentity.GetCurrent())
            {
                WindowsPrincipal principal = new WindowsPrincipal(identity);
                isElevated = principal.IsInRole(WindowsBuiltInRole.Administrator);
            }
            return isElevated;
        }
    }
}
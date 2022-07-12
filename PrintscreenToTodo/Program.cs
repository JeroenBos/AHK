namespace PrintscreenToTodo
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();

            if (args.Length != 1)
            {
                MessageBox.Show($"args.Length == {args.Length} != 1", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }


            PrintscreenToTodoForm? form = null;
            try
            {
                bool omitPrintscreen = bool.Parse(args[0]); // otherwise just error
                form = PrintscreenToTodoForm.Create(omitPrintscreen);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            if (form != null)
            {
                Application.Run(form);
            }
        }
    }
}
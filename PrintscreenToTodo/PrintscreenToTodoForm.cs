using System.Configuration;
using System.Drawing.Imaging;

namespace PrintscreenToTodo;

public partial class PrintscreenToTodoForm : Form
{
    public static PrintscreenToTodoForm? Create()
    {
        // bail early if doesn't exist
        Extensions.GetTodoFile();

        // fetch clipboard contents
        bool success = Extensions.CacheImage(out string tmpFile);
        if (success)
        {
            return new PrintscreenToTodoForm(tmpFile);
        }
        return null;
    }
    private readonly string tmpFile;
    private PrintscreenToTodoForm(string tmpFile)
    {
        this.tmpFile = tmpFile;
        InitializeComponent();
        this.descriptionTextBox.KeyPress += this.onKeyPress!;
    }

    private void okButton_Click(object sender, EventArgs e)
    {
        SaveImageAndAddTodo();
        this.Close();
    }
    private void cancelButton_Click(object sender, EventArgs e)
    {
        this.Close();
    }
    private void onKeyPress(object sender, KeyPressEventArgs e)
    {
        if (e.KeyChar == (char)Keys.Return)
        {
            e.Handled = true;
            okButton_Click(sender, new EventArgs());
        }
        else if (e.KeyChar == (char)Keys.Escape)
        {
            e.Handled = true;
            cancelButton_Click(sender, new EventArgs());
        }
    }

    protected override void OnClosed(EventArgs e)
    {
        base.OnClosed(e);

        // try to delete the temp file
        if (this.tmpFile is not null)
        {
            try
            {
                File.Delete(this.tmpFile);
            }
            catch
            {
            }
        }
    }



    private void SaveImageAndAddTodo()
    {
        string description = GetDescription();
        var (relativeImagePath, absoluteImagePath) = GetImagePath(description);
        bool savedSuccessfully = SaveImage(absoluteImagePath);
        if (savedSuccessfully)
        {
            AddTodo(description, relativeImagePath);
        }

    }
    private (string RelativeImagePath, string AbsoluteImagePath) GetImagePath(string description)
    {
        if (string.IsNullOrEmpty(description))
            throw new ArgumentException();

        const string fileExtension = ".png";
        string dir = Extensions.GetImagesFolder();
        if (!dir.EndsWith(Path.DirectorySeparatorChar))
        {
            dir += Path.DirectorySeparatorChar;
        }

        string path;
        if (Path.IsPathFullyQualified(description))
        {
            throw new NotImplementedException("Cannot specify full path");
        }
        else
        {
            path = Path.Join(dir, description.ReplaceInvalidChars());
        }

        const int maxPathLength = 200;
        if (path.Length > maxPathLength)
        {
            path = path[..maxPathLength];
        }
        if (!path.EndsWith(fileExtension))
        {
            path += fileExtension;
        }
        path = path.IncrementFilenameUntilDoesntExist();
        return (path[dir.Length..], path);
    }
    private bool SaveImage(string fullPath)
    {
        try
        {
            Directory.CreateDirectory(Path.GetDirectoryName(fullPath)!);
            File.Copy(this.tmpFile, fullPath, overwrite: false);
            return true;
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return false;
        }

    }

    private string GetDescription()
    {
        string contents = this.descriptionTextBox.Text.Trim();
        if (string.IsNullOrEmpty(contents))
        {
            return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }
        return contents;
    }
    private void AddTodo(string description, string relativeImagePath)
    {
        string todoFilePath = Extensions.GetTodoFile();
        string fullImagePath = relativeImagePath.Replace('\\', '/');
        string[] lines = new[] {
            $"# {description}",
            $"![[{fullImagePath}]]",
            "",
        };

        File.AppendAllLines(todoFilePath, lines);
    }
}


public static class Extensions
{
    /// <summary>Caches the image on the clipboard in a temp file; shows a message box on failure.</summary>
    /// <returns>whether it was a success.</returns>
    public static bool CacheImage(out string path)
    {
        path = Path.GetTempFileName();
        try
        {
            if (Clipboard.ContainsImage())
            {
                Image img = Clipboard.GetImage();
                if (img is not null)
                {
                    img.Save(path, ImageFormat.Png);
                    return true;
                }
            }
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return false;
        }

        MessageBox.Show("No image in clipboard", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        return false;
    }

    public static string GetImagesFolder()
    {
        string? value = ConfigurationManager.AppSettings.Get("ImagesFolder");
        return value ?? Path.Combine(Path.GetDirectoryName(GetTodoFile())!, "TODO_images");
    }
    public static string GetTodoFile()
    {
        string? value = ConfigurationManager.AppSettings.Get("TodoFile");
        if (value == null)
        {
            throw new ConfigurationErrorsException("Configuration 'TodoFile' not found in app.config");
        }
        if (!Path.IsPathFullyQualified(value))
        {
            throw new ConfigurationErrorsException("Configuration 'TodoFile' must be a full path");
        }

        var result = Path.GetFullPath(value);
        return result;
    }
    public static string ReplaceInvalidChars(this string path)
    {
        return string.Join("_", path.Split(Path.GetInvalidFileNameChars()));
    }
    public static IEnumerable<string> IncrementFilename(this string fullPath)
    {
        yield return fullPath;

        string dir = Path.GetDirectoryName(fullPath)!;
        string originalFileName = Path.GetFileNameWithoutExtension(fullPath);
        string extension = Path.GetExtension(fullPath);

        for (int postfix = 1; ; postfix++)
        {
            string newFileName = originalFileName + "_" + postfix + extension;
            yield return Path.Join(dir, newFileName);
        }
    }
    public static string IncrementFilenameUntilDoesntExist(this string fullPath)
    {
        foreach (var incrementedPath in fullPath.IncrementFilename())
        {
            if (!File.Exists(incrementedPath))
                return incrementedPath;
        }
        throw new Exception("Not possible");
    }

}

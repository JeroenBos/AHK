using System.Collections;
using System.Configuration;
using System.Globalization;

namespace NoteWork;

public partial class NoteWorkForm : Form
{
    public static NoteWorkForm Create()
    {
        Extensions.GetDoneFile();

        return new NoteWorkForm();
    }
    private NoteWorkForm()
    {
        InitializeComponent();
        this.descriptionTextBox.KeyPress += this.onKeyPress!;

    }

    private void onKeyPress(object sender, KeyPressEventArgs e)
    {
        if (e.KeyChar == (char)Keys.Return)
        {
            e.Handled = true;
            NoteWork();
        }
        else if (e.KeyChar == (char)Keys.Escape)
        {
            e.Handled = true;
            Cancel();
        }
    }

    public void NoteWork()
    {
        string description = this.Description;
        if (string.IsNullOrEmpty(description))
            return;

        this.Persist();
        this.Close();
    }
    public void Cancel()
    {
        this.Close();
    }

    public string Description
    {
        get => this.descriptionTextBox.Text.Trim();
    }

    private void Persist()
    {
        string todayHeader = $"### {DateTime.Now.ToString("MMMM-dd", CultureInfo.InvariantCulture)}";

        var donePath = Extensions.GetDoneFile();

        var lines = File.ReadAllLines(donePath)
                       .ToInsertionList(GetFirstLineAfterHeader);

        bool appendHeader = !lines.Any(IsHeader);
        if (appendHeader)
        {
            lines.Add("");
            lines.Add(todayHeader);
        }
        lines.Add($"- {this.Description}");
        File.WriteAllLines(donePath, lines);


        int GetFirstLineAfterHeader(IReadOnlyList<string> existingLines)
        {
            bool foundHeader = false;
            foreach (var (line, index) in existingLines.Select((value, index) => (value, index)))
            {
                if (IsHeader(line))
                {
                    foundHeader = true;
                }
                else if (foundHeader && IsEmptyLine(line))
                {
                    return index;
                }
            }

            var lastNonEmptyLineIndex = existingLines.LastIndexOf(line => !IsEmptyLine(line));
            return lastNonEmptyLineIndex + 1;
        }

        bool IsHeader(string line)
        {
            return line.StartsWith(todayHeader);
        }
        static bool IsEmptyLine(string line)
        {
            return string.IsNullOrWhiteSpace(line)
                || line.StartsWith('-') && string.IsNullOrWhiteSpace(line[1..]);
        }
    }
}



static class Extensions
{
    public static string GetDoneFile()
    {
        string? value = ConfigurationManager.AppSettings.Get("DoneFile");
        if (value == null)
        {
            throw new ConfigurationErrorsException("Configuration 'DoneFile' not found in app.config");
        }
        value = Environment.ExpandEnvironmentVariables(value);
        if (!Path.IsPathFullyQualified(value))
        {
            throw new ConfigurationErrorsException("Configuration 'DoneFile' must be a full path");
        }

        var result = Path.GetFullPath(value);
        return result;
    }
    public static InsertionList<T> ToInsertionList<T>(this IEnumerable<T> sequence, Func<IReadOnlyList<T>, int> computeInsertionIndex)
    {
        var list = sequence.ToList();
        var insertionIndex = computeInsertionIndex(list);
        return new InsertionList<T>(list, insertionIndex);
    }
    public static InsertionList<T> ToInsertionList<T>(this IEnumerable<T> sequence, int insertionIndex)
    {
        return new InsertionList<T>(sequence.ToList(), insertionIndex);
    }
    public static int LastIndexOf<T>(this IReadOnlyCollection<T> sequence, Func<T, bool> predicate)
    {
        int index = sequence.Count - 1;
        foreach (var item in sequence.Reverse())
        {
            if (predicate(item))
            {
                return index;
            }
            index--;
        }
        return -1;
    }
}

class InsertionList<T> : IEnumerable<T>
{
    private readonly List<T> list;
    private readonly int insertionIndex;
    private int itemsInsertedCount = 0;

    public InsertionList(List<T> list, int insertionIndex)
    {
        if (insertionIndex > list.Count)
            throw new ArgumentOutOfRangeException(nameof(insertionIndex));

        this.list = list;
        this.insertionIndex = insertionIndex;
    }
    public void Add(T item)
    {
        this.list.Insert(insertionIndex + itemsInsertedCount, item);
        this.itemsInsertedCount++;
    }

    public IEnumerator<T> GetEnumerator()
    {
        return this.list.GetEnumerator();
    }
    IEnumerator IEnumerable.GetEnumerator()
    {
        return this.GetEnumerator();
    }
}
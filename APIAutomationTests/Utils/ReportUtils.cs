namespace APIAutomationTests.Utils
{
    using System.Text;
    using Allure.Commons;

    /// <summary>
    /// Defines methods to handle report data.
    /// </summary>
    public static class ReportUtils
    {
        /// <summary>
        /// Adds json data to report.
        /// </summary>
        /// <param name="name">Attachment name.</param>
        /// <param name="content">Attachment content.</param>
        public static void AddJsonData(string name, string content)
        {
            AllureLifecycle.Instance.AddAttachment(name, "application/json", Encoding.UTF8.GetBytes(content), "json");
        }
    }
}

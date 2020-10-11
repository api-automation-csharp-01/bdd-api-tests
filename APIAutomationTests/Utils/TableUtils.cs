namespace APIAutomationTests.Utils
{
    using System.Collections.Generic;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines table utils class.
    /// </summary>
    public static class TableUtils
    {
        /// <summary>
        /// Defines convert to dictionary method.
        /// </summary>
        /// <param name="table">Specflow table.</param>
        /// <returns>Dictionary.</returns>
        public static Dictionary<string, string> ConvertToDictionary(Table table)
        {
            var dictionary = new Dictionary<string, string>();
            foreach (var row in table.Rows)
            {
                dictionary.Add(row[0], row[1]);
            }

            return dictionary;
        }
    }
}

namespace APIAutomationCore.Utils
{
    using System.Collections.Generic;
    using System.Text.RegularExpressions;

    /// <summary>
    /// Defines Mapped utility class.
    /// </summary>
    public static class Mapper
    {
        /// <summary>
        /// Maps values according to stored data.
        /// </summary>
        /// <param name="value">Value to be mapped.</param>
        /// <param name="storedData">Stored data.</param>
        /// <returns>Mapped value.</returns>
        public static string MapValue(string value, Dictionary<string, string> storedData)
        {
            var regex = @"\{[A-Z_-]+}";
            MatchCollection matches = Regex.Matches(value, regex);
            foreach (Match match in matches)
            {
                foreach (Capture capture in match.Captures)
                {
                    Regex regexKeys = new Regex("[{}]");
                    string key = regexKeys.Replace(capture.Value, string.Empty);
                    if (storedData.ContainsKey(key))
                    {
                        value = value.Replace(capture.Value, storedData[key]);
                    }
                }
            }

            return value;
        }
    }
}

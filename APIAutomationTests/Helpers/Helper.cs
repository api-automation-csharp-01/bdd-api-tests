namespace APIAutomationTests.Helpers
{
    using System.Collections.Generic;

    /// <summary>
    /// Helper utility class.
    /// </summary>
    public class Helper
    {
        private List<string> ids;
        private Dictionary<string, string> data;

        /// <summary>
        /// Initializes a new instance of the <see cref="Helper"/> class.
        /// </summary>
        public Helper()
        {
            CleanHelper();
        }

        /// <summary>
        /// Cleans helper data.
        /// </summary>
        public void CleanHelper()
        {
            ids = new List<string>();
            data = new Dictionary<string, string>();
        }

        /// <summary>
        /// Stores id data.
        /// </summary>
        /// <param name="id">Id value.</param>
        public void StoreId(string id)
        {
            ids.Add(id);
        }

        /// <summary>
        /// Gets ids data.
        /// </summary>
        /// <returns>Ids data.</returns>
        public List<string> GetIds()
        {
            return ids;
        }

        /// <summary>
        /// Stores data.
        /// </summary>
        /// <param name="key">Key identifier.</param>
        /// <param name="value">Value to be stored.</param>
        public void StoreData(string key, string value)
        {
            data.Add(key, value);
        }

        /// <summary>
        /// Gets stored data.
        /// </summary>
        /// <returns>Stored data.</returns>
        public Dictionary<string, string> GetData()
        {
            return data;
        }
    }
}

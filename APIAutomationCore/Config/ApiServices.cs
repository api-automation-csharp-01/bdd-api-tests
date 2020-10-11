namespace APIAutomationCore.Config
{
    using Newtonsoft.Json;

    /// <summary>
    /// Defines API service class.
    /// </summary>
    public class ApiServices
    {
        /// <summary>
        /// Gets or sets pivotal config.
        /// </summary>
        [JsonProperty("pivotal")]
        public ApiConfig Pivotal { get; set; }

        /// <summary>
        /// Gets or sets trello config.
        /// </summary>
        [JsonProperty("trello")]
        public ApiConfig Trello { get; set; }

        /// <summary>
        /// Gets or sets todoist config.
        /// </summary>
        [JsonProperty("todoist")]
        public ApiConfig Todoist { get; set; }

        /// <summary>
        /// Gets or sets salesforce config.
        /// </summary>
        [JsonProperty("salesforce")]
        public ApiConfig Salesforce { get; set; }
    }
}

namespace APIAutomationCore.Config
{
    using Newtonsoft.Json;

    /// <summary>
    /// Defines API config class.
    /// </summary>
    public class ApiConfig
    {
        /// <summary>
        /// Gets or sets token.
        /// </summary>
        [JsonProperty("token")]
        public string Token { get; set; }

        /// <summary>
        /// Gets or sets key.
        /// </summary>
        [JsonProperty("key")]
        public string Key { get; set; }

        /// <summary>
        /// Gets or sets base url.
        /// </summary>
        [JsonProperty("baseURL")]
        public string BaseUrl { get; set; }

        /// <summary>
        /// Gets or sets authentication URL.
        /// </summary>
        [JsonProperty("authenticationUrl")]
        public string AuthenticationUrl { get; set; }

        /// <summary>
        /// Gets or sets client id.
        /// </summary>
        [JsonProperty("clientId")]
        public string ClientId { get; set; }

        /// <summary>
        /// Gets or sets client secret.
        /// </summary>
        [JsonProperty("clientSecret")]
        public string ClientSecret { get; set; }

        /// <summary>
        /// Gets or sets secret token.
        /// </summary>
        [JsonProperty("secretToken")]
        public string SecretToken { get; set; }

        /// <summary>
        /// Gets or sets username.
        /// </summary>
        [JsonProperty("username")]
        public string Username { get; set; }

        /// <summary>
        /// Gets or sets password.
        /// </summary>
        [JsonProperty("password")]
        public string Password { get; set; }
    }
}

namespace APIAutomationCore.Config
{
    using System.IO;
    using APIAutomationCore.Client;
    using Microsoft.Extensions.Configuration;

    /// <summary>
    /// Defines environment config class.
    /// </summary>
    public sealed class EnvironmentConfig
    {
        private static EnvironmentConfig instance;
        private ApiServices apiServices;

        private EnvironmentConfig()
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("TestSettings.json")
                .Build();
            apiServices = builder.Get<ApiServices>();
        }

        /// <summary>
        /// Gets singleton instance.
        /// </summary>
        /// <returns>Singleton instance.</returns>
        public static EnvironmentConfig GetInstance()
        {
            if (instance == null)
            {
                instance = new EnvironmentConfig();
            }

            return instance;
        }

        /// <summary>
        /// Gets token value.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <returns>Token value.</returns>
        public string GetToken(ApisEnum service)
        {
            return GetConfig(service).Token;
        }

        /// <summary>
        /// Gets key value.
        /// </summary>
        /// <param name="service"> API service.</param>
        /// <returns>Key value.</returns>
        public string GetKey(ApisEnum service)
        {
            return GetConfig(service).Key;
        }

        /// <summary>
        /// Gets base url value.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <returns>Base url value.</returns>
        public string GetBaseUrl(ApisEnum service)
        {
            return GetConfig(service).BaseUrl;
        }

        /// <summary>
        /// Gets API config value.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <returns>API config object.</returns>
        public ApiConfig GetConfig(ApisEnum service)
        {
            var config = new ApiConfig();
            switch (service)
            {
                case ApisEnum.Pivotal:
                    config = apiServices.Pivotal;
                    break;
                case ApisEnum.Trello:
                    config = apiServices.Trello;
                    break;
                case ApisEnum.Todoist:
                    config = apiServices.Todoist;
                    break;
                case ApisEnum.Salesforce:
                    config = apiServices.Salesforce;
                    break;
            }

            return config;
        }
    }
}

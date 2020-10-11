namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines Pivotal API client.
    /// </summary>
    public sealed class PivotalClient : IClient
    {
        private static PivotalClient instance;
        private readonly RestClient client;

        private PivotalClient()
        {
            client = new RestClient(EnvironmentConfig.GetInstance().GetBaseUrl(ApisEnum.Pivotal));
        }

        /// <summary>
        /// Gets singleton instance.
        /// </summary>
        /// <returns>Client singleton instance.</returns>
        public static PivotalClient GetInstance()
        {
            if (instance == null)
            {
                instance = new PivotalClient();
            }

            return instance;
        }

        /// <summary>
        /// Gets rest client instance.
        /// </summary>
        /// <returns>rest client instance.</returns>
        public RestClient GetClient()
        {
            return client;
        }
    }
}

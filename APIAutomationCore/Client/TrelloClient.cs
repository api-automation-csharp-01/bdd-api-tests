namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines Trello api client class.
    /// </summary>
    public sealed class TrelloClient : IClient
    {
        private static TrelloClient instance;
        private readonly RestClient client;

        private TrelloClient()
        {
            client = new RestClient(EnvironmentConfig.GetInstance().GetBaseUrl(ApisEnum.Trello));
        }

        /// <summary>
        /// Gets singleton instance.
        /// </summary>
        /// <returns>Singleton instance.</returns>
        public static TrelloClient GetInstance()
        {
            if (instance == null)
            {
                instance = new TrelloClient();
            }

            return instance;
        }

        /// <summary>
        /// Gets rest client object.
        /// </summary>
        /// <returns>Rest client object.</returns>
        public RestClient GetClient()
        {
            return client;
        }
    }
}

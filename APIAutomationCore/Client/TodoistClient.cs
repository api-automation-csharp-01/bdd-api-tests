namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines Todoist client.
    /// </summary>
    public class TodoistClient : IClient
    {
        private static TodoistClient instance;
        private readonly RestClient client;

        /// <summary>
        /// Initializes a new instance of the <see cref="TodoistClient"/> class.
        /// </summary>
        private TodoistClient()
        {
            client = new RestClient(EnvironmentConfig.GetInstance().GetBaseUrl(ApisEnum.Todoist));
        }

        /// <summary>
        /// Gets singleton instance.
        /// </summary>
        /// <returns>Singleton instance.</returns>
        public static TodoistClient GetInstance()
        {
            if (instance == null)
            {
                instance = new TodoistClient();
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

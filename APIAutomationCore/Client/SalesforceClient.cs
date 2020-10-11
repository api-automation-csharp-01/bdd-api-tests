namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using APIAutomationCore.Utils;
    using RestSharp;

    /// <summary>
    /// Defines salesforce client class.
    /// </summary>
    public class SalesforceClient : IClient
    {
        private static SalesforceClient instance;
        private readonly RestClient client;

        /// <summary>
        /// Initializes a new instance of the <see cref="SalesforceClient"/> class.
        /// </summary>
        private SalesforceClient()
        {
            client = new RestClient(SalesforceAuthenticator.GetInstance().GetInstanceUrl()
                                    + EnvironmentConfig.GetInstance().GetBaseUrl(ApisEnum.Salesforce));
        }

        /// <summary>
        /// Gets singleton instance.
        /// </summary>
        /// <returns>Singleton instance.</returns>
        public static SalesforceClient GetInstance()
        {
            if (instance == null)
            {
                instance = new SalesforceClient();
            }

            return instance;
        }

        /// <summary>
        /// Gets client object.
        /// </summary>
        /// <returns>Client object.</returns>
        public RestClient GetClient()
        {
            return client;
        }
    }
}

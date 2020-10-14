namespace APIAutomationCore.Utils
{
    using APIAutomationCore.Client;
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines Sales force authenticator utility class.
    /// </summary>
    public class SalesforceAuthenticator
    {
        private static SalesforceAuthenticator instance;
        private readonly string token;
        private readonly string instanceUrl;

        private SalesforceAuthenticator()
        {
            var client =
                new RestClient(EnvironmentConfig.GetInstance().GetConfig(ApisEnum.Salesforce).AuthenticationUrl);
            var request = new RestRequest("/services/oauth2/token", Method.POST);
            request.AddQueryParameter("grant_type", "password");
            request.AddQueryParameter(
                "client_id",
                EnvironmentConfig.GetInstance().GetConfig(ApisEnum.Salesforce).ClientId);
            request.AddQueryParameter(
                "client_secret",
                EnvironmentConfig.GetInstance().GetConfig(ApisEnum.Salesforce).ClientSecret);
            request.AddQueryParameter(
                "username",
                EnvironmentConfig.GetInstance().GetConfig(ApisEnum.Salesforce).Username);
            request.AddQueryParameter(
                "password",
                EnvironmentConfig.GetInstance().GetConfig(ApisEnum.Salesforce).Password + EnvironmentConfig.GetInstance().GetConfig(ApisEnum.Salesforce).SecretToken);
            Response response = new Response(client.Execute(request));
            token = response.GetValue("access_token");
            instanceUrl = response.GetValue("instance_url");
        }

        /// <summary>
        /// Gets singleton instance.
        /// </summary>
        /// <returns>Singleton instance.</returns>
        public static SalesforceAuthenticator GetInstance()
        {
            if (instance == null)
            {
                instance = new SalesforceAuthenticator();
            }

            return instance;
        }

        /// <summary>
        /// Gets token value.
        /// </summary>
        /// <returns>Token value.</returns>
        public string GetToken()
        {
            return token;
        }

        /// <summary>
        /// Gets instance url value.
        /// </summary>
        /// <returns>instance url value.</returns>
        public string GetInstanceUrl()
        {
            return instanceUrl;
        }
    }
}

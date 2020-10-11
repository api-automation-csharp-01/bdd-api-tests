namespace APIAutomationCore.Client
{
    /// <summary>
    /// Defines Client factory utility class.
    /// </summary>
    public static class ClientFactory
    {
        /// <summary>
        /// Builds client according to parameter.
        /// </summary>
        /// <param name="service">API service enum.</param>
        /// <returns>Client instance.</returns>
        public static IClient GetClient(ApisEnum service)
        {
            IClient client;
            switch (service)
            {
                case ApisEnum.Pivotal:
                    client = PivotalClient.GetInstance();
                    break;
                case ApisEnum.Trello:
                    client = TrelloClient.GetInstance();
                    break;
                case ApisEnum.Todoist:
                    client = TodoistClient.GetInstance();
                    break;
                case ApisEnum.Salesforce:
                    client = SalesforceClient.GetInstance();
                    break;
                default:
                    client = PivotalClient.GetInstance();
                    break;
            }

            return client;
        }
    }
}
namespace APIAutomationCore.Client
{
    /// <summary>
    /// Defines request factory utility class.
    /// </summary>
    public static class RequestFactory
    {
        /// <summary>
        /// Builds rest request instances according to parameter.
        /// </summary>
        /// <param name="service">API service enum.</param>
        /// <param name="resource">Enpoint resource.</param>
        /// <returns>rest request instance.</returns>
        public static IRequest GetRequest(ApisEnum service, string resource)
        {
            IRequest request;
            switch (service)
            {
                case ApisEnum.Pivotal:
                    request = new PivotalRequest(resource);
                    break;
                case ApisEnum.Trello:
                    request = new TrelloRequest(resource);
                    break;
                case ApisEnum.Todoist:
                    request = new TodoistRequest(resource);
                    break;
                case ApisEnum.Salesforce:
                    request = new SalesforceRequest(resource);
                    break;
                default:
                    request = new PivotalRequest(resource);
                    break;
            }

            return request;
        }
    }
}

namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines trello request object.
    /// </summary>
    public class TrelloRequest : IRequest
    {
        private readonly RestRequest request;

        /// <summary>
        /// Initializes a new instance of the <see cref="TrelloRequest"/> class.
        /// </summary>
        /// <param name="resource">Endpoint resource.</param>
        public TrelloRequest(string resource)
        {
            request = new RestRequest();
            request.AddQueryParameter("key", EnvironmentConfig.GetInstance().GetKey(ApisEnum.Trello));
            request.AddQueryParameter("token", EnvironmentConfig.GetInstance().GetToken(ApisEnum.Trello));
            request.Resource = resource;
        }

        /// <summary>
        /// Gets request object.
        /// </summary>
        /// <returns>Request object.</returns>
        public RestRequest GetRequest()
        {
            return request;
        }
    }
}

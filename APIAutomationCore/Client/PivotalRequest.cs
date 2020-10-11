namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines Pivotal API request object.
    /// </summary>
    public class PivotalRequest : IRequest
    {
        private readonly RestRequest request;

        /// <summary>
        /// Initializes a new instance of the <see cref="PivotalRequest"/> class.
        /// </summary>
        /// <param name="resource">Endpoint resource.</param>
        public PivotalRequest(string resource)
        {
            request = new RestRequest();
            request.AddHeader("X-TrackerToken", EnvironmentConfig.GetInstance().GetToken(ApisEnum.Pivotal));
            request.Resource = resource;
        }

        /// <summary>
        /// Gets rest request instance.
        /// </summary>
        /// <returns>rest request instance.</returns>
        public RestRequest GetRequest()
        {
            return request;
        }
    }
}

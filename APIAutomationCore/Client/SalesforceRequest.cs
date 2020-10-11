namespace APIAutomationCore.Client
{
    using APIAutomationCore.Utils;
    using RestSharp;

    /// <summary>
    /// Defines salesforce request class.
    /// </summary>
    public class SalesforceRequest : IRequest
    {
        private readonly RestRequest request;

        /// <summary>
        /// Initializes a new instance of the <see cref="SalesforceRequest"/> class.
        /// </summary>
        /// <param name="resource">Endpoint resource.</param>
        public SalesforceRequest(string resource)
        {
            request = new RestRequest();
            request.AddHeader("Authorization", "Bearer " + SalesforceAuthenticator.GetInstance().GetToken());
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

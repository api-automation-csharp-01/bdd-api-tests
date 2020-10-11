namespace APIAutomationCore.Client
{
    using APIAutomationCore.Config;
    using RestSharp;

    /// <summary>
    /// Defines Todois request object.
    /// </summary>
    public class TodoistRequest : IRequest
    {
        private readonly RestRequest request;

        /// <summary>
        /// Initializes a new instance of the <see cref="TodoistRequest"/> class.
        /// </summary>
        /// <param name="resource">Endpoint resource.</param>
        public TodoistRequest(string resource)
        {
            request = new RestRequest();
            request.AddHeader(
                "Authorization",
                "Bearer " + EnvironmentConfig.GetInstance().GetToken(ApisEnum.Todoist));
            request.Resource = resource;
        }

        /// <summary>
        /// Gets reques object.
        /// </summary>
        /// <returns>Request object.</returns>
        public RestRequest GetRequest()
        {
            return request;
        }
    }
}

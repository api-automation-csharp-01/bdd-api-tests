namespace APIAutomationCore.Client
{
    using RestSharp;

    /// <summary>
    /// Defines Request Manager utility class.
    /// </summary>
    public static class RequestManager
    {
        /// <summary>
        /// Sends GET request.
        /// </summary>
        /// <param name="client">Rest client.</param>
        /// <param name="request">Rest request.</param>
        /// <returns>Response object.</returns>
        public static Response Get(IClient client, IRequest request)
        {
            request.GetRequest().Method = Method.GET;
            return new Response(client.GetClient().Execute(request.GetRequest()));
        }

        /// <summary>
        /// Sends POST request.
        /// </summary>
        /// <param name="client">Rest client.</param>
        /// <param name="request">Rest request.</param>
        /// <returns>Response object.</returns>
        public static Response Post(IClient client, IRequest request)
        {
            request.GetRequest().Method = Method.POST;
            return new Response(client.GetClient().Execute(request.GetRequest()));
        }

        /// <summary>
        /// Sends PUT request.
        /// </summary>
        /// <param name="client">Rest client.</param>
        /// <param name="request">Rest request.</param>
        /// <returns>Response object.</returns>
        public static Response Put(IClient client, IRequest request)
        {
            request.GetRequest().Method = Method.PUT;
            return new Response(client.GetClient().Execute(request.GetRequest()));
        }

        /// <summary>
        /// Sends Patch request.
        /// </summary>
        /// <param name="client">Rest client.</param>
        /// <param name="request">Rest request.</param>
        /// <returns>Response object.</returns>
        public static Response Patch(IClient client, IRequest request)
        {
            request.GetRequest().Method = Method.PATCH;
            return new Response(client.GetClient().Execute(request.GetRequest()));
        }

        /// <summary>
        /// Sends Delete request.
        /// </summary>
        /// <param name="client">Rest client.</param>
        /// <param name="request">Rest request.</param>
        /// <returns>Response object.</returns>
        public static Response Delete(IClient client, IRequest request)
        {
            request.GetRequest().Method = Method.DELETE;
            return new Response(client.GetClient().Execute(request.GetRequest()));
        }
    }
}

namespace APIAutomationCore.Client
{
    using RestSharp;

    /// <summary>
    /// API client interface.
    /// </summary>
    public interface IClient
    {
        /// <summary>
        /// Gets API client instance.
        /// </summary>
        /// <returns>API client instance.</returns>
        RestClient GetClient();
    }
}

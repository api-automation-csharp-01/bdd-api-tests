namespace APIAutomationCore.Client
{
    using RestSharp;

    /// <summary>
    /// Defines API request interface.
    /// </summary>
    public interface IRequest
    {
        /// <summary>
        /// Gets API request instance.
        /// </summary>
        /// <returns>API request instance.</returns>
        RestRequest GetRequest();
    }
}

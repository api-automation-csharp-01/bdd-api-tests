namespace APIAutomationCore.Client
{
    using Newtonsoft.Json.Linq;
    using RestSharp;

    /// <summary>
    /// Defines response object.
    /// </summary>
    public class Response
    {
        private readonly IRestResponse response;
        private readonly JObject jObject;
        private readonly JArray jArray;

        /// <summary>
        /// Initializes a new instance of the <see cref="Response"/> class.
        /// </summary>
        /// <param name="response">Rest response object.</param>
        public Response(IRestResponse response)
        {
            this.response = response;
            if (!string.IsNullOrEmpty(response.Content))
            {
                if (response.Content.StartsWith("["))
                {
                    jArray = JArray.Parse(response.Content);
                }
                else
                {
                    jObject = JObject.Parse(response.Content);
                }
            }
            else
            {
                jArray = new JArray();
                jObject = new JObject();
            }
        }

        /// <summary>
        /// Gets status code from response.
        /// </summary>
        /// <returns>Status code.</returns>
        public int GetStatusCode()
        {
            return (int)response.StatusCode;
        }

        /// <summary>
        /// Gets value from response using jsonpath expression.
        /// </summary>
        /// <param name="jsonPath">Jsonpath expression.</param>
        /// <returns>Response value.</returns>
        public string GetValue(string jsonPath)
        {
            JToken value = null;
            if (jsonPath.StartsWith("["))
            {
                value = jArray.SelectToken(jsonPath);
            }
            else
            {
                value = jObject.SelectToken(jsonPath);
            }

            return value is null ? string.Empty : value.ToString();
        }

        /// <summary>
        /// Gets response json object.
        /// </summary>
        /// <returns>Json object.</returns>
        public JObject GetJsonJObject()
        {
            return jObject;
        }

        /// <summary>
        /// Gest response json array.
        /// </summary>
        /// <returns>Json array.</returns>
        public JArray GetJsonJArray()
        {
            return jArray;
        }

        /// <summary>
        /// Gets response object.
        /// </summary>
        /// <returns>response object.</returns>
        public IRestResponse GetResponse()
        {
            return response;
        }
    }
}

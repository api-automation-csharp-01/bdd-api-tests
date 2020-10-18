[assembly: NUnit.Framework.Parallelizable(NUnit.Framework.ParallelScope.Fixtures)]
[assembly: NUnit.Framework.LevelOfParallelism(1)]

namespace APIAutomationTests.Steps
{
    using APIAutomationCore.Client;
    using APIAutomationCore.Utils;
    using APIAutomationTests.Helpers;
    using APIAutomationTests.Utils;
    using NUnit.Framework;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines request step definitions.
    /// </summary>
    [Binding]
    public sealed class RequestStepDefinitions
    {
        private IClient client;
        private Helper helper;
        private Response response;

        /// <summary>
        /// Initializes a new instance of the <see cref="RequestStepDefinitions"/> class.
        /// </summary>
        /// <param name="helper">Helper object.</param>
        public RequestStepDefinitions(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Sets client to be used.
        /// </summary>
        /// <param name="service">API service.</param>
        [Given(@"I use the ""(.*)"" (?:service|api) client")]
        public void GivenIUseTheServiceClient(ApisEnum service)
        {
            client = ClientFactory.GetClient(service);
        }

        /// <summary>
        /// Sends GET request.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <param name="endpoint">Endpoint.</param>
        [When(@"I send a ""(.*)"" GET request to ""(.*)""")]
        public void WhenISendGetRequest(ApisEnum service, string endpoint)
        {
            string endpointMapped = Mapper.MapValue(endpoint, helper.GetData());
            IRequest request = RequestFactory.GetRequest(service, endpointMapped);
            response = RequestManager.Get(client, request);
        }

        /// <summary>
        /// Sends DELETE request.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <param name="endpoint">Endpoint.</param>
        [When(@"I send a ""(.*)"" DELETE request to ""(.*)""")]
        public void WhenISendDeleteRequest(ApisEnum service, string endpoint)
        {
            string endpointMapped = Mapper.MapValue(endpoint, helper.GetData());
            IRequest request = RequestFactory.GetRequest(service, endpointMapped);
            response = RequestManager.Delete(client, request);
        }

        /// <summary>
        /// Sends POST request.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <param name="endpoint">Endpoint.</param>
        /// <param name="body">Request body.</param>
        [When(@"I send a ""(.*)"" POST request to ""(.*)"" with the following json body")]
        public void WhenISendPostRequest(ApisEnum service, string endpoint, string body)
        {
            string endpointMapped = Mapper.MapValue(endpoint, helper.GetData());
            string bodyMapped = Mapper.MapValue(body, helper.GetData());
            IRequest request = RequestFactory.GetRequest(service, endpointMapped);
            request.GetRequest().AddJsonBody(bodyMapped);
            response = RequestManager.Post(client, request);
            ReportUtils.AddJsonData("Request body", bodyMapped);
            ReportUtils.AddJsonData("Response body", response.GetResponse().Content);
        }

        /// <summary>
        /// Sends PUT request.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <param name="endpoint">Endpoint.</param>
        /// <param name="body">Request body.</param>
        [When(@"I send a ""(.*)"" PUT request to ""(.*)"" with the following json body")]
        public void WhenISendPutRequest(ApisEnum service, string endpoint, string body)
        {
            string endpointMapped = Mapper.MapValue(endpoint, helper.GetData());
            string bodyMapped = Mapper.MapValue(body, helper.GetData());
            IRequest request = RequestFactory.GetRequest(service, endpointMapped);
            request.GetRequest().AddJsonBody(bodyMapped);
            response = RequestManager.Put(client, request);
            ReportUtils.AddJsonData("Request body", bodyMapped);
            ReportUtils.AddJsonData("Response body", response.GetResponse().Content);
        }

        /// <summary>
        /// Sends PATCH request.
        /// </summary>
        /// <param name="service">API service.</param>
        /// <param name="endpoint">Endpoint.</param>
        /// <param name="body">Request body.</param>
        [When(@"I send a ""(.*)"" PATCH request to ""(.*)"" with the following json body")]
        public void WhenISendPatchRequest(ApisEnum service, string endpoint, string body)
        {
            string endpointMapped = Mapper.MapValue(endpoint, helper.GetData());
            string bodyMapped = Mapper.MapValue(body, helper.GetData());
            IRequest request = RequestFactory.GetRequest(service, endpointMapped);
            request.GetRequest().AddJsonBody(bodyMapped);
            response = RequestManager.Patch(client, request);
            ReportUtils.AddJsonData("Request body", bodyMapped);
            ReportUtils.AddJsonData("Response body", response.GetResponse().Content);
        }

        /// <summary>
        /// Stored project ID for deleting.
        /// </summary>
        [When(@"I store (?:project|response) id for workspace cleaning")]
        public void WhenIStoreProjectIdForWorkspaceCleaning()
        {
            helper.StoreId(response.GetValue("id"));
        }

        /// <summary>
        /// Stored project ID for deleting.
        /// </summary>
        [StepDefinition(@"I store response id for cleaning environment")]
        public void StoreIdToCleaningEnvironment()
        {
            helper.StoreId(response.GetValue("id"));
        }

        /// <summary>
        /// Stored campaign ID for deleting.
        /// </summary>
        [When(@"I store campaign id for workspace cleaning")]
        public void WhenIStoreCampaignIdForWorkspaceCleaning()
        {
            helper.StoreId(response.GetValue("id"));
        }

        /// <summary>
        /// Stores data from response.
        /// </summary>
        /// <param name="jsonpath">Jsonpath expression.</param>
        /// <param name="key">Key identifier.</param>
        [When(@"I store response ""(.*)"" value as ""(.*)""")]
        public void WhenIStoreResponseValueAs(string jsonpath, string key)
        {
            var value = response.GetValue(jsonpath);
            helper.StoreData(key, value);
        }

        /// <summary>
        /// Validates response status code.
        /// </summary>
        /// <param name="expectedStatusCode">Expected status code.</param>
        [Then(@"I validate that the response status code is ""(\d+)""")]
        public void ThenIValidateThatTheResponseStatusCodeIs(int expectedStatusCode)
        {
            Assert.AreEqual(expectedStatusCode, response.GetStatusCode(), "Expected status does not match.");
        }

        /// <summary>
        /// Validates json schema.
        /// </summary>
        /// <param name="schemaPath">Json schema path.</param>
        [Then(@"I validate that the response body match ""(.*)"" JSON schema")]
        public void ThenIValidateThatTheResponseBodyMatchJsonSchema(string schemaPath)
        {
            AssertUtils.AssertJsonSchema(response, schemaPath);
        }

        /// <summary>
        /// Validates response body content.
        /// </summary>
        /// <param name="table">Expected values.</param>
        [Then(@"I validate that the response body contains the following values")]
        public void ThenIValidateThatTheResponseBodyContainsTheFollowingValues(Table table)
        {
            var dictionary = TableUtils.ConvertToDictionary(table);
            var fieldsMapped = Mapper.MapValues(dictionary, helper.GetData());
            AssertUtils.AssertExpectedValues(response, fieldsMapped);
        }

        /// <summary>
        /// stored label Id for deleting.
        /// </summary>
        [Then(@"I store label id for workspace cleaning")]
        public void ThenIStoreLabelIdForWorkspaceCleaning()
        {
            helper.StoreId(response.GetValue("id"));
        }

        /// <summary>
        /// Stores data from response.
        /// </summary>
        /// <param name="jsonpath">jsonpath expression.</param>
        /// <param name="key">Key identifier.</param>
        [Then(@"I store response ""(.*)"" value as ""(.*)""")]
        public void ThenIStoreResponseValueAs(string jsonpath, string key)
        {
            var value = response.GetValue(jsonpath);
            helper.StoreData(key, value);
        }
    }
}

namespace APIAutomationTests.Hooks.Salesforce
{
    using APIAutomationCore.Client;
    using APIAutomationCore.Utils;
    using APIAutomationTests.Helpers;
    using Google.Protobuf.WellKnownTypes;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines account hooks class.
    /// </summary>
    [Binding]
    public class AccountHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountHooks"/> class.
        /// </summary>
        /// <param name="helper">Helper class.</param>
        public AccountHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Deleted Account.
        /// </summary>
        [AfterScenario(Order = 100)]
        [Scope(Tag = "deleteSalesforceAccount")]
        public void DeleteAccount()
        {
            foreach (string id in helper.GetIds())
            {
                var request = new SalesforceRequest($"Account/{id}");
                RequestManager.Delete(SalesforceClient.GetInstance(), request);
            }
        }

        /// <summary>
        /// Create Account.
        /// </summary>
        [BeforeScenario(Order = 100)]
        [Scope(Tag = "createSalesforceAccount")]
        public void CreateAccount()
        {
            string endpointMapped = Mapper.MapValue("Account", helper.GetData());
            var jsonRequest = new
            {
                name = "Hook Account Sales Force",
            };
            IRequest request = RequestFactory.GetRequest(ApisEnum.Salesforce, endpointMapped);
            request.GetRequest().AddJsonBody(jsonRequest);
            var response = RequestManager.Post(SalesforceClient.GetInstance(), request);
            var value = response.GetValue("id");
            helper.StoreData("ACCOUNT_ID_HOOK", value);
            helper.StoreId(value);
        }
    }
}

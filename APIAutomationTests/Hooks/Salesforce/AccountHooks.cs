namespace APIAutomationTests.Hooks.Salesforce
{
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
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
        public void DeleteProject()
        {
            foreach (string id in helper.GetIds())
            {
                var request = new SalesforceRequest($"Account/{id}");
                RequestManager.Delete(SalesforceClient.GetInstance(), request);
            }
        }
    }
}

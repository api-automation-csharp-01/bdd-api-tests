namespace APIAutomationTests.Hooks.Salesforce
{
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines campaign hooks class.
    /// </summary>
    [Binding]
    public class CampaignHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="CampaignHooks"/> class.
        /// </summary>
        /// <param name="helper">Helper class.</param>
        public CampaignHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Deleted project.
        /// </summary>
        [AfterScenario(Order = 100)]
        [Scope(Tag = "deleteSalesforceCampaign")]
        public void DeleteCampaign()
        {
            foreach (string id in helper.GetIds())
            {
                var request = new SalesforceRequest($"Campaign/{id}");
                RequestManager.Delete(SalesforceClient.GetInstance(), request);
            }
        }
    }
}
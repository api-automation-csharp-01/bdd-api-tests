namespace APIAutomationTests.Hooks.Salesforce
{
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines project hooks class.
    /// </summary>
    [Binding]
    public class GroupHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="GroupHooks"/> class.
        /// </summary>
        /// <param name="helper">Helper class.</param>
        public GroupHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Deleted project.
        /// </summary>
        [AfterScenario(Order = 100)]
        [Scope(Tag = "deleteSalesforceGroup")]
        public void DeleteGroup()
        {
            foreach (string id in helper.GetIds())
            {
                var request = new SalesforceRequest("group/" + id);
                RequestManager.Delete(SalesforceClient.GetInstance(), request);
            }
        }
    }
}

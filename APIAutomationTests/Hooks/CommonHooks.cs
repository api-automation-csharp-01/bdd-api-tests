namespace APIAutomationTests.Hooks
{
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines common hooks class.
    /// </summary>
    [Binding]
    public class CommonHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="CommonHooks"/> class.
        /// </summary>
        /// <param name="helper">Helper object.</param>
        public CommonHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Cleans helper data.
        /// </summary>
        [AfterScenario(Order = 10000)]
        public void CleanHelper()
        {
            helper.CleanHelper();
        }
    }
}

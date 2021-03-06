namespace APIAutomationTests.Hooks
{
    using APIAutomationTests.Helpers;
    using NUnit.Framework;
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

        /// <summary>
        /// Handles scenario context data.
        /// </summary>
        /// <param name="scenarioContext">Specflow scenario context.</param>
        [AfterScenario(Order = 10001)]
        public void ScenarioContextHook(ScenarioContext scenarioContext)
        {
            ScenarioContext context = scenarioContext;
        }

        /// <summary>
        /// Skips test scenario.
        /// </summary>
        /// <param name="scenarioContext">Specflow scenario context.</param>
        [BeforeScenario(Order = 0)]
        [Scope(Tag = "skipScenario")]
        public void SkipScenario(ScenarioContext scenarioContext)
        {
            Assert.Ignore($"The '{scenarioContext.ScenarioInfo.Title}' test was skipped.");
        }
    }
}

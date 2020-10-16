namespace APIAutomationTests.Hooks.Trello
{
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Class to handle specifi handles.
    /// </summary>
    [Binding]
    public sealed class BoardHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="BoardHooks"/> class.
        /// </summary>
        /// <param name="helper"> Instance that handles ids.</param>
        public BoardHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// RunThis to cleanup boards.
        /// </summary>
        [AfterScenario(Order = 101)]
        [Scope(Tag = "deleteTrelloBoard")]
        public void AfterScenario()
        {
            foreach (var id in helper.GetIds())
            {
                var request = new TrelloRequest("boards/" + id);

                RequestManager.Delete(TrelloClient.GetInstance(), request);
            }
        }
    }
}

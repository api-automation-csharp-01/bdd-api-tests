namespace APIAutomationTests.Hooks.Trello
{
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines boards hooks class.
    /// </summary>
    [Binding]
    public class BoardHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="BoardHooks"/> class.
        /// </summary>
        /// <param name="helper">Helper class.</param>
        public BoardHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Create board.
        /// </summary>
        [BeforeScenario(Order = 1)]
        [Scope(Tag = "createTrelloBoard")]
        public void CreateBoard()
        {
            var request = new TrelloRequest(resource: "boards");
            var requestBody = $"{{\"name\": \"Board created\"}}";
            request.GetRequest().AddJsonBody(requestBody);

            // Send Request
            var response = RequestManager.Post(TrelloClient.GetInstance(), request);

            // Parse response to json object
            helper.StoreId(response.GetValue("id"));
            helper.StoreData("BOARD_ID", response.GetValue("id"));
        }

        /// <summary>
        /// Delete board.
        /// </summary>
        [AfterScenario(Order = 100)]
        [Scope(Tag = "deleteTrelloBoard")]
        public void DeleteBoard()
        {
            foreach (string id in helper.GetIds())
            {
                var request = new TrelloRequest(resource: "boards/" + id);
                RequestManager.Delete(TrelloClient.GetInstance(), request);
            }
        }
    }
}

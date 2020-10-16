﻿namespace APIAutomationTests.Hooks.Trello
{
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// This class have the common hook for trello.
    /// </summary>
    [Binding]
    public class BoardHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="BoardHooks"/> class.
        ///  Initializes a new instance for BoardHooks class.
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
        [Scope(Tag = "createBoard")]
        public void CreateBoard()
        {
            var request = new TrelloRequest(resource: "boards");
            var requestBody = @"{
                ""name"":""myFirstTestBoard""
            }";
            request.GetRequest().AddJsonBody(requestBody);

            // Send request
            var response = RequestManager.Post(TrelloClient.GetInstance(), request);

            // Parse response to json object
            helper.StoreId(response.GetValue("id"));
            helper.StoreData("BOARD_ID", response.GetValue("id"));
        }

        /// <summary>
        /// Create label.
        /// </summary>
        [BeforeScenario(Order = 1)]
        [Scope(Tag = "createLabel")]
        public void CreateLabel()
        {
            var request = new TrelloRequest(resource: "boards/{BOARD_ID}/labels");
            var requestBody = @"{
                ""name"":""myFirstTestLabel""
            }";
            request.GetRequest().AddJsonBody(requestBody);

            // Send request
            var response = RequestManager.Post(TrelloClient.GetInstance(), request);

            // Parse response to json object
            helper.StoreId(response.GetValue("id"));
            helper.StoreData("LABEL_ID", response.GetValue("id"));
        }

        /// <summary>
        /// Delete a board.
        /// </summary>
        [AfterScenario(Order = 100)]
        [Scope(Tag = "deleteBoard")]
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

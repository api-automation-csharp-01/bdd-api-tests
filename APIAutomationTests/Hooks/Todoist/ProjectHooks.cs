namespace APIAutomationTests.Hooks.Todoist
{
    using System;
    using System.Collections.Generic;
    using System.Text;
    using APIAutomationCore.Client;
    using APIAutomationTests.Helpers;
    using TechTalk.SpecFlow;

    /// <summary>
    /// Defines project hooks class.
    /// </summary>
    [Binding]
    public class ProjectHooks
    {
        private Helper helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectHooks"/> class.
        /// </summary>
        /// <param name="helper">Helper class.</param>
        public ProjectHooks(Helper helper)
        {
            this.helper = helper;
        }

        /// <summary>
        /// Deleted project.
        /// </summary>
        [AfterScenario(Order = 100)]
        [Scope(Tag = "deleteTodoistProject")]
        public void DeleteProject()
        {
            foreach (string id in helper.GetIds())
            {
                var request = new TodoistRequest("projects/" + id);
                RequestManager.Delete(TodoistClient.GetInstance(), request);
            }
        }
    }
}

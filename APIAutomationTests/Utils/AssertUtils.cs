namespace APIAutomationTests.Utils
{
    using System.Collections.Generic;
    using System.IO;
    using APIAutomationCore.Client;
    using Newtonsoft.Json.Schema;
    using NUnit.Framework;

    /// <summary>
    /// Defines assert utils class.
    /// </summary>
    public static class AssertUtils
    {
        /// <summary>
        /// Asserts expected values.
        /// </summary>
        /// <param name="response">Response object.</param>
        /// <param name="expectedValues">Expected values.</param>
        public static void AssertExpectedValues(Response response, Dictionary<string, string> expectedValues)
        {
            foreach (var entry in expectedValues)
            {
                Assert.AreEqual(entry.Value, response.GetValue(entry.Key));
            }
        }

        /// <summary>
        /// Asserts Json schema.
        /// </summary>
        /// <param name="response">Response object.</param>
        /// <param name="schemaPath">Json schema path.</param>
        public static void AssertJsonSchema(Response response, string schemaPath)
        {
            var jsonSchemaString = File.ReadAllText(schemaPath);
            var jsonSchema = JSchema.Parse(jsonSchemaString);
            IList<string> schemaErrors = new List<string>();
            Assert.IsTrue(
                response.GetJsonJObject().IsValid(jsonSchema, out schemaErrors),
                "Schema validation failed: " + string.Join("\n", schemaErrors));
        }
    }
}

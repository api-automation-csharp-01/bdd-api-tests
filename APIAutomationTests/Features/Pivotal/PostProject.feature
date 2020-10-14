Feature: Create Project

@smoke @functional @deletePivotalProject
Scenario: Project is created with name
	Given I use the "Pivotal" service client
	When I send a "Pivotal" POST request to "projects" with the following json body
		"""
		{
			"name": "Test automation CSharp"
		}
		"""
	And I store project id for workspace cleaning
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Pivotal/PostProjectSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue          |
		| name           | Test automation CSharp |
		| kind           | project                |
		| week_start_day | Monday                 |

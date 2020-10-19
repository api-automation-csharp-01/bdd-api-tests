@regression @skipScenario
Feature: Create Project

@functional @createTodoist
Scenario: Project is created with name
	Given I use the "Todoist" api client
	When I send a "Todoist" POST request to "projects" with the following json body
		"""
		{
			"name": "Test1"
			
		}
		"""
	And I store project id for workspace cleaning
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Todoist/CreateProject.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue          |
		| name           | Test1                  |
		| shared         | False                  |
		| favorite       | False                  |

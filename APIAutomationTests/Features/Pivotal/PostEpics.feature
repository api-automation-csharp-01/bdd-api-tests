@regression
Feature: Create Epics

Background: Create Projects
	Given I use the "Pivotal" service client
	When I send a "Pivotal" POST request to "projects" with the following json body
		"""
		{
			"name": "Test automation CSharp"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"

@functional @deletePivotalProject
Scenario: Create epics in a project
	Given I use the "Pivotal" service client
	When I send a "Pivotal" POST request to "projects/{PROJECT_ID}/epics" with the following json body
		"""
		{
			"name": "New epic name",
			"description": "This is the epic description"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Pivotal/PostEpicSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue    |
		| name           | New epic name    |
		| kind           | epic             |

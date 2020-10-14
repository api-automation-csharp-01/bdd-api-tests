@regression
Feature: Update Project

Background: Create project
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
Scenario: Project is updated with name
	Given I use the "Pivotal" service client
	When I send a "Pivotal" PUT request to "projects/{PROJECT_ID}" with the following json body
		"""
		{
			"name": "New project name"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Pivotal/PutProjectSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue    |
		| name           | New project name |
		| kind           | project          |
		| week_start_day | Monday           |

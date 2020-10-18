@regression
Feature: Get All  Project

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
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Todoist/GetAllProjects.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue    |
		| name           | Test1            |
		| shared         | False            |
		| favorite       | False            |

@functional @getallTodoist
Scenario: Return all created projects
	Given I use the "Todoist" service client
	When I send a "Todoist" GET request to "projects"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Todoist/GetAllProjects.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue   |
		| Id             | {PROJECT_ID}    |
		| name           | Test1           |
		| shared         | False           |
		| favorite       | False           |
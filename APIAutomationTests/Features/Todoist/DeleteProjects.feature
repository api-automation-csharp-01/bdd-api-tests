@regression
Feature: Delete new Project

@functional @createTodoist
Scenario: Project is created with name
	Given I use the "Todoist" api client
	When I send a "Todoist" POST request to "projects" with the following json body
		"""
		{
			"name": "Test2"
			
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Todoist/CreateProject.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue          |
		| name           | Test2                  |
		| shared         | False                  |
		| favorite       | False                  |

@functional @delete
Scenario: Project is deleted by id
	Given I use the "Todoist" service client
	When I send a "Todoist" DELETE request to "projects/{PROJECT_ID}"
	Then I validate that the response status code is "200"
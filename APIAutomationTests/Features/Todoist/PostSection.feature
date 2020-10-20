Feature: Create Section

Background: Create project
	Given I use the "Todoist" service client
	When I send a "Todoist" POST request to "projects" with the following json body
		"""
		{
			"name": "Test project01"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "TODOIST_PROJECT_ID"
	Then I validate that the response status code is "200"
	

@deleteTodoistProject
Scenario: Create a section in a project
	Given I use the "Todoist" service client
	When I send a "Todoist" POST request to "sections" with the following json body
		"""
		{
			"project_id":{TODOIST_PROJECT_ID},
			"name":"TO DO"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Todoist/PostSectionSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath   | expectedValue        |
		| name       | TO DO                |
		| project_id | {TODOIST_PROJECT_ID} |
		| order      | 1                    |

@deleteTodoistProject
Scenario: Create a section without name - Negative
	Given I use the "Todoist" service client
	When I send a "Todoist" POST request to "sections" with the following json body
		"""
		{
			"project_id":{TODOIST_PROJECT_ID},
			"name":""
		}
		"""
	Then I validate that the response status code is "400"

@deleteTodoistProject 
Scenario: Create a section for nonexistent project - Negative
	Given I use the "Todoist" service client
	When I send a "Todoist" POST request to "sections" with the following json body
		"""
		{
			"project_id":22479174810,
			"name":"IN TESTING"
		}
		"""
	Then I validate that the response status code is "400"
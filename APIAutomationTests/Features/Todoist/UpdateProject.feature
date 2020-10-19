@regression @skipScenario
Feature: Update Project

Background: Create project
	Given I use the "Todoist" service client
	When I send a "Todoist" POST request to "projects" with the following json body
		"""
		{
			"name": "NUEVO456"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"

@functional @updateTodoistProject
Scenario: Project is updated with name
	Given I use the "Todoist" service client
	When I send a "Todoist" POST request to "projects/{PROJECT_ID}" with the following json body
		"""
		{
			"name": "New project name"
		}
		"""
	Then I validate that the response status code is "204"
	
		

Feature: Delete Project

Background: Create project
	Given I use the "Pivotal" service client
	When I send a "Pivotal" POST request to "projects" with the following json body
		"""
		{
			"name": "Project to delete"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"

@functional @deletePivotalProject
Scenario: Verify that is posible to delete a project
	Given I use the "Pivotal" service client
	When I send a "Pivotal" DELETE request to "projects/{PROJECT_ID}" 
	Then I validate that the response status code is "204"
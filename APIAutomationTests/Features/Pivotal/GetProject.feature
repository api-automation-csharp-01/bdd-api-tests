Feature: Get  Project

Background: Create project
	Given I use the "Pivotal" service client
	When I send a "Pivotal" POST request to "projects" with the following json body
		"""
		{
			"name": "Project to GET"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"

@smoke @functional @deletePivotalProject
Scenario: Verify the status code is 200 when a request for a project is sent
	Given I use the "Pivotal" service client
    When I send a "Pivotal" GET request to "projects"
    Then I validate that the response status code is "200"

@smoke @functional @deletePivotalProject
Scenario: Get project
	Given I use the "Pivotal" service client
    When I send a "Pivotal" GET request to "projects/{PROJECT_ID}" 
	Then I validate that the response status code is "200"
    And I validate that the response body match "Schemas/Pivotal/GetProjectSchema.json" JSON schema
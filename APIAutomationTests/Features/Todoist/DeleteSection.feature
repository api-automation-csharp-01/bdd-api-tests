Feature: Delete Section

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
	When I send a "Todoist" POST request to "sections" with the following json body
		"""
		{
			"project_id":{TODOIST_PROJECT_ID},
			"name":"TO DO"
		}
		"""
	Then I validate that the response status code is "200"
	And I store response "id" value as "TODOIST_SECTION_ID"
	

@deleteTodoistProject
Scenario: Update a section in a project
	Given I use the "Todoist" service client
	When I send a "Todoist" DELETE request to "sections/{TODOIST_SECTION_ID}"		
	Then I validate that the response status code is "204"

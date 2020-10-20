Feature: Get Section

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
			"name":"IN PROGRESS"
		}
		"""
	Then I validate that the response status code is "200"
	And I store response "id" value as "TODOIST_SECTION_ID"

	

@deleteTodoistProject
Scenario: Get a section by ID
	Given I use the "Todoist" service client
	When I send a "Todoist" GET request to "sections/{TODOIST_SECTION_ID}" 
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Todoist/GetSectionByIdSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath   | expectedValue        |
		| id         | {TODOIST_SECTION_ID} |
		| name       | IN PROGRESS          |
		| project_id | {TODOIST_PROJECT_ID} |

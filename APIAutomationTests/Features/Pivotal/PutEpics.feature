@regression
Feature: Update Epics

Background: Create Projects
	Given I use the "Pivotal" service client
	When I send a "Pivotal" POST request to "projects" with the following json body
		"""
		{
			"name": "Project for API Automation"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "PROJECT_ID"
	Then I validate that the response status code is "200"
	When I send a "Pivotal" POST request to "projects/{PROJECT_ID}/epics" with the following json body
		"""
		{
			"name": "New epic name",
			"description": "This is the epic description"
		}
		"""
	And I store response "id" value as "EPIC_ID"
	Then I validate that the response status code is "200"

@functional  @deletePivotalProject
Scenario: Update Epic
	Given I use the "Pivotal" service client
	When I send a "Pivotal" PUT request to "projects/{PROJECT_ID}/epics/{EPIC_ID}" with the following json body
		"""
		{
			"name": "New epic name edited",
			"description": "Description edited",
			"label": {
				"name": "new label"
			}

		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Pivotal/PutEpicSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue		   |
		| name           | New epic name edited    |
		| description    | Description edited      |
		| label.name     | new label		       |

@smoke  @deletePivotalProject
Scenario: Update Epic name
	Given I use the "Pivotal" service client
	When I send a "Pivotal" PUT request to "projects/{PROJECT_ID}/epics/{EPIC_ID}" with the following json body
		"""
		{
			"name": "New epic name edited"
		}
		"""
	Then I validate that the response status code is "200"

@negative  @deletePivotalProject
Scenario: Cannot update Epic with a empty name
	Given I use the "Pivotal" service client
	When I send a "Pivotal" PUT request to "projects/{PROJECT_ID}/epics/{EPIC_ID}" with the following json body
		"""
		{
			"name": " "
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath			 | expectedValue		   |
		| code				 | invalid_parameter       |
		| general_problem    | Name can't be blank     |

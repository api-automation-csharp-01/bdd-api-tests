@regression
Feature: Consult Label

Background: Create label
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
	
	When I send a "Pivotal" POST request to "projects/{PROJECT_ID}/labels/" with the following json body
		"""
		{
			"name": "a new hope"
		}
		"""
	Then I validate that the response status code is "200"
	And I store label id for workspace cleaning
	And I store response "id" value as "LABEL_ID"

@functional @deletePivotalProject
Scenario: Update label
	Given I use the "Pivotal" service client
	When I send a "Pivotal" GET request to "projects/{PROJECT_ID}/labels/{LABEL_ID}/"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Pivotal/GetLabelSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       | expectedValue    |
		| name           | a new hope       |
		| kind           | label            |
		

@regression
Feature: Update label

Background: Create Board
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{
			"name": "development",
			"prefs_background": "orange"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "BOARD_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "first quarter",
			"color": "sky"			
		}
		"""
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"

@functional @deleteBoard
Scenario: It is possible to update the label name	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"name": "first quarter 2020"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutLabelSchemaFirstScenario.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue      |
		| name     | first quarter 2020 |
		| idBoard  | {BOARD_ID}         |
		| color    | sky                |		

@functional @deleteBoard
Scenario: It is possible to update the label color	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"color": "green"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutLabelSchemaSecondScenario.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| name     | first quarter |
		| idBoard  | {BOARD_ID}    |
		| color    | green         |
			
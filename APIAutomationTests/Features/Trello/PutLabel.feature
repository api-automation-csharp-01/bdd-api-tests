Feature: Update label
Background: Create Board
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{
			"name": "board to update a label",
			"prefs_background": "orange"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "BOARD_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "development",
			"color": "sky"			
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"

Scenario: It is possible to update the label name	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"name": "development updated"
		}
		"""
	Then I validate that the response status code is "200"


Scenario: It is possible to update the label color	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"color": "green"
		}
		"""
	Then I validate that the response status code is "200"
	
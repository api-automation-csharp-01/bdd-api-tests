Feature: Negative tests to update labels
Background: Create Board and label
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

Scenario: It is not possible to update the id label	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"id": "012345a6c789"
		}
		"""
	Then I validate that the response status code is "200"


Scenario: It is not possible to update the idBoard label	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"idBoard": "d5f2345a6c543"
		}
		"""
	Then I validate that the response status code is "200"
	
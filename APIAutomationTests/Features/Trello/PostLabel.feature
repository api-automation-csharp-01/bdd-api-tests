Feature: Create label
Background: Create Board, list and a card
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{
			"name": "first board today 3 0",
			"prefs_background": "sky"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "BOARD_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "boards/{BOARD_ID}/lists" with the following json body
		"""
		{
			"name": "first list3"			
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "LIST_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"idBoard": "{BOARD_ID}",
			"idList": "{LIST_ID}",
			"name": "first card3"			
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "CARD_ID"
	Then I validate that the response status code is "200"


Scenario: Create a label for the board	
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "first label3",
			"color": "red"			
		}
		"""
	Then I validate that the response status code is "200"


Scenario: Add a label to a created card	
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "first label3",
			"color": "red"			
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards/{CARD_ID}/idLabels" with the following json body
		"""
		{
			"value": "{LABEL_ID}"	
		}
		"""
	Then I validate that the response status code is "200"


Scenario: Create a card with a created label	
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "first label 5",
			"color": "green"			
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"idBoard": "{BOARD_ID}",
			"idList": "{LIST_ID}",		
			"idLabels": "{LABEL_ID}",
			"name": "first card3"	
		}
		"""
	Then I validate that the response status code is "200"
	
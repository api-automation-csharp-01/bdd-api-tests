@regression
Feature: Create label

Background: Create Board, list and a card
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{
			"name": "development",
			"prefs_background": "sky"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "BOARD_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "boards/{BOARD_ID}/lists" with the following json body
		"""
		{
			"name": "first quarter"			
		}
		"""
	And I store response "id" value as "LIST_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"idBoard": "{BOARD_ID}",
			"idList": "{LIST_ID}",
			"name": "work on login"			
		}
		"""
	And I store response "id" value as "CARD_ID"
	Then I validate that the response status code is "200"

@functional @deleteBoard
Scenario: Create a label for the board	
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "login",
			"color": "yellow"			
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostLabelSchemaFirstScenario.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| name     | login         |
		| color    | yellow        |
		| idBoard  | {BOARD_ID}    |

@functional @deleteBoard
Scenario: Add a label to a created card	
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "login",
			"color": "green"			
		}
		"""
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards/{CARD_ID}/idLabels" with the following json body
		"""
		{
			"value": "{LABEL_ID}"	
		}
		"""
	Then I validate that the response status code is "200"
		
@functional @deleteBoard
Scenario: Create a card with a created label	
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "login",
			"color": "green"			
		}
		"""
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"idBoard": "{BOARD_ID}",
			"idList": "{LIST_ID}",		
			"idLabels": "{LABEL_ID}",
			"name": "work on login"	
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostLabelSchemaThirdScenario.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| name     | work on login |
		| closed   | False         |
		| idBoard  | {BOARD_ID}    |
		| idList   | {LIST_ID}     |
			
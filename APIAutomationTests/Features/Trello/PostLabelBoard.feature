Feature: Create a Label on a Board

@functional @deleteTrelloBoard @regression @createTrelloBoard
Scenario: Create a Label on a Board
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{ 
			"name": "My label",
			"color": "green"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostLabelBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| name     | My label      |
		| color    | green         |

@negative @deleteTrelloBoard @createTrelloBoard
Scenario: Create a label with invalid color
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{ 
			"name": "My label",
			"color": " "
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue           |
		| message  | invalid value for color |
		| error    | ERROR                   |
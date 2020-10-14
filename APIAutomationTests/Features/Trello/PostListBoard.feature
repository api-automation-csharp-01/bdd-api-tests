Feature: Create a List on a Board

@functional @deleteTrelloBoard @regression @createTrelloBoard
Scenario: Create a List on a Board
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/lists" with the following json body
		"""
		{ 
			"name": "My List"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostListBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| name     | My List       |

@negative @deleteTrelloBoard @createTrelloBoard
Scenario: Create a List on a Board with an invalid position
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/lists" with the following json body
		"""
		{ 
			"name": "My List", 
			"pos": "middle"
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue     |
		| message  | Invalid position. |
		| error    | ERROR             |
Feature: Enable Power-Ups on a Board

@functional @deleteTrelloBoard @regression @createTrelloBoard
Scenario: Enable a Power-Up on a board
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/boardPlugins" with the following json body
		"""
		{
			"idPlugin": "588a331cc86ffbe08f5d2c67"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostPowerUpBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue            |
		| idPlugin | 588a331cc86ffbe08f5d2c67 |

@deleteTrelloBoard @negative @createTrelloBoard
Scenario: Enable a Power-Up on a board that was already enabled
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/boardPlugins" with the following json body
		"""
		{
			"idPlugin": "588a331cc86ffbe08f5d2c67"
		}
		"""
	Then I validate that the response status code is "200"
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/boardPlugins" with the following json body
		"""
		{
			"idPlugin": "588a331cc86ffbe08f5d2c67"
		}
		"""
	Then I validate that the response status code is "409"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue          |
		| message  | Can't enable plugin    |
		| error    | PLUGIN_ALREADY_ENABLED |

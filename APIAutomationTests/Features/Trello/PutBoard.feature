Feature: Update Board

@functional @deleteTrelloBoard @regression @createTrelloBoard
Scenario: Board is update 
	Given I use the "Trello" service client
	When I send a "Trello" PUT request to "boards/{BOARD_ID}" with the following json body
		"""
		{ 
			"name": "Board updated",
			"desc": "This board has been updated using SpecFlow",
			"prefs/background": "green",
			"labelNames/yellow": "Label in yellow"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath              | expectedValue                              |
		| name                  | Board updated                              |
		| desc                  | This board has been updated using SpecFlow |
		| prefs.permissionLevel | private                                    |
		| prefs.invitations     | members                                    |
		| prefs.background      | green                                      |
		| labelNames.yellow     | Label in yellow                            |
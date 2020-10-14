Feature: Update Board

@functional @deleteTrelloBoard @regression @createTrelloBoard
Scenario: Board is update 
	Given I use the "Trello" service client
	When I send a "Trello" PUT request to "boards/{BOARD_ID}" with the following json body
		"""
		{ 
			"name": "Board updated",
			"desc": "This board has been updated using SpecFlow",
			"idOrganization": "5f5801b5776a7a5da2f3561a",
			"prefs/permissionLevel": "org",
			"prefs/invitations": "admins",
			"prefs/background": "green"				
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath              | expectedValue                              |
		| name                  | Board updated                              |
		| desc                  | This board has been updated using SpecFlow |
		| idOrganization        | 5f5801b5776a7a5da2f3561a                   |
		| prefs.permissionLevel | org                                        |
		| prefs.invitations     | admins                                     |
		| prefs.background      | green                                      |
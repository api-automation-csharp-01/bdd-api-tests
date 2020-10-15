Feature: Create Board

@functional @deleteTrelloBoard @regression
Scenario: Board is created only with name
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{ 
			"name": "Test automation CSharp"		
		}
		"""
	And I store response id for workspace cleaning
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath              | expectedValue            |
		| name                  | Test automation CSharp   |
		| prefs.permissionLevel | private                  |
		| prefs.comments        | members                  |
		| prefs.invitations     | members                  |
		| prefs.background      | blue                     |
		

@functional @deleteTrelloBoard @regression
Scenario: Board is created with name and other fields
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{ 
			"name": "Test automation CSharp",
			"desc": "This board has been created using SpecFlow",
			"prefs_permissionLevel": "public",
			"prefs_background": "green"			
		}
		"""
	And I store response id for workspace cleaning
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostBoardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath              | expectedValue                              |
		| name                  | Test automation CSharp                     |
		| desc                  | This board has been created using SpecFlow |
		| prefs.permissionLevel | public                                     |
		| prefs.comments        | members                                    |
		| prefs.invitations     | members                                    |
		| prefs.background      | green                                      |

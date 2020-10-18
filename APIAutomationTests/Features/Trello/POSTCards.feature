Feature: POST Cards

Background: To create cards
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "board" with the following json body
		"""
		{
			"name": "Test automation CSharp"
		}
		"""
	And I store board id for workspace cleaning
	And I store response "id" value as "TRELLO_BOARD_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "list" with the following json body
		"""
		{
			"name": "TO DO",
			"idBoard": "{TRELLO_BOARD_ID}"
		}
		"""
	And I store response "id" value as "TRELLO_BOARD_LIST_ID"
	Then I validate that the response status code is "200"

@deleteTrelloBoard @acceptance
Scenario: Post Cards should create a card
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"name": "New card from API",
			"desc": "New card from API described",
			"pos": "top",
			"idList": "{TRELLO_BOARD_LIST_ID}"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostCardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue     |
		| name     | New card from API |

@deleteTrelloBoard @functional
Scenario: Post Cards can be created without name/description
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"idList": "{TRELLO_BOARD_LIST_ID}"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PostCardSchema.json" JSON schema


@deleteTrelloBoard @negative
Scenario: Error when List is not sent
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"name": "New card from API",
			"desc": "New card from API described",
			"pos": "top"
			
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the message "invalid value for idList"


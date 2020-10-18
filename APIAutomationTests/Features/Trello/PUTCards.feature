Feature: PUT Cards

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
			"name": "IN PROGRESS",
			"idBoard": "{TRELLO_BOARD_ID}"
		}
		"""
	And I store response "id" value as "TRELLO_BOARD_LIST_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "cards" with the following json body
		"""
		{
			"name": "Test",
			"desc": "Test",
			"pos": "top",
			"idList": "{TRELLO_BOARD_LIST_ID}"
		}
		"""
	And I store response "id" value as "CARD_ID"
	Then I validate that the response status code is "200"

@deleteTrelloBoard @acceptance
Scenario: Description can be updated
	Given I use the "Trello" service client
	When I send a "Trello" PUT request to "cards/{CARD_ID}" with the following json body
		"""
		{
			"desc": "Card to verify if description was updated"
			
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutCardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue                             |
		| desc     | Card to verify if description was updated |

@deleteTrelloBoard @functional
Scenario: Card can be moved to another list
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "list" with the following json body
		"""
		{
			"name": "DONE",
			"idBoard": "{TRELLO_BOARD_ID}"
		}
		"""
	And I validate that the response status code is "200"
	And I store response "id" value as "OTHER_LIST_ID"
	When I send a "Trello" PUT request to "cards/{CARD_ID}" with the following json body
		"""
		{
			"idList": "{OTHER_LIST_ID}"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutCardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue   |
		| idList   | {OTHER_LIST_ID} |

@deleteTrelloBoard @functional
Scenario: Cover can be applied to a card
	Given I use the "Trello" service client
	When I send a "Trello" PUT request to "cards/{CARD_ID}" with the following json body
		"""
		{
			"cover":{
			"idAttachment":null,
			"color":"yellow",
			"idUploadedBackground":null,
			"size":"normal", 
			"brightness":"light"
			}
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/PutCardSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath    | expectedValue |
		| cover.color | yellow        |
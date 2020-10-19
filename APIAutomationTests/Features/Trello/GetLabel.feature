@regression
Feature: Get label

@functional @createBoard @deleteBoard
Scenario: It is possible getting a label by ID 
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "first quarter",
			"color": "sky"			
		}
		"""
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" GET request to "labels/{LABEL_ID}"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Trello/GetLabelSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| name     | first quarter |
		| color    | sky           |
		| idBoard  | {BOARD_ID}    |
		
@createBoard @deleteBoard
Scenario: It is possible gettting all the labels by board
	Given I use the "Trello" service client
	When I send a "Trello" GET request to "boards/{BOARD_ID}/labels"
	Then I validate that the response status code is "200"
	And I validate that the response body contains the following values
		| jsonpath  | expectedValue |
		| [0].color | green         |
		| [1].color | yellow        |
		| [2].color | orange        |
		| [3].color | red           |
		| [4].color | purple        |
		| [5].color | blue          |		

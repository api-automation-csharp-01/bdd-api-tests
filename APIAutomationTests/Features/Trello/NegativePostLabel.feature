@regression
Feature: Negative test to create labels

@negative  @createBoard @deleteBoard
Scenario: It is not possible to create a label with color value equal to numbers.
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "development",
			"color": "12345"			
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue           |
		| message  | invalid value for color |
		| error    | ERROR                   |		
		
@negative @createBoard @deleteBoard
Scenario: It is not possible to create a label with color value equal to empty spaces.
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "development",
			"color": "     "			
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue           |
		| message  | invalid value for color |
		| error    | ERROR                   |	

@negative @createBoard @deleteBoard
Scenario: It is not possible to create a label with color value equal to special characters.
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "development",
			"color": "#@#@#@#@"			
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue           |
		| message  | invalid value for color |
		| error    | ERROR                   |	

@negative @createBoard @deleteBoard
Scenario: It is not possible to create a label with color value equal to uppercase.
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "development",
			"color": "YELLOW"			
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue           |
		| message  | invalid value for color |
		| error    | ERROR                   |
	
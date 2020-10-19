@regression
Feature: Negative tests to update labels

Background: Create Board and label
	Given I use the "Trello" service client
	When I send a "Trello" POST request to "boards" with the following json body
		"""
		{
			"name": "development",
			"prefs_background": "sky"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "BOARD_ID"
	Then I validate that the response status code is "200"
	When I send a "Trello" POST request to "boards/{BOARD_ID}/labels" with the following json body
		"""
		{
			"name": "first quarter 2020",
			"color": "green"			
		}
		"""
	And I store response "id" value as "LABEL_ID"
	Then I validate that the response status code is "200"

@negative @deleteBoard
Scenario: It is not possible to update the id label	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"id": "012345a6c789"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue      |
		| id       | {LABEL_ID}         |
		| idBoard  | {BOARD_ID}         |
		| name     | first quarter 2020 |
		| color    | green              |

@negative @deleteBoard
Scenario: It is not possible to update the idBoard label	
	When I send a "Trello" PUT request to "labels/{LABEL_ID}" with the following json body
		"""
		{
			"idBoard": "d5f2345a6c543"
		}
		"""
	Then I validate that the response status code is "200"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue      |
		| id       | {LABEL_ID}         |
		| idBoard  | {BOARD_ID}         |
		| name     | first quarter 2020 |
		| color    | green              |
	
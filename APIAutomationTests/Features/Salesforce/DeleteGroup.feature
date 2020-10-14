Feature: Delete Group

Background: Create group
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "group" with the following json body
		"""
		{
			"Name": "Test automation CSharp"
		}
		"""
	And I store response id for workspace cleaning
	And I store response "id" value as "GROUP_ID"
	Then I validate that the response status code is "201"

@functional
Scenario: Group is deleted
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "group/{GROUP_ID}"
	Then I validate that the response status code is "204"

@negative
Scenario: Group is not deleted with non existing id
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "group/00G4W000003e0P5UAI"
	Then I validate that the response status code is "404"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue               |
		| [0].message   | invalid cross reference id  |
		| [0].errorCode | INVALID_CROSS_REFERENCE_KEY |


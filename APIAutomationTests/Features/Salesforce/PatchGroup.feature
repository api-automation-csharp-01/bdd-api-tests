@deleteSalesforceGroup
Feature: Update Group

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
Scenario: Group is updated with name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "group/{GROUP_ID}" with the following json body
		"""
		{
			"Name": "Test automation CSharp UPDATED"
		}
		"""
	Then I validate that the response status code is "204"

@functional
Scenario: Group is updated with developer name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "group/{GROUP_ID}" with the following json body
		"""
		{
			"DeveloperName": "Test_Automation_CSharp_UPDATED"
		}
		"""
	Then I validate that the response status code is "204"

@negative
Scenario: Group is not updated with empty name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "group/{GROUP_ID}" with the following json body
		"""
		{
			"Name": ""
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                       |
		| [0].message   | Required fields are missing: [Name] |
		| [0].errorCode | REQUIRED_FIELD_MISSING              |

@negative
Scenario: Group is not updated with spaces on developer name 
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "group/{GROUP_ID}" with the following json body
		"""
		{
			"Name": "Test automation CSharp",
			"DeveloperName": "Test Automation CSharp"
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                                                                                                                                                                                                                     |
		| [0].message   | Developer Name: The Group API Name can only contain underscores and alphanumeric characters. It must be unique, begin with a letter, not include spaces, not end with an underscore, and not contain two consecutive underscores. |
		| [0].errorCode | FIELD_INTEGRITY_EXCEPTION                                                                                                                                                                                                         |

@negative
Scenario: Group is not updated with non existing id
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "group/00G4W000003e0P5UAI" with the following json body
		"""
		{
			"Name": "TEST UPDATED"
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue     |
		| [0].message   | invalid record id |
		| [0].errorCode | INVALID_ID_FIELD  |
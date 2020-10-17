Feature: Create Group

@functional @deleteSalesforceGroup
Scenario: Group is created with name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "group" with the following json body
		"""
		{
			"Name": "Test automation CSharp",
			"DeveloperName": "Test_Automation_CSharp"
		}
		"""
	And I store response id for workspace cleaning
	Then I validate that the response status code is "201"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| success  | True          |
		| errors   | []            |

@functional @deleteSalesforceGroup
Scenario: Group is created with queue type
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "group" with the following json body
		"""
		{
			"Name": "Test automation CSharp Personal Type",
			"DeveloperName": "Test_Automation_CSharp_PT",
			"Type": "Queue"
		}
		"""
	And I store response id for workspace cleaning
	Then I validate that the response status code is "201"
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| success  | True          |
		| errors   | []            |

@negative
Scenario: Group is not created with spaces on developer name 
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "group" with the following json body
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
Scenario: Group is not created with empty name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "group" with the following json body
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

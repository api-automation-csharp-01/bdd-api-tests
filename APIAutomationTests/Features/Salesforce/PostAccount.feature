@regression
Feature: Create Account

@functional @aceptance @deleteSalesforceAccount
Scenario: Create Account
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Account" with the following json body
		"""
		{
			"name": "Test automation SalesForce",
			"NumberOfEmployees": 2,
			"Phone": 8758265,
			"Fax": 9875,
			"AccountNumber": 411
		}
		"""
	And I store response id for cleaning environment
	And I store response "id" value as "ACCOUNT_ID"
	Then I validate that the response status code is "201"
	And I validate that the response body match "Schemas/Salesforce/PostAccountSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| id       | {ACCOUNT_ID}  |
		| success  | True          |
		| errors   | []            |

@smoke @deleteSalesforceAccount
Scenario: Create Account with Name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Account" with the following json body
		"""
		{
			"name": "Test automation SalesForce"
		}
		"""
	And I store response id for cleaning environment	
	Then I validate that the response status code is "201"

@negative
Scenario: Is not possible to create  Create Account
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Account" with the following json body
		"""
		{
			"name": ""
		}
		"""
	Then I validate that the response status code is "400"	
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                       |
		| [0].message   | Required fields are missing: [Name] |
		| [0].errorCode | REQUIRED_FIELD_MISSING              |
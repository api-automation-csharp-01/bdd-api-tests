@regression
Feature: Create Account

@functional @deleteSalesforceAccount
Scenario: Create Account with Name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Account" with the following json body
		"""
		{
			"name": "02 Test automation SalesForce"
		}
		"""
	And I store project id for workspace cleaning
	And I store response "id" value as "ACCOUNT_ID"
	Then I validate that the response status code is "201"
	And I validate that the response body match "Schemas/Salesforce/PostAccountSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue |
		| id       | {ACCOUNT_ID}  |
		| success  | True          |
		| errors   | []            |

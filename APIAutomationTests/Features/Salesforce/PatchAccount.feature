@regression
Feature: Update Account

Background: Create Account
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

@functional @deleteSalesforceAccount
Scenario: Account is updated with name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "Account/{ACCOUNT_ID}" with the following json body
		"""
		{
			"name": "EDITED Test automation SalesForce"
		}
		"""
	Then I validate that the response status code is "204"
	#This did not have a body response, GET request is used to verify the changes

	When I send a "Salesforce" GET request to "Account/{ACCOUNT_ID}"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Salesforce/GetAccountSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath          | expectedValue                     |
		| Id                | {ACCOUNT_ID}                      |
		| Name              | EDITED Test automation SalesForce |
		| Phone             | 8758265                           |
		| Fax               | 9875                              |
		| AccountNumber     | 411                               |
		| NumberOfEmployees | 2                                 |

		

@regression
Feature: Get Account

@functional @aceptance @createSalesforceAccount @deleteSalesforceAccount
Scenario: Get Account
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Account/{ACCOUNT_ID_HOOK}"
	Then I validate that the response status code is "200"

	And I validate that the response body match "Schemas/Salesforce/GetDefaultAccountSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue     |
		| Id       | {ACCOUNT_ID_HOOK} |		

@smoke @createSalesforceAccount @deleteSalesforceAccount
Scenario: Get Account Smoke
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Account/{ACCOUNT_ID_HOOK}"
	Then I validate that the response status code is "200"

@negative @functional
Scenario Outline: Not Possible to GET Acount with invalid Account ID
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Account/<Invalid ID>"
	Then I validate that the response status code is "404"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                                                                |
		| [0].errorCode | NOT_FOUND                                                                    |
		| [0].message   | Provided external ID field does not exist or is not accessible: <Invalid ID> |

	Examples: 
	| Invalid ID |
	| XYZ        |
	| null       |
	| 999987     |
	| true       |

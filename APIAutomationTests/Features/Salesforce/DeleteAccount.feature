@regression
Feature: Delete Account

@functional @aceptance @createSalesforceAccount
Scenario: Delete Account
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "Account/{ACCOUNT_ID_HOOK}"
	Then I validate that the response status code is "204"

	#This did not have a body response, GET request is used to verify the changes
	When I send a "Salesforce" GET request to "Account/{ACCOUNT_ID_HOOK}"
	Then I validate that the response status code is "404"	
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                         |
		| [0].errorCode | NOT_FOUND                             |
		| [0].message   | The requested resource does not exist |

@smoke @createSalesforceAccount
Scenario: Delete Account Smoke
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "Account/{ACCOUNT_ID_HOOK}"
	Then I validate that the response status code is "204"

@negative @functional @createSalesforceAccount @deleteSalesforceAccount
Scenario Outline: Not Possible to DELETE Acount with invalid Account ID
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "Account/<Invalid ID>"
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
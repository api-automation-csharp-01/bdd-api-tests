@deleteSalesforceGroup
Feature: Get Group

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

@functional @deleteSalesforceGroup
Scenario: Group is recovered
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "group/{GROUP_ID}"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Salesforce/GetGroupSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath | expectedValue          |
		| Name     | Test automation CSharp |
		| Type     | Regular                |
		#| Id       | {GROUP_ID}             |

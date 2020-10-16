@regression
Feature: Create Campaign

@functional @deleteSalesforceCampaign
Scenario: Campaign is created with name
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Campaign" with the following json body
		"""
		{
			"name": "Test automation Campaign Salesforce"
		}
		"""
	And I store campaign id for workspace cleaning
	And I store response "id" value as "CAMPAIGN_ID"
	Then I validate that the response status code is "201"
	And I validate that the response body match "Schemas/Salesforce/PostCampaignSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath       	 | expectedValue        |
		| id            	 | {CAMPAIGN_ID}		|
		| success          	 | True              	|
		| errors			 | [] 		            |

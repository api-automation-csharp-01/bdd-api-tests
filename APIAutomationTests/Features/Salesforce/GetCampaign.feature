@regression
Feature: Get Campaign

Background: Create Campaign
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Campaign" with the following json body
	"""
	{
		"name": "Webinar Campaign",
		"Type": "Webinar",
		"Status": "Planned"
	}
	"""
	And I store campaign id for workspace cleaning
	And I store response "id" value as "CAMPAIGN_ID"
	Then I validate that the response status code is "201"

@functional @deleteSalesforceCampaign
Scenario: Get a campaign by Id
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Campaign/{CAMPAIGN_ID}"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Salesforce/GetCampaignSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath          | expectedValue        |
		| Id                | {CAMPAIGN_ID}        |
		| Name              | Webinar Campaign     |
		| Type              | Webinar              |
		| Status            | Planned              |

@functional @deleteSalesforceCampaign
Scenario: Get all campaigns of one account
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Campaign"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Salesforce/GetAllCampaignsFromAccount.json" JSON schema

@negative	@deleteSalesforceCampaign
Scenario Outline: It is not possible to get Campaign by invalid Campaign ID
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Campaign/<InvalidCampaignId>"
	Then I validate that the response status code is "404"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue      																	|                                                          			
		| [0].errorCode | NOT_FOUND        																		|                                                            			
		| [0].message   | Provided external ID field does not exist or is not accessible: <InvalidCampaignId> 	|

	Examples:
		| InvalidCampaignId |
		| ThisIsAtest       |
		| 123123	      	|

@negative @deleteSalesforceCampaign
Scenario Outline: It is not possible to get a deleted Campaign Id
	Given I use the "Salesforce" service client
	When I send a "Salesforce" GET request to "Campaign/<CampaignDeleted>" 
	Then I validate that the response status code is "404"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue        						|                                                        			
		| [0].errorCode | NOT_FOUND           						|                                                         			
		| [0].message   | The requested resource does not exist		|
	
	Examples:
		| CampaignDeleted 			|
		| 7014W000001FFwkQAG        |
		| 7014W000001FHAYQA4	    |
		| 7014W000001FGMdQAO	    |	
	
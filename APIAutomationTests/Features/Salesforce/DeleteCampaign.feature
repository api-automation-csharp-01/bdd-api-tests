@regression
Feature: Delete Campaign

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

@functional
Scenario: Delete a campaign by Id
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "Campaign/{CAMPAIGN_ID}"
	Then I validate that the response status code is "204"


@negative	@deleteSalesforceCampaign
Scenario Outline: It is not possible to delete Campaign by invalid Campaign ID
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "Campaign/<InvalidCampaignId>"
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
Scenario Outline: It is not possible to delete a Campaign Id that was already deleted
	Given I use the "Salesforce" service client
	When I send a "Salesforce" DELETE request to "Campaign/<CampaignDeleted>" 
	Then I validate that the response status code is "404"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue    		|                                                        			
		| [0].errorCode | ENTITY_IS_DELETED 	|                                                         			
		| [0].message   | entity is deleted		|
	
	Examples:
		| CampaignDeleted 			|
		| 7014W000001FFwkQAG        |
		| 7014W000001FHAYQA4	    |
		| 7014W000001FGMdQAO	    |	
	
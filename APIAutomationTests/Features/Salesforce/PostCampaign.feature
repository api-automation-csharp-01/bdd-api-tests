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

@functional @deleteSalesforceCampaign	
Scenario: Create Campaign of type Webinar and status planned
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Campaign" with the following json body
		"""
		{
			"name" : "Webinar Campaign with status planned",
			"Type": "Webinar",
			"Status": "Planned"
		}
	    """
	And I store campaign id for workspace cleaning
	Then I validate that the response status code is "201"

@functional @deleteSalesforceCampaign
Scenario: Create Campaign of type Conference and status completed
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Campaign" with the following json body
		"""
		{
			"name" : "API Campaign",
			"Type": "Conference",
			"Status": "Completed"
		}
		"""
	And I store campaign id for workspace cleaning
	Then I validate that the response status code is "201"
	
@functional @deleteSalesforceCampaign
Scenario: Create Campaign of type Trade Show and status In progress
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Campaign" with the following json body
		"""
		{
			"name" : "API Campaign",
			"Type": "Trade Show",
			"Status": "In Progress"
		}
		"""
	And I store campaign id for workspace cleaning
	Then I validate that the response status code is "201"
	
@negative
Scenario: It is not possible to add additional Campaign column 
	Given I use the "Salesforce" service client
	When I send a "Salesforce" POST request to "Campaign" with the following json body
		"""
		{
			"name" : "API Campaign",
			"Type": "Webinar",
			"Status": "Planned",
			"Aditional column": "Can be included?"
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                       							|
		| [0].message   | No such column 'Aditional column' on sobject of type Campaign |
		| [0].errorCode | INVALID_FIELD            										|	
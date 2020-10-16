@regression
Feature: Update Campaign

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
Scenario: Campaign name and type is updated
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "Campaign/{CAMPAIGN_ID}" with the following json body
		"""
			{
				"name": "Conference Campaign",
			    "Type": "Conference"
			}
		"""
	Then I validate that the response status code is "204"

	When I send a "Salesforce" GET request to "Campaign/{CAMPAIGN_ID}"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Salesforce/GetCampaignSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath          | expectedValue        |
		| Id                | {CAMPAIGN_ID}        |
		| Name              | Conference Campaign  |
		| Type              | Conference           |
		| Status            | Planned              |

@functional @deleteSalesforceCampaign
Scenario: Campaign name and status is updated
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "Campaign/{CAMPAIGN_ID}" with the following json body
		"""
			{
				"name": "Aborted Campaign",
			    "Status": "Aborted"
			}
		"""
	Then I validate that the response status code is "204"

	When I send a "Salesforce" GET request to "Campaign/{CAMPAIGN_ID}"
	Then I validate that the response status code is "200"
	And I validate that the response body match "Schemas/Salesforce/GetCampaignSchema.json" JSON schema
	And I validate that the response body contains the following values
		| jsonpath          | expectedValue      |
		| Id                | {CAMPAIGN_ID}      |
		| Name              | Aborted Campaign   |
		| Type              | Webinar            |	
		| Status            | Aborted            |

@negative	
Scenario: Campaign doesn't allow to change the Id
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "campaign/{CAMPAIGN_ID}" with the following json body
		"""
		{
			"Id": "This is a new ID"
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                       					    |													   
		| [0].message   | The Id field should not be specified in the sobject data. |
		| [0].errorCode | INVALID_FIELD                  					        |		 											   

@negative
Scenario: Campaign doesn't allow to include a new column
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "campaign/{CAMPAIGN_ID}" with the following json body
		"""
		{
			"ColumnTest": "This is a column test"
		}
		"""
	Then I validate that the response status code is "400"
	And I validate that the response body contains the following values
		| jsonpath      | expectedValue                                           |
		| [0].message   | No such column 'ColumnTest' on sobject of type Campaign |
		| [0].errorCode | INVALID_FIELD                                           |
	
@negative
Scenario: Campaign name doesn't accept an empty value
	Given I use the "Salesforce" service client
	When I send a "Salesforce" PATCH request to "campaign/{CAMPAIGN_ID}" with the following json body
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
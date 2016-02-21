# CrowdBuilder

On-platform crowdfunding.

## Configuration Steps
1) Assign the CrowdBuilder Admin permission set to your admin.
2) Make sure to enable Automatic Campaign Member Management in NPSP Setting
3) Create a Force.com Public Site named 'CrowdBuilder' (you'll need to set your domain)
   - Assign CB_CampaignHome as the home page
   - Assign CB_Robots as the Robots.txt file
   - Assign the CrowdBuilder_Site permission set to the Site Guest User
4) Create your master campaign (RT CrowdBuilder Master)
5) Make sure your master campaign has a Hero Attachment with relevant metadata, a goal, a description, and a contact link.
6) Create child campaigns for your captains, and make sure to set a donate link, a goal, a description, and a twitter username.

## Expectations
- BYO Donation page, set it on a per campaign basis, and figure out yourself how to associate gifts with a primary campaign.  

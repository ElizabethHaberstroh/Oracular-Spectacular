# What's in Kermit Lynch's Wine Portfolio?
An end-to-end data analysis project- from web scraping to database building to visualization- presenting insights into Kermit Lynch's portfolio offered on https://shop.kermitlynch.com/. 

BUSINESS PROBLEM

Kermit Lynch is one of the most trusted and reputable importers of French and Italian wines in the US. The importer’s portfolio features highly sought-out and exclusive wines from notoriously expensive wine-producing regions due to its longstanding relationships with producers of these high-quality wines. Kermit Lynch would like to invigorate its portfolio by importing new and under-the-radar wines that fill current gaps in price options and are from regions which will fare well with climate change. The importer would first like to assess its current portfolio offerings to identify the distribution of regions, prices, and farming practices of its wines, as well as assess the representation of France vs. Italy. Through careful analysis of the importer’s current portfolio, Kermit Lynch will better be able to make strategic buying decisions to meet the needs of its environmentally minded customers and broaden its customer base. Several business questions were answered through data analysis and visualization:  

What is the distribution of prices of all wines offered online in 750mL format bottles?
What farming styles are producers most often using? 
Which regions are the most and least represented?
Is either France or Italy dominating the portfolio?
Which wine styles and grape varietals are most represented?

METHODOLOGY

Data was scraped from Kermit Lynch’s website https://kermitlynch.com/ using Python, leveraging V1 interface calls to extract raw JSON. Network inspection gave insight into the URIs needed to extract data about the importer's producers, wines available for purchase, wine regions, and farming types:

https://kermitlynch.com/api/v1?action=getFarming  
https://kermitlynch.com/api/v1?action=getGrowers 
https://kermitlynch.com/api/v1?action=getWines 
https://kermitlynch.com/api/v1?action=getRegions 

JSON formatting was converted into tabular (CSV) files while preserving UTF-8 encoded characters and removing italicization and other HTML encoding. Only needed columns were selected and often renamed for readability. Four CSV files were created:  
 
get_farming.csv - all farming types with their unique IDs 
get_growers.csv - all producers within Kermit Lynch’s portfolio 
get_inventory.csv - data on all wines currently available for purchase online
get_regions.csv - all wine regions in France and Italy with their unique IDs

Time was allocated to understand the data and business rules before creating an Entity Relationship Diagram and Graphical Representation in Third Normal Form. After designing the schema, the four CSV files were uploaded via SQL Developer's Import Wizard into four staging tables with defined constraints and relations.

get_farming.csv → STG_FARMING 
get_regions.csv → STG_REGION 
get_inventory.csv → STG_WINE 
get_growers.csv → STG_GROWER



# What's in Kermit Lynch's Wine Portfolio?
An end-to-end data analysis project (web scraping, data cleaning, data modeling, database creation, and data visualization) presenting insights into Kermit Lynch's portfolio and utilizing a decade of wine expertise to deliver business suggestions. 

BUSINESS PROBLEM

Kermit Lynch is one of the most trusted and reputable US importers of fine French and Italian wines. Kermit Lynch would like to invigorate its portfolio by filling gaps in eco-friendly options, underrepresented wine regions, and regions which will fare well with climate change. The importer would first like to assess its current portfolio offerings to identify the distribution of regions, prices, and farming practices of its wines, as well as assess the representation of France vs. Italy. Through careful analysis of the importer’s portfolio, Kermit Lynch will better be able to make strategic buying decisions to meet the needs of its environmentally minded customers and broaden its customer base. Business questions were defined and answered:  

1. Is either France or Italy dominating the portfolio?
2. Which regions are the most and least represented?
3. What is the distribution of prices?
4. Where are the gaps in eco-friendly farming practices?
5. Which wine styles and grape varietals are most represented?


METHODOLOGY

Data was scraped from Kermit Lynch’s website https://kermitlynch.com/ using Python, leveraging V1 interface calls to extract raw JSON. JSON was converted into tabular (CSV) files while preserving UTF-8 encoded characters and removing italicization and other HTML encoding. Only needed columns were selected and data was normalized by splitting multi-valued columns into multiple rows. Four Python scripts yielded four normalized tables. Time was allocated to understand the data and business rules before creating an Entity Relationship Diagram and 3NF Graphical Representation using Lucidchart. After designing the schema, the four CSV files were uploaded via SQL Developer's Import Wizard as staging tables with defined constraints and relations. ETL is as follows:

get_farming_3.ipynb → get_farming.csv → STG_FARMING 

get_regions_3.ipynb→ get_regions.csv → STG_REGION 

get_inventory_3.ipynb → get_inventory.csv → STG_WINE 

get_growers_3.ipynb → get_growers.csv → STG_GROWER

Eight final tables were created using SQL DDL and populated with data from the four staging tables to produce the final normalized schema. Two joining tables were created to handle many-to-many relationships between the WINE and GRAPE tables and the PRODUCER and FARMING tables as wines are often made from multiple grape varietals and producers can use more than one farming type. 

Finally, data was visualized in four interactive Tableau dashboards. All dashboards were combined to create a final Tableau Story which answers all business questions.  


ACTIONABLE INSIGHTS

Kermit Lynch should invigorate its Italian offerings as the portfolio is dominated by France in number of wines and higher median price. While the portfolio does already offer predominantly eco-friendly wines, its Italian offerings are lacking in Organic and Biodynamic wines. Kermit Lynch should also import more wines from cooler climate regions that currently have little representation in the portfolio (e.g. Alto Adige, Savoie/Bugey/Hautes-Alpes, Jura). These regions will fare well with warmer temperatures brought by climate change. The team also suggests importing more wines made from heat resistant grape varietals such as Mourvèdre, Carignan, and Grenache, all of which are commonly grown in the Southern Rhône and Languedoc regions of France and will fare well with rising temperatures.  

# What's in Kermit Lynch's Wine Portfolio?
An end-to-end data analysis project- from web scraping to database building to visualization- presenting insights into Kermit Lynch's portfolio offered on https://shop.kermitlynch.com/. 

BUSINESS PROBLEM

Kermit Lynch is one of the most trusted and reputable importers of French and Italian wines in the US. The importer’s portfolio features highly sought-out and exclusive wines from notoriously expensive wine-producing regions such as Burgundy, Bordeaux, Champagne, Barolo, and Barbaresco due to its longstanding relationships with producers of these high-quality wines. Kermit Lynch would like to invigorate its portfolio by importing new and under-the-radar wines that fill current gaps in price options and are from regions which will fare well with climate change. The importer would first like to assess its current portfolio offerings to identify the distribution of regions, prices, and farming practices of its wines, as well as assess the representation of France vs. Italy. Through careful analysis of the importer’s current portfolio, Kermit Lynch will better be able to make strategic buying decisions to meet the needs of its environmentally minded customers and broaden its customer base. 

Business Questions:  

What is the distribution of prices of all wines offered online in 750mL format bottles?
What farming styles are producers most often using? 
Which regions are the most and least represented?
Is either France or Italy dominating the portfolio?
Which wine styles and grape varietals are most represented?

METHODOLOGY

Data was scraped from Kermit Lynch’s website https://kermitlynch.com/ using Python. 

Extract from Kermit lynch website leveraged two distinct interfaces from their applications: titles V1 and V2. The V1 interface provided data on wine regions, wine producers, and farming practices. The V2 interface provided data on Kermit Lynch's inventory in their oline shop and was password protected. The password protection limited data collection to inventory that was presently presented on the website.  

The first step in the process was to investigate the website and develop and understanding of how the site worked.  Looking for the clues for where the data was stored. Figure X show the source of the website, as viewed in Google Chrome. 

Completing  the network inspection the V1 interface calls are visible, via the firm’s RESTFul interface.  

JSON formatting was converted into tabular (CSV) files, careful to preserve UTF-8 encoded characters as many values contain French words. Only needed columns were selected and often renamed for readability. We removed italicization as well. Four CSV files were created:  
 
get_farming_3.csv which contains all farming types with their unique IDs 
get_growers_3.csv which contains data on all producers within Kermit Lynch’s portfolio 
get_regions_3.csv which contains all wine regions in France and Italy with their unique IDs 
get_inventory_3.csv which contains data on all wines currently available for purchase online

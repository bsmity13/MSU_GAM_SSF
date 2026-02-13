===================================================================================================
Files in this dataset:
  * 'coyote_cougar.csv'
  * 'coyote_cougar_habitat.tif'
  * 'roads.shp' (and associated shapefile extensions)

---------------------------------------------------------------------------------------------------
********************
'coyote_cougar.csv'
********************

File 'coyote_cougar.csv' is a comma-delimited file with GPS data from multiple coyotes and cougars 
from Mahoney and Young (2016). Full citation: 
	Mahoney PJ, Young JK (2016) Uncovering behavioural states from animal activity and site 
		fidelity patterns. Methods in Ecology and Evolution 8(2): 174–183. 
		doi:10.1111/2041-210X.12658. 
These data are available on Movebank: https://www.datarepository.movebank.org/handle/10255/move.590

The CRS for these data is EPSG:32612

---------------------------------------------------------------------------------------------------
****************************
'coyote_cougar_habitat.tif'
****************************

File 'coyote_cougar_habitat.tif' is a GeoTIFF with 4 layers: 
  * elevation (m), 
  * tree cover (%), 
  * biomass (kg/ha; from Rangeland Analysis Platform biomass layer), 
  * and distance to road (m).

---------------------------------------------------------------------------------------------------
************
'roads.shp'
************

This original shapefile came from the Utah Geospatial Resource Center and contained roads for 
all of Utah. It has been cropped to the extent of coyote_cougar.csv +/- 1 km and only 3 attribute 
columns have been retained:

* 'FULLNAME' is the name of the road
* 'DOT_CLASS' is the department of transportation class; see below for classes
* 'SPEED_LMT' is the speed limit in miles per hour

DOT Classes
See https://docs.google.com/spreadsheets/d/1jQ_JuRIEtzxj60F0FAGmdu5JrFpfYBbSt3YzzCjxpfI/edit?gid=1776792153#gid=1776792153
  A	Class A - State 
  B	Class B - County 
  C	Class C - Municipality
  D	Class D - County, Other
  F	Federal Agency Maintenance
  P	Private Maintenance

---------------------------------------------------------------------------------------------------
===================================================================================================
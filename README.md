# NIDS_Metric
This is a repository for R code which allows researchers to calculate the NIDS Metric (Number of Isotopically Distinct Specimens) using stable carbon and nitrogen isotope values from bone collagen following the publication by Hyland et al. 2021 (https://doi.org/10.1007/s10816-021-09533-7).

Within this code you can:
- Calculate the NIDS value for a dataset of bone collagen samples based on your cutoff metric (suggested 1.5, but see Hyland et al. 2021 for more discussion)
- Plot the NIDS cluster analysis with the cut off line and coloured dendrogram
- Identify the clusters which each bone sample has been assigned
- Plot the d13C and d15N values with respect to the identified NIDS clusters
    
The code is currently set up to run data that is entered following the format of the csv file "Book1.csv", which allows for data to be entered as d13C and d15N values only.
I will work to update the code so that the d13C and d15N values can be specified within a larger dataset so contextual information about each sample can be included in these analyses.

If you use this software, please cite it using the information found in the "Cite this repository" panel to the right.

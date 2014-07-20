# cleaning data project

Smartphone data downloaded from UCI repository, cleaned and summarized.

## description of files
'Codebook' describing features is in tidy_features_info.txt

run_analysis.R is a script that can be sourced in R 3.1 with data.table package installed.  It searces current directory for downloaded UCI data.  If downloaded data is not found, the data is downloaded, unzipped, and processed. 

Mean and standard deviations of each sampling window of all measured features are ouput to tidy.txt.  This data is also summarized by the mean for each resulting feature for each subject and activity type, and the resulting (final) data is output in tidy_means.txt


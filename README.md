This repository is both a product and reproducibility asset from the MSc research developed by Lorraine Trento Oliveira.

Entitled **EXPLORING THE DIVERSITY OF DEPRIVED AREAS: THE APPLICATIONS OF UNSUPERVISED MACHINE LEARNING AND OPEN GEODATA**, the thesis proposed to explore the potential of unsupervised machine learning models for characterizing deprived areas based on morphological and environmental features using solely open geodata and presenting diaggregated outputs. The results show the capability of the pilot state-of-art model with high transferability and scalability potential and proved the relevance of open data framework and
data mining techniques, particularly to Low- to Middle Income Countries (LMICs). The study is applied in the city of São Paulo, Brazil. 

The folders contain:
1. Base_Layers: Contains the base layers used to prepare and process all the input features for the kmeans model. 
2. PCA_input: Includes only the final input files to conduct the PCA assessment of the hand-crafted features - Grey-Level Cocurrence Matrix (GLCM) and Landscape Metrics (LSM) of the model in order to select the optimal moving window size that will be included in the k-means model. 
3. Model_input: Contains the final processed input extracted in each grid centroid and integrated into a single csv file (Input_variables.csv) as the k-means model input.
4. Data_products: Contains the final output among the seven model  experiment conducted to test model robustness, optimise perfomance with features selection techniques.

The scripts contain data processing and machine learning modelling steps. Quick summary of the files in the order they were applied in the research:
* GLCM: calculation of texture metrics using R Studio 
* LSM: this is not a script, but it is the file for the calculation of the Landscape Metrics in Fragstats.
* PCA_processing: calculation of Principal Component Analysis to select the optimal moving window to extract hand-crafted features (GLCM and LSM)
* EDA: analysis of final data input and processing before applying the k-means
* FeatureImp_tool: code runs iteratively with k-means and generate a by-product of the important of the features for each resulting cluster
* kmeans_model: training and simulation of k-means model

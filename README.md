# MC-PB-Paper
 
 Investigating Seefedlt's motor skill proficiency barrier on aspects of health-related fitness in youth ages 10-18.

## Guidelines for Pushing/Pulling Commits:

1. Commits should be pushed as frequently as possible. 

2. Before beginning work, make sure you have pulled the most recent commits to your local machine.

3. While working, push commits after every milestone (e.g., getting deemographic info, creating composite scores for all variables, running groups of correlations/regressions, creating a table or multiple plots)

	—> Use your best judgement when making commits. You do not have to push commits after every line of code, but you should be pushing commits throughout
	   your working session. 
	
	—> This allows for more visibility between team members, and keeps us from working on the same chunks of code at the same time.
	
4. Push all commits at the end of your work session!

## Data Cleaning Workflow and File Organization:

1. After double-entering the data, original Excel files are saved to the “Excel Files” folder.

2. Open the original Excel file and immediately “Save As” a .csv file in the “csv Files” folder.

   —> Any modifications that need to be made should be made to the .csv file. 
      
      —> Original files should not be manipulated. They serve as a reference in case data is overwritten or lost in the other folders.

3. Create a folder for the analysis	you plan to use with the .csv file.

  	—>  Example: Create a folder labelled “Spring ’21” to analyze the motor and ACFT data for Spring ’21. 

4. Within the new folder (i.e., Spring ’21), create another folder labelled “Data Cleaning”. 

 	 —> Example:  Spring ’21
			                  	—> Data Cleaning

5. Create a notebook that includes the word “Cleaning” and is easily identifiable. Save this .Rmd file under the “Data Cleaning” subfolder. Then proceed with cleaning the data. 

  	—> Example:  Spring ’21
			               	   —> Data Cleaning
					                     	   —> Cleaning_Spring-21.Rmd

6. After you have finished cleaning the data, write to a .csv file and save the file in the “Clean Data” subfolder
    within the “Data Files” folder.

	  —> Example: Data Files
				               —> Clean Data
					                       —>  Spring-21.csv

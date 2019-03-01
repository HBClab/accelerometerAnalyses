# HBC lab accelerometer analysis

<!-- (https://ecotrust-canada.github.io/markdown-toc/) -->
- [Accelerometer materials on the server](#accelerometer-materials-on-the-server)
- [Data collection and file management](#data-collection-and-file-management)
  * [Device maintenance and check-out](#device-maintenance-and-check-out)
  * [Initializing the accelerometer before use](#initializing-the-accelerometer-before-use)
  * [Downloading data](#downloading-data)
  * [Exporting downloaded data](#exporting-downloaded-data)
  * [Wear Time Validation](#wear-time-validation)
  * [Sleep Analysis](#sleep-analysis)


# Accelerometer materials on the server

The scripts and data output for the procedures described here are located on our server at:
`/Volumes/vosslabhpc/Projects/Accelerometer`

**Document history:** The manual was initially developed and written as a word document named `actigraph_accelerometer_manual` by Lauren Reist and Rachel Clark Cole, and updated by Lauren and Abby Mickley in August 2018. As of March 2019, we are putting the manual into a markdown file so that we can more easily track changes collaborative edits time. 


# Data collection and file management

## Device maintenance and check-out 

* **Maintaining the devices:** Accelerometer batteries should never be allowed to die completely.  If they are not being used regularly, they should be charged on a regular basis.

* **Choosing the device to use:**: Give out the accelerometers in order of their labelID as much as possible. Tis ensures you are charging them regularly and helps you keep track of them.  

* **Identify LabID of the participant:** Before collecting data, the ActiGraph device needs to be initialized with subject-specific information. Use Lab ID for identification, rather than study IDs. Obtain subject information prior to initializing the device. 

* **Tracking:** Fill out the Accelerometer Set-Up Sheet with the subject information, cross off when you have set that accelerometer. After you have set the accelerometer, fill out the Accelerometer Tracking Sheet. You will finish filling this out when the accelerometer is returned.  

* **Software:** ActiLife should be used from the hbclab account (login: hbclab , password: see lab manager/exercise specialist for password). 



## Initializing the accelerometer before use

1. Accelerometers must have a battery level over 80% to be initialized.   
2. Open Actilife software.  
3. Make sure that any data currently on the device is already downloaded and stored because the initialization process will delete any data currently stored on the device  
4. Select “Devices” tab  
5. Make sure the checkbox on the left under “device” is checked. **Note** if more than 1 accelerometer is in the charging port, make sure to check the device list to be sure you are setting the correct one.  

> **TIP** If you need to set more than 1 accelerometer for the same dates and times for 2 or more people, you can set them at the same time, BUT they have to be for the same dates and times!

6. Click “Initialization” tab, then click “Regular Initialization”
    * Set appropriate start/stop date and time in the pop up window

        * Double check that device time is same as computer time

        * Check the “Use Stop Time?” box

        * The accelerometers should be set to record from 12:00 am to 12:00 am over 7 days. There will be a few times when you may set them to record for fewer days, but the most common is 7 days. 

    > Example:  if you are giving the accelerometer out on 6/13/2018, the device would be set to  start recording on 6/14/2018 at 12:00 am and stop recording at 6/21/2018 at 12:00 am.

    
    * Set **Sample rate** to 60 Hz. Sample rate should already be set at 60 hz, but double check to make sure. 
    * Do **not check** the “Enable Wireless” or “Heart Rate” boxes under “Wireless Options”
    * Set **Idle Sleep Mode** to Enabled
    * Check the box beside **Show Display** and click Options
        * Show 24 and show subject feedback. Verify that no boxes are checked 
        * Click Accept

7. **Do not** check the box beside “Enable IMU”

8. Click **Subject Info** on the bottom right of the pop-up window. This information should be on your set up sheet.
    * Enter information under appropriate column
    * To keep information anonymous, use Lab ID as subject name.
    * Select **Wrist** under Limb, enter subject-appropriate side and select “Non-Dominant” under Dominance (the device should always be worn on the subject’s non-dominant hand). **Double check the entered data!**

9. Click **Initialize Device** on the bottom right of the window
* The status bar will say **finished initializing** when it is completed

10. Remove it from the USB connection and place it directly into the wristband.  
    * You will have 10 seconds to get it in the wristband once you remove it from the charging port.  
    * The wristband should be laying flat on the desk.  
    * Once the accelerometer is in the wrist band, do not move or touch the band until the count down has stopped.
    * It is now ready for data acquisition.

11. Fill out the data collection form to give to the participant along with the accelerometer

12. Add the accelerometer to the Tracking sheet.  This allows us to know where all devices are at all times. 

## Downloading data

1. Open Actilife software
2. Put devices in charging port
3. Click on devices
4. Check the box to the left of the device you want to download. Confirm that the device has data to download by looking at “Current data recorded BEFORE downloading."
5. Click **Download** at the top left. In the new window, the top text bar is the location that the data will be stored. Make sure the file is located at: `C:\Users\hbclab\Documents\ActiGraph\ActiLife\Downloads` 
6. Under **Download Naming Convention**, select the `<Subject Name><Start Date>` label. The following options should be set:
    * Under Download Options, do not select “Create Clinical Report”
    * Select “Create AGD File:”
    * Epoch: 60 seconds
    * Number (#) of axis: 3
    * Select: Steps, Lux and Inclinometer 
    * **Do not select** Low Frequency Extension
    * Add biometric and user information
    * Click “Download all devices." Once it’s finished downloading, the status column will say “finished downloading.”
7. Click the “finished downloading” hyperlink to view the data. The device is now ready to be stored or ready for initialization. 
    * Fully charge the device
    * Remove it from charging port and wipe down with an alcohol swab, taking care not to wipe it over the contacts on the back of the device.  

## Exporting downloaded data
1. Once the data are downloaded to the PC, we will export it to a few different file types.
    * Click File -> Import/Export/Convert.  
    * Select: RAW to RAW  
    * Select: GT3X -> .CSV (batch)  
        * Select correct dataset by clicking on “Add Dataset” button, select file from the folder.
        * Make sure to uncheck “Add Column Headers to CSV”
        * Export CSV files, cut and paste the RAW CSV files into `Repositories\Accelerometer_Data`
        * Move the GT3X file from downloads on the Eprime PC to `vosslabhpc\Projects\Accelerometer\3-Data\RawFiles\RawGT3X_Files`
    * Data Table
        * Open Actilife
        * File -> import/export/convert -> epoch to epoch -> AGD to CSV
        * CSV export mode: select Data Table
        * Add datasets of interest
        * Convert
        * Cut and Paste file [lab id (start date)60sec] from downloads on Eprime computer to `vosslabhpc\Projects\Accelerometer\3-Data\RawFiles\60secondDataTables`
    * Enter the subject’s LabID into the sublist located in `vosslabhpc\Projects\Accelerometer\4-Analysis\specs_sublist` 
        > **TIP** If the sublist does not open on the computer, open the file through notepad

2. Update the `ActiGraph_analysis_summary.xlsx` file to reflect what has been done for each subject. This file is found at `vosslabhpc\Projects\Accelerometer\4-Analysis\ ActiGraph_analysis_summary`
    > **TIP** For studies where subjects wear the device for multiple timepoints during study, add them as LAB ID_#, where # refers to the "session" replicate.  Example:  for EXTEND they wear the device 8 times, so pre-testing is LAB ID_1, Month 1 wear is LAB ID_2, Month 2 wear is LAB ID_3. If the participant doesn't have Month 1 data, then Month 2 is still LAB ID_3. If you're unsure, ask the Exercise Specialist.


## Wear Time Validation

1. Open ActiLife Program
    * Click on the tab “Wear Time Validation” (second tab from the left)

2. Select a dataset.  Look for LAB ID (DATE), if you do not see the correct file in the list, click on the “Add Dataset” button and select the correct file.  
    * Once your dataset is selected make sure the small checkbox to the left of the dataset name is checked.

3. Select a Wear Time Algorithm (Choi 2011) by clicking on the dropdown box in the top left hand corner, underneath the “Devices” tab
    * Check the default setting for the algorithm, NOT custom
    * Do not change any of the Optional Screen Parameters (the only thing checked should be “Evaluate Wear Sensor Data”)

4. Click “Calculate” at the bottom of the window that shows the selected data set (show preview graphs should be checked)

5. Either automatically or by selecting “Details”, a pop-up window will show wear and non-wear times
    * Wear and non-wear times should be confirmed or changed by clicking on the blue hyperlink next to each period
    * Consult with the subject log to determine wear/non-wear times 
        * > **TIP** You cannot manually add in any times the subject said they were not wearing the watch, you can only confirm/deny the times that are detected by the algorithm.  
    * Click on “Open file in Advanced Details” -> Export -> Day and Wear Info. 
    * Save the file titled `LABID_StartDate_WearTime` in `Repositories\Accelerometer_Data\WearTime` 
    * Click save changes and the .agd file will now reflect these changes.


## Sleep Analysis
1. Open Actilife Program
2. Click on the “Sleep” tab
3. Select dataset (look for the Lab ID and correct date) from `C:\Users\hbclab\Documents\ActiGraph\ActiLife\Downloads`
    * Change preferences to **Normal View** and either **24hr/48 hr can be used** 
4. Select sleep algorithm **Cole-Kripke** from the dropdown menu in the top right-hand corner of the screen
5. Click “Detect Sleep Periods”
6. Sleep periods will appear in the box in the top right hand corner
    * Use subject log to edit sleep periods
    * Be very careful, you may need to add, delete or drastically edit time periods
    * Be sure to save any edits you’ve made
7. Click **export report**
    * In the pop-up box, verify that all boxes are checked( “Create CSV”,  “Create PDF” and the “Show all graphs” and “Show Times on Graphs” are checked
    * Select **Create Report**
    * The report will open once and it will ask you to name both files. Save as `LABID_Date_Sleep` in `Repositories\Accelerometer_Data\Sleep`



# Data analysis

Procedures initially developed in a word doc named `Analysis_steps_2018` by Rachel Cole Clark in spring/summer 2018, and then updated winter 2019 by Matt Sodoma and Ellie Henry. As of March 2019, we are documenting the steps in a markdown file so that we can more easily track changes collaborative edits time. 

**Before you start** make sure the device data has been initialized and downloaded according to the steps above.

1. Check the file `Accelerometer/4-Analysis/ActiGraph_analysis_summary.xlsx` to determine which subjects need to be analyzed.

2. Run the R notebook `4-Analysis/Analysis.Rmd`

## Minute-based Wear time and Sleep Validation (URA)

1. Check the `Repositories/Accelerometer_Data/Assignments.xlsx` to see which subjects to complete

2. Open the output file `sub#_output.xls`. Each line should correspond with one 60-second epoch. 
    * Open `4-Analysis/template.xls` and copy the data (without the headers) to the “all data” tab
    * Open the `template.xls` file and “save as” `sub#_output_year-month-day` to `Accelerometer/5-Results/`

3. Locate the subject’s wear time output report and sleep report (PDF second page is easiest to read) in the WearTime and Sleep folders. 
    * `Repositories/Accelerometer_Data/Sleep`
    * `Repositories/Accelerometer_Data/WearTime`

4. Use the wear time output report and the sleep data to enter 0 or 1 into the Wear? and Awake? Columns as appropriate. If the data looks slightly different from the minute cut-points (for sleep or non-wear), adjust to match the data. 
    * If the data **clearly** show that there is an error in one of the times indicated by either report, then you can use your best judgment to alter wear time or sleep within 10 minutes in either direction of the time point indicated on the report, but do not exceed the 10 minute from the time on the sleep or wear time report.
    * When making decisions like this be sure you are not adjusting times to compensate for data that falls outside of the 10-minute window. In other words, unless data within 10 minutes clearly show something different than the report, stick to the report times. Do not regularly adjust data just because you can. Only adjust it if the data clearly indicate otherwise.  
    * Do **not** change data if it is not indicated by a report or the activity log. Even if it appears that the watch wasn’t being worn for a period of time during the day, do not mark that data as non-wear time unless the activity log or wear time report indicates that the watch wasn’t being worn.
    * For sleep and non-wear time, typically the reports will indicate the first minute that is either asleep, awake, wear or non-wear. For example, if the sleep report says 11:23 pm, unless the data clearly show that sleep occurred at a different minute (within 10 minutes on either side), then indicate 11:23 as the first sleep minute (0 in the awake column). The same goes for the first minute identified as sleep, wake, wear or non-wear. Assume the first minute noted in the report is the first minute where the new activity occurs (sleep, wake, wear or non-wear), rather than being the last minute of the previous category. 

## Summarize the data using the pivot table

1. Update the pivot table in the first sheet (“Summary_pivots”) to source data from the “All_Data” sheet.
    * Select PivotTable Analyze (tab in the toolbar at the top of the page) 
    * Under PivotTable Analyze tab, click “Change Data Source” 
    * Highlight all data on the All_Data sheet 
        > **TIP** click on cell A1, hold the command and shift keys down, press right arrow, followed by down arrow to select all the data) 
    * Click okay (or hit enter)

2. Confirm that you are filtering out wear=0 datapoints (non-wear times).
    * Also confirm you filter out “start” from the row labels dropdown in column A.
    * Also confirm that the days for this subject are checked

3. The pivot table is set up to summarize the data from the sed.rf variable. For example, Row label=1 (meaning awake) and column “sedentary” shows the number of awake sedentary minutes for each day.  The values in the Summary Chart (top middle of the sheet, underneath the blue heading) should also update after the pivot table is updated. 

4. Update other aspects of the Summary chart 
    * Update subject number in blue heading
    * Update data start date (based off of first start date in All_data sheet) 
    * Click on bottom right corner of cell, use fill handle (small black cross) to drag horizontally across the other days. This will automatically add the subsequent dates in the following boxes.
    * Some participants may wear the accelerometer a different number of days than other participants; make sure this is reflected in the data by deleting or adding days as needed.

5. Check to see if the days and dates are matching up to the pivot table by double clicking on a cell within the SUMMARY table. Verify that the reference cell from the pivot table is the correct data.

6. Update the Weekend/Weekday Minutes Table (middle of the sheet)
    * Each cell corresponds to information in the SUMMARY chart above for Sedentary, Light, MVPA (Moderate-Vigorous Physical Activity) and Sleep. 
        * Double click on one cell (Ex: Total Weekend Sed mins) and see if it corresponds to the correct cells. 
        * If it does not match, click and drag highlighted box(es) in Summary table to update as necessary (note: Weekday = Monday-Friday, Weekend = Saturday-Sunday)
        * Manually enter the number of weekend and weekday days in the data. Note some studies are less than 7 days, so make sure to check and manually enter in the correct number of weekend and weekdays.

7. Update MVPA category once done running R notebook
    * Insert MVPA info from GGIR output `(E1M_T100 and E5M_T100)` into the excel sheet. The sheet can be found in the subject output folder within `daysummary.xls` (column P and Q)
    * `/Volumes/vosslabhpc/Projects/Accelerometer/5-Results/output_(sub#)/results/part2_daysummary.csv`
    * Copy to sheet, then transpose each column E1M_T100 to row 9, E5M_T100 to row 10

8. Copy values found in Totals, Weekend Minutes, and Weekday Minutes into the `/Volumes/vosslabhpc/Projects/Accelerometer/6-Outputs/ALL_Accel_data_summary.xlsx`
    * Be sure to paste **values only** and not formulas
    * Enter in date manually, not updating correctly
    * Drag down formulas from existing row

9. Update the `/Volumes/vosslabhpc/Projects/Accelerometer/4-Analysis/ActiGraph_analysis_summary.xlsx` to show that you completed the analysis and copied the values into the summary data sheet. 

## Make Activity Reports

1. Copy and paste updated graphs into a Report and save as `.pdf`
2. Ready to send to the participant!








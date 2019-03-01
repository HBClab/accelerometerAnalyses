# HBC lab accelerometer analysis

<!-- (https://ecotrust-canada.github.io/markdown-toc/) -->
- [Accelerometer materials on the server](#accelerometer-materials-on-the-server)
- [Data collection and storage](#data-collection-and-storage)
  * [Device maintenance and check-out](#device-maintenance-and-check-out)
  * [Initializing the accelerometer before use](#initializing-the-accelerometer-before-use)
  * [Downloading data](#downloading-data)
- [of axis: 3](#of-axis--3)
  * [Exporting downloaded data](#exporting-downloaded-data)
  * [Wear Time Validation](#wear-time-validation)
  * [Sleep Analysis](#sleep-analysis)


# Accelerometer materials on the server

The scripts and data output for the procedures described here are located on our server at:
`/Volumes/vosslabhpc/Projects/Accelerometer`

**Document history:** The manual was initially developed and written as a word document by Lauren Reist and Rachel Clark Cole, and updated by Lauren and Abby Mickley in August 2018. As of March 2019, we are putting the manual into a markdown file so that we can more easily track changes collaborative edits time. 


# Data collection and storage

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



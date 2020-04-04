# accelerometerAnalyses

For device preparation and analyses here we aim to keep an updated markdown guide and example scripts for our analyses of lifestyle activity and sleep based accelerometer measures. Below are resources commonly used to inform our analysis decision and scripts.
* [Working document](https://docs.google.com/document/d/17TNZZvJFBjL2qUoh3NPVUbQWhLub9iz2mz3hYD0mxjw/edit?usp=sharing) documenting update of analysis decisions based on recent papers (Menai et al; Cabanas-Sanches et al)
* [R code and post-processing script](https://github.com/HBClab/accelerometerAnalyses/blob/master/key-papers/Cabanas-Sanchez_%20GGIR_proccesing.R) used in Cabanas-Sanchez et al., 2019 
* [Working document](https://docs.google.com/document/d/1BgBa-3dfzeY-CC7VV0Ui5lI3ciEGKPAOZHgIpvRG6gU/edit?usp=sharing) annotating Cabanas-Sanchez et al., 2019 code and where modifications should be considered for our sample


</br>

## Literature tracking sheet
* [Link to shared google doc](https://docs.google.com/spreadsheets/d/1YL4whsPbZzHwvM_Q4FRuhpljLQG9wr8kREy8r6ICwT8/edit?usp=sharing) for tracking the literature on the methods of accelerometer use in research. 
* [Link](https://github.com/HBClab/accelerometerAnalyses/tree/master/key-papers) to our repository of PDFs of key papers


</br>

## Overview of our data collection methods
* Wear time: All participants wore a GT9X ActiGraph Link accelerometer (ActiGraph; Pensacola,
Florida) on the non-dominant wrist for seven consecutive days during both wake and
sleep. Participants were asked to wear the device at all times except during water activities (e.g., showering, washing dishes, etc.). A daily activity log was maintained to cross-check times in and out of bed, non-wear times, and perceived exertion. Participants enrolled in a training study were inactive and wore the device before randomization. 

Data recording: 
* Number of days: 7 
* Time: 12am to 12am (midnight-to-midnight)
* Sampling rate: 60 Hz
* Options: 
  * Enabled: idle sleep mode was enabled, show display, steps not shown
  * Not enabled: wireless and heart rate, IMU 

Data download and reduction: 
* Processed with the ActiLife v6.13.3 software
* Raw data saved in .csv -> this is the data input to GGIR
* Data also reduced to 60 second epochs in ActiLife and saved in .csv for potential analysis with ActiLife or other softwares


</br>

## Finding help with GGIR

* [GGIR manual with working examples](https://cran.r-project.org/web/packages/GGIR/vignettes/GGIR.html)
* [GGIR R package page](https://cran.r-project.org/web/packages/GGIR/index.html)
* [GGIR defaults](https://docs.google.com/spreadsheets/d/1kX32vmafaGPmlnSpjmCzFA9LSbKJv1DaCNB9hyx85po/edit?usp=sharing)
* [GGIR google listserv](https://groups.google.com/forum/#!forum/rpackageggir)
* [GGIR github page](https://github.com/wadpac/GGIR) where you can see or open issues and package updates

################################################################################
#Packages
################################################################################
#Sólo la primera vez (seleccionar la fila 5 y pinchar en control+intro or run porque es para installar el pacquete ggir)
install.packages("GGIR")

#Siempre que abras R (para cargar el paquete de GGIR: seleccionar fila 8 library y control+intor or run)
library(GGIR)

################################################################################
#Configuraciones básicas 
################################################################################
datadir = "./csv/"
outputdir= "./"
metadatadir = ""
desiredtz = "Europe/Madrid"

################################################################################
#G.PART1  para transformar los archivos a 5 sec ; f0 = 1, f1 = 1 ( habría que poner f1= hasta el nº maxi de archivos que hay en la carpeta)
#SI sale error instalar zoo: install.packages("zoo") y library(zoo)#)
################################################################################
#5 seconds files
g.part1(datadir = datadir, outputdir = outputdir, f0 = 1, f1 = 3000, 
        windowsizes = c(5, 900, 3600), 
        desiredtz = desiredtz, dynrange = 8,
        chunksize = 1, studyname = "impact65",
        do.enmo = TRUE, do.anglez = TRUE,
        do.cal = TRUE, use.temp = TRUE, spherecrit = 0.3, minloadcrit = 72, 
        printsummary = TRUE, print.filename = TRUE, overwrite = FALSE)


################################################################################
#G.SHELL 
################################################################################
g.shell.GGIR(mode = 2:5, datadir = datadir, outputdir = outputdir,
             f0 = 1,f1 = 1600,
             studyname = "IMPACT65",
             overwrite = FALSE,
             storefolderstructure = FALSE, 
             do.parallel = TRUE,
             #PART 2
             strategy = 1,
             hrs.del.start = 0, hrs.del.end = 0,
             maxdur = 0,
             includedaycrit = 0,
             qlevels = c(960/1440,   #M1/3 (8h)
                         1320/1440, 1380/1440,  #M120, M60
                         1410/1440, 1430/1440,  #M30, M10
                         1435/1440, 1438/1440), #M5, M2
             ilevels = seq(0,600,by = 25),
             idloc = 2,
             do.imp = TRUE,
             epochvalues2csv = TRUE,
             desiredtz = desiredtz,
             dayborder = 12,
             L5M5window = c(0,24), M5L5res = 10,
             winhr = c(5,10),
             #PART 3
             anglethreshold = 5,timethreshold = 5,
             ignorenonwear=TRUE, acc.metric="ENMO",do.part3.pdf=TRUE,
             #PART 4
             do.visual=TRUE, 
             outliers.only = FALSE,
             def.noc.sleep = 1,
             excludefirstlast = FALSE, 
             includenightcrit = 0,
             #PART 5
             acc.metric = "ENMO",
             excludefirstlast.part5 = FALSE,
             threshold.lig = c(45), threshold.mod = c(100), threshold.vig = c(430),
             boutcriter.mvpa=0.8, boutcriter.in=0.9, boutcriter.lig=0.8,
             timewindow=c("MM", "WW"), 
             boutdur.mvpa = c(1,5,10), boutdur.in = c(10,20,30), boutdur.lig = c(1,5,10),
             desiredtz="Europe/Madrid", bout.metric=4,
             #REPORTS
             do.report = c(2,4,5),
             visualreport = TRUE)



################################################################################
#REMOVE DAYS BASED ON CRITERIA BY VERO
################################################################################
file.rename("./output_csv/meta/ms5.out/", "./output_csv/meta/ms5.out_original/")
dir = "./output_csv/meta/ms5.out_original/"
files = dir("./output_csv/meta/ms5.out_original/")
for(i in 1:length(files)){
  load(paste0(dir,files[i]))
  del = c()
  del.tmp1 = del.tmp3 = del.tmp4b = NA
  
  if("removed" %in% ls() == F){
    removed = data.frame(crit = c("1","3","4b","Totals"), 
                         nights = rep(0,4), 
                         participants_affected = rep(0,4),
                         participants_no_valid = rep(0,4), 
                         participants_zero_days = rep(0,4))
  }
  
  if("removed_person" %in% ls() == F){
    removed_person = data.frame(id = files, 
                                nights_crit1 = 0, 
                                nights_crit3 = 0,
                                nights_crit4b = 0,
                                nights_allcrit = 0)
  }
  
  if("parts_1" %in% ls() == F) parts_1 = 0
  if("parts_3" %in% ls() == F) parts_3 = 0
  if("parts_4b" %in% ls() == F) parts_4b = 0
  
  #Valid hours
  del = which(as.numeric(output$window_length_in_hours) < 16)
  if(length(del) > 0) output = output[-del,]
  
  #Crit. 1
  diff_wake = as.numeric(output$acc_wake) - mean(as.numeric(output$acc_wake), na.rm = T)
  diff_onset = as.numeric(output$acc_onset) - mean(as.numeric(output$acc_onset), na.rm = T)
  diff_bedtime = (as.numeric(output$dur_night_min) - mean(as.numeric(output$dur_night_min)))/60
  
  if("affected1" %in% ls() == F) affected1 = c()
  crit1 = FALSE
  if(TRUE %in% (abs(diff_bedtime) > 3) & TRUE %in% (abs(diff_wake) > 3)){
    bedtime = which(abs(diff_bedtime) > 3)
    wake = which(abs(diff_wake) > 3)
    if(length(intersect(bedtime, wake)) > 0) crit1 = TRUE
  }
  
  if(TRUE %in% (abs(diff_bedtime) > 3) & TRUE %in% (abs(diff_onset) > 3)){
    bedtime = which(abs(diff_bedtime) > 3)
    onset = which(abs(diff_onset) > 3)
    if(length(intersect(bedtime, onset)) > 0) crit1 = TRUE
  }
  
  if(crit1 == TRUE){
    affected1 = c(affected1,i)
    del.tmp1 = c(which(abs(diff_wake) > 3 & abs(diff_bedtime) > 3), 
                 which(abs(diff_onset) > 3 & abs(diff_bedtime) > 3))
    del.tmp1 = unique(del.tmp1)
    output.tmp = output[-del.tmp1,]
    
    parts_1 = parts_1 + 1
    no_weekends = length(which(output.tmp$weekday == "Saturday" | output.tmp$weekday == "Sunday"))
    novalid = ifelse((nrow(output.tmp) < 4 | (nrow(output.tmp) - no_weekends) < 3 | no_weekends < 1), 1, 0)
    zerodays = ifelse(nrow(output.tmp) == 0,1,0)
    
    removed[1,2:5] = c((as.numeric(removed[1,2]) + length(del.tmp1)), 
                       parts_1, 
                       (as.numeric(removed[1,4]) + novalid),
                       (as.numeric(removed[1,5]) + zerodays))
  }
  
  #Crit. 3
  onset_time = as.numeric(output$acc_onset) > 12 & as.numeric(output$acc_onset) < 19
  wake_time = as.numeric(output$acc_wake) > 13 & as.numeric(output$acc_wake) < 24
  if(TRUE %in% onset_time | TRUE %in% wake_time){
    del.tmp3 = c(which(onset_time == T), which(wake_time == T))
    output.tmp = output[-del.tmp3,]
    
    parts_3 = parts_3 + 1
    no_weekends = length(which(output.tmp$weekday == "Saturday" | output.tmp$weekday == "Sunday"))
    novalid = ifelse((nrow(output.tmp) < 4 | (nrow(output.tmp) - no_weekends) < 3 | no_weekends < 1), 1, 0)
    zerodays = ifelse(nrow(output.tmp) == 0,1,0)
    removed[2,2:5] = c((as.numeric(removed[2,2]) + length(del.tmp3)), 
                       parts_3, 
                       (as.numeric(removed[2,4]) + novalid),
                       (as.numeric(removed[2,5]) + zerodays))  
  }
  
  #Crit. 4b
  if(TRUE %in% (as.numeric(output$dur_night_min) < 4*60)){
    del.tmp4b = which(as.numeric(output$dur_night_min) < 4*60)
    output.tmp = output[-del.tmp4b,]
    
    parts_4b = parts_4b + 1
    no_weekends = length(which(output.tmp$weekday == "Saturday" | output.tmp$weekday == "Sunday"))
    novalid = ifelse((nrow(output.tmp) < 4 | (nrow(output.tmp) - no_weekends) < 3 | no_weekends < 1), 1, 0)
    zerodays = ifelse(nrow(output.tmp) == 0,1,0)
    removed[3,2:5] = c((as.numeric(removed[3,2]) + length(del.tmp4b)), 
                       parts_4b, 
                       (as.numeric(removed[3,4]) + novalid),
                       (as.numeric(removed[3,5]) + zerodays))    
  }
  
  del.tmp = unique(c(del.tmp1, del.tmp3, del.tmp4b))
  del.tmp = del.tmp[is.na(del.tmp) == FALSE]
  if(length(del.tmp) > 0) output = output[-del.tmp,]
  
  
  #Removed totals summary 
  parts.comb = ifelse(length(del.tmp) == 0, 0, 1)
  no_weekends = length(which(output$weekday == "Saturday" | output$weekday == "Sunday"))
  novalid = ifelse((nrow(output) < 4 | (nrow(output) - no_weekends) < 3 | no_weekends < 1), 1, 0)
  zerodays = ifelse(nrow(output) == 0,1,0)
  
  ##
  if(novalid == 1) print(paste("novalid:",i))
  if(zerodays == 1) print(paste("ZERO:",i))
  ##
  
  removed[4,1:5] = c("Totals", 
                     (as.numeric(removed[4,2]) + length(del.tmp)), 
                     (as.numeric(removed[4,3]) + parts.comb), 
                     (as.numeric(removed[4,4]) + novalid),
                     (as.numeric(removed[4,5]) + zerodays))
  
  removed_person[i,2:5] = c(sum(del.tmp1 > 0, na.rm = T), 
                            sum(del.tmp3 > 0, na.rm = T), 
                            sum(del.tmp4b > 0, na.rm = T), 
                            sum(unique(c(del.tmp1,del.tmp3,del.tmp4b)) > 0, na.rm = T))
  
  if(dir.exists("./output_csv/meta/ms5.out/") == FALSE) dir.create("./output_csv/meta/ms5.out/")
  
  save(output, file = paste0("./output_csv/meta/ms5.out/", files[i]))
  
  if(i == length(files)){
    write.csv(removed, './excluded_nights.csv', row.names = F)
    write.csv(removed_person, './excluded_nights_person.csv', row.names = F)
  }
}

################################################################################
#NEW DATABASE AFTER REMOVING ABNORMAL DAYS 
################################################################################

g.report.part5(metadatadir="./output_csv/", f0 = 1, f1 = 3000, includenightcrit = 16, includedaycrit = 16)

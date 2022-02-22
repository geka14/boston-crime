install.packages("scales")

library("dplyr")
library("tidyverse")
library("chron")
library("ggplot2")
library("janitor")
library("Hmisc")
library("funModeling")
library("tidyverse")
library("openair")
library("rticles")
library("lubridate")
library("tidyr")
library("skimr")
library("rmarkdown")
library("visdat")
library("maps")
library("leaflet")
library("plotly")
library("waffle") 
library("DataExplorer")
library("lattice")
library("wordcloud")
library("gridExtra")
library("scales")

boston<-read.csv(file.choose(),sep=",")

#Menghapus duplicate data pada dataset boston
boston<-unique(boston)

#Mengubah seluruh blank cells menjadi NA
boston<-boston %>% mutate_all(na_if,"")

#Merangkum jumlah missing data pada tiap kolom
sort(sapply(boston, function(x) sum(is.na(x))), decreasing = TRUE)

#Melakukan plotting missing values dari dataset Boston
plot_missing(boston,ggtheme=theme_bw())

#Melakukan input N pada sel NA pada kolom SHOOTING
boston$SHOOTING<-as.character(boston$SHOOTING)
boston[which(is.na(boston$SHOOTING), arr.ind=TRUE),7]<-"N"

#Menghapus kolom REPORTING_AREA
boston<-boston[,-6]

#Menghapus data dengan nilai DISTRICT NA
boston<-boston[!is.na(boston$DISTRICT),]

#Menghapus data dengan nilai UCR_PART NA
boston<-boston[!is.na(boston$UCR_PART),]

#Menghapus data dengan nilai STREET NA
boston<-boston[!is.na(boston$STREET),]

#Mencari nilai latitude dan longitude rata-rata dari setiap district sebagai dasar penggantian missing values
aggregate(Lat~DISTRICT,boston,mean)
aggregate(Long~DISTRICT,boston,mean)

#Menggunakan nilai rata-rata tiap district sebagai pengganti missing value lat dan long pada district tersebut
boston$Lat[boston$DISTRICT=="A1" & is.na(boston$Lat)]<-42.33520
boston$Lat[boston$DISTRICT=="A15" & is.na(boston$Lat)]<-42.17341
boston$Lat[boston$DISTRICT=="A7" & is.na(boston$Lat)]<-42.36426
boston$Lat[boston$DISTRICT=="B2" & is.na(boston$Lat)]<-42.31560
boston$Lat[boston$DISTRICT=="B3" & is.na(boston$Lat)]<-42.28343
boston$Lat[boston$DISTRICT=="C11" & is.na(boston$Lat)]<-42.29539
boston$Lat[boston$DISTRICT=="C6" & is.na(boston$Lat)]<-42.20461
boston$Lat[boston$DISTRICT=="D14" & is.na(boston$Lat)]<-42.33836
boston$Lat[boston$DISTRICT=="D4" & is.na(boston$Lat)]<-42.33758
boston$Lat[boston$DISTRICT=="E13" & is.na(boston$Lat)]<-42.31069
boston$Lat[boston$DISTRICT=="E18" & is.na(boston$Lat)]<-42.26097
boston$Lat[boston$DISTRICT=="E5" & is.na(boston$Lat)]<-42.21646
summary(boston$Lat)

boston$Long[boston$DISTRICT=="A1" & is.na(boston$Long)]<--71.02605
boston$Long[boston$DISTRICT=="A15" & is.na(boston$Long)]<--70.73582
boston$Long[boston$DISTRICT=="A7" & is.na(boston$Long)]<--71.00922
boston$Long[boston$DISTRICT=="B2" & is.na(boston$Long)]<--71.07442
boston$Long[boston$DISTRICT=="B3" & is.na(boston$Long)]<--71.07927
boston$Long[boston$DISTRICT=="C11" & is.na(boston$Long)]<--71.05462
boston$Long[boston$DISTRICT=="C6" & is.na(boston$Long)]<--70.84338
boston$Long[boston$DISTRICT=="D14" & is.na(boston$Long)]<--71.12293
boston$Long[boston$DISTRICT=="D4" & is.na(boston$Long)]<--71.07098
boston$Long[boston$DISTRICT=="E13" & is.na(boston$Long)]<--71.10003
boston$Long[boston$DISTRICT=="E18" & is.na(boston$Long)]<--71.11570
boston$Long[boston$DISTRICT=="E5" & is.na(boston$Long)]<--71.03244
summary(boston$Long)

#Mengecek hasil data preprocessing
plot_missing(boston,ggtheme=theme_bw())

#EDA
#Melihat pola kriminalitas di boston dari tahun 2015-2019
boston %>% filter(OFFENSE_CODE_GROUP %in% (boston  %>% count(OFFENSE_CODE_GROUP) %>% arrange(-n) %>% head(20) %>% pull(OFFENSE_CODE_GROUP))) %>% 
  ggplot(aes(YEAR, fill = OFFENSE_CODE_GROUP)) + geom_bar()+ scale_fill_ordinal()

ggplot(boston,aes(YEAR,fill=OFFENSE_CODE_GROUP,order=OFFENSE_CODE_GROUP))+
  geom_bar(colour="black")

#Melihat pola kriminalitas harian di Boston



ggplot(data=boston,aes(x=boston$YEAR,y=))+geom_point()

offhead<-head(boston,n=10)
offhead

head(boston)

COUNT


ggplot(boston, aes(YEAR, fill = count(OFFENSE_CODE_GROUP,)) +
  geom_histogram(binwidth = 500)

boston %>% filter(YEAR %in% (boston  %>% count(YEAR) %>% arrange(-n)  %>% pull(YEAR)),
              OFFENSE_DESCRIPTION %in% (df  %>% count(OFFENSE_DESCRIPTION) %>% arrange(-n) %>% head(10) %>% pull(OFFENSE_DESCRIPTION))) %>% 
  ggplot(aes(YEAR, fill = OFFENSE_DESCRIPTION))+
  geom_bar(position = "fill")+
  scale_fill_ordinal()+
  coord_flip()
       
boston  %>% count(YEAR) %>% arrange(-n) %>% pull(YEAR)),
OFFENSE_DESCRIPTION %in% (boston %>% count(OFFENSE_DESCRIPTION) %>% arrange(-n) %>% head(10) %>% pull(OFFENSE_DESCRIPTION)))
  ggplot(aes(YEAR, fill=OFFENSE_DESCRIPTION))+
  geom_col(fill = "navy")+
  labs(x = NULL, y = NULL)
  
  boston  %>% count(OFFENSE_CODE_GROUP) %>% arrange(-n) %>% 
    ggplot(aes(reorder(OFFENSE_CODE_GROUP,n), n))+
    geom_col(fill = "navy")+
    coord_flip()+
    labs(x = NULL, y = NULL)
  
  boston %>% filter(OFFENSE_CODE_GROUP %in% (boston  %>% count(OFFENSE_CODE_GROUP) %>% arrange(-n) %>% head(8) %>% pull(OFFENSE_CODE_GROUP))) %>% 
    ggplot(aes(YEAR, fill = OFFENSE_CODE_GROUP)) + geom_bar()+ scale_fill_ordinal()
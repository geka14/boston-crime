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

boston<-read.csv(file.choose(),sep=",") summary(boston) boston[boston$INCIDENT_NUMBER=="I152071596",] 

#Menghapus duplicate data pada dataset boston 
boston<-unique(boston)

#Mengubah seluruh blank cells menjadi NA 
boston<-boston %>% mutate_all(na_if,"")

#Merangkum jumlah missing data pada tiap kolom 
sort(sapply(boston, function(x) sum(is.na(x))), decreasing = TRUE)

#Melakukan plotting missing values dari dataset Boston 
plot_missing(boston,ggtheme=theme_bw())

#Melakukan input N pada sel NA pada kolom SHOOTING 
boston$SHOOTING<-as.character(boston$SHOOTING) boston[which(is.na(boston$SHOOTING), arr.ind=TRUE),7]<-"N"

#Menghapus kolom REPORTING_AREA 
boston<-boston[,-6]

#Menghapus data dengan nilai DISTRICT NA 
boston<-boston[!is.na(boston$DISTRICT),]

#Menghapus data dengan nilai UCR_PART NA 
boston<-boston[!is.na(boston$UCR_PART),]

#Menghapus data dengan nilai STREET NA 
boston<-boston[!is.na(boston$STREET),]

#Mencari nilai latitude dan longitude rata-rata dari setiap district sebagai dasar penggantian missing values
aggregate(Lat~DISTRICT,boston,mean) aggregate(Long~DISTRICT,boston,mean)

#Menggunakan nilai rata-rata tiap district sebagai pengganti missing value lat dan long pada district tersebut
boston$Lat[boston$DISTRICT=="A1" & is.na(boston$Lat)]<-42.33520 boston$Lat[boston$DISTRICT=="A15" & is.na(boston$Lat)]<-42.17341 boston$Lat[boston$DISTRICT=="A7" & is.na(boston$Lat)]<-42.36426 boston$Lat[boston$DISTRICT=="B2" & is.na(boston$Lat)]<-42.31560 boston$Lat[boston$DISTRICT=="B3" & is.na(boston$Lat)]<-42.28343 boston$Lat[boston$DISTRICT=="C11" & is.na(boston$Lat)]<-42.29539 boston$Lat[boston$DISTRICT=="C6" & is.na(boston$Lat)]<-42.20461 boston$Lat[boston$DISTRICT=="D14" & is.na(boston$Lat)]<-42.33836 boston$Lat[boston$DISTRICT=="D4" & is.na(boston$Lat)]<-42.33758 boston$Lat[boston$DISTRICT=="E13" & is.na(boston$Lat)]<-42.31069 boston$Lat[boston$DISTRICT=="E18" & is.na(boston$Lat)]<-42.26097 boston$Lat[boston$DISTRICT=="E5" & is.na(boston$Lat)]<-42.21646 summary(boston$Lat)
boston$Long[boston$DISTRICT=="A1" & is.na(boston$Long)]<--71.02605 boston$Long[boston$DISTRICT=="A15" & is.na(boston$Long)]<--70.73582 boston$Long[boston$DISTRICT=="A7" & is.na(boston$Long)]<--71.00922 boston$Long[boston$DISTRICT=="B2" & is.na(boston$Long)]<--71.07442 boston$Long[boston$DISTRICT=="B3" & is.na(boston$Long)]<--71.07927 boston$Long[boston$DISTRICT=="C11" & is.na(boston$Long)]<--71.05462 boston$Long[boston$DISTRICT=="C6" & is.na(boston$Long)]<--70.84338 boston$Long[boston$DISTRICT=="D14" & is.na(boston$Long)]<--71.12293 boston$Long[boston$DISTRICT=="D4" & is.na(boston$Long)]<--71.07098 boston$Long[boston$DISTRICT=="E13" & is.na(boston$Long)]<--71.10003 boston$Long[boston$DISTRICT=="E18" & is.na(boston$Long)]<--71.11570
boston$Long[boston$DISTRICT=="E5" & is.na(boston$Long)]<--71.03244 summary(boston$Long)

#Mengecek hasil data preprocessing 
plot_missing(boston,ggtheme=theme_bw())

#EDA
            
#Plotting correlation antar variabel 
plot_correlation(boston)

#Melihat pola kriminalitas di boston dari tahun 2015-2019 
ggplot(boston,aes(YEAR,fill=OFFENSE_CODE_GROUP,order=OFFENSE_CODE_GROUP))+geom_bar()
            
#Melihat pola kriminalitas bulanan di Boston 
ggplot(boston,aes(MONTH,fill=OFFENSE_CODE_GROUP,order=OFFENSE_CODE_GROUP))+ geom_bar() + ggtitle("Tingkat Kriminalitas Berdasarkan Bulan Kejadian")

#Memetakan hubungan antara hari dengan jam untuk mengetahui hari dan waktu paling rawan terjadi tindak kejahatan di Boston
ggplot(data=boston,aes(x=DAY_OF_WEEK,y=HOUR))+geom_bin2d(bins=8)+scale_fill_continuous(typ e="viridis")+theme_bw()+ggtitle("Pola Hubungan Hari dan Waktu Kejadian Kriminalitas")

#Analisa spasial dari kota Boston
ggplot(data=boston,aes(x=Long,y=Lat))+xlim(-71.2,- 70.95)+ylim(42.22,42.4)+geom_hex(bins=39)+scale_fill_continuous(type="viridis")+theme_bw()+ggti tle("Tingkat Kriminalitas Berdasarkan Daerah Kejadian")
base<-qplot(Long, Lat, data= boston,color=DISTRICT, geom='point', xlim = c(-71.2,-70.95), ylim= c(42.22,42.4))+
theme_bw(base_size=15)+ geom_point(size = 2)

#Melihat tingkat kejahatan berdasarkan district boston %>% count(DISTRICT) %>% arrange(-n) %>%
ggplot(aes(reorder(DISTRICT,n),n), n)+
geom_col(fill = "navy")+
coord_flip()+
labs(x = NULL, y = NULL) + ggtitle("Tingkat Kriminalitas Berdasarkan District")
            
#Melihat statistik jenis kejahatan di kota Boston
boston %>% count(OFFENSE_CODE_GROUP) %>% arrange(-n) %>%
ggplot(aes(reorder(OFFENSE_CODE_GROUP,n), n))+ geom_col(fill = "navy")+
coord_flip()+
labs(x = NULL, y = NULL)
            
#Pembuatan pie chart
larceny<- boston[boston$OFFENSE_CODE_GROUP=="Larceny",] slices<-c(34271,378453)
lbls <- c("Pencurian","Tindak Kriminal Lain")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) 
lbls <- paste(lbls,"%",sep="")
pie(slices,labels = lbls, col=rainbow(length(lbls)),
main="Proporsi Pencurian Dibanding Tindak Kriminal Lain") pie()
            
#Memetakan hubungan hari dan waktu terjadinya pencurian
ggplot(data=larceny,aes(x=DAY_OF_WEEK,y=HOUR))+geom_bin2d(bins=8)+scale_fill_continuous(typ e="viridis")+theme_bw()+ggtitle("Pola Hubungan Hari dan Waktu Kejadian Pencurian")

#Memetakan daerah paling sering terjadinya pencurian
ggplot(data=larceny,aes(x=Long,y=Lat))+xlim(-71.2,- 70.95)+ylim(42.22,42.4)+geom_hex(bins=33)+scale_fill_gradient(low='darkmagenta',high='gold')+th eme_bw()+ggtitle("Tingkat Pencurian Berdasarkan Daerah Kejadian")
base<-qplot(Long, Lat, data= larceny,color=DISTRICT, geom='point', xlim = c(-71.2,-70.95), ylim= c(42.22,42.4))+
theme_bw(base_size=15)+ geom_point(size = 2)

#Memetakan district yang paling sering terjadi pencurian larceny %>% count(DISTRICT) %>% arrange(-n) %>%
ggplot(aes(reorder(DISTRICT,n),n), n)+
geom_col(fill = "navy")+
coord_flip()+
labs(x = NULL, y = NULL) + ggtitle("Daerah Paling Rawan Terjadi Pencurian")

#TOP 5 jalan paling rawan pencurian di distrik D4 street_crime <- sort(table(la1$STREET), decreasing = TRUE) head(street_crime, 10)
la1<-larceny[larceny$DISTRICT=="D4" & larceny$STREET=="BOYLSTON ST",] la2<-larceny[larceny$DISTRICT=="D4" & larceny$STREET=="NEWBURY ST",] la3<-larceny[larceny$DISTRICT=="D4" & larceny$STREET=="HUNTINGTON AVE",] la4<-larceny[larceny$DISTRICT=="D4" & larceny$STREET=="HARRISON AVE",] la5<-larceny[larceny$DISTRICT=="D4" & larceny$STREET=="MASSACHUSETTS AVE",] la<-rbind(la1,la2,la3,la4,la5)
la %>% count(STREET) %>% arrange(-n) %>% ggplot(aes(reorder(STREET,n), n) )+ geom_col(fill = "green")+
coord_flip()+labs(x = NULL, y = NULL)+ggtitle("5 Jalan Paling Rawan Pencurian di Distrik D4")

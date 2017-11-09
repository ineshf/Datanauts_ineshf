
dat<-read.csv("/home/ines/Escritorio/nasa/fireball/cneos_fireball_data.csv")
head(dat)
dim(dat)
str(dat)
#Clusterizacion basada en caracteristicas fisicas del meteorito 
fdat<-dat[,4:10]
fdat[is.na(fdat)] <- 0
head(fdat)
str(fdat)

set.seed(123)
#Escalamos lso datos
scaled_data = as.matrix(scale(fdat))

k.max <- 25
data <- scaled_data
wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=50,iter.max = 15 )$tot.withinss})
wss
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Numeros de cluster K",
     ylab="Total sum squares")

#Clusters de 9-10 segmentos
#Le metemos estacion del año

library(lubridate)
getSeason <- function(input.date){
  numeric.date <- 100*month(input.date)+day(input.date)
  ## input Seasons upper limits in the form MMDD in the "break =" option:
  cuts <- base::cut(numeric.date, breaks = c(0,319,0620,0921,1220,1231)) 
  # rename the resulting groups (could've been done within cut(...levels=) if "Winter" wasn't double
  levels(cuts) <- c("Winter","Spring","Summer","Fall","Winter")
  return(cuts)
}
season<-getSeason(parse_date_time(dat$Peak.Brightness.Date.Time..UT., orders ="y-m-d H:M:S"))
dummy_season<-data.frame(model.matrix(~season-1))
#unimos el dataset escalado con el de las estaciones
sdata<-cbind(scaled_data,dummy_season)
sdata2<-cbind(fdat,dummy_season)
k.max <- 25
data <- sdata

wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=50,iter.max = 15 )$tot.withinss})
wss
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Numeros de cluster K",
     ylab="Total sum squares")
#Parece no afectar la epoca del año!
#Lo metemos por mes?
mes<-month(parse_date_time(dat$Peak.Brightness.Date.Time..UT., orders ="y-m-d H:M:S"))
dummy_month<-data.frame(model.matrix(~mes-1))
#unimos el dataset escalado con el de las estaciones
sdata<-cbind(scaled_data,dummy_month)
k.max <- 25
data <- sdata
wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=50,iter.max = 15 )$tot.withinss})
wss
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Numeros de cluster K",
     ylab="Total sum squares")
#Parece no afectar la eestacion del año!
datestacon<-cbind(dat,season)
año<-year(parse_date_time(dat$Peak.Brightness.Date.Time..UT., orders ="y-m-d H:M:S"))
destaño<-cbind(datestacon,año)
desta<-destaño %>%
  group_by(season,año) %>%
  summarise(count=n())

gr4 <- ggplot(desta, aes(x=season, y=count)) + geom_bar(stat="identity") 
gr4+facet_grid(año ~.)



#Veamos numero de meteoritos por mes
library(dplyr)
datames<-cbind(fdat, mes)
dres<-datames %>%
  group_by(mes) %>%
  summarise(count=n())
plot(dres)
#Parece que octubre mola! 
#veamos por año y mes
año<-year(parse_date_time(dat$Peak.Brightness.Date.Time..UT., orders ="y-m-d H:M:S"))
dataño<-cbind(datames,año)
dres<-dataño %>%
  group_by(mes,año) %>%
  summarise(count=n())

gr4 <- ggplot(dres, aes(x=mes, y=count)) + geom_bar(stat="identity") 
gr4+facet_grid(año ~.)


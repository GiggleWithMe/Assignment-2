stormdata = read.csv(bzfile("repdata-data-StormData.csv.bz2"), header = TRUE)
stormdata$year <- as.numeric(format(as.Date(stormdata$BGN_DATE, format = "%m/%d/%Y %H:%M:%S"), "%Y"))
hist(stormdata$year, breaks = 30)
redstormdata <- stormdata[,c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG")]
fataldata <-aggregate(redstormdata$FATALITIES,by=list(redstormdata$EVTYPE), FUN=sum, na.rm=TRUE)
colnames(fataldata) = c("event.type", "fatality.total")
fatals <- fataldata[order(-fataldata$fatality.total),] 
fatalities <- fatals[1:10,]
fatalities$event.type <- factor(fatalities$event.type, levels=fatalities$event.type, ordered=TRUE)
barplot(fatalities$fatality.total,names.arg = fatalities$event.type,las=2)
injdata <-aggregate(redstormdata$INJURIES,by=list(redstormdata$EVTYPE), FUN=sum, na.rm=TRUE)
colnames(injdata) = c("event.type", "injuries.total")
inj <- injdata[order(-injdata$injuries.total),] 
injuries <- inj[1:10,]
injuries$event.type <- factor(injuries$event.type, levels=injuries$event.type, ordered=TRUE)
barplot(injuries$injuries.total,names.arg = injuries$event.type,las=2)

dmgdata <-aggregate(redstormdata$PROPDMG,by=list(redstormdata$EVTYPE), FUN=sum, na.rm=TRUE)
colnames(dmgdata) = c("event.type", "damage.total")
dmg <- dmgdata[order(-dmgdata$damage.total),] 
damage <- dmg[1:10,]
damage$event.type <- factor(damage$event.type, levels=damage$event.type, ordered=TRUE)
barplot(damage$damage.total,names.arg = damage$event.type,las=2)

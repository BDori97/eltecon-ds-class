Feladatok
# 1) Hokis adatok, Preisinger Péterrel
# 2) Adatok: http://inalitic.com/datasets/nhl%20player%20data.html?fbclid=IwAR0-BV1_ZVfUOm22DOq5G-nfsGdO8sfyOCax5zUhmEmKBlFY3hSvWGhcVEA 
# 3) Hiányzó/kiugró értékek, duplikátumok, furcsaságok, eloszlások, stb.
# 4) Kódfeltöltés
# 5) Adatok megosztása 

library(data.table)
library(chron)

skater_stats <- fread("C:/Users/barat_ojs0p6a/Documents/eltecon-ds-class/skater_stats.csv")

summary(skater_stats)
str(skater_stats)

# Delete data before 2008, because some data was not collected before
skater_stats <- skater_stats[Season >= 2008]

# Delete col "V1"
skater_stats$V1 <- NULL # értelmetlen adat volt

# Converting to numeric (or 'times') where neccesary
skater_stats[, G := as.numeric(G)]
skater_stats[, PTS := as.numeric(PTS)]
skater_stats[, A := as.numeric(A)]
skater_stats[, PIM := as.numeric(PIM)]
skater_stats[, EVG := as.numeric(EVG)]
skater_stats[, PPG := as.numeric(PPG)]
skater_stats[, SHG := as.numeric(SHG)]
skater_stats[, GWG := as.numeric(GWG)]
skater_stats[, EVA := as.numeric(EVA)]
skater_stats[, PPA := as.numeric(PPA)]
skater_stats[, SHA := as.numeric(SHA)]
skater_stats[, S := as.numeric(S)]

skater_stats$ATOI = paste0("00:", skater_stats$ATOI)     # needs to be converted to hours first
skater_stats[, ATOI := times(skater_stats$ATOI)]         # special numeric type for time
skater_stats$TOI = skater_stats$ATOI*skater_stats$GP     # setting TOI from ATOI and GP to have time format

# Rename columns: "+/-", "S%", FO%
colnames(skater_stats)[colnames(skater_stats)=="+/-"] <- "Plus_minus"
colnames(skater_stats)[colnames(skater_stats)=="S%"] <- "S_percent"
olnames(skater_stats)[colnames(skater_stats) == "FO%"] <- "FO_percent"

skater_stats[, Plus_minus := as.numeric(Plus_minus)] 
skater_stats[, S_percent := as.numeric(S_percent)]  

str(skater_stats)

# Changing NA to 0 where that makes sense
skater_stats$G[is.na(skater_stats$G)] <- 0
skater_stats$A[is.na(skater_stats$A)] <- 0
skater_stats$PTS[is.na(skater_stats$PTS)] <- 0
skater_stats$Plus_minus[is.na(skater_stats$Plus_minus)] <- 0
skater_stats$PIM[is.na(skater_stats$PIM)] <- 0
skater_stats$EVG[is.na(skater_stats$EVG)] <- 0
skater_stats$PPG[is.na(skater_stats$PPG)] <- 0
skater_stats$SHG[is.na(skater_stats$SHG)] <- 0
skater_stats$GWG[is.na(skater_stats$GWG)] <- 0
skater_stats$EVA[is.na(skater_stats$EVA)] <- 0
skater_stats$PPA[is.na(skater_stats$PPA)] <- 0
skater_stats$SHA[is.na(skater_stats$SHA)] <- 0
skater_stats$S[is.na(skater_stats$S)] <- 0
skater_stats$S_percent[is.na(skater_stats$S_percent)] <- 0
skater_stats$BLK[is.na(skater_stats$BLK)] <- 0
skater_stats$HIT[is.na(skater_stats$HIT)] <- 0
skater_stats$FOwin[is.na(skater_stats$FOwin)] <- 0
skater_stats$FOloss[is.na(skater_stats$FOloss)] <- 0

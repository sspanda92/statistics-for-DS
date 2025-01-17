#install.packages("pylr")
#install.packages("ggplot2")
#install.packages("fitdistrplus")
library(plyr)
library(ggplot2) 
library(fitdistrplus)
#file<-'/Users/pushpitapanigrahi/Desktop/PushpitaFiles/Study/4.StatsForDS/Proj1/Selected/networkbnbTX.txt'
#file<- "D:/UTD/Academics/Fourth Sem/Stats for Data Science - Cuneyt/Project1/Token Graphs/networkbnbTX.txt"
file <-'B:/study/Fall 2018/Stats for DS/Project1/Datasets/Ethereum token graphs/networkbnbTX.txt'
col_names <- c("FROMNODE","TONODE","TIME","TOKENAMOUNT")
mydata <- read.csv( file, header = FALSE, sep = " ", dec = ".", col.names = col_names)
amounts <- mydata[4]

totalSupply <- 192443301
subUnits <- 18
totalAmount <- totalSupply * (10 ^ subUnits)
temp <- which(mydata< totalAmount)
#print meta data 
message('Maximum allowed amount : ', totalAmount)
count <- 0
outliers <- 0
for( a in 1:nrow(amounts)){
  if( a > totalAmount){
    outliers <- outliers + 1
  }
  else{
    count <- count + 1
  }
}
message('Number of outliers : ',outliers)
message('Number of valid amounts : ',count)


#graph1
countFromDf <- count(mydata, "FROMNODE")

countFromFf <- count(countFromDf, "freq")
colnames(countFromFf) <- c("Users_Count", "Sell_Count")
head(countFromFf)
message("DISTRIBUTION PARAMETERS OF THE NUMBER OF SELLERS ",descdist(countFromFf$Sell_Count, boot= 500))

distributionFit_Seller_pois <- fitdist(countFromFf$Sell_Count, "pois", method ="mle")
distributionFit_Seller_wb <- fitdist(countFromFf$Sell_Count, "weibull", method ="mle")
distributionFit_Seller_ln <- fitdist(countFromFf$Sell_Count, "lnorm", method ="mle")
distributionFit_Seller_gm <- fitdist(countFromFf$Sell_Count, "gamma" ,method="mme")
distributionFit_Seller

plot(distributionFit_Seller_wb)
plot(distributionFit_Seller_pois)
plot(distributionFit_Seller_ln)
plot(distributionFit_Seller_gm)


#graph2
countToDf <- count(mydata, "TONODE")
countToFf <- count(countToDf, "freq")
colnames(countToFf) <- c("Users_Count", "Buy_Count")
head(countToFf)
descdist(countToFf$Buy_Count, boot=500)
# ggplot(countToDf, aes(x= n))+geom_histogram() +xlab("Frequency") +ylab("Number of Buyers (Density)")
message("DISTRIBUTION PARAMETERS OF THE NUMBER OF BUYERS ",descdist(countToFf$Buy_Count, boot=500))
distributionFit_Buyer_pois <- fitdist(countToFf$Buy_Count, "pois", method ="mle")
distributionFit_Buyer_wb <- fitdist(countToFf$Buy_Count, "weibull", method ="mle")
distributionFit_Buyer_ln <- fitdist(countToFf$Buy_Count, "lnorm", method ="mle")
distributionFit_Buyer_gm <- fitdist(countToFf$Buy_Count, "gamma", method ="mme")


plot(distributionFit_Buyer_pois, xlim(0, 100))
plot(distributionFit_Buyer_wb)
plot(distributionFit_Buyer_ln)
plot(distributionFit_Buyer_gm)

distributionFit_Seller_wb
distributionFit_Seller_pois
distributionFit_Seller_ln
distributionFit_Seller_gm


distributionFit_Buyer_pois
distributionFit_Buyer_wb
distributionFit_Buyer_ln
distributionFit_Buyer_gm
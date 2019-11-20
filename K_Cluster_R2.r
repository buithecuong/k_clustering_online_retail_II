


install.packages("readxl")
 library("readxl")
 install.packages("plyr")
library("plyr")
#df <- read_excel("https://archive.ics.uci.edu/ml/machine-learning-databases/00502/online_retail_II.xlsx")

df <- read_excel("C:\\ML\\New\\online_retail_II.xlsx")

#omit NA
df<-na.omit(df)
#create Amount variable#
df$Amount <- df$Quantity * df$Price
#create SKU variable
df$SKU <- substr(df$StockCode,1,3)
#separate date & time#
df$InvoiceDate<-strptime(df$InvoiceDate,"%Y-%m-%d %H:%M",tz="")
df$InvoiceTime = format(df$InvoiceDate,"%H")
df$InvoiceDate<-as.Date(df$InvoiceDate,"%Y-%m-%d")

# df$InvoiceDate<-strptime(df$InvoiceDate,"%d/%m/%Y %H:%M",tz="")
# df$InvoiceTime = format(df$InvoiceDate,"%H")
# df$InvoiceDate<-as.Date(df$InvoiceDate,"%d/%m/%Y")

# df$InvoiceTime = format(as.POSIXct(strptime(df$InvoiceDate,"%d/%m/%Y %H:%M",tz="")) ,format = "%H:%M")
# df$InvoiceDate<-format(as.POSIXct(strptime(df$InvoiceDate,"%d/%m/%Y %H:%M",tz="")) ,format = "%d/%m/%Y")
#look at internal structure#
str(df)

summary(df)
#View the top#
head(df)

## boxplot of Amount
boxplot(df$Amount)$stats[c(1, 5), ]

## [1] -18.75  42.45
#cutoff outliner
df<-subset(df,df$Amount>= 0 & df$Amount<= 10000 )
boxplot(df$Amount)$stats[c(1, 5), ]


#top 5 most important

df1 <- ddply(df, .(StockCode,Description), summarize, sumAmount= sum(Amount), sumQuantity= sum(Quantity), nCustomer= length(unique('Customer ID')), nPurchase= length(unique(Invoice)) )

head(df1[order(-df1$sumQuantity),] )

head(df1[order(-df1$sumAmount),] )

head(df1[order(-df1$nPurchase),] )

#Do these sales of top selling products change with time (months)?Any seasonality?
df2 <- subset(df, Description%in%c("MEDIUM CERAMIC TOP STORAGE JAR","JUMBO BAG RED RETROSPOT","REGENCY CAKESTAND 3 TIER","WHITE HANGING HEART T-LIGHT HOLDER","PARTY BUNTING","WORLD WAR 2 GLIDERS ASSTD DESIGNS"), select = c(Description,InvoiceDate,InvoiceTime,Quantity,'Customer ID',Amount,Invoice))
df2$Invoice_month<-month(df2$InvoiceDate)
df2$Decription<-as.character(df2$Description)


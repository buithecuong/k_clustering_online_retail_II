


install.packages("readxl")
 library("readxl")
#df <- read_excel("https://archive.ics.uci.edu/ml/machine-learning-databases/00502/online_retail_II.xlsx")

df <- read_excel("C:\\ML\\online_retail_II.xlsx")

#omit NA
df<-na.omit(df)
#create Amount variable#
df$Amount <- df$Quantity * df$UnitPrice
#create SKU variable
df$SKU <- substr(df$StockCode,1,3)
#separate date & time#
df$InvoiceDate<-strptime(df$InvoiceDate,"%d/%m/%Y %H:%M",tz="")
df$InvoiceTime = format(df$InvoiceDate,"%H")
df$InvoiceDate<-as.Date(df$InvoiceDate,"%d/%m/%Y")

df$InvoiceTime = format(as.POSIXct(strptime(df$InvoiceDate,"%d/%m/%Y %H:%M",tz="")) ,format = "%H:%M")
df$InvoiceDate<-format(as.POSIXct(strptime(df$InvoiceDate,"%d/%m/%Y %H:%M",tz="")) ,format = "%d/%m/%Y")
#look at internal structure#
str(df)

#View the top#
head(df)

## boxplot of Amount
boxplot(df$Amount)$stats[c(1, 5), ]

## [1] -18.75  42.45
#cutoff outliner
Retail<-subset(df,df$Amount>= 0 & df$Amount<= 10000 )
boxplot(Retail$Amount)$stats[c(1, 5), ]



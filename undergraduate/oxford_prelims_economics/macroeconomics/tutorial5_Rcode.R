# Prelims Economics: Macroeconomics Problem Set 5
# Written by David Murakami
# St Hildas College, University of Oxford

rm(list=ls(all=TRUE));
graphics.off();

# load libraries
library(readxl);
library(tseries);
library(TSA);
library(mFilter);
library(quantmod);
library(xts);

# set working directory accordingly for your computer:
# setwd();
getwd();

# import data
usdata = read_excel("USdata.xlsx",sheet=1,col_names=TRUE);
attach(usdata);

# set parameters
phipi = 1.5;
phiy = 0.5
pibar = 2;
rbar = 2;

# need to construct Yhat (percent deviation from steady state)
names(usdata); # double check column names
Yhat = 100*(GDP-GDPPOT)/GDPPOT;
# plot(Yhat); #can quickly check the data
# summary(Yhat);
usdata=cbind(usdata,Yhat);

# Make Taylor rule implied interest rate
i_TR = (rbar+pibar) + phipi*COREINF + phiy*Yhat;

# prepare data for plotting
i_TR_ts = ts(i_TR,start=c(1958,1),frequency=4);
EFFR_ts = ts(EFFR,start=c(1958,1),frequency=4);

# plot
quartz();
plot.ts(i_TR_ts,main="Taylor Rule Interest Rate vs Effective Federal Funds Rate",ylab="%p.a.",xlab=NULL,col="blue");
lines(EFFR_ts,col="red");
legend("topright",legend=c("Taylor Rule","EFFR"),col=c("blue","red"),lty=c(1,1),ncol=1);

# repeat exercise but use CPI inflation instead of core inflation
i_TR_CPI = (rbar+pibar) + phipi*CPIINF + phiy*Yhat;
i_TR_CPI_ts = ts(i_TR_CPI,start=c(1958,1),frequency=4);
quartz();
plot.ts(i_TR_ts,main="Taylor Rule Interest Rate (Core; CPI) vs Effective Federal Funds Rate",ylab="%p.a.",xlab=NULL,col="blue");
lines(i_TR_CPI_ts,col="green");
lines(EFFR_ts,col="red");
legend("topright",legend=c("Taylor Rule (Core)","Taylor Rule (CPI)","EFFR"),col=c("blue","green","red"),lty=c(1,1,1),ncol=1);


### Not part of the problem set ###
# We could even try and estimate ibar, phipi, and phiy using OLS estimation:
TR_core = glm(EFFR ~ COREINF + Yhat);
summary(TR_core);
TR_CPI = glm(EFFR ~ CPIINF + Yhat);
summary(TR_CPI);
# How do these estimate results compare with the ibar, phipi, and phiy values we assumed?
# What part of the Taylor Rule, when estimated with CPI inflation, violates macroeconomic theory?









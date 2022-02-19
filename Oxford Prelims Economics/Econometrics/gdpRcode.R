# Prelims Economics: Practising R
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
# setwd("");
getwd();

# import data
usgdpdata = read_excel("usrealgdp.xlsx",sheet=1,col_names=TRUE);
attach(usgdpdata);

# create %ch.gdp "y hat"
log_gdp = log(GDP);
d_log_gdp = diff(log_gdp);
gdp_hat = 100*d_log_gdp;
gdp_hat = as.matrix(gdp_hat);
gdp_hat = c(0,gdp_hat);
gdp_hat = gdp_hat - mean(gdp_hat); 

# create time series
gdp_ts = ts(log_gdp,start=c(1947,1),frequency=4);
gdp_hat_ts = ts(gdp_hat,start=c(1947,1),frequency=4);
ts_data = cbind(gdp_ts,gdp_hat_ts);

# make some plots
plot.ts(gdp_ts,main="US Log Real GDP",ylab=NULL,xlab=NULL,col=2);
quartz();
plot.ts(gdp_hat_ts,main="US Log Real GDP (%ch.)",ylab=NULL,xlab=NULL,col=4);
abline(h=0);
# can put them on the same plot
quartz();
par(mfrow=c(2,1),mar=c(2,2,2,1));
plot.ts(gdp_ts,main="US Log Real GDP",ylab=NULL,xlab=NULL,col=2);
plot.ts(gdp_hat_ts,main="US Log Real GDP (%ch.)",ylab=NULL,xlab=NULL,col=4);
abline(h=0);

# Put linear fit
x=1:300;
linfit = lm(log_gdp~x);
summary(linfit);
quadfit = lm(log_gdp~x+I(x^2));
summary(quadfit);
cubefit = lm(log_gdp~x+I(x^2)+I(x^3));
summary(cubefit);
quartz();
plot(log_gdp,main="US Real GDP (log)",xlab="",ylab="log(GDP)",col="blue");
abline(linfit,col="red");
quadfitcounts = predict(quadfit);
lines(x,quadfitcounts,col="green");
cubefitcounts = predict(cubefit);
lines(x,cubefitcounts,col="orange");
legend("topleft",legend=c("Data","Linear","Quadratic","Cubic"),col=c("blue","red","green","orange"),pch=c(1,NA,NA,NA),lty=c(NA,1,1,1),ncol=1);


# Extract trend and business cycles from log real GDP data
hpf_gdp = hpfilter(log_gdp,freq=1600); #gives x,trend,cycle
gdp_ts = ts(hpf_gdp$x,start=c(1947,1),frequency=4); #rewrites gdp_ts above
trend_ts = ts(hpf_gdp$trend,start=c(1947,1),frequency=4);
cycle_ts = ts(hpf_gdp$cycle,start=c(1947,1),frequency=4);

# Plot the HP filtered data
quartz();
par(mfrow=c(2,1),mar=c(2,4,2,1));
plot.ts(gdp_ts,main="Hodrick-Prescott Filter of US Real GDP (log)",col="blue",ylab="log(GDP)");
lines(trend_ts,col="red");
legend("topleft",legend=c("log(GDP)","Trend"),col=c("blue","red"),lty=rep(1,2),ncol=2);
plot.ts(cycle_ts,main="Cyclical Component (deviations from trend)",col="blue",ylab="");
abline(h=0);

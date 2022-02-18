# Prelims Economics: Practising R
# Written by David Murakami
# St Hildas College, University of Oxford

rm(list=ls(all=TRUE));
graphics.off();

getwd();
setwd("/Users/hiro/Documents/Oxford 2021-22/St Hildas College/Prelims Metrics and Maths/20220218 Metrics Lab");

x=2
y=5
x
y
x+y

# R uses +,-,*,and/ for the basic arithmetic operations, and ^ for exponentials
# Vector operations are done element by element
x=c(2,3);
y=c(1,4,5,6);
2*x
2 + x
y^2
x+y

# R also understands vectors of characters, logical values, and factors
mywords = c("This","is","a","character");
mywords
c(F,T,F,F)
factor(c("Low","Low","Medium","High","High"))

# R understands logical comparisons <,>,<=,>= which are applied elementwise
# Logical equality is == and inequality is !=, while & is "logical and", and | is "logical or"
(1:5)==(5:1)
(1:5) > (5:1)
((1:5)==(5:1)) | ((1:5)>(5:1))
((1:5)==(5:1)) & ((1:5)>(5:1))

# To index components of a vector, x, use the form x[...]
# Square brackets can contain: numeric vector specifying elements and logical vectors (only TRUE elements required)
x = c(1,3,4,7)
x[c(2,4)]
x[-2]
x[x>3.5]
which(x>3.5)

# Vectors can be put together to make flexible data structures called data frames
# A data frame is a collection of column vectors each of the same length
# The vectors may be numeric, factors, or whatever
# Each particular column and row of a data frame is given a name which can be chosen by the user, or assigned a default by R
names = c("Ayush","Ed","Katie","Shin");
class = factor(c("Knight","Warrior","Mage","Mage"));
x = sample.int(100,4,replace=TRUE);
characters = data.frame(names,class,level=x);
characters
# The variables (columns) of a data frame cannot be accessed by name until the data frame has been attached, either explicitly with attach()/detach() or implicitly via the with() command
attach(characters);
class

# Other common commands in R: mean(), sd(), min(), max(), range(), var()
# summary() returns summary information dependent on the argument type
# plot() is self explanatory


# A probability model for binary data: Bernoulli distribution
# If a random variable Y has a Bernoulli distribution with parameter pi(Y~Bern(pi)) then
# Y takes bianry values (i.e. 1 wp pi or 0 wp 1-pi)
# Y has a probability mass function:
# P(Y=y) = pi^y(1-pi)^(1-y), y={0,1}
# only one parameter, pi, describes the distribution:
# E[Y] = pi
# Var(Y) = pi(1-pi)
pi.true = 0.4544 #true value of pi
# this could be, for example, the outcome of a vote or referendum
n.obs = 1000 #set number of observations per sample
n.samples = 10000 #set number of samples
samples.all = matrix(0,n.obs,n.samples); #create storage of simulated samples
pi.hat = rep(0,n.samples); #create storage of each sample
# Simulate 10000 samples and calculate and store the average of each sample
for (i in 1:n.samples){
	samples.all[,i] = rbinom(n.obs,1,pi.true)
	pi.hat[i] = mean(samples.all[,i])
} 
hist(pi.hat,col="blue")
abline(v=pi.true,col="red")
mean(pi.hat) #close to our "true pi"
var(pi.hat) #close to 0
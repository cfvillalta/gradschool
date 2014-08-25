library(MASS)

exp = read.table("test_readcount_table.dat",header=FALSE,sep="\t",row.names=1)

output = data.frame(P_value=0)

NCUids = row.names(exp)

lib_size = vector()

for(i in 1:length(exp[1,])){
        lib_size[i] = sum(exp[,i])
}

for(i in 1:length(exp[,1])){

counts <- unlist(exp[i,])
class <- c(0,0,1,1)
fit <- glm.nb(counts~offset(log(lib_size))+class, control = glm.control(maxit = 100))
beta0 <- fit$coefficients[[1]] 
beta1 <- fit$coefficients[[2]]

dispersion <- 1/fit$theta
prop0 <- exp(beta0) 
prop1 <- exp(beta0+beta1)

t.value <- summary(fit)$coefficients [,"z value"][2]
p.value <- 2 * pt(-abs(t.value), fit$df.residual)
output[i,]=p.value
}

row.names(output) = NCUids
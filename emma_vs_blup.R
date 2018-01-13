library(rrBLUP)
np = 200   # num of individuals
nm = 1000  # num of all markers
nq = 10     # num of markers with effects
#random population of np lines with nm markers
M <- matrix(rep(0,np*nm),np,nm)
for (i in 1:nm) {
	r = runif(np)
	M[which(r<0.25),i] <- -1
	M[which(r>0.75),i] <- 1
}
M = t(M)
colnames(M) <- 1:np
geno <- data.frame(marker=1:nm,chrom=rep(1,nm),pos=1:nm,M,check.names=FALSE)

#random phenotypes
u <- rep(0.,nm)
u[1:nq] <- rnorm(nq)
g <- as.vector(crossprod(M,u))
h2 <- 0.5 #heritability
y <- g + rnorm(np,mean=0,sd=sqrt((1-h2)/h2*var(g)))
pheno <- data.frame(line=1:np,y=y)
scores <- GWAS(pheno,geno,plot=FALSE)               # emmax
exact_scores <- GWAS(pheno,geno,plot=FALSE,P3D=F)   # emma

ans <- mixed.solve(y,Z=t(M),SE=TRUE) #By default K = I
zstat = ans$u/sqrt(ans$Vu - ans$u.SE ** 2)
pval = 2*pnorm(abs(zstat),lower.tail=F)
blup_scores = -log10(pval)                          # blup

plot(scores$y,blup_scores)
abline(a=0,b=1)
lm(blup_scores ~ scores$y)
blup_scores[1:nq]
scores$y[1:nq]
exact_scores$y[1:nq]


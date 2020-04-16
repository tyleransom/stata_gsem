clear all
set more off
version 14.1
capture log close
log using gsemMonteCarloJointFactor.log, replace

set seed 32
set obs 100000

scalar T = 10
gen id = floor((_n-1)/`=T')+1
bys id: gen period = _n
xtset id period
xtsum id

scalar bcons  = 1.45
scalar bmeduc = .39
scalar bexper = .05
scalar bexper2 = -.0001
scalar alphaC  = .32
scalar alphaC2 = .69
scalar alphaW  = .45
scalar alphaW2 = .15
scalar vasvab1  = .45
scalar vasvab2  = .75
scalar vasvab3  = .33
scalar vasvab4  = .67
scalar vasvab5  = .91
scalar vasvab6  = .25
scalar vNoiseAsvab1  = .75
scalar vNoiseAsvab2  = .85
scalar vNoiseAsvab3  = .55
scalar vNoiseAsvab4  = .45
scalar vNoiseAsvab5  = .35
scalar vNoiseAsvab6  = .95

gen meduA = rnormal(0,1)
bys id: gen meduc = meduA[1]
gen factA = rnormal(0,1)
bys id: gen fact = factA[1]
gen asvab1A = sqrt(`=vasvab1')*fact + sqrt(`=vNoiseAsvab1')*rnormal(0,1)
bys id: gen asvab1 = asvab1A[1]
gen asvab2A = sqrt(`=vasvab2')*fact + sqrt(`=vNoiseAsvab2')*rnormal(0,1)
bys id: gen asvab2 = asvab2A[1]
gen asvab3A = sqrt(`=vasvab3')*fact + sqrt(`=vNoiseAsvab3')*rnormal(0,1)
bys id: gen asvab3 = asvab3A[1]
gen asvab4A = sqrt(`=vasvab4')*fact + sqrt(`=vNoiseAsvab4')*rnormal(0,1)
bys id: gen asvab4 = asvab4A[1]
gen asvab5A = sqrt(`=vasvab5')*fact + sqrt(`=vNoiseAsvab5')*rnormal(0,1)
bys id: gen asvab5 = asvab5A[1]
gen asvab6A = sqrt(`=vasvab6')*fact + sqrt(`=vNoiseAsvab6')*rnormal(0,1)
bys id: gen asvab6 = asvab6A[1]
gen fact2A = rnormal(0,1)
bys id: gen fact2 = fact2A[1]
drop factA fact2A meduA asvab?A

gen double draw = runiform()
gen double noise = rnormal(0,.35)
gen double exper = rnormal(5,10)
replace exper = 0 if exper<=0

l id period exper fact draw asvab? in 1/20, sepby(id)

gen p1 = exp(`=bcons' + `=bmeduc'*meduc + `=bexper'*exper + `=bexper2'*exper^2 + `=alphaC'*fact )/(1+exp(`=bcons' + `=bmeduc'*meduc + `=bexper'*exper + `=bexper2'*exper^2 + `=alphaC'*fact))
gen p2 = exp(`=bcons' + `=bmeduc'*meduc + `=bexper'*exper + `=bexper2'*exper^2 + `=alphaC'*fact + `=alphaC2'*fact2)/(1+exp(`=bcons' + `=bmeduc'*meduc + `=bexper'*exper + `=bexper2'*exper^2 + `=alphaC'*fact + `=alphaC2'*fact2))
gen work = p1>draw
gen work2= p2>draw

gen lnWage = `=bcons' + `=bexper'*exper + `=bexper2'*exper^2 + `=alphaW'*fact                    + noise if work
gen lnWage2= `=bcons' + `=bexper'*exper + `=bexper2'*exper^2 + `=alphaW'*fact + `=alphaW2'*fact2 + noise if work2

* infeasible
reg lnWage c.exper##c.exper fact if work
reg lnWage2 c.exper##c.exper fact fact2 if work2
logit work  meduc c.exper##c.exper fact
logit work2 meduc c.exper##c.exper fact fact2

* wage RE by itself
xtreg lnWage c.exper##c.exper, re
gsem (lnWage <- c.exper##c.exper Factor[id]), var(Factor[id]@1)

* logit RE by itself
xtlogit work meduc c.exper##c.exper, re
gsem (i.work <- meduc c.exper##c.exper Factor[id], mlogit), var(Factor[id]@1)

* joint estimation
gsem (i.work <- meduc c.exper##c.exper Factor[id], mlogit) (lnWage <- c.exper##c.exper Factor[id]), var(Factor[id]@1)

forv x=1/6 {
    bys id: replace asvab`x' = . if _n>1
}

* simple estimation of wage only
gsem (lnWage <- c.exper##c.exper), nocapslatent difficult dnumerical nonrtolerance
matrix bwage0 = e(b)

* joint estimation of measurement system with wage only
gsem (Ability -> asvab1-asvab6) (lnWage <- c.exper##c.exper Ability), latent(Ability) var(Ability@1) nocapslatent difficult dnumerical nonrtolerance
matrix bwage = e(b)

* joint estimation of measurement system with labor supply only
gsem (Ability -> asvab1-asvab6) (i.work <- meduc c.exper##c.exper Ability, mlogit), latent(Ability) var(Ability@1) nocapslatent difficult dnumerical nonrtolerance
matrix bchoice = e(b)

* joint estimation with measurement system with everything
matrix temp = bwage0,bchoice
gsem (Ability -> asvab1-asvab6) (i.work <- meduc c.exper##c.exper Ability, mlogit) (lnWage <- c.exper##c.exper Ability), latent(Ability) var(Ability@1) nocapslatent difficult from(temp,skip)
matrix fac1 = e(b)

* joint estimation with 2 factors (different DGP, so different dependent variables)
gsem (Ability -> asvab1-asvab6) (1.work2 <- meduc c.exper##c.exper Ability Noncog[id], mlogit) (lnWage2 <- c.exper##c.exper Ability Noncog[id]), var(Ability@1 Noncog[id]@1) cov(Ability*Noncog[id]@0) latent(Ability Noncog) nocapslatent difficult dnumerical nonrtolerance from(fac1,skip)

log close


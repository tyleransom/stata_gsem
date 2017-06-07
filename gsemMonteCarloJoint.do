clear all
set more off
version 13.1
capture cd "/work/A0943_vjh3_group/Estimation/gsemPractice"
capture log close
log using gsemMonteCarloJoint.log, replace

set seed 32
set obs 100000

scalar T = 10
gen id = floor((_n-1)/`=T')+1
bys id: gen period = _n
xtset id period
xtsum id

scalar bcons  = 1.45
scalar bmeduc = .39
scalar bafqt  = .15
scalar bexper = .05
scalar alphaC  = .32
scalar alphaC2 = .69
scalar alphaW  = .45

gen afqtA = rnormal(0,1)
bys id: gen afqt = afqtA[1]
gen meduA = rnormal(0,1)
bys id: gen meduc = meduA[1]
gen factA = rnormal(0,1)
bys id: gen fact = factA[1]
gen fact2A = rnormal(0,1)
bys id: gen fact2 = fact2A[1]
drop afqtA factA fact2A meduA

gen double draw = runiform()
gen double noise = rnormal(0,.35)
gen double exper = rnormal(5,10)
replace exper = 0 if exper<=0

l id period afqt exper fact draw in 1/20, sepby(id)

gen p1 = exp(`=bcons' + `=bafqt'*afqt + `=bmeduc'*meduc + `=bexper'*exper + `=alphaC'*fact )/(1+exp(`=bcons' + `=bafqt'*afqt + `=bmeduc'*meduc + `=bexper'*exper + `=alphaC'*fact))
gen p2 = exp(`=bcons' + `=bafqt'*afqt + `=bmeduc'*meduc + `=bexper'*exper + `=alphaC'*fact + `=alphaC2'*fact2)/(1+exp(`=bcons' + `=bafqt'*afqt + `=bmeduc'*meduc + `=bexper'*exper + `=alphaC'*fact + `=alphaC2'*fact2))
gen work = p1>draw
gen work2= p2>draw

gen lnWage = `=bcons' + `=bafqt'*afqt + `=bexper'*exper + `=alphaW'*fact + noise if work
gen lnWage2= `=bcons' + `=bafqt'*afqt + `=bexper'*exper + `=alphaW'*fact2+ noise if work

* wage RE by itself
xtreg lnWage afqt exper, re
gsem (lnWage <- afqt exper Factor[id]), var(Factor[id]@1)

* logit RE by itself
xtlogit work afqt meduc exper, re
gsem (i.work <- afqt meduc exper Factor[id], mlogit), var(Factor[id]@1)

* joint estimation
gsem (i.work <- afqt meduc exper Factor[id], mlogit) (lnWage <- afqt exper Factor[id]), var(Factor[id]@1)

* joint estimation with 2 factors (different DGP, so different dependent variables)
gsem (1.work2 <- afqt meduc exper Factor1[id] Factor2[id], mlogit) (lnWage2 <- afqt exper Factor2[id]), var(Factor1[id]@1 Factor2[id]@1) cov(Factor1[id]*Factor2[id]@0) 

log close

clear all
set more off
version 13.1
capture cd "/work/A0943_vjh3_group/Estimation/gsemPractice"
capture log close
log using gsemMonteCarloJointProper.log, replace

set seed 32
set obs 10000

scalar T = 10
gen id = _n

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

forvalues t=1/`=T' {
	gen double draw`t'  = runiform()
	gen double noise`t' = rnormal(0,.35)
}
gen double exper1 = 0

l id afqt exper1 fact in 1/20, sepby(id)

forvalues t=1/`=T' {
	gen p`t' = exp(`=bcons' + `=bafqt'*afqt + `=bmeduc'*meduc + `=bexper'*exper`t' + `=alphaC'*fact )/(1+exp(`=bcons' + `=bafqt'*afqt + `=bmeduc'*meduc + `=bexper'*exper`t' + `=alphaC'*fact))
	gen work`t' = p`t'>draw`t'
	gen exper`=`t'+1' = exper`t'+work`t'

	gen lnWage`t' = `=bcons' + `=bafqt'*afqt + `=bexper'*exper`t' + `=alphaW'*fact + noise`t' if work`t'
}

drop exper11

reshape long work exper lnWage, i(id) j(t)
xtset id t

* wage RE by itself
xtreg lnWage afqt exper, re
gsem (lnWage <- afqt exper Factor[id]), var(Factor[id]@1)

* logit RE by itself
xtlogit work afqt meduc exper, re
gsem (i.work <- afqt meduc exper Factor[id], mlogit), var(Factor[id]@1)

* joint estimation
gsem (i.work <- afqt meduc exper Factor[id], mlogit) (lnWage <- afqt exper Factor[id]), var(Factor[id]@1)

* joint estimation with 2 factors (different DGP, so different dependent variables)
* gsem (1.work2 <- afqt meduc exper Factor1[id] Factor2[id], mlogit) (lnWage2 <- afqt exper Factor2[id]), var(Factor1[id]@1 Factor2[id]@1) cov(Factor1[id]*Factor2[id]@0) 

log close

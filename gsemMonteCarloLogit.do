clear all
set more off
version 13.1
capture cd "/work/A0943_vjh3_group/Estimation/gsemPractice"
capture log close
log using gsemMonteCarloLogit.log, replace

set seed 32
set obs 100000

scalar T = 10
gen id = floor((_n-1)/`=T')+1
bys id: gen period = _n
xtset id period
xtsum id

scalar bcons  = 1.45
scalar bafqt  = .15
scalar bexper = .05
scalar alpha  = .32

gen afqtA = rnormal(0,1)
bys id: gen afqt = afqtA[1]
gen factA = rnormal(0,1)
bys id: gen fact = factA[1]
drop afqtA factA

gen double draw = runiform()
gen double exper = rnormal(5,10)
replace exper = 0 if exper<=0

l id period afqt exper fact draw in 1/20, sepby(id)

gen p1 = exp(`=bcons' + `=bafqt'*afqt + `=bexper'*exper + `=alpha'*fact)/(1+exp(`=bcons' + `=bafqt'*afqt + `=bexper'*exper + `=alpha'*fact))
gen work = p1>draw

logit work afqt exper

xtlogit work afqt exper, re

gsem (i.work <- afqt exper Factor[id]@1), mlogit

gsem (i.work <- afqt exper Factor[id]), mlogit var(Factor[id]@1)

log close

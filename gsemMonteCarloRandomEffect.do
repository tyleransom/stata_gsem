clear all
set more off
version 13.1
capture cd "/work/A0943_vjh3_group/Estimation/gsemPractice"
capture log close
log using gsemMonteCarloRandomEffect.log, replace

set seed 32
set obs 1000000

scalar T = 10
gen ID = floor((_n-1)/`=T')+1
bys ID: gen period = _n
xtset ID period
xtsum ID

scalar bcons  = 1.45
scalar bafqt  = .15
scalar bexper = .05
scalar alpha  = .32

gen afqtA = rnormal(0,1)
bys ID: gen afqt = afqtA[1]
gen factA = rnormal(0,1)
bys ID: gen fact = factA[1]
drop afqtA factA

gen double noise = rnormal(0,.35)
gen double exper = rnormal(5,10)
replace exper = 0 if exper<=0

l ID period afqt exper fact noise in 1/20, sepby(ID)

gen lnWage = `=bcons' + `=bafqt'*afqt + `=bexper'*exper + `=alpha'*fact + noise

reg lnWage afqt exper

xtreg lnWage afqt exper, re

log close

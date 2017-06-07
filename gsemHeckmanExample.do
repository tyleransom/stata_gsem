clear all
set more off
version 13.1
capture cd "/work/A0943_vjh3_group/Estimation/gsemPractice"
capture log close
log using gsemHeckmanExample.log, replace

***********************************************
* Do example 44g (Endogenous treatment-effects model)
* Unix PDF version
***********************************************
use http://www.stata-press.com/data/r13/gsem_union3

gsem (wage <- age grade i.smsa i.black tenure union L) (union <- i.black tenure i.south L@1, probit), var(L@1)



***********************************************
* Now, do example 43g (Heckman Selection model)
* Unix PDF version
***********************************************
use http://www.stata-press.com/data/r13/gsem_womenwk, clear

gen selected = ~mi(wage)

* Stata manual version
gsem (wage <- educ age L) (selected <- married children educ age L@1, probit), var(L@1)
nlcom (sigma: sqrt(_b[var(e.wage):_cons] +_b[wage:L]^2)) (rho: _b[wage:L]/(sqrt(2)*sqrt(_b[var(e.wage):_cons] + _b[wage:L]^2)))

* Stata manual version
gsem (wage <- educ age A) (selected <- married children educ age A@1, probit), var(A@1)
nlcom (sigma: sqrt(_b[var(e.wage):_cons] +_b[wage:A]^2)) (rho: _b[wage:A]/(sqrt(2)*sqrt(_b[var(e.wage):_cons] + _b[wage:A]^2)))

***********************************************
* Now, do example 45g (Heckman Selection model)
* Internet version
***********************************************
use http://www.stata-press.com/data/r13/gsem_womenwk, clear
gen selected = 0 if ~mi(wage)
gen notselected = 0 if mi(wage)

* Stata manual version
gsem (wage <- educ age L) (selected <- married children educ age L@1, family(gaussian, udepvar(notselected))), var(L@1 e.wage@a e.selected@a)
nlcom (sigma: sqrt(_b[var(e.wage):_cons] +_b[wage:L]^2)) (rho: _b[wage:L]/(sqrt((_b[var(e.wage):_cons]+1)*(_b[var(e.wage):_cons] + _b[wage:L]^2))))

* Modified version to see if syntax of "L" and "a" matter
gsem (wage <- educ age A) (selected <- married children educ age A@1, family(gaussian, udepvar(notselected))), var(A@1 e.wage@q e.selected@q)
nlcom (sigma: sqrt(_b[var(e.wage):_cons] +_b[wage:A]^2)) (rho: _b[wage:A]/(sqrt((_b[var(e.wage):_cons]+1)*(_b[var(e.wage):_cons] + _b[wage:A]^2))))

log close

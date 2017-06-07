*** Choice variables
local Pvars79O  black hispanic          born1957 born1958 born1959  foreignBorn afqtZscore m_afqt
local Pvars79OM black hispanic          born1957 born1958 born1959 
local Pvars79ON black                   born1957 born1958 born1959 

local Pvars79Y  black hispanic          born1961 born1962 born1963 foreignBorn afqtZscore m_afqt
local Pvars79YM black hispanic          born1961 born1962 born1963
local Pvars79YN black                   born1961 born1962 born1963

local Pvars79   black hispanic          born1961 born1962 born1963 foreignBorn afqtZscore m_afqt
local Pvars79M  black hispanic          born1961 born1962 born1963
local Pvars79N  black hispanic          born1961 born1962 born1963 foreignBorn afqtZscore m_afqt

local Pvars97   black hispanic born1980 born1981 born1982 born1983 foreignBorn afqtZscore m_afqt
local Pvars97M  black          born1980 born1981          born1983             afqtZscore m_afqt
local Pvars97N  black hispanic born1980 born1981 born1982 born1983             afqtZscore m_afqt

local Mvars    empPct    incPerCapita    
local Svars    c.schoolOnlyt (b1.race c.schoolOnlyt)#c.schoolOnlyt
local Zvars    c.workK12t (b1.race c.workK12t)#c.workK12t  c.workColleget (b1.race c.workColleget)#c.workColleget
local ZvarsA   c.workK12t (b1.race c.workK12t)#c.workK12t 
local Evars    c.workPTonlyt (b1.race c.workPTonlyt)#c.workPTonlyt  c.workFTonlyt (b1.race c.workFTonlyt)#c.workFTonlyt  c.militaryt (b1.race c.militaryt)#c.militaryt  c.othert (b1.race c.othert)#c.othert
local EvarsA   c.workPTonlyt (b1.race c.workPTonlyt)#c.workPTonlyt  c.workFTonlyt (b1.race c.workFTonlyt)#c.workFTonlyt                                                 c.othert (b1.race c.othert)#c.othert
local EvarsB   c.workPTonlyt (b1.race c.workPTonlyt)#c.workPTonlyt  c.workFTonlyt (b1.race c.workFTonlyt)#c.workFTonlyt  c.militaryt         (c.militaryt)#c.militaryt  c.othert (b1.race c.othert)#c.othert
local Fvars    hgcMoth hgcMothSq m_hgcMoth hgcFath hgcFathSq m_hgcFath famInc famIncSq m_famInc femaleHeadHH14 liveWithMom14

*** Wage variables
local Pvars79OW black@p1 hispanic@p2             born1957@p4 born1958@p5 born1959@p6 foreignBorn@p7 afqtZscore@p8 m_afqt@p9
local Pvars79YW black@p1 hispanic@p2             born1961@p4 born1962@p5 born1963@p6 foreignBorn@p7 afqtZscore@p8 m_afqt@p9
local Pvars79W  black@p1 hispanic@p2             born1961@p4 born1962@p5 born1963@p6 foreignBorn@p7 afqtZscore@p8 m_afqt@p9
local Pvars97W  black@p1 hispanic@p2 born1980@p3 born1981@p4 born1982@p5 born1983@p6 foreignBorn@p7 afqtZscore@p8 m_afqt@p9
local MvarsW    empPct@m1 incPerCapita@m2 
local SvarsW    schoolOnlyt@s1 (c.schoolOnlyt#c.schoolOnlyt)@s2 (c.schoolOnlyt#c.schoolOnlyt#c.schoolOnlyt)@s3
local SvarsWP   anySchoolt@s1 (c.anySchoolt#c.anySchoolt)@s2 (c.anySchoolt#c.anySchoolt#c.anySchoolt)@s3
local ZvarsW    workK12t@z1 (c.workK12t#c.workK12t)@z2 (c.workK12t#c.schoolOnlyt)@z3 (c.workK12t#c.workK12t#c.workK12t)@z4 workColleget@z5 (c.workColleget#c.workColleget)@z6 (c.workColleget#c.schoolOnlyt)@z7 (c.workColleget#c.workK12t)@z8 (c.workColleget#c.workColleget#c.workColleget)@z9
local ZvarsWP   workK12t@z1 (c.workK12t#c.workK12t)@z2 (c.workK12t#c.anySchoolt)@z3 (c.workK12t#c.workK12t#c.workK12t)@z4 workColleget@z5 (c.workColleget#c.workColleget)@z6 (c.workColleget#c.anySchoolt)@z7 (c.workColleget#c.workK12t)@z8 (c.workColleget#c.workColleget#c.workColleget)@z9
local EvarsW    workPTonlyt@e1 (c.workPTonlyt#c.workPTonlyt)@e2 (c.workPTonlyt#c.schoolOnlyt)@e3 (c.workPTonlyt#c.workK12t)@e4 (c.workPTonlyt#c.workColleget)@e5 (c.workPTonlyt#c.workPTonlyt#c.workPTonlyt)@e6 workFTonlyt@e7 (c.workFTonlyt#c.workFTonlyt)@e8 (c.workFTonlyt#c.schoolOnlyt)@e9 (c.workFTonlyt#c.workK12t)@e0 (c.workFTonlyt#c.workColleget)@ea (c.workFTonlyt#c.workPTonlyt)@eb (c.workFTonlyt#c.workFTonlyt#c.workFTonlyt)@ec militaryt@ed (c.militaryt#c.militaryt)@ee (c.militaryt#c.militaryt#c.militaryt)@ef othert@eg (c.othert#c.othert)@eh (c.othert#c.othert#c.othert)@ei
local EvarsWP   workPTonlyt@e1 (c.workPTonlyt#c.workPTonlyt)@e2 (c.workPTonlyt#c.anySchoolt)@e3 (c.workPTonlyt#c.workK12t)@e4 (c.workPTonlyt#c.workColleget)@e5 (c.workPTonlyt#c.workPTonlyt#c.workPTonlyt)@e6 workFTonlyt@e7 (c.workFTonlyt#c.workFTonlyt)@e8 (c.workFTonlyt#c.anySchoolt)@e9 (c.workFTonlyt#c.workK12t)@e0 (c.workFTonlyt#c.workColleget)@ea (c.workFTonlyt#c.workPTonlyt)@eb (c.workFTonlyt#c.workFTonlyt#c.workFTonlyt)@ec militaryt@ed (c.militaryt#c.militaryt)@ee (c.militaryt#c.militaryt#c.militaryt)@ef othert@eg (c.othert#c.othert)@eh (c.othert#c.othert#c.othert)@ei
local risk      gradHS@r1 grad4yr@r2
local work      inSchWork@w1 ptWork@w2

*** Drop variables that start with capital letters (gsem latency issue)
capture drop HHsize1979 HHsize1997 BA_year BA_month Diploma_year Diploma_month GED_year GED_month HS_year HS_month R1interviewDate R2interviewDate R3interviewDate R4interviewDate R5interviewDate R6interviewDate R7interviewDate R8interviewDate R9interviewDate R10interviewDate R11interviewDate R12interviewDate R13interviewDate R14interviewDate R15interviewDate R16interviewDate R17interviewDate R18interviewDate Highest_degree_ever BA_start_year BA_start_month BAstartYr BAstartMo BAstartYrMo BAstartDate BAendDate BA_stop_year BA_stop_month BAstopYr BAstopMo BAstopYrMo HSgradOnly AAgradOnly BAgradOnly GradgradOnly NoHSgradEver

*** Generate certain variables
gen constant  = 1
gen inSchWork = inlist(activity,2,12,22)
gen ptWork    = inlist(activity,3,13,23)

gen lnWage    = ln(wageNoSelf)
gen lnWageSch = lnWage if inlist(activity,2,12,22)
gen lnWagePT  = lnWage if inlist(activity,3,13,23)
gen lnWageFT  = lnWage if inlist(activity,4,14,24)

gen activity1 = activity if inrange(activity, 1, 7)
gen activity2 = activity if inrange(activity,11,17)
gen activity3 = activity if inrange(activity,21,26)

* re-scale activity variables, by dividing by 12
foreach var in schoolOnlyt schoolOnlyBlack schoolOnlyHisp anySchoolt workK12t workK12Black workK12Hisp workColleget workCollegeBlack workCollegeHisp workPTonlyt workPTBlack workPTHisp workFTonlyt workFTBlack workFTHisp militaryt militaryBlack militaryHisp othert otherBlack otherHisp {
	replace `var' = `var'/12
}

replace famIncSq = famInc^2/1000
replace famInc = famInc/10

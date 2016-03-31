use "H:\My Documents\uvr_thyroid_usrt\data\ambient_avg_forest.dta", clear

gen loghr = log(HazardRatio)
gen loglb= log(HRLowerCL)
gen logub= log(HRUpperCL)
replace loglb=-1 if missing(loglb)

metan     loghr loglb logub if  loghr !=. ,  eform fixed xlabel(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) force xtick(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) effect(HazardRatio) label(namevar=Label) nowt nooverall nobox textsize(140) astext(40)

use "H:\My Documents\uvr_thyroid_usrt\data\hours_avg_forest.dta", clear

drop C1 C2 C3 C4 C5 C6 C7
rename C8 HazardRatio
rename C9 HRLowerCL
rename C10 HRUpperCL
rename C11 Label
drop if HazardRatio=="HazardRatio"

destring HazardRatio HRLowerCL HRUpperCL, replace
gen loghr = log(HazardRatio)
gen loglb= log(HRLowerCL)
gen logub= log(HRUpperCL)
replace loglb=-.5 if missing(loglb)

metan     loghr loglb logub if  loghr !=. ,  eform fixed xlabel(0.35, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) force xtick(0.35, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) effect(HazardRatio) label(namevar=Label) nowt nooverall nobox textsize(100) astext(40)


use "H:\My Documents\uvr_thyroid_usrt\data\combined_avg_forest.dta", clear

gen loghr = log(HazardRatio)
gen loglb= log(HRLowerCL)
gen logub= log(HRUpperCL)
replace loglb=-.5 if missing(loglb)

metan     loghr loglb logub if  loghr !=. ,  eform fixed xlabel(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.01) force xtick(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.01) effect(HazardRatio) label(namevar=Label) nowt nooverall nobox textsize(140) astext(40)



use "H:\My Documents\uvr_thyroid_usrt\data\ambient_40plus_forest.dta", clear

replace HRLowerCL=.5 if HRLowerCL==.1
gen loghr = log(HazardRatio)
gen loglb= log(HRLowerCL)
gen logub= log(HRUpperCL)
replace loglb=-1 if missing(loglb)
replace Label=Parameter if missing(Label)

metan     loghr loglb logub if  loghr !=. ,  eform fixed xlabel(0.49, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) force xtick(0.49, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) effect(HazardRatio) label(namevar=Label) nowt nooverall nobox textsize(140) astext(40)

use "H:\My Documents\uvr_thyroid_usrt\data\hours_40plus_forest.dta", clear


gen loghr = log(HazardRatio)
gen loglb= log(HRLowerCL)
gen logub= log(HRUpperCL)
replace loglb=-.5 if missing(loglb)
replace Label=Parameter if missing(Label)

metan     loghr loglb logub if  loghr !=. ,  eform fixed xlabel(0.35, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) force xtick(0.35, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.0, 2.5) effect(HazardRatio) label(namevar=Label) nowt nooverall nobox textsize(140) astext(40)


use "H:\My Documents\uvr_thyroid_usrt\data\combined_40plus_forest.dta", clear

replace HRLowerCL=.5 if HRLowerCL==.1

gen loghr = log(HazardRatio)
gen loglb= log(HRLowerCL)
gen logub= log(HRUpperCL)
replace loglb=-.5 if missing(loglb)
replace Label=Parameter if missing(Label)

metan     loghr loglb logub if  loghr !=. ,  eform fixed xlabel(0.35, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.01) force xtick(0.35, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.01) effect(HazardRatio) label(namevar=Label) nowt nooverall nobox textsize(140) astext(40)


//for lisa

use "C:\REB\Chernobyl_Thyroid\Data\thyroid.dta", clear
sort(order)

metan     loghr loglb logub,  ///
	fixed xlabel (0, 1, 2, 3, 4, 5) ///
	force xtick  (0, 1, 2, 3, 4, 5) ///
	effect(EOR) ///
	by(subgroup) ///
	label(namevar=Label) ///
	nowt nooverall nobox nosubgroup ///
	textsize(100) astext(50) ///
	rcols(Parameter) ///
	ti("Figure 3. Excess Odds Ratio for 1 (95% CI)*", size(medium))

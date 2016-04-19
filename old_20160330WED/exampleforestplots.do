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
	ti("Figure 3. Excess Odds Ratio for 1 (95% CI)*", size(medium)) ///
	plotregion(margin( 40 0 0 0 )) graphregion(margin(0 1 2 1))

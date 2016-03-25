! FIGURE 2

! ERR rad vs Age at exposure plot	 
! For never-smoker:
! OR_rad=(dgyb*dose1)×exp(ex5b(age_exp-5))+1
! OR per Gy by age at accident

! All nodules

clear
set obs 190
gen age_exp10= _n-1
gen age_exp=age_exp10/10
scalar dose1=1


! dgycat cutoffs:
! 1:0-1.9, 2:2-4.9, 3: 5-9.9, 4: 10-18;

*gen dgycat1=0
gen agecat1=0
gen agecat2=0
gen agecat3=0
gen agecat4=0


*Based on means
replace agecat1=1 if age_exp10==6
replace agecat2=1 if age_exp10==15
replace agecat3=1 if age_exp10==35
replace agecat4=1 if age_exp10==109

scalar agecat1b=1.097
scalar agecat1lob=-0.7239
scalar agecat1hib=2.19722
*29.3

scalar agecat2b=.4548
scalar agecat2lob=-0.6017
scalar agecat2hib=1.78

scalar agecat3b=-0.4833
scalar agecat3lob=-1.429
scalar agecat3hib=-.2825

scalar agecat4b=-1.998
scalar agecat4lob=-4.366
scalar agecat4hib=-1.194

gen ctpoint=.
replace ctpoint=1 if age_exp10==6|age_exp10==15|age_exp10==35|age_exp10==109

gen exct4rad=   exp((agecat1b  *agecat1 + agecat2b  *agecat2 + agecat3b  *agecat3 + agecat4b  *agecat4) * ctpoint) + 1
gen exct4hirad= exp((agecat1hib*agecat1 + agecat2hib*agecat2 + agecat3hib*agecat3 + agecat4hib*agecat4) * ctpoint) + 1
gen exct4lorad= exp((agecat1lob*agecat1 + agecat2lob*agecat2 + agecat3lob*agecat3 + agecat4lob*agecat4) * ctpoint) + 1

!Modelled effect modification

scalar dgyb=0.576
scalar ex5b=-.3156
gen linrad= dgyb*dose1*exp(ex5b*(age_exp-5))+1

twoway	(rcap exct4hirad exct4lorad age_exp) ///
		(scatter exct4rad age_exp) ///
		(line linrad  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
ti("{bf}All nodules ")  ///
yti("{bf}Odds ratio* ")  yla(,ang(0)) ylab(0(1)10) ///
legend(off) ///
xti("{bf}Age at time of accident")  ///
note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast of }" "{stSerif: residence at time of accident, thyroid enlargement, goiter detected at screening, and }" "{stSerif: family history of thyroid disease.}", size(medsmall))  ///
name(Fig1A, replace) graphregion(fc(white)) 








legend(region(lwidth(none)) order(2 "Categorical ORs and 95%CIs" 3 "Linear" )) legend(col(1) pos(1) ring (0) size (small) ) ///
scatter allrad age_exp



twoway (line allrad age_exp, ///
	 lpattern( solid) ///
	 lcol(black*0.75 ) ///
	 lw(medthick ) ), ///
	 legend(off) ///
	 yti("{bf}OR at 1 Gy* ") yla(,ang(0))  ///
	 xti("{bf}age at exposure") ///
	 title("B", pos(10)) ///
	 note("* Odds ratio for 1 Gy ")  ///
     name(Fig2A, replace) graphregion(fc(white))

	 
grc1leg Fig3A Fig3B, legendfrom(Fig3A) 	 
!graph combine Fig3A Fig3B

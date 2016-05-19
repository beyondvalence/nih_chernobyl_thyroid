! FIGURE 2
! updated 20160513FRI WTL
! ERR rad vs Age at exposure plot	 
! For never-smoker:
! OR_rad=(dgyb*dose1)×exp(ex5b(age_exp-5))+1
! OR per Gy by age at accident

!!!!!!!!!! All nodules

clear
set obs 189
gen age_exp10= _n-1
gen age_exp=age_exp10/10
scalar dose1=1

gen agecat1=0
gen agecat2=0
gen agecat3=0

*Based on means
replace agecat1=1 if age_exp10==11
replace agecat2=1 if age_exp10==35
replace agecat3=1 if age_exp10==109

scalar agecat1b=2.25
scalar agecat1lob=1.72
scalar agecat1hib=3.03

scalar agecat2b=1.62
scalar agecat2lob=1.29
scalar agecat2hib=2.10

scalar agecat3b=1.16
scalar agecat3lob=1.03
scalar agecat3hib=1.33

gen ctpoint=.
replace ctpoint=1 if inlist(age_exp10, 11, 35, 109)

gen exct3rad=   ((agecat1b  *agecat1 + agecat2b  *agecat2 + agecat3b  *agecat3 ) * ctpoint) 
gen exct3hirad= ((agecat1hib*agecat1 + agecat2hib*agecat2 + agecat3hib*agecat3 ) * ctpoint) 
gen exct3lorad= ((agecat1lob*agecat1 + agecat2lob*agecat2 + agecat3lob*agecat3 ) * ctpoint) 

!Modelled effect modification

scalar dgyb=.59
scalar ex5b=-0.2411
gen linrad= dgyb*dose1*exp(ex5b*(age_exp-5))+1

twoway	(rcap exct3hirad exct3lorad age_exp) ///
		(scatter exct3rad age_exp, mc(black)) ///
		(line linrad  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}All nodules ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  ///
			yla(,ang(0)) ylab(0 (1) 4) ///
			legend(region(lwidth(none)) order(2 "ORs and 95%CIs") col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) ///
			xlab(0 (2) 19) ///
			name(Fig2A, replace) graphregion(fc(white) margin( 2 3 2 1 )) 

!!!!!!!!!! Nodules by behavior: non-neoplastic / neoplastic

clear
set obs 189
gen age_exp10= _n-1
gen age_exp=age_exp10/10
scalar dose1=1

gen agecat1=0
gen agecat2=0
gen agecat3=0


*Based on means
replace agecat1=1 if age_exp10==11
replace agecat2=1 if age_exp10==35
replace agecat3=1 if age_exp10==109

scalar agecat1_non_b=1.28
scalar agecat1_neo_b=6.27

scalar agecat2_non_b=1.08
scalar agecat2_neo_b=4.91 

scalar agecat3_non_b=1.07
scalar agecat3_neo_b=1.57

gen ctpoint=.
replace ctpoint=1 if inlist(age_exp10, 11, 35, 109)

gen exct3_non_rad= ((agecat1_non_b*agecat1 + agecat2_non_b*agecat2 + agecat3_non_b*agecat3 ) * ctpoint) 
gen exct3_neo_rad= ((agecat1_neo_b*agecat1 + agecat2_neo_b*agecat2 + agecat3_neo_b*agecat3 ) * ctpoint) 

!Modelled effect modification

scalar dgy_non_b= 0.15
scalar dgy_non_leb=-0.09
scalar ex5_non_b=-0.19
gen lerad_non= dgy_non_b*dose1*exp(ex5_non_b*(age_exp-5)+dgy_non_leb*dose1)+1

scalar dgy_neo_b=2.12
scalar ex5_neo_b=-0.29
gen linrad_neo= dgy_neo_b*dose1*exp(ex5_neo_b*(age_exp-5))+1

twoway	(scatter exct3_non_rad age_exp, mc(gray)) ///
		(line lerad_non  age_exp, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct3_neo_rad age_exp, mc(black)) ///
		(line linrad_neo  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}Behavior ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ///
			ylab(0 (2) 10) ///
			legend(region(lwidth(none)) order(4 "Neoplastic" 2 "Non-neoplastic" ) col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) ///
			xlab(0 (2) 19) ///
			name(Fig2B, replace) graphregion(fc(white) margin( 2 3 2 1 ))


!!!!!!!!!! Nodules by size : small / large

clear
set obs 189
gen age_exp10= _n-1
gen age_exp=age_exp10/10
scalar dose1=1

gen agecat1=0
gen agecat2=0
gen agecat3=0

*Based on means
replace agecat1=1 if age_exp10==11
replace agecat2=1 if age_exp10==35
replace agecat3=1 if age_exp10==109

scalar agecat1_sma_b=1.78
scalar agecat1_lar_b=3.85

scalar agecat2_sma_b=1.43
scalar agecat2_lar_b=2.25

scalar agecat3_sma_b=1.10
scalar agecat3_lar_b=1.37


gen ctpoint=.
replace ctpoint=1 if inlist(age_exp10, 11, 35, 109)

gen exct3_sma_rad= ((agecat1_sma_b*agecat1 + agecat2_sma_b*agecat2 + agecat3_sma_b*agecat3 ) * ctpoint) 
gen exct3_lar_rad= ((agecat1_lar_b*agecat1 + agecat2_lar_b*agecat2 + agecat3_lar_b*agecat3 ) * ctpoint) 

!Modelled effect modification

scalar dgy_sma_b=0.32
scalar ex5_sma_b=-0.25
gen linrad_sma= dgy_sma_b*dose1*exp(ex5_sma_b*(age_exp-5))+1

scalar dgy_lar_b=1.76
scalar ex5_lar_b=-0.24
gen linrad_lar= dgy_lar_b*dose1*exp(ex5_lar_b*(age_exp-5))+1

twoway	(scatter exct3_sma_rad age_exp, mc(gray)) ///
		(line linrad_sma  age_exp, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct3_lar_rad age_exp, mc(black)) ///
		(line linrad_lar age_exp, ///
		 lpattern( solid ) ///
		 lcol(black) ///
		 lw(medthick )), ///
			ti("{bf}Size ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ///
			ylab(0 (2) 8) ///
			legend(region(lwidth(none)) order(4 "Large, 10+ mm" 2 "Small, <10 mm"  ) col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) ///
			xlab(0 (2) 19) ///
			name(Fig2C, replace) graphregion(fc(white) margin( 2 3 2 2 ))


!!!!!!!!!! Nodules by singularity: single / multiple

clear
set obs 189
gen age_exp10= _n-1
gen age_exp=age_exp10/10
scalar dose1=1

gen agecat1=0
gen agecat2=0
gen agecat3=0


*Based on means
replace agecat1=1 if age_exp10==11
replace agecat2=1 if age_exp10==35
replace agecat3=1 if age_exp10==109

scalar agecat1_sin_b=2.03
scalar agecat1_mul_b=2.17

scalar agecat2_sin_b=1.48
scalar agecat2_mul_b=1.58

scalar agecat3_sin_b=1.18
scalar agecat3_mul_b=1.07

gen ctpoint=.
replace ctpoint=1 if inlist(age_exp10, 11, 35, 109)

gen exct3_sin_rad= ((agecat1_sin_b*agecat1 + agecat2_sin_b*agecat2 + agecat3_sin_b*agecat3 ) * ctpoint) 
gen exct3_mul_rad= ((agecat1_mul_b*agecat1 + agecat2_mul_b*agecat2 + agecat3_mul_b*agecat3 ) * ctpoint) 

!Modelled effect modification

scalar dgy_sin_b=0.56
scalar ex5_sin_b=-0.21
gen linrad_sin= dgy_sin_b*dose1*exp(ex5_sin_b*(age_exp-5))+1


scalar dgyLE_mul_b=0.22
scalar dgyLE_mul_LEb=0.09
scalar ex5LE_mul_b=-0.46
gen linErad_mul= dgyLE_mul_b*dose1*exp(ex5LE_mul_b*(age_exp-5)+dgyLE_mul_LEb*dose1)+1

twoway	(scatter exct3_sin_rad age_exp, mc(gray)) ///
		(line linrad_sin age_exp, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct3_mul_rad age_exp, mc(black)) ///
		(line linErad_mul age_exp, ///
		 lpattern( solid ) ///
		 lcol( black ) ///
		 lw(medthick )), ///
			ti("{bf}Singularity ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ///
			ylab(0 (1) 4) ///
			legend(region(lwidth(none)) order(4 "Multiple" 2 "Single" ) col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) ///
			xlab(0 (2) 19) ///
			name(Fig2D, replace) graphregion(fc(white) margin( 2 3 2 2 ))

graph combine Fig2A Fig2B Fig2C Fig2D, ///
	cols(2) ///
	iscale(*0.75) ///
	name(Fig2all, replace) ///
	ysize(5) xsize(5.5) ///
	///title("Figure 2. Thyroid nodule risk by age at time of accident by nodule type", size(medium)) ///
	///note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast of residence at time of accident,}" "{stSerif: thyroid enlargement, goiter detected at screening, and family history of thyroid disease.}", size(small) ring(0))  ///


/******
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
*******/


! FIGURE 2

! ERR rad vs Age at exposure plot	 
! For never-smoker:
! OR_rad=(dgyb*dose1)×exp(ex5b(age_exp-5))+1
! OR per Gy by age at accident

!!!!!!!!!! All nodules

clear
set obs 120
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

scalar agecat1b=1.234
scalar agecat1lob=0.5252
scalar agecat1hib=2.384
*29.3

scalar agecat2b=1.252
scalar agecat2lob=0.6714
scalar agecat2hib=2.155

scalar agecat3b=-0.6165
scalar agecat3lob=0.2895
scalar agecat3hib=1.103

scalar agecat4b=0.1586
scalar agecat4lob=0.3126
scalar agecat4hib=0.3281

gen ctpoint=.
replace ctpoint=1 if age_exp10==6|age_exp10==15|age_exp10==35|age_exp10==109

gen exct4rad=   exp((agecat1b  *agecat1 + agecat2b  *agecat2 + agecat3b  *agecat3 + agecat4b  *agecat4) * ctpoint) + 1
gen exct4hirad= exp((agecat1hib*agecat1 + agecat2hib*agecat2 + agecat3hib*agecat3 + agecat4hib*agecat4) * ctpoint) + 1
gen exct4lorad= exp((agecat1lob*agecat1 + agecat2lob*agecat2 + agecat3lob*agecat3 + agecat4lob*agecat4) * ctpoint) + 1

!Modelled effect modification

scalar dgyb=0.5935
scalar ex5b=-0.2411
gen linrad= dgyb*dose1*exp(ex5b*(age_exp-5))+1

twoway	(rcap exct4hirad exct4lorad age_exp) ///
		(scatter exct4rad age_exp, mc(black)) ///
		(line linrad  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}All nodules ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ylab(0 (2) 10) ///
			legend(region(lwidth(none)) order(2 "ORs and 95%CIs") col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) xlab(0 (2) 12) ///
			name(Fig2A, replace) graphregion(fc(white) margin( 2 3 2 1 )) 

!!!!!!!!!! Nodules by behavior: benign / malignant

clear
set obs 120
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

scalar agecat1_ben_b=0.6219
scalar agecat1_mal_b=2.19722 ///9.898

scalar agecat2_ben_b=0.1198
scalar agecat2_mal_b=2.19722 ///80.36 

scalar agecat3_ben_b=-0.7143
scalar agecat3_mal_b=0.279

scalar agecat4_ben_b=-2.068
scalar agecat4_mal_b=-1.018

gen ctpoint=.
replace ctpoint=1 if age_exp10==6|age_exp10==15|age_exp10==35|age_exp10==109

gen exct4_ben_rad= exp((agecat1_ben_b*agecat1 + agecat2_ben_b*agecat2 + agecat3_ben_b*agecat3 + agecat4_ben_b*agecat4) * ctpoint) + 1
gen exct4_mal_rad= exp((agecat1_mal_b*agecat1 + agecat2_mal_b*agecat2 + agecat3_mal_b*agecat3 + agecat4_mal_b*agecat4) * ctpoint) + 1

!Modelled effect modification

scalar dgy_ben_b=0.4859
scalar ex5_ben_b=-0.2223
gen linrad_ben= dgy_ben_b*dose1*exp(ex5_ben_b*(age_exp-5))+1

scalar dgy_mal_b=20124
scalar ex5_mal_b=-0.2908
gen linrad_mal= dgy_mal_b*dose1*exp(ex5_mal_b*(age_exp-5))+1

twoway	(scatter exct4_ben_rad age_exp, mc(gray)) ///
		(line linrad_ben  age_exp, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct4_mal_rad age_exp, mc(black)) ///
		(line linrad_mal  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}Behavior ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ylab(0 (2) 10) ///
			legend(region(lwidth(none)) order(2 "Non-neoplastic" 4 "Neoplastic") col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) xlab(0 (2) 12) ///
			name(Fig2B, replace) graphregion(fc(white) margin( 2 3 2 1 ))


!!!!!!!!!! Nodules by size : small / large

clear
set obs 120
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

scalar agecat1_sma_b=-0.3522
scalar agecat1_lar_b=2.19722 ///8.743

scalar agecat2_sma_b=-0.01155
scalar agecat2_lar_b=1.821

scalar agecat3_sma_b=-0.9415
scalar agecat3_lar_b=0.6838

scalar agecat4_sma_b=-2.663
scalar agecat4_lar_b=-1.026

gen ctpoint=.
replace ctpoint=1 if age_exp10==6|age_exp10==15|age_exp10==35|age_exp10==109

gen exct4_sma_rad= exp((agecat1_sma_b*agecat1 + agecat2_sma_b*agecat2 + agecat3_sma_b*agecat3 + agecat4_sma_b*agecat4) * ctpoint) + 1
gen exct4_lar_rad= exp((agecat1_lar_b*agecat1 + agecat2_lar_b*agecat2 + agecat3_lar_b*agecat3 + agecat4_lar_b*agecat4) * ctpoint) + 1

!Modelled effect modification

scalar dgy_sma_b=0.3218
scalar ex5_sma_b=-0.2527
gen linrad_sma= dgy_sma_b*dose1*exp(ex5_sma_b*(age_exp-5))+1

scalar dgy_lar_b=1.762
scalar ex5_lar_b=-0.2445
gen linrad_lar= dgy_lar_b*dose1*exp(ex5_lar_b*(age_exp-5))+1

twoway	(scatter exct4_sma_rad age_exp, mc(gray)) ///
		(line linrad_sma  age_exp, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct4_lar_rad age_exp, mc(black)) ///
		(line linrad_lar age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}Size ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ylab(0 (2) 10) ///
			legend(region(lwidth(none)) order(2 "Small, <10 mm" 4 "Large, 10+ mm" ) col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) xlab(0 (2) 12) ///
			name(Fig2C, replace) graphregion(fc(white) margin( 2 3 2 2 ))


!!!!!!!!!! Nodules by singularity: single / multiple

clear
set obs 120
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

scalar agecat1_sin_b=0.5009
scalar agecat1_mul_b=2.19722 ///10.63

scalar agecat2_sin_b=0.8251
scalar agecat2_mul_b=-0.1888

scalar agecat3_sin_b=-1.131
scalar agecat3_mul_b=1.244

scalar agecat4_sin_b=-1.912
scalar agecat4_mul_b=-2.069

gen ctpoint=.
replace ctpoint=1 if age_exp10==6|age_exp10==15|age_exp10==35|age_exp10==109

gen exct4_sin_rad= exp((agecat1_sin_b*agecat1 + agecat2_sin_b*agecat2 + agecat3_sin_b*agecat3 + agecat4_sin_b*agecat4) * ctpoint) + 1
gen exct4_mul_rad= exp((agecat1_mul_b*agecat1 + agecat2_mul_b*agecat2 + agecat3_mul_b*agecat3 + agecat4_mul_b*agecat4) * ctpoint) + 1

!Modelled effect modification

scalar dgy_sin_b=0.557
scalar ex5_sin_b=-0.2069
gen linrad_sin= dgy_sin_b*dose1*exp(ex5_sin_b*(age_exp-5))+1

scalar dgy_mul_b=0.59
scalar ex5_mul_b=-0.4047
gen linrad_mul= dgy_mul_b*dose1*exp(ex5_mul_b*(age_exp-5))+1

scalar dgyLE_mul_b=0.2165 // coefficients results different 0.2168 or 0.2173
scalar dgyLE_mul_LEb=0.08932 
scalar ex5LE_mul_b=-0.455 
gen linErad_mul= dgyLE_mul_b*dose1*exp(ex5LE_mul_b*(age_exp-5)+dgyLE_mul_LEb*dose1)+1

twoway	(scatter exct4_sin_rad age_exp, mc(gray)) ///
		(line linrad_sin age_exp, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct4_mul_rad age_exp, mc(black)) ///
		(line linrad_mul age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )) ///
		(line linErad_mul age_exp, ///
		 lpattern( shortdash ) ///
		 lcol( black ) ///
		 lw(medthick )), ///
			ti("{bf}Singularity ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) )  yla(,ang(0)) ylab(0 (2) 10) ///
			legend(region(lwidth(none)) order(2 "Single" 4 "Multiple" 5 "Multiple L-E") col(1) pos(1) ring (0) ) ///
			legend( size (5.5) symxsize(5) keygap(0.7) ) ///
			xti("{bf}Age at time of accident", size(4.7) ) xlab(0 (2) 12) ///
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


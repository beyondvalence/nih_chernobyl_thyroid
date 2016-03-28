! FIGURE 2

! ERR rad vs Age at exposure plot	 
! For never-smoker:
! OR_rad=(dgyb*dose1)×exp(ex5b(age_exp-5))+1
! OR per Gy by age at accident

!!!!!!!!!! All nodules

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
name(Fig2A, replace) graphregion(fc(white)) 

!!!!!!!!!! Nodules by behavior: benign / malignant

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

scalar dgy_ben_b=0.5108
scalar ex5_ben_b=-0.2916
gen linrad_ben= dgy_ben_b*dose1*exp(ex5_ben_b*(age_exp-5))+1

scalar dgy_mal_b=1.142
scalar ex5_mal_b=-0.3676
gen linrad_mal= dgy_mal_b*dose1*exp(ex5_mal_b*(age_exp-5))+1

twoway	(scatter exct4_ben_rad age_exp) ///
		(line linrad_ben  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct4_mal_rad age_exp, mc(red)) ///
		(line linrad_mal  age_exp, ///
		 lpattern( solid ) ///
		 lcol(red*0.75 ) ///
		 lw(medthick )), ///
ti("{bf}Nodules by behavior ")  ///
yti("{bf}Odds ratio* ")  yla(,ang(0)) ylab(0(1)10) ///
legend(off) ///
xti("{bf}Age at time of accident")  ///
note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast of }" "{stSerif: residence at time of accident, thyroid enlargement, goiter detected at screening, and }" "{stSerif: family history of thyroid disease.}", size(medsmall))  ///
name(Fig2B, replace) graphregion(fc(white))


!!!!!!!!!! Nodules by size : small / large

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

scalar dgy_sma_b=0.5108
scalar ex5_sma_b=-0.2916
gen linrad_sma= dgy_sma_b*dose1*exp(ex5_sma_b*(age_exp-5))+1

scalar dgy_lar_b=1.142
scalar ex5_lar_b=-0.3676
gen linrad_lar= dgy_lar_b*dose1*exp(ex5_lar_b*(age_exp-5))+1

twoway	(scatter exct4_sma_rad age_exp) ///
		(line linrad_sma  age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct4_lar_rad age_exp, mc(purple)) ///
		(line linrad_lar age_exp, ///
		 lpattern( solid ) ///
		 lcol(purple*0.75 ) ///
		 lw(medthick )), ///
ti("{bf}Nodules by size ")  ///
yti("{bf}Odds ratio* ")  yla(,ang(0)) ylab(0(1)10) ///
legend(off) ///
xti("{bf}Age at time of accident")  ///
note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast of }" "{stSerif: residence at time of accident, thyroid enlargement, goiter detected at screening, and }" "{stSerif: family history of thyroid disease.}", size(medsmall))  ///
name(Fig2C, replace) graphregion(fc(white))


!!!!!!!!!! Nodules by singularity: single / multiple

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

scalar dgy_sin_b=0.5411
scalar ex5_sin_b=-0.2605
gen linrad_sin= dgy_sin_b*dose1*exp(ex5_sin_b*(age_exp-5))+1

scalar dgy_mul_b=0.4869
scalar ex5_mul_b=-0.5874
gen linrad_mul= dgy_mul_b*dose1*exp(ex5_mul_b*(age_exp-5))+1

scalar dgyLE_mul_b=0.2173
scalar dgyLE_mul_LEb=0.08468
scalar ex5LE_mul_b=-0.6398
gen linErad_mul= dgyLE_mul_b*dose1*exp(ex5LE_mul_b*(age_exp-5)+dgyLE_mul_LEb)+1

twoway	(scatter exct4_sin_rad age_exp) ///
		(line linrad_sin age_exp, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )) ///
		(scatter exct4_mul_rad age_exp, mc(green)) ///
		(line linrad_mul age_exp, ///
		 lpattern( solid ) ///
		 lcol(green*0.75 ) ///
		 lw(medthick )) ///
		(line linErad_mul age_exp, ///
		 lpattern( dash ) ///
		 lcol(emerald*0.75 ) ///
		 lw(medthick )), ///
ti("{bf}Nodules by singularity ")  ///
yti("{bf}Odds ratio* ")  yla(,ang(0)) ylab(0(1)10) ///
legend(off) ///
xti("{bf}Age at time of accident")  ///
note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast of }" "{stSerif: residence at time of accident, thyroid enlargement, goiter detected at screening, and }" "{stSerif: family history of thyroid disease.}", size(medsmall))  ///
name(Fig2D, replace) graphregion(fc(white))


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

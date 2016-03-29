! FIGURE 1: Curves and confidence intervals
! whole dose rang

!!!!!!! All nodules 

clear
set obs 8001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1:0-0.099, 2:0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2b=1.03136
scalar dgycat2lob=0.8139
scalar dgycat2hib=1.4101

scalar dgycat3b=1.2884
scalar dgycat3lob=1.008
scalar dgycat3hib=1.759

scalar dgycat4b=1.4201
scalar dgycat4lob=1.07432
scalar dgycat4hib=1.9883

scalar dgycat5b=2.429
scalar dgycat5lob=1.619
scalar dgycat5hib=3.563

scalar dgycat6b=2.124
scalar dgycat6lob=1.4459
scalar dgycat6hib=3.247

scalar dgycat7b=5.406
scalar dgycat7lob=2.992
scalar dgycat7hib=9.09


gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7rad=   (dgycat2b*dgycat2+dgycat3b*dgycat3+dgycat4b*dgycat4+dgycat5b*dgycat5+dgycat6b*dgycat6+dgycat7b*dgycat7)*ctpoint
gen dct7hirad= (dgycat2hib*dgycat2+dgycat3hib*dgycat3+dgycat4hib*dgycat4+dgycat5hib*dgycat5+dgycat6hib*dgycat6+dgycat7hib*dgycat7)*ctpoint
gen dct7lorad= (dgycat2lob*dgycat2+dgycat3lob*dgycat3+dgycat4lob*dgycat4+dgycat5lob*dgycat5+dgycat6lob*dgycat6+dgycat7lob*dgycat7)*ctpoint

!Linear model
scalar lin_dgyb=0.576

gen linrad= lin_dgyb*dgy+1

twoway	(rcap dct7hirad dct7lorad dgy) ///
		(scatter dct7rad dgy) ///
		(line linrad  dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}All nodules ", pos(11) ring(1) ) ///
			yti("{bf}Odds ratio* ")  ///
			yla(0 (2) 10,ang(1)) ///
			xti("{bf} Thyroid dose (Gy)")  ///
			legend(region(lwidth(none)) order(2 "Categorical ORs and 95%CIs" 3 "Linear" )) ///
			legend(col(1) pos(10) ring (0) size (small) ) ///
			name(Fig1A, replace) graphregion(fc(white) margin( 1 1 2 1 )) 

!!!!!!! Nodules by behavior: non-neoplastic, neoplastic

clear
set obs 8001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_ben_b=1.03958
scalar dgycat2_mal_b=0.8737

scalar dgycat3_ben_b=1.2934
scalar dgycat3_mal_b=1.1989

scalar dgycat4_ben_b=1.3053
scalar dgycat4_mal_b=1.9185

scalar dgycat5_ben_b=2.301
scalar dgycat5_mal_b=2.893

scalar dgycat6_ben_b=1.8548
scalar dgycat6_mal_b=2.956

scalar dgycat7_ben_b=5.249
scalar dgycat7_mal_b=5.347


gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_ben_rad= (dgycat2_ben_b*dgycat2+dgycat3_ben_b*dgycat3+dgycat4_ben_b*dgycat4+dgycat5_ben_b*dgycat5+dgycat6_ben_b*dgycat6+dgycat7_ben_b*dgycat7)*ctpoint
gen dct7_mal_rad= (dgycat2_mal_b*dgycat2+dgycat3_mal_b*dgycat3+dgycat4_mal_b*dgycat4+dgycat5_mal_b*dgycat5+dgycat6_mal_b*dgycat6+dgycat7_mal_b*dgycat7)*ctpoint

!Linear model
scalar lin_dgy_ben_b=0.5108
scalar lin_dgy_mal_b=1.142

gen linrad_ben= lin_dgy_ben_b*dgy+1
gen linrad_mal= lin_dgy_mal_b*dgy+1

twoway	(scatter dct7_ben_rad dgy, mc(black)) ///
		(line linrad_ben dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct7_mal_rad dgy, mc(gray)) ///
		(line linrad_mal dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)), ///
			ti("{bf}Behavior ", pos(11) ring(1))  ///
			yti("{bf}Odds ratio* ")  ///
			yla(0 (2) 10,ang(1)) ///
			xti("{bf} Thyroid dose (Gy)")  ///
			legend(region(lwidth(none)) order(2 "Benign" 4 "Malignant" )) ///
			legend(col(1) pos(10) ring (0) size (small) ) ///
			name(Fig1B, replace) graphregion(fc(white) margin( 1 1 2 1 ))

!!!!!!! Nodules by size: small, large

clear
set obs 8001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_sma_b=1.0272
scalar dgycat2_lar_b=1.08233

scalar dgycat3_sma_b=1.1508
scalar dgycat3_lar_b=1.9753

scalar dgycat4_sma_b=1.4442
scalar dgycat4_lar_b=1.4761

scalar dgycat5_sma_b=1.9421
scalar dgycat5_lar_b=4.501

scalar dgycat6_sma_b=1.4409
scalar dgycat6_lar_b=4.992

scalar dgycat7_sma_b=3.777
scalar dgycat7_lar_b=12.46


gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_sma_rad= (dgycat2_sma_b*dgycat2+dgycat3_sma_b*dgycat3+dgycat4_sma_b*dgycat4+dgycat5_sma_b*dgycat5+dgycat6_sma_b*dgycat6+dgycat7_sma_b*dgycat7)*ctpoint
gen dct7_lar_rad= (dgycat2_lar_b*dgycat2+dgycat3_lar_b*dgycat3+dgycat4_lar_b*dgycat4+dgycat5_lar_b*dgycat5+dgycat6_lar_b*dgycat6+dgycat7_lar_b*dgycat7)*ctpoint

!Linear model
scalar lin_dgy_sma_b=0.2949
scalar lin_dgy_lar_b=1.689

gen linrad_sma= lin_dgy_sma_b*dgy+1
gen linrad_lar= lin_dgy_lar_b*dgy+1

twoway	(scatter dct7_sma_rad dgy, mc(black)) ///
		(line linrad_sma dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct7_lar_rad dgy, mc(gray)) ///
		(line linrad_lar dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)), ///
			ti("{bf}Size ", pos(11) ring(1))  ///
			yti("{bf}Odds ratio* ")  ///
			yla(0 (2) 16,ang(1)) ///
			xti("{bf} Thyroid dose (Gy)")  ///
			legend(region(lwidth(none)) order(2 "Small" 4 "Large" )) ///
			legend(col(1) pos(10) ring (0) size (small) ) ///
			name(Fig1C, replace) graphregion(fc(white) margin( 1 1 14 2 )) 

!!!!!!! Nodules by singularity: single, multiple

clear
set obs 11001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

! new test 20160329TUES to look for low point estimates to justify L-E curve
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-5.99, 8:6-38.9 9:0/NIC; 

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_sin_b=1.09989
scalar dgycat2_mul_b=1.03058

scalar dgycat3_sin_b=1.217
scalar dgycat3_mul_b=1.4673

scalar dgycat4_sin_b=1.4245
scalar dgycat4_mul_b=1.334

scalar dgycat5_sin_b=2.346
scalar dgycat5_mul_b=2.24

scalar dgycat6_sin_b=1.9186
scalar dgycat6_mul_b=2.268

scalar dgycat7_sin_b=5.216
scalar dgycat7_mul_b=4.43

gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_sin_rad= (dgycat2_sin_b*dgycat2+dgycat3_sin_b*dgycat3+dgycat4_sin_b*dgycat4+dgycat5_sin_b*dgycat5+dgycat6_sin_b*dgycat6+dgycat7_sin_b*dgycat7)*ctpoint
gen dct7_mul_rad= (dgycat2_mul_b*dgycat2+dgycat3_mul_b*dgycat3+dgycat4_mul_b*dgycat4+dgycat5_mul_b*dgycat5+dgycat6_mul_b*dgycat6+dgycat7_mul_b*dgycat7)*ctpoint

!Linear model
scalar lin_dgy_sin_b=0.5411
scalar lin_dgy_mul_b=0.4869

gen linrad_sin= lin_dgy_sin_b*dgy+1
gen linrad_mul= lin_dgy_mul_b*dgy+1

!Linear exponential model
scalar le_dgy_mul_b=0.2168
scalar le_dgy_mul_exb=0.08473

gen lerad_mul= 1+le_dgy_mul_b*dgy*exp(le_dgy_mul_exb*dgy)

*new dcat8 to investgate multiple L-E curve
gen dct8_2=0
gen dct8_3=0
gen dct8_4=0
gen dct8_5=0
gen dct8_6=0
gen dct8_7=0
gen dct8_8=0

replace dct8_2=1 if dose1000==167
replace dct8_3=1 if dose1000==363
replace dct8_4=1 if dose1000==708
replace dct8_5=1 if dose1000==1387
replace dct8_6=1 if dose1000==2745
replace dct8_7=1 if dose1000==4953
replace dct8_8=1 if dose1000==10302

scalar dct82_mul_b=0.98285
scalar dct83_mul_b=1.03052
scalar dct84_mul_b=1.2552
scalar dct85_mul_b=1.8227
scalar dct86_mul_b=1.9211
scalar dct87_mul_b=1.4256
scalar dct88_mul_b=5.002

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_mul_rad= (dct82_mul_b*dct8_2+dct83_mul_b*dct8_3+dct84_mul_b*dct8_4+dct85_mul_b*dct8_5+dct86_mul_b*dct8_6+dct87_mul_b*dct8_7+dct88_mul_b*dct8_8)*ctpoint8

twoway	(scatter dct7_sin_rad dgy, mc(black)) ///
		(line linrad_sin dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct7_mul_rad dgy, mc(gray)) ///
		(line linrad_mul dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(line lerad_mul dgy, ///
		 lpattern(dash) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		 (scatter dct8_mul_rad dgy, mc(red)), ///
			ti("{bf}Singularity ", pos(11) ring(1))  ///
			yti("{bf}Odds ratio* ")  ///
			yla(0 (2) 8, ang(1)) ///
			xti("{bf} Thyroid dose (Gy)")  ///
			legend(region(lwidth(none)) order(2 "Single" 4 "Multiple" 5 "Multiple, L-E" 6 "dct8" )) ///
			legend(col(1) pos(10) ring (0) size (small) ) ///
			name(Fig1D, replace) graphregion(fc(white) margin( 3 1 14 2 )) 

graph combine Fig1A Fig1B Fig1C Fig1D, ///
	cols(2) ///
	xcommon ///
	/// title("Figure 1. Thyroid nodule risk by thyroid dose (Gy) by nodule type", size(medium)) ///
	note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast at time of accident, thyroid}" "{stSerif: enlargement goiter detected at screening, and family history of thyroid disease for a person age 5 at time of accident.}", size(small) ring(0))  ///
	iscale(*0.75) ///
	name(Fig1all, replace) graphregion(ic(white)) ///
	

/***
! Example
!Linear exponential model
scalar le_dgyb=0.2465
scalar le_dgyexb=0.08287

gen lerad= le_dgyb*dgy*exp(le_dgyexb*dgy)+1
***/

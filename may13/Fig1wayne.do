! FIGURE 1: Curves and confidence intervals
! whole dose range
! updated 20160513FRI WTL

!!!!!!! All nodules 

clear
set obs 12001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1:0-0.099, 2:0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

! new test 20160329TUES to look for low point estimates to justify L-E curve
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4.00-5.99, 8:6-38.9 9:0/NIC; 

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==167
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2b=1.08
scalar dgycat2lob=0.79
scalar dgycat2hib=1.52

scalar dgycat3b=1.41
scalar dgycat3lob=1.04
scalar dgycat3hib=1.95

scalar dgycat4b=1.49
scalar dgycat4lob=1.08
scalar dgycat4hib=2.10

scalar dgycat5b=2.59
scalar dgycat5lob=1.82
scalar dgycat5hib=3.69

scalar dgycat6b=2.21
scalar dgycat6lob=1.48
scalar dgycat6hib=3.34

scalar dgycat7b=6.17
scalar dgycat7lob=3.79
scalar dgycat7hib=9.76

gen ctpoint=.
replace ctpoint=1 if dose1000==167|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_all_rad= (dgycat2b*dgycat2+dgycat3b*dgycat3+dgycat4b*dgycat4+dgycat5b*dgycat5+dgycat6b*dgycat6+dgycat7b*dgycat7)*ctpoint
gen dct7_upp_rad= (dgycat2hib*dgycat2+dgycat3hib*dgycat3+dgycat4hib*dgycat4+dgycat5hib*dgycat5+dgycat6hib*dgycat6+dgycat7hib*dgycat7)*ctpoint
gen dct7_low_rad= (dgycat2lob*dgycat2+dgycat3lob*dgycat3+dgycat4lob*dgycat4+dgycat5lob*dgycat5+dgycat6lob*dgycat6+dgycat7lob*dgycat7)*ctpoint

*new dcat8 for all nodules
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

scalar dct82_all_b=1.07
scalar dct83_all_b=1.40
scalar dct84_all_b=1.48
scalar dct85_all_b=2.58
scalar dct86_all_b=2.20
scalar dct87_all_b=4.94
scalar dct88_all_b=7.35

scalar dct82_low_b=0.79
scalar dct83_low_b=1.03
scalar dct84_low_b=1.07
scalar dct85_low_b=1.80
scalar dct86_low_b=1.47
scalar dct87_low_b=2.57
scalar dct88_low_b=4.16

scalar dct82_upp_b=1.51
scalar dct83_upp_b=1.94
scalar dct84_upp_b=2.09
scalar dct85_upp_b=3.67
scalar dct86_upp_b=3.33
scalar dct87_upp_b=8.95
scalar dct88_upp_b=12.6

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_all_rad= (dct82_all_b*dct8_2+dct83_all_b*dct8_3+dct84_all_b*dct8_4+dct85_all_b*dct8_5+dct86_all_b*dct8_6+dct87_all_b*dct8_7+dct88_all_b*dct8_8)*ctpoint8
gen dct8_low_rad= (dct82_low_b*dct8_2+dct83_low_b*dct8_3+dct84_low_b*dct8_4+dct85_low_b*dct8_5+dct86_low_b*dct8_6+dct87_low_b*dct8_7+dct88_low_b*dct8_8)*ctpoint8
gen dct8_upp_rad= (dct82_upp_b*dct8_2+dct83_upp_b*dct8_3+dct84_upp_b*dct8_4+dct85_upp_b*dct8_5+dct86_upp_b*dct8_6+dct87_upp_b*dct8_7+dct88_upp_b*dct8_8)*ctpoint8


!Linear model
scalar lin_dgyb=0.5935

gen linrad= lin_dgyb*dgy+1

twoway	(rcap dct7_upp_rad dct7_low_rad dgy)  ///
		(scatter dct7_all_rad dgy, mc(black)) ///
		(line linrad dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}All nodules ", pos(11) ring(1) size(5.7) ) ///
			yti("{bf}Odds ratio*", size(4.7) )  ///
			yla(0 (2) 10, ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(2 "ORs and 95%CIs" 3 "Linear" )) ///
			legend(col(1) pos(10) ring (0) size (4.5) symxsize(5) keygap(0.7) textw(19) ) ///
			name(Fig1A, replace) graphregion(fc(white) margin( 2 3 2 1 )) 

!!!!!!! Nodules by behavior: non-neoplastic, neoplastic

clear
set obs 12001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

! new test 20160329TUES to look for low point estimates to justify L-E curve
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4.00-5.99, 8:6-38.9 9:0/NIC; 

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==167
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_non_b=0.93
scalar dgycat2_neo_b=1.42

scalar dgycat3_non_b=1.10
scalar dgycat3_neo_b=1.99

scalar dgycat4_non_b=1.09
scalar dgycat4_neo_b=3.19

scalar dgycat5_non_b=1.95
scalar dgycat5_neo_b=5.41

scalar dgycat6_non_b=1.19
scalar dgycat6_neo_b=5.96

scalar dgycat7_non_b=4.74
scalar dgycat7_neo_b=12.0 /// 13.9


gen ctpoint=.
replace ctpoint=1 if dose1000==167|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_non_rad= (dgycat2_non_b*dgycat2+dgycat3_non_b*dgycat3+dgycat4_non_b*dgycat4+dgycat5_non_b*dgycat5+dgycat6_non_b*dgycat6+dgycat7_non_b*dgycat7)*ctpoint
gen dct7_neo_rad= (dgycat2_neo_b*dgycat2+dgycat3_neo_b*dgycat3+dgycat4_neo_b*dgycat4+dgycat5_neo_b*dgycat5+dgycat6_neo_b*dgycat6+dgycat7_neo_b*dgycat7)*ctpoint


*new dcat8 to investgate neoplastic point
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

scalar dct82_non_b=0.92
scalar dct83_non_b=1.11
scalar dct84_non_b=1.09
scalar dct85_non_b=1.95
scalar dct86_non_b=1.21
scalar dct87_non_b=2.90
scalar dct88_non_b=6.70

scalar dct82_neo_b=1.47
scalar dct83_neo_b=2.06
scalar dct84_neo_b=3.29
scalar dct85_neo_b=5.58
scalar dct86_neo_b=6.15
scalar dct87_neo_b=10.1
scalar dct88_neo_b=12.0 /* scaled from 13.9 */

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_non_rad= (dct82_non_b*dct8_2+dct83_non_b*dct8_3+dct84_non_b*dct8_4+dct85_non_b*dct8_5+dct86_non_b*dct8_6+dct87_non_b*dct8_7+dct88_non_b*dct8_8)*ctpoint8
gen dct8_neo_rad= (dct82_neo_b*dct8_2+dct83_neo_b*dct8_3+dct84_neo_b*dct8_4+dct85_neo_b*dct8_5+dct86_neo_b*dct8_6+dct87_neo_b*dct8_7+dct88_neo_b*dct8_8)*ctpoint8

!Linear model
scalar lin_dgy_non_b = 0.3617
scalar lin_dgy_neo_b = 2.124

gen linrad_non= lin_dgy_non_b*dgy+1
gen linrad_neo= lin_dgy_neo_b*dgy+1
replace linrad_neo=. if linrad_neo > 12

! Linear exponential model, non-neoplastic
scalar le_dgy_non_b = 0.1472
scalar le_dgy_non_expb = 0.09457
gen lerad_non= 1+le_dgy_non_b*dgy*exp(le_dgy_non_expb*dgy)

twoway	(scatter dct7_non_rad dgy, mc(gray)) ///
		(line lerad_non dgy, ///
		 lpattern( solid ) /// 
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct7_neo_rad dgy, mc(black)) ///
		(line linrad_neo dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)) , ///
			ti("{bf}Behavior ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) ) ///
			yla(0 (2) 12,ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(4 "Neoplastic" 2 "Non-neoplastic")) ///
			legend(col(1) pos(4) ring (0) size (4) symxsize(4.8) keygap(0.6) textw(14) ) ///
			name(Fig1B, replace) graphregion(fc(white) margin( 2 3 2 1 ))

!!!!!!! Nodules by size: small, large

clear
set obs 12001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4-38.9, 8:0/NIC;

! new test 20160329TUES to look for low point estimates to justify L-E curve
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4.00-5.99, 8:6-38.9 9:0/NIC; 

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==167
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_sma_b=1.13
scalar dgycat2_lar_b=1.01

scalar dgycat3_sma_b=1.22
scalar dgycat3_lar_b=2.07

scalar dgycat4_sma_b=1.55
scalar dgycat4_lar_b=1.39

scalar dgycat5_sma_b=2.10
scalar dgycat5_lar_b=4.11

scalar dgycat6_sma_b=1.58
scalar dgycat6_lar_b=4.21

scalar dgycat7_sma_b=4.50
scalar dgycat7_lar_b=12.0 ///12.1

gen ctpoint=.
replace ctpoint=1 if dose1000==167|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_sma_rad= (dgycat2_sma_b*dgycat2+dgycat3_sma_b*dgycat3+dgycat4_sma_b*dgycat4+dgycat5_sma_b*dgycat5+dgycat6_sma_b*dgycat6+dgycat7_sma_b*dgycat7)*ctpoint
gen dct7_lar_rad= (dgycat2_lar_b*dgycat2+dgycat3_lar_b*dgycat3+dgycat4_lar_b*dgycat4+dgycat5_lar_b*dgycat5+dgycat6_lar_b*dgycat6+dgycat7_lar_b*dgycat7)*ctpoint


*new dcat8 for small large
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

scalar dct82_sma_b=1.13
scalar dct83_sma_b=1.22
scalar dct84_sma_b=1.55
scalar dct85_sma_b=2.10
scalar dct86_sma_b=1.57
scalar dct87_sma_b=3.75
scalar dct88_sma_b=5.34

scalar dct82_lar_b=1.00
scalar dct83_lar_b=2.06
scalar dct84_lar_b=1.38
scalar dct85_lar_b=4.08
scalar dct86_lar_b=4.19
scalar dct87_lar_b=10.1
scalar dct88_lar_b=13.9

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_sma_rad= (dct82_sma_b*dct8_2+dct83_sma_b*dct8_3+dct84_sma_b*dct8_4+dct85_sma_b*dct8_5+dct86_sma_b*dct8_6+dct87_sma_b*dct8_7+dct88_sma_b*dct8_8)*ctpoint8
gen dct8_lar_rad= (dct82_lar_b*dct8_2+dct83_lar_b*dct8_3+dct84_lar_b*dct8_4+dct85_lar_b*dct8_5+dct86_lar_b*dct8_6+dct87_lar_b*dct8_7+dct88_lar_b*dct8_8)*ctpoint8


!Linear model
scalar lin_dgy_sma_b=0.3752
scalar lin_dgy_lar_b=1.526

gen linrad_sma= lin_dgy_sma_b*dgy+1
gen linrad_lar= lin_dgy_lar_b*dgy+1
replace linrad_lar=. if linrad_lar > 12

twoway	(scatter dct7_sma_rad dgy, mc(gray)) ///
		(line linrad_sma dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct7_lar_rad dgy, mc(black)) ///
		(line linrad_lar dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)), ///
			ti("{bf}Size ", pos(11) ring(1) size(5.7) ) ///
			yti("{bf}Odds ratio* ", size(4.7) )  ///
			yla(0 (2) 12, ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(4 "Large, 10+ mm" 2 "Small, <10 mm"  )) ///
			legend(col(1) pos(4) ring (0) size (4.6) symxsize(4.7) keygap(0.6) textw(17.2) ) ///
			name(Fig1C, replace) graphregion(fc(white) margin( 2 3 2 2 )) 

!!!!!!! Nodules by singularity: single, multiple

clear
set obs 12001
gen dose1000 = _n-1
gen dgy=dose1000/1000

! dgycat cutoffs:
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4.00-38.9, 8:0/NIC;

! table 2 combined categories 4.00-5.99, 6.00-38.9 into 4.00-38.9

! new test 20160329TUES to look for low point estimates to justify L-E curve
! 1: 0-0.099, 2: 0.1-0.2499, 3: 0.25-0.499, 4: 0.50-0.999, 5:1.0-1.999, 6: 2-3.99 7:4.00-5.99, 8:6-38.9 9:0/NIC; 

*gen dgycat1=0
gen dgycat2=0
gen dgycat3=0
gen dgycat4=0
gen dgycat5=0
gen dgycat6=0
gen dgycat7=0

*Based on means
*replace dgycat1=1 if dose1000==43
replace dgycat2=1 if dose1000==167
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_sin_b=1.18
scalar dgycat2_mul_b=0.73

scalar dgycat3_sin_b=1.33
scalar dgycat3_mul_b=1.68

scalar dgycat4_sin_b=1.53
scalar dgycat4_mul_b=1.33

scalar dgycat5_sin_b=2.50
scalar dgycat5_mul_b=2.80

scalar dgycat6_sin_b=2.03
scalar dgycat6_mul_b=2.78

scalar dgycat7_sin_b=5.84
scalar dgycat7_mul_b=7.15

gen ctpoint=.
replace ctpoint=1 if dose1000==167|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_sin_rad= (dgycat2_sin_b*dgycat2+dgycat3_sin_b*dgycat3+dgycat4_sin_b*dgycat4+dgycat5_sin_b*dgycat5+dgycat6_sin_b*dgycat6+dgycat7_sin_b*dgycat7)*ctpoint
gen dct7_mul_rad= (dgycat2_mul_b*dgycat2+dgycat3_mul_b*dgycat3+dgycat4_mul_b*dgycat4+dgycat5_mul_b*dgycat5+dgycat6_mul_b*dgycat6+dgycat7_mul_b*dgycat7)*ctpoint

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

scalar dct82_sin_b=1.18
scalar dct83_sin_b=1.33
scalar dct84_sin_b=1.53
scalar dct85_sin_b=2.50
scalar dct86_sin_b=2.03
scalar dct87_sin_b=5.42
scalar dct88_sin_b=6.28

scalar dct82_mul_b=0.95
scalar dct83_mul_b=1.45
scalar dct84_mul_b=1.26
scalar dct85_mul_b=2.01
scalar dct86_mul_b=2.06
scalar dct87_mul_b=1.75
scalar dct88_mul_b=5.99

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_sin_rad= (dct82_sin_b*dct8_2+dct83_sin_b*dct8_3+dct84_sin_b*dct8_4+dct85_sin_b*dct8_5+dct86_sin_b*dct8_6+dct87_sin_b*dct8_7+dct88_sin_b*dct8_8)*ctpoint8
gen dct8_mul_rad= (dct82_mul_b*dct8_2+dct83_mul_b*dct8_3+dct84_mul_b*dct8_4+dct85_mul_b*dct8_5+dct86_mul_b*dct8_6+dct87_mul_b*dct8_7+dct88_mul_b*dct8_8)*ctpoint8

!Linear model
scalar lin_dgy_sin_b=0.557
scalar lin_dgy_mul_b=0.59

gen linrad_sin= lin_dgy_sin_b*dgy+1
gen linrad_mul= lin_dgy_mul_b*dgy+1

!Linear exponential model
scalar le_dgy_mul_b=0.2165
scalar le_dgy_mul_exb=0.08932

gen lerad_mul= 1+le_dgy_mul_b*dgy*exp(le_dgy_mul_exb*dgy)

twoway	(scatter dct7_sin_rad dgy, mc(gray)) ///
		(line linrad_sin dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct7_mul_rad dgy, mc(black)) ///
		(line lerad_mul dgy, ///
		 lpattern(solid) ///
		 lcol(black ) ///
		 lw(medthick)) , ///
			ti("{bf}Singularity ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*" , size(4.7) )  ///
			yla(0 (2) 10, ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(4 "Multiple" 2 "Single" )) ///
			legend(col(1) pos(10) ring (0) size (5.4) symxsize(5) keygap(0.7) ) ///
			name(Fig1D, replace) graphregion(fc(white) margin( 2 3 2 2 )) 

graph combine Fig1A Fig1B Fig1C Fig1D, ///
	cols(2) ///
	/// title("Figure 1. Thyroid nodule risk by thyroid dose (Gy) by nodule type", size(medium)) ///
	///note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast at time of accident, thyroid}" "{stSerif: enlargement goiter detected at screening, and family history of thyroid disease for a person age 5 at time of accident.}", size(small) ring(0))  ///
	iscale(*0.75) ///
	name(Fig1all, replace) graphregion(ic(white)) ///
	ysize(5) xsize(5.5)
	

/***
! Example
!Linear exponential model
scalar le_dgyb=0.2465
scalar le_dgyexb=0.08287

gen lerad= le_dgyb*dgy*exp(le_dgyexb*dgy)+1
***/

! FIGURE 1: Curves and confidence intervals
! whole dose range

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
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2b=1.1656
scalar dgycat2lob=0.8519
scalar dgycat2hib=1.6718

scalar dgycat3b=1.4238
scalar dgycat3lob=1.05256
scalar dgycat3hib=1.9993

scalar dgycat4b=1.5185
scalar dgycat4lob=1.09962
scalar dgycat4hib=2.164

scalar dgycat5b=2.579
scalar dgycat5lob=1.7659
scalar dgycat5hib=3.743

scalar dgycat6b=2.218
scalar dgycat6lob=1.4807
scalar dgycat6hib=3.406

scalar dgycat7b=5.671
scalar dgycat7lob=3.322
scalar dgycat7hib=9.267

gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7rad=   (dgycat2b*dgycat2+dgycat3b*dgycat3+dgycat4b*dgycat4+dgycat5b*dgycat5+dgycat6b*dgycat6+dgycat7b*dgycat7)*ctpoint
gen dct7hirad= (dgycat2hib*dgycat2+dgycat3hib*dgycat3+dgycat4hib*dgycat4+dgycat5hib*dgycat5+dgycat6hib*dgycat6+dgycat7hib*dgycat7)*ctpoint
gen dct7lorad= (dgycat2lob*dgycat2+dgycat3lob*dgycat3+dgycat4lob*dgycat4+dgycat5lob*dgycat5+dgycat6lob*dgycat6+dgycat7lob*dgycat7)*ctpoint

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

scalar dct82_all_b=1.1536
scalar dct83_all_b=1.41
scalar dct84_all_b=1.5029
scalar dct85_all_b=2.549
scalar dct86_all_b=2.193
scalar dct87_all_b=4.125
scalar dct88_all_b=7.254

scalar dct82_low_b=0.8464
scalar dct83_low_b=1.04486
scalar dct84_low_b=1.09015
scalar dct85_low_b=1.7337
scalar dct86_low_b=1.4648
scalar dct87_low_b=2.105
scalar dct88_low_b=3.919

scalar dct82_upp_b=1.6555
scalar dct83_upp_b=1.9807
scalar dct84_upp_b=2.144
scalar dct85_upp_b=3.707
scalar dct86_upp_b=3.372
scalar dct87_upp_b=7.772
scalar dct88_upp_b=12.9

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_all_rad= (dct82_all_b*dct8_2+dct83_all_b*dct8_3+dct84_all_b*dct8_4+dct85_all_b*dct8_5+dct86_all_b*dct8_6+dct87_all_b*dct8_7+dct88_all_b*dct8_8)*ctpoint8
gen dct8_low_rad= (dct82_low_b*dct8_2+dct83_low_b*dct8_3+dct84_low_b*dct8_4+dct85_low_b*dct8_5+dct86_low_b*dct8_6+dct87_low_b*dct8_7+dct88_low_b*dct8_8)*ctpoint8
gen dct8_upp_rad= (dct82_upp_b*dct8_2+dct83_upp_b*dct8_3+dct84_upp_b*dct8_4+dct85_upp_b*dct8_5+dct86_upp_b*dct8_6+dct87_upp_b*dct8_7+dct88_upp_b*dct8_8)*ctpoint8


!Linear model
scalar lin_dgyb=0.5935

gen linrad= lin_dgyb*dgy+1

twoway	(rcap dct8_upp_rad dct8_low_rad dgy)  ///
		(scatter dct8_all_rad dgy, mc(black)) ///
		(line linrad dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick )), ///
			ti("{bf}All nodules ", pos(11) ring(1) size(5.7) ) ///
			yti("{bf}Odds ratio*", size(4.7) )  ///
			yla(0 (2) 12,ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(2 "ORs and 95%CIs" 3 "Linear" )) ///
			legend(col(1) pos(10) ring (0) size (5.5) symxsize(5) keygap(0.7) textw(23.6) ) ///
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
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_ben_b=1.1393
scalar dgycat2_mal_b=1.5485

scalar dgycat3_ben_b=1.3744
scalar dgycat3_mal_b=2.043

scalar dgycat4_ben_b=1.3337
scalar dgycat4_mal_b=3.439

scalar dgycat5_ben_b=2.291
scalar dgycat5_mal_b=5.999

scalar dgycat6_ben_b=1.8128
scalar dgycat6_mal_b=6.269

scalar dgycat7_ben_b=5.067
scalar dgycat7_mal_b=12.43


gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_ben_rad= (dgycat2_ben_b*dgycat2+dgycat3_ben_b*dgycat3+dgycat4_ben_b*dgycat4+dgycat5_ben_b*dgycat5+dgycat6_ben_b*dgycat6+dgycat7_ben_b*dgycat7)*ctpoint
gen dct7_mal_rad= (dgycat2_mal_b*dgycat2+dgycat3_mal_b*dgycat3+dgycat4_mal_b*dgycat4+dgycat5_mal_b*dgycat5+dgycat6_mal_b*dgycat6+dgycat7_mal_b*dgycat7)*ctpoint


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

scalar dct82_ben_b=1.1235
scalar dct83_ben_b=1.3573
scalar dct84_ben_b=1.3155
scalar dct85_ben_b=2.255
scalar dct86_ben_b=1.7893
scalar dct87_ben_b=2.937
scalar dct88_ben_b=7.33

scalar dct82_mal_b=1.6633
scalar dct83_mal_b=2.157
scalar dct84_mal_b=3.63
scalar dct85_mal_b=6.366
scalar dct86_mal_b=6.685
scalar dct87_mal_b=12 /*16.5*/
scalar dct88_mal_b=10.07

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_ben_rad= (dct82_ben_b*dct8_2+dct83_ben_b*dct8_3+dct84_ben_b*dct8_4+dct85_ben_b*dct8_5+dct86_ben_b*dct8_6+dct87_ben_b*dct8_7+dct88_ben_b*dct8_8)*ctpoint8
gen dct8_mal_rad= (dct82_mal_b*dct8_2+dct83_mal_b*dct8_3+dct84_mal_b*dct8_4+dct85_mal_b*dct8_5+dct86_mal_b*dct8_6+dct87_mal_b*dct8_7+dct88_mal_b*dct8_8)*ctpoint8

!Linear model
scalar lin_dgy_ben_b = 0.4859
scalar lin_dgy_mal_b = 2.124

gen linrad_ben= lin_dgy_ben_b*dgy+1
gen linrad_mal= lin_dgy_mal_b*dgy+1
replace linrad_mal=. if linrad_mal > 12

! Linear exponential model, non-neoplastic
scalar le_dgy_ben_b = 0.2926
scalar le_dgy_ben_expb = 0.05972
gen lerad_ben= 1+le_dgy_ben_b*dgy*exp(le_dgy_ben_expb*dgy)

twoway	(scatter dct8_ben_rad dgy, mc(gray)) ///
		(line linrad_ben dgy, ///
		 lpattern( solid ) /// 
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(line lerad_ben dgy, ///
		 lpattern( shortdash ) /// 
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct8_mal_rad dgy, mc(black)) ///
		(line linrad_mal dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)) , ///
			ti("{bf}Behavior ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*", size(4.7) ) ///
			yla(0 (2) 12,ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(2 "Non-neoplastic" 3 "Non-neoplastic LE" 5 "Neoplastic")) ///
			legend(col(1) pos(5) ring (0) size (5.112) symxsize(4.8) keygap(0.7) textw(18.2) ) ///
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
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_sma_b=1.1779
scalar dgycat2_lar_b=1.2679

scalar dgycat3_sma_b=1.2181
scalar dgycat3_lar_b=2.391

scalar dgycat4_sma_b=1.5458
scalar dgycat4_lar_b=1.6365

scalar dgycat5_sma_b=2.062
scalar dgycat5_lar_b=4.869

scalar dgycat6_sma_b=1.4274
scalar dgycat6_lar_b=5.51

scalar dgycat7_sma_b=3.962
scalar dgycat7_lar_b=13.46

gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

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

scalar dct82_sma_b=1.1762
scalar dct83_sma_b=1.2145
scalar dct84_sma_b=1.5423
scalar dct85_sma_b=2.058
scalar dct86_sma_b=1.4236
scalar dct87_sma_b=3.006
scalar dct88_sma_b=5.162

scalar dct82_lar_b=1.2503
scalar dct83_lar_b=2.35
scalar dct84_lar_b=1.6131
scalar dct85_lar_b=4.794
scalar dct86_lar_b=5.415
scalar dct87_lar_b=9.998
scalar dct88_lar_b=16 /*16.85*/

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_sma_rad= (dct82_sma_b*dct8_2+dct83_sma_b*dct8_3+dct84_sma_b*dct8_4+dct85_sma_b*dct8_5+dct86_sma_b*dct8_6+dct87_sma_b*dct8_7+dct88_sma_b*dct8_8)*ctpoint8
gen dct8_lar_rad= (dct82_lar_b*dct8_2+dct83_lar_b*dct8_3+dct84_lar_b*dct8_4+dct85_lar_b*dct8_5+dct86_lar_b*dct8_6+dct87_lar_b*dct8_7+dct88_lar_b*dct8_8)*ctpoint8


!Linear model
scalar lin_dgy_sma_b=0.3218
scalar lin_dgy_lar_b=1.762

gen linrad_sma= lin_dgy_sma_b*dgy+1
gen linrad_lar= lin_dgy_lar_b*dgy+1
replace linrad_lar=. if linrad_lar > 16

twoway	(scatter dct8_sma_rad dgy, mc(gray)) ///
		(line linrad_sma dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct8_lar_rad dgy, mc(black)) ///
		(line linrad_lar dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)), ///
			ti("{bf}Size ", pos(11) ring(1) size(5.7) ) ///
			yti("{bf}Odds ratio* ", size(4.7) )  ///
			yla(0 (2) 16, ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(2 "Small, <10 mm" 4 "Large, 10+ mm" )) ///
			legend(col(1) pos(11) ring (0) size (4.74) symxsize(4.7) keygap(0.6) textw(17.2) ) ///
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
replace dgycat2=1 if dose1000==117
replace dgycat3=1 if dose1000==364
replace dgycat4=1 if dose1000==707
replace dgycat5=1 if dose1000==1392
replace dgycat6=1 if dose1000==2745
replace dgycat7=1 if dose1000==7552

scalar dgycat2_sin_b=1.2951
scalar dgycat2_mul_b=0.8068

scalar dgycat3_sin_b=1.3753
scalar dgycat3_mul_b=1.5431

scalar dgycat4_sin_b=1.5898
scalar dgycat4_mul_b=1.3256

scalar dgycat5_sin_b=2.572
scalar dgycat5_mul_b=2.507

scalar dgycat6_sin_b=2.074
scalar dgycat6_mul_b=2.587

scalar dgycat7_sin_b=5.663
scalar dgycat7_mul_b=5.361

gen ctpoint=.
replace ctpoint=1 if dose1000==117|dose1000==364|dose1000==707|dose1000==1392|dose1000==2745|dose1000==7552

gen dct7_sin_rad= (dgycat2_sin_b*dgycat2+dgycat3_sin_b*dgycat3+dgycat4_sin_b*dgycat4+dgycat5_sin_b*dgycat5+dgycat6_sin_b*dgycat6+dgycat7_sin_b*dgycat7)*ctpoint
gen dct7_mul_rad= (dgycat2_mul_b*dgycat2+dgycat3_mul_b*dgycat3+dgycat4_mul_b*dgycat4+dgycat5_mul_b*dgycat5+dgycat6_mul_b*dgycat6+dgycat7_mul_b*dgycat7)*ctpoint

!Linear model
scalar lin_dgy_sin_b=0.557
scalar lin_dgy_mul_b=0.59

gen linrad_sin= lin_dgy_sin_b*dgy+1
gen linrad_mul= lin_dgy_mul_b*dgy+1

!Linear exponential model
scalar le_dgy_mul_b=0.2165
scalar le_dgy_mul_exb=0.08932

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

scalar dct82_sin_b=1.2917
scalar dct83_sin_b=1.3717
scalar dct84_sin_b=1.5855
scalar dct85_sin_b=2.565
scalar dct86_sin_b=2.069
scalar dct87_sin_b=4.905
scalar dct88_sin_b=6.548

scalar dct82_mul_b=0.992109
scalar dct83_mul_b=1.3273
scalar dct84_mul_b=1.2127
scalar dct85_mul_b=1.7667
scalar dct86_mul_b=1.8481
scalar dct87_mul_b=1.2564
scalar dct88_mul_b=4.987

gen ctpoint8=.
replace ctpoint8=1 if inlist(dose1000, 167, 363, 708, 1387, 2745, 4953, 10302)

gen dct8_sin_rad= (dct82_sin_b*dct8_2+dct83_sin_b*dct8_3+dct84_sin_b*dct8_4+dct85_sin_b*dct8_5+dct86_sin_b*dct8_6+dct87_sin_b*dct8_7+dct88_sin_b*dct8_8)*ctpoint8
gen dct8_mul_rad= (dct82_mul_b*dct8_2+dct83_mul_b*dct8_3+dct84_mul_b*dct8_4+dct85_mul_b*dct8_5+dct86_mul_b*dct8_6+dct87_mul_b*dct8_7+dct88_mul_b*dct8_8)*ctpoint8

twoway	(scatter dct8_sin_rad dgy, mc(gray)) ///
		(line linrad_sin dgy, ///
		 lpattern( solid ) ///
		 lcol(gray*0.75 ) ///
		 lw(medthick)) ///
		(scatter dct8_mul_rad dgy, mc(black)) ///
		(line linrad_mul dgy, ///
		 lpattern( solid ) ///
		 lcol(black*0.75 ) ///
		 lw(medthick)) ///
		(line lerad_mul dgy, ///
		 lpattern(shortdash) ///
		 lcol(black ) ///
		 lw(medthick)) , ///
			ti("{bf}Singularity ", pos(11) ring(1) size(5.7) )  ///
			yti("{bf}Odds ratio*" , size(4.7) )  ///
			yla(0 (2) 10, ang(1)) ///
			xti("{bf} Thyroid dose (Gy)", size(4.7) ) ///
			xla(0 (2) 12) ///
			legend(region(lwidth(none)) order(2 "Single" 4 "Multiple" 5 "Multiple L-E")) ///
			legend(col(1) pos(10) ring (0) size (5.5) symxsize(5) keygap(0.7) ) ///
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

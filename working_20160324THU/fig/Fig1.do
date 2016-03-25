! FIGURE 1: Curves and confidence intervals for all nodules whole dose range

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

gen dct7rad= (dgycat2b*dgycat2+dgycat3b*dgycat3+dgycat4b*dgycat4+dgycat5b*dgycat5+dgycat6b*dgycat6+dgycat7b*dgycat7)*ctpoint
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
ti("{bf}All nodules ")  ///
yti("{bf}Odds ratio* ")  ///
yla(1 (1)8,ang(1)) ///
xti("{bf} Thyroid dose (Gy)")  ///
legend(region(lwidth(none)) order(2 "Categorical ORs and 95%CIs" 3 "Linear" )) ///
legend(col(1) pos(10) ring (0) size (small) ) ///
note("{stSerif:* Adjusted for sex, log age at screening, year of birth, urbanicity at screening, oblast of }" "{stSerif: residence at time of accident, thyroid enlargement, goiter detected at screening, and }" "{stSerif: family history of thyroid disease.}", size(medsmall))  ///
name(Fig1, replace) graphregion(fc(white)) 

! Example
!Linear exponential model
scalar le_dgyb=0.2465
scalar le_dgyexb=0.08287

gen lerad= le_dgyb*dgy*exp(le_dgyexb*dgy)+1

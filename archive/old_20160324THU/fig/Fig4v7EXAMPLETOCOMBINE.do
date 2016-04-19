! FIGURE 4

! ERR rad vs Attained age plot	 
! For never-smoker:
! ERR_rad=(d10gyb*dose1)×(age/70)^lage70b×exp(e30b(agex-30)/10))


! Excess relative risk per Gy by attained age for never smoker
! assuming age at exposure agex=30, so e30=(agex-30)/10=0

clear
set obs 41
gen age = _n+49
scalar agex=30
scalar dose1=1

!GMM1
scalar gmmd10gyb=0.80
scalar gmmlage70b=-2.49

gen gmm1rad= gmmd10gyb*dose1*((age/70)^gmmlage70b)

!SMM1
scalar smmd10gyb=0.73
scalar smmlage70b=-2.60

gen smm1rad= smmd10gyb*dose1*((age/70)^smmlage70b)

!SAM1
scalar samd10gyb=1.15
scalar samlage70b=-2.61

gen sam1rad= samd10gyb*dose1*((age/70)^samlage70b)

!Unadjusted Rad only
scalar und10gyb=0.82
scalar unlage70b=-2.12

gen un1rad= und10gyb*dose1*((age/70)^unlage70b)

twoway (line sam1rad smm1rad gmm1rad  age, ///
	 lpattern(shortdash longdash  solid) ///
	 lcol(black*0.75 black*0.75 black*0.75  black*0.75) ///
	 lw(med medthick  thick)), ///
	 legend(label(1 "{stSerif:Additive model}") label(2 "{stSerif:Multiplicative model}") label(3 "{stSerif:Generalized multiplicative model}")  ) ///
	 legend(col(1) pos(1)) ///
	 yti("{bf}{stSerif:ERR at 1 Gy* }") yla(,ang(0)) ylab(0(.5)3) ///
	 xti("{bf}{stSerif:attained age}") ///
	 title("{stSerif:A}", pos(10)) ///
     note("{stSerif:* Sex-averaged radiation excess risk at}" "{stSerif:  1 Gy for never smoker exposed at age 30}", size(medsmall))  ///
	 name(Fig4A, replace) graphregion(fc(white))

! ERR rad vs Age at exposure plot	 
! For never-smoker:
! ERR_rad=(d10gyb*dose1)×(age/70)^lage70b×exp(e30b(agex-30)/10))
! Excess relative risk per Gy by age at exposure for never smoker
! assuming attained age =70


clear
set obs 51
gen agex = _n-1
scalar age=70
scalar dose1=1

!GMM1
scalar gmmd10gyb=0.80
scalar gmme30b=0.0626

gen gmm1rad= gmmd10gyb*dose1*exp(gmme30b*(agex-30)/10)

!SMM1
scalar smmd10gyb=0.7256
scalar smme30b=0.1386

gen smm1rad= smmd10gyb*dose1*exp(smme30b*(agex-30)/10)
scatter smm1rad age

!SAM1
scalar samd10gyb=1.147
scalar same30b=0.1471

gen sam1rad= samd10gyb*dose1*exp(same30b*(agex-30)/10)
scatter sam1rad age

!Unadjusted Rad only
scalar und10gyb=0.8248
scalar une30b=0.1487

gen un1rad= und10gyb*dose1*exp(une30b*(agex-30)/10)
scatter un1rad agex


twoway (line sam1rad smm1rad gmm1rad agex, ///
	 lpattern( shortdash longdash solid) ///
	 lcol(black*0.75 black*0.75 black*0.75  black*0.75) ///
	 lw(med medthick  thick) ), ///
	 legend(off) ///
	 yti("{bf}{stSerif:ERR at 1 Gy* }") yla(,ang(0)) ylab(0(.5)2) ///
	 xti("{bf}{stSerif:age at exposure}") ///
	 title("{stSerif:B}", pos(10)) ///
	 note("{stSerif:* Sex-averaged radiation excess risk at 1 Gy for}" "{stSerif: 1 Gy for never smoker at age 70}", size(medsmall))  ///
     name(Fig4B, replace) graphregion(fc(white))

	 
grc1leg Fig4A Fig4B, legendfrom(Fig4A) 	 
!graph combine Fig4A Fig4B

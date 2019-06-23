*****************************************************************************
************** Cohort2005 over 10 years: 2005-2015 *************
*****************************************************************************


********************************************
*********** 1. Data Management *************
********************************************

*********************************
********* year 2005 *************
*********************************
capture clear
capture clear matrix
capture clear mata
set showbaselevels on
set maxvar 10000, permanently
cd "/Users/bobwen/Desktop/PSID_1975_2017/Cohort2005"
use fam2005.dta, clear

***********************************
****** global variables************
***********************************
global couple ER25361
global ID ER25002
global wifeemploy ER25362
global wifeage ER25019
global num_chi ER25020
global husbandannuallabourincome ER27931
global marital ER28049
global age_youn ER25021
global wifeedu ER28048
global wifehealth ER27113
//global WIC 
//global WICeligible 
//global foodstamp 
global annualtransfers ER28002
global husbandSSI ER28031
global wifeSSI ER28033
global mealtogether ER25624
//global familywealth 
global region ER28042
global wiferace ER27297


global wifeannuallabourincome ER27943 
global wifeworkhours ER27895
global wifehousehours ER25620

global wifejobtype ER25399
global wifeocccode ER25385
global wifeunion ER25396
global wifefirmsize ER25390

global husbandworkhours ER27884

global wifeempstatus ER25362

global wifeexpyear ER25418
global wifeexpmonth ER25419 
global wifeexpweek ER25420 


*******************************************************
******The following can be copied for other years *****
*******************************************************

***********************************
****** generate variables *********
***********************************
gen couple=$couple

gen ID=$ID

gen wifelfstatus=.
replace wifelfstatus=1 if $wifeemploy==1 | $wifeemploy==2 
replace wifelfstatus=0 if $wifeemploy==3 | $wifeemploy==4 | $wifeemploy==5 | $wifeemploy==6 | $wifeemploy==7
label var wifelfstatus "1: employed or temporarily laid off; 0: umemployed"

gen agedummy=($wifeage>=17 & $wifeage<=55)
label var agedummy "age of spouse is between 17 and 55"

gen wifeage=$wifeage
replace wifeage=. if wifeage==999 | wifeage==0

gen num_chi=$num_chi

gen husbandweeklylabourincome= $husbandannuallabourincome/52.143/1000
label var husbandweeklylabourincome "husband weekly labour income in 1000$"

//gen husbandweeklywage=ER71277/52.143/1000 //another wage measure for husbands, annual wage and salary
//gen husbandwagerate=ER71392 // the third wage measure for husbands

gen marital=$marital

gen age_youn=$age_youn

gen wifeedu=$wifeedu
replace wifeedu=. if wifeedu==99

gen wifehealth=$wifehealth
replace wifehealth=. if wifehealth==8 | wifehealth==9

gen lnhusbandweeklylabourincome=ln(husbandweeklylabourincome)

//gen WIC=.
//replace WIC=1 if $WIC==1
//replace WIC=0 if $WIC==5

//gen WICeligible=($WICeligible==1)

//gen foodstamp=.
//replace foodstamp=1 if $foodstamp==1
//replace foodstamp=0 if $foodstamp==5

gen weeklyfamilytransfer=$annualtransfers/52.143/1000
label var weeklyfamilytransfer "weekly transfer income in $1000"

gen weeklyfamilySSinc=($husbandSSI+ $wifeSSI)/52.143/1000
label var weeklyfamilySSinc "weekly social security income in $1000"

gen mealtogether=$mealtogether
replace mealtogether=. if mealtogether==8 | mealtogether==9

//gen familywealth= $familywealth/1000

gen region=$region

gen regiondummy=(region==1 | region==2 | region==3 | region==4)

//gen wiferace=$wiferace
//replace wiferace=. if wiferace==9

gen wifeweeklylabourincome=$wifeannuallabourincome/52.143/1000
label var wifeweeklylabourincome "wife weekly labour income in 1000$"
gen lnwifewage=ln(wifeweeklylabourincome)

gen wifeweeklyworkhours=$wifeworkhours
gen lnwifehours=ln(wifeweeklyworkhours)
gen wifeweeklyhousehours=$wifehousehours
replace wifeweeklyhousehours=. if wifeweeklyhousehours==998 | wifeweeklyhousehours==999

gen wifelabourinctype=.
replace wifelabourinctype=1 if $wifejobtype==1 | $wifejobtype==2
replace wifelabourinctype=2 if $wifejobtype==3 | $wifejobtype==4 | $wifejobtype==6
replace wifelabourinctype=3 if $wifejobtype==7 | $wifejobtype==8 | $wifejobtype==9 | $wifejobtype==0

gen wiferace=4
replace wiferace=1 if $wiferace==1
replace wiferace=2 if $wiferace==2
replace wiferace=3 if $wiferace==4
label var wiferace "1: white; 2: black; 3: asian; 4: other"

gen wifeocccode=$wifeocccode
gen wifeocc=.
replace wifeocc=11 if wifeocccode>=1 & wifeocccode<=43
replace wifeocc=13 if wifeocccode>=50 & wifeocccode<=95
replace wifeocc=15 if wifeocccode>=100 & wifeocccode<=124
replace wifeocc=17 if wifeocccode>=130 & wifeocccode<=156
replace wifeocc=19 if wifeocccode>=160 & wifeocccode<=196
replace wifeocc=21 if wifeocccode>=200 & wifeocccode<=206
replace wifeocc=23 if wifeocccode>=210 & wifeocccode<=215
replace wifeocc=25 if wifeocccode>=220 & wifeocccode<=255
replace wifeocc=27 if wifeocccode>=260 & wifeocccode<=296
replace wifeocc=29 if wifeocccode>=300 & wifeocccode<=354
replace wifeocc=31 if wifeocccode>=360 & wifeocccode<=365
replace wifeocc=33 if wifeocccode>=370 & wifeocccode<=395
replace wifeocc=35 if wifeocccode>=400 & wifeocccode<=416
replace wifeocc=37 if wifeocccode>=420 & wifeocccode<=425
replace wifeocc=39 if wifeocccode>=430 & wifeocccode<=465
replace wifeocc=41 if wifeocccode>=470 & wifeocccode<=496
replace wifeocc=43 if wifeocccode>=500 & wifeocccode<=593
replace wifeocc=45 if wifeocccode>=600 & wifeocccode<=613
replace wifeocc=47 if wifeocccode>=620 & wifeocccode<=676
replace wifeocc=49 if wifeocccode>=700 & wifeocccode<=762
replace wifeocc=51 if wifeocccode>=770 & wifeocccode<=896
replace wifeocc=53 if wifeocccode>=900 & wifeocccode<=975

gen nowifedummy=($wifeage==0)
gen wifeunioncont=.
replace wifeunioncont=1 if $wifeunion==1
replace wifeunioncont=0 if $wifeunion==5

gen wifefirmsize=$wifefirmsize
replace wifefirmsize=. if wifefirmsize==999999998 | wifefirmsize==999999999

gen husbandweeklyworkhours=$husbandworkhours
gen lnhusbandhours=ln(husbandweeklyworkhours)

gen wifeworkstatus=.
replace wifeworkstatus=1 if $wifeempstatus==1 | $wifeempstatus==2
replace wifeworkstatus=0 if $wifeempstatus==3 | $wifeempstatus==4 | $wifeempstatus==5 | $wifeempstatus==6 | $wifeempstatus==7

gen secondwifeworkstatus=.
replace secondwifeworkstatus=1 if wifeweeklyworkhours>0 & couple==1
replace secondwifeworkstatus=0 if wifeweeklyworkhours==0 & couple==1

drop wifeocccode


gen wifeexpyear=$wifeexpyear
replace wifeexpyear=. if wifeexpyear==98 | wifeexpyear==99
gen wifeexpmonth=$wifeexpmonth
replace wifeexpmonth=. if wifeexpmonth==98 | wifeexpmonth==99
gen wifeexpweek=$wifeexpweek
replace wifeexpweek=. if wifeexpweek==98 | wifeexpweek==99
gen wifeexp=wifeexpweek+wifeexpmonth*4.345+wifeexpyear*52.143

drop ER*
drop wifeexpyear wifeexpmonth wifeexpweek

order ID wifeworkstatus secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours lnwifehours husbandweeklyworkhours lnhusbandhours ///
wifeweeklyhousehours marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc  wifefirmsize ///
wifeedu wifehealth  wifeage region wifelabourinctype wiferace wifeocc nowifedummy wifeunioncont /// 
 wifeexp ///
lnhusbandweeklylabourincome 


foreach var of varlist ID-lnhusbandweeklylabourincome {
rename `var' `var'2005
}

merge 1:1 ID2005 using wealth05.dta
drop _merge
drop S*


save year2005.dta, replace










*********************************
********* year 2007 *************
*********************************
use fam2007.dta, clear

***********************************
****** global variables************
***********************************
global couple ER36366
global ID ER36002
global wifeemploy ER36367 
global wifeage ER36019
global num_chi ER36020
global husbandannuallabourincome ER40921
global marital ER41039
global age_youn ER36021
global wifeedu ER41038
global wifehealth ER39299 
//global WIC 
//global WICeligible 
//global foodstamp 
global annualtransfers ER40992
global husbandSSI ER41021 
global wifeSSI ER41023 
global mealtogether ER36629 
//global familywealth 
global region ER41032
global wiferace ER40472



global wifeannuallabourincome ER40933
global wifeworkhours ER40885 
global wifehousehours ER36625

global wifejobtype ER36404
global wifeocccode ER36390
global wifeunion ER36401
global wifefirmsize ER36395

global husbandworkhours ER40874 

global wifeempstatus ER36367 

global wifeexpyear ER36423
global wifeexpmonth ER36424
global wifeexpweek ER36425 


*******************************************************
******The following can be copied for other years *****
*******************************************************

***********************************
****** generate variables *********
***********************************
gen couple=$couple

gen ID=$ID

gen wifelfstatus=.
replace wifelfstatus=1 if $wifeemploy==1 | $wifeemploy==2 
replace wifelfstatus=0 if $wifeemploy==3 | $wifeemploy==4 | $wifeemploy==5 | $wifeemploy==6 | $wifeemploy==7
label var wifelfstatus "1: employed or temporarily laid off; 0: umemployed"

gen agedummy=($wifeage>=17 & $wifeage<=55)
label var agedummy "age of spouse is between 17 and 55"

gen wifeage=$wifeage
replace wifeage=. if wifeage==999 | wifeage==0

gen num_chi=$num_chi

gen husbandweeklylabourincome= $husbandannuallabourincome/52.143/1000
label var husbandweeklylabourincome "husband weekly labour income in 1000$"



//gen husbandweeklywage=ER71277/52.143/1000 //another wage measure for husbands, annual wage and salary
//gen husbandwagerate=ER71392 // the third wage measure for husbands

gen marital=$marital

gen age_youn=$age_youn

gen wifeedu=$wifeedu
replace wifeedu=. if wifeedu==99

gen wifehealth=$wifehealth
replace wifehealth=. if wifehealth==8 | wifehealth==9

gen lnhusbandweeklylabourincome=ln(husbandweeklylabourincome)

//gen WIC=.
//replace WIC=1 if $WIC==1
//replace WIC=0 if $WIC==5

//gen WICeligible=($WICeligible==1)

//gen foodstamp=.
//replace foodstamp=1 if $foodstamp==1
//replace foodstamp=0 if $foodstamp==5

gen weeklyfamilytransfer=$annualtransfers/52.143/1000
label var weeklyfamilytransfer "weekly transfer income in $1000"

gen weeklyfamilySSinc=($husbandSSI+ $wifeSSI)/52.143/1000
label var weeklyfamilySSinc "weekly social security income in $1000"

gen mealtogether=$mealtogether
replace mealtogether=. if mealtogether==8 | mealtogether==9

//gen familywealth= $familywealth/1000

gen region=$region

gen regiondummy=(region==1 | region==2 | region==3 | region==4)

//gen wiferace=$wiferace
//replace wiferace=. if wiferace==9
gen wifeweeklylabourincome=$wifeannuallabourincome/52.143/1000
label var wifeweeklylabourincome "wife weekly labour income in 1000$"
gen lnwifewage=ln(wifeweeklylabourincome)

gen wifeweeklyworkhours=$wifeworkhours
gen lnwifehours=ln(wifeweeklyworkhours)

gen wifeweeklyhousehours=$wifehousehours
replace wifeweeklyhousehours=. if wifeweeklyhousehours==998 | wifeweeklyhousehours==999

gen wifelabourinctype=.
replace wifelabourinctype=1 if $wifejobtype==1 | $wifejobtype==2
replace wifelabourinctype=2 if $wifejobtype==3 | $wifejobtype==4 | $wifejobtype==6
replace wifelabourinctype=3 if $wifejobtype==7 | $wifejobtype==8 | $wifejobtype==9 | $wifejobtype==0

gen wiferace=4
replace wiferace=1 if $wiferace==1
replace wiferace=2 if $wiferace==2
replace wiferace=3 if $wiferace==4
label var wiferace "1: white; 2: black; 3: asian; 4: other"

gen wifeocccode=$wifeocccode
gen wifeocc=.
replace wifeocc=11 if wifeocccode>=1 & wifeocccode<=43
replace wifeocc=13 if wifeocccode>=50 & wifeocccode<=95
replace wifeocc=15 if wifeocccode>=100 & wifeocccode<=124
replace wifeocc=17 if wifeocccode>=130 & wifeocccode<=156
replace wifeocc=19 if wifeocccode>=160 & wifeocccode<=196
replace wifeocc=21 if wifeocccode>=200 & wifeocccode<=206
replace wifeocc=23 if wifeocccode>=210 & wifeocccode<=215
replace wifeocc=25 if wifeocccode>=220 & wifeocccode<=255
replace wifeocc=27 if wifeocccode>=260 & wifeocccode<=296
replace wifeocc=29 if wifeocccode>=300 & wifeocccode<=354
replace wifeocc=31 if wifeocccode>=360 & wifeocccode<=365
replace wifeocc=33 if wifeocccode>=370 & wifeocccode<=395
replace wifeocc=35 if wifeocccode>=400 & wifeocccode<=416
replace wifeocc=37 if wifeocccode>=420 & wifeocccode<=425
replace wifeocc=39 if wifeocccode>=430 & wifeocccode<=465
replace wifeocc=41 if wifeocccode>=470 & wifeocccode<=496
replace wifeocc=43 if wifeocccode>=500 & wifeocccode<=593
replace wifeocc=45 if wifeocccode>=600 & wifeocccode<=613
replace wifeocc=47 if wifeocccode>=620 & wifeocccode<=676
replace wifeocc=49 if wifeocccode>=700 & wifeocccode<=762
replace wifeocc=51 if wifeocccode>=770 & wifeocccode<=896
replace wifeocc=53 if wifeocccode>=900 & wifeocccode<=975

gen nowifedummy=($wifeage==0)
gen wifeunioncont=.
replace wifeunioncont=1 if $wifeunion==1
replace wifeunioncont=0 if $wifeunion==5

gen wifefirmsize=$wifefirmsize
replace wifefirmsize=. if wifefirmsize==999999998 | wifefirmsize==999999999

gen husbandweeklyworkhours=$husbandworkhours
gen lnhusbandhours=ln(husbandweeklyworkhours)

gen wifeworkstatus=.
replace wifeworkstatus=1 if $wifeempstatus==1 | $wifeempstatus==2
replace wifeworkstatus=0 if $wifeempstatus==3 | $wifeempstatus==4 | $wifeempstatus==5 | $wifeempstatus==6 | $wifeempstatus==7

gen secondwifeworkstatus=.
replace secondwifeworkstatus=1 if wifeweeklyworkhours>0 & couple==1
replace secondwifeworkstatus=0 if wifeweeklyworkhours==0 & couple==1

drop wifeocccode


gen wifeexpyear=$wifeexpyear
replace wifeexpyear=. if wifeexpyear==98 | wifeexpyear==99
gen wifeexpmonth=$wifeexpmonth
replace wifeexpmonth=. if wifeexpmonth==98 | wifeexpmonth==99
gen wifeexpweek=$wifeexpweek
replace wifeexpweek=. if wifeexpweek==98 | wifeexpweek==99
gen wifeexp=wifeexpweek+wifeexpmonth*4.345+wifeexpyear*52.143

drop ER*
drop wifeexpyear wifeexpmonth wifeexpweek

order ID wifeworkstatus secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours lnwifehours husbandweeklyworkhours lnhusbandhours ///
wifeweeklyhousehours marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc  wifefirmsize ///
wifeedu wifehealth  wifeage region wifelabourinctype wiferace wifeocc nowifedummy wifeunioncont /// 
 wifeexp ///
lnhusbandweeklylabourincome 

foreach var of varlist ID-lnhusbandweeklylabourincome {
rename `var' `var'2007
}

merge 1:1 ID2007 using wealth2007.dta
drop _merge
drop S*


save year2007.dta, replace















*********************************
********* year 2009 *************
*********************************
use fam2009.dta, clear

***********************************
****** global variables************
***********************************
global couple ER42391
global ID ER42002
global wifeemploy ER42392
global wifeage ER42019
global num_chi ER42020
global husbandannuallabourincome ER46829
global marital ER46983
global age_youn ER42021
global wifeedu ER46982
global wifehealth ER45272
//global WIC 
//global WICeligible 
//global foodstamp 
global annualtransfers ER46900
global husbandSSI ER46929
global wifeSSI ER46931
global mealtogether ER42648
global familywealth ER46968
global secondfamilywealth ER46970
global region ER46974
global wiferace ER46449 


global wifeannuallabourincome ER46841
global wifeworkhours ER46784
global wifehousehours ER42644

global wifejobtype ER42433
global wifeocccode ER42419
global wifeunion ER42430
global wifefirmsize ER42424

global husbandworkhours ER46763

global wifeempstatus ER42392 

global wifeexpyear ER42452
global wifeexpmonth ER42453
global wifeexpweek ER42454 



*******************************************************
******The following can be copied for other years *****
*******************************************************

***********************************
****** generate variables *********
***********************************
gen couple=$couple

gen ID=$ID

gen wifelfstatus=.
replace wifelfstatus=1 if $wifeemploy==1 | $wifeemploy==2 
replace wifelfstatus=0 if $wifeemploy==3 | $wifeemploy==4 | $wifeemploy==5 | $wifeemploy==6 | $wifeemploy==7
label var wifelfstatus "1: employed or temporarily laid off; 0: umemployed"

gen agedummy=($wifeage>=17 & $wifeage<=55)
label var agedummy "age of spouse is between 17 and 55"

gen wifeage=$wifeage
replace wifeage=. if wifeage==999 | wifeage==0

gen num_chi=$num_chi

gen husbandweeklylabourincome= $husbandannuallabourincome/52.143/1000
label var husbandweeklylabourincome "husband weekly labour income in 1000$"
gen wifeweeklyworkhours=$wifeworkhours
gen lnwifehours=ln(wifeweeklyworkhours)

gen wifeweeklyhousehours=$wifehousehours
replace wifeweeklyhousehours=. if wifeweeklyhousehours==998 | wifeweeklyhousehours==999


//gen husbandweeklywage=ER71277/52.143/1000 //another wage measure for husbands, annual wage and salary
//gen husbandwagerate=ER71392 // the third wage measure for husbands

gen marital=$marital

gen age_youn=$age_youn

gen wifeedu=$wifeedu
replace wifeedu=. if wifeedu==99

gen wifehealth=$wifehealth
replace wifehealth=. if wifehealth==8 | wifehealth==9

gen lnhusbandweeklylabourincome=ln(husbandweeklylabourincome)

//gen WIC=.
//replace WIC=1 if $WIC==1
//replace WIC=0 if $WIC==5

//gen WICeligible=($WICeligible==1)

//gen foodstamp=.
//replace foodstamp=1 if $foodstamp==1
//replace foodstamp=0 if $foodstamp==5

gen weeklyfamilytransfer=$annualtransfers/52.143/1000
label var weeklyfamilytransfer "weekly transfer income in $1000"

gen weeklyfamilySSinc=($husbandSSI+ $wifeSSI)/52.143/1000
label var weeklyfamilySSinc "weekly social security income in $1000"

gen mealtogether=$mealtogether
replace mealtogether=. if mealtogether==8 | mealtogether==9

gen familywealth= $familywealth/1000000
gen secondfamilywealth=$secondfamilywealth/1000000

gen region=$region

gen regiondummy=(region==1 | region==2 | region==3 | region==4)

//gen wiferace=$wiferace
//replace wiferace=. if wiferace==9

gen wifeweeklylabourincome=$wifeannuallabourincome/52.143/1000
label var wifeweeklylabourincome "wife weekly labour income in 1000$"
gen lnwifewage=ln(wifeweeklylabourincome)

gen wifelabourinctype=.
replace wifelabourinctype=1 if $wifejobtype==1 | $wifejobtype==2
replace wifelabourinctype=2 if $wifejobtype==3 | $wifejobtype==4 | $wifejobtype==6
replace wifelabourinctype=3 if $wifejobtype==7 | $wifejobtype==8 | $wifejobtype==9 | $wifejobtype==0

gen wiferace=4
replace wiferace=1 if $wiferace==1
replace wiferace=2 if $wiferace==2
replace wiferace=3 if $wiferace==4
label var wiferace "1: white; 2: black; 3: asian; 4: other"

gen wifeocccode=$wifeocccode
gen wifeocc=.
replace wifeocc=11 if wifeocccode>=1 & wifeocccode<=43
replace wifeocc=13 if wifeocccode>=50 & wifeocccode<=95
replace wifeocc=15 if wifeocccode>=100 & wifeocccode<=124
replace wifeocc=17 if wifeocccode>=130 & wifeocccode<=156
replace wifeocc=19 if wifeocccode>=160 & wifeocccode<=196
replace wifeocc=21 if wifeocccode>=200 & wifeocccode<=206
replace wifeocc=23 if wifeocccode>=210 & wifeocccode<=215
replace wifeocc=25 if wifeocccode>=220 & wifeocccode<=255
replace wifeocc=27 if wifeocccode>=260 & wifeocccode<=296
replace wifeocc=29 if wifeocccode>=300 & wifeocccode<=354
replace wifeocc=31 if wifeocccode>=360 & wifeocccode<=365
replace wifeocc=33 if wifeocccode>=370 & wifeocccode<=395
replace wifeocc=35 if wifeocccode>=400 & wifeocccode<=416
replace wifeocc=37 if wifeocccode>=420 & wifeocccode<=425
replace wifeocc=39 if wifeocccode>=430 & wifeocccode<=465
replace wifeocc=41 if wifeocccode>=470 & wifeocccode<=496
replace wifeocc=43 if wifeocccode>=500 & wifeocccode<=593
replace wifeocc=45 if wifeocccode>=600 & wifeocccode<=613
replace wifeocc=47 if wifeocccode>=620 & wifeocccode<=676
replace wifeocc=49 if wifeocccode>=700 & wifeocccode<=762
replace wifeocc=51 if wifeocccode>=770 & wifeocccode<=896
replace wifeocc=53 if wifeocccode>=900 & wifeocccode<=975

gen nowifedummy=($wifeage==0)
gen wifeunioncont=.
replace wifeunioncont=1 if $wifeunion==1
replace wifeunioncont=0 if $wifeunion==5

gen wifefirmsize=$wifefirmsize
replace wifefirmsize=. if wifefirmsize==999999998 | wifefirmsize==999999999

gen husbandweeklyworkhours=$husbandworkhours
gen lnhusbandhours=ln(husbandweeklyworkhours)


gen wifeworkstatus=.
replace wifeworkstatus=1 if $wifeempstatus==1 | $wifeempstatus==2
replace wifeworkstatus=0 if $wifeempstatus==3 | $wifeempstatus==4 | $wifeempstatus==5 | $wifeempstatus==6 | $wifeempstatus==7

gen secondwifeworkstatus=.
replace secondwifeworkstatus=1 if wifeweeklyworkhours>0 & couple==1
replace secondwifeworkstatus=0 if wifeweeklyworkhours==0 & couple==1

gen wifeexpyear=$wifeexpyear
replace wifeexpyear=. if wifeexpyear==98 | wifeexpyear==99
gen wifeexpmonth=$wifeexpmonth
replace wifeexpmonth=. if wifeexpmonth==98 | wifeexpmonth==99
gen wifeexpweek=$wifeexpweek
replace wifeexpweek=. if wifeexpweek==98 | wifeexpweek==99
gen wifeexp=wifeexpweek+wifeexpmonth*4.345+wifeexpyear*52.143
drop wifeexpyear wifeexpmonth wifeexpweek


order ID wifeworkstatus secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours lnwifehours husbandweeklyworkhours lnhusbandhours ///
wifeweeklyhousehours marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc  wifefirmsize ///
wifeedu wifehealth  wifeage region wifelabourinctype wiferace wifeocc nowifedummy wifeunioncont /// 
familywealth secondfamilywealth wifeexp ///
lnhusbandweeklylabourincome 

drop wifeocccode
drop ER*

foreach var of varlist ID-lnhusbandweeklylabourincome {
rename `var' `var'2009
}

save year2009.dta, replace














*********************************
********* year 2011 *************
*********************************
use fam2011.dta, clear


***********************************
****** global variables************
***********************************
global couple ER47704
global ID ER47302
global wifeemploy ER47705
global wifeage ER47319
global num_chi ER47320
global husbandannuallabourincome ER52237
global marital ER52407
global age_youn ER47321
global wifeedu ER52406
global wifehealth ER50612
//global WIC 
//global WICeligible 
//global foodstamp 
global annualtransfers ER52308
global husbandSSI ER52337
global wifeSSI ER52339
global mealtogether ER47966
global familywealth ER52392
global secondfamilywealth ER52394
global region ER52398
global wiferace ER51810


global wifeannuallabourincome ER52249
global wifeworkhours ER52192
global wifehousehours ER47962

global wifejobtype ER47751
global wifeocccode ER47736
global wifeunion ER47748
global wifefirmsize ER47742

global husbandworkhours ER52171

global wifeempstatus ER47705 

global wifeexpyear ER47770
global wifeexpmonth ER47771
global wifeexpweek ER47772



*******************************************************
******The following can be copied for other years *****
*******************************************************

***********************************
****** generate variables *********
***********************************
gen couple=$couple

gen ID=$ID

gen wifelfstatus=.
replace wifelfstatus=1 if $wifeemploy==1 | $wifeemploy==2 
replace wifelfstatus=0 if $wifeemploy==3 | $wifeemploy==4 | $wifeemploy==5 | $wifeemploy==6 | $wifeemploy==7
label var wifelfstatus "1: employed or temporarily laid off; 0: umemployed"

gen agedummy=($wifeage>=17 & $wifeage<=55)
label var agedummy "age of spouse is between 17 and 55"

gen wifeage=$wifeage
replace wifeage=. if wifeage==999 | wifeage==0

gen num_chi=$num_chi

gen husbandweeklylabourincome= $husbandannuallabourincome/52.143/1000
label var husbandweeklylabourincome "husband weekly labour income in 1000$"

//gen husbandweeklywage=ER71277/52.143/1000 //another wage measure for husbands, annual wage and salary
//gen husbandwagerate=ER71392 // the third wage measure for husbands

gen marital=$marital

gen age_youn=$age_youn

gen wifeedu=$wifeedu
replace wifeedu=. if wifeedu==99

gen wifehealth=$wifehealth
replace wifehealth=. if wifehealth==8 | wifehealth==9

gen lnhusbandweeklylabourincome=ln(husbandweeklylabourincome)

//gen WIC=.
//replace WIC=1 if $WIC==1
//replace WIC=0 if $WIC==5

//gen WICeligible=($WICeligible==1)

//gen foodstamp=.
//replace foodstamp=1 if $foodstamp==1
//replace foodstamp=0 if $foodstamp==5

gen weeklyfamilytransfer=$annualtransfers/52.143/1000
label var weeklyfamilytransfer "weekly transfer income in $1000"

gen weeklyfamilySSinc=($husbandSSI+ $wifeSSI)/52.143/1000
label var weeklyfamilySSinc "weekly social security income in $1000"

gen mealtogether=$mealtogether
replace mealtogether=. if mealtogether==8 | mealtogether==9

gen familywealth= $familywealth/1000000
gen secondfamilywealth=$secondfamilywealth/1000000

gen region=$region

gen regiondummy=(region==1 | region==2 | region==3 | region==4)

gen wifeweeklylabourincome=$wifeannuallabourincome/52.143/1000
label var wifeweeklylabourincome "wife weekly labour income in 1000$"
gen lnwifewage=ln(wifeweeklylabourincome)

gen wifeweeklyworkhours=$wifeworkhours
gen lnwifehours=ln(wifeweeklyworkhours)

gen wifeweeklyhousehours=$wifehousehours
replace wifeweeklyhousehours=. if wifeweeklyhousehours==998 | wifeweeklyhousehours==999


//gen wiferace=$wiferace
//replace wiferace=. if wiferace==9

gen wifelabourinctype=.
replace wifelabourinctype=1 if $wifejobtype==1 | $wifejobtype==2
replace wifelabourinctype=2 if $wifejobtype==3 | $wifejobtype==4 | $wifejobtype==6
replace wifelabourinctype=3 if $wifejobtype==7 | $wifejobtype==8 | $wifejobtype==9 | $wifejobtype==0

gen wiferace=4
replace wiferace=1 if $wiferace==1
replace wiferace=2 if $wiferace==2
replace wiferace=3 if $wiferace==4
label var wiferace "1: white; 2: black; 3: asian; 4: other"

gen wifeocccode=$wifeocccode
gen wifeocc=.
replace wifeocc=11 if wifeocccode>=1 & wifeocccode<=43
replace wifeocc=13 if wifeocccode>=50 & wifeocccode<=95
replace wifeocc=15 if wifeocccode>=100 & wifeocccode<=124
replace wifeocc=17 if wifeocccode>=130 & wifeocccode<=156
replace wifeocc=19 if wifeocccode>=160 & wifeocccode<=196
replace wifeocc=21 if wifeocccode>=200 & wifeocccode<=206
replace wifeocc=23 if wifeocccode>=210 & wifeocccode<=215
replace wifeocc=25 if wifeocccode>=220 & wifeocccode<=255
replace wifeocc=27 if wifeocccode>=260 & wifeocccode<=296
replace wifeocc=29 if wifeocccode>=300 & wifeocccode<=354
replace wifeocc=31 if wifeocccode>=360 & wifeocccode<=365
replace wifeocc=33 if wifeocccode>=370 & wifeocccode<=395
replace wifeocc=35 if wifeocccode>=400 & wifeocccode<=416
replace wifeocc=37 if wifeocccode>=420 & wifeocccode<=425
replace wifeocc=39 if wifeocccode>=430 & wifeocccode<=465
replace wifeocc=41 if wifeocccode>=470 & wifeocccode<=496
replace wifeocc=43 if wifeocccode>=500 & wifeocccode<=593
replace wifeocc=45 if wifeocccode>=600 & wifeocccode<=613
replace wifeocc=47 if wifeocccode>=620 & wifeocccode<=676
replace wifeocc=49 if wifeocccode>=700 & wifeocccode<=762
replace wifeocc=51 if wifeocccode>=770 & wifeocccode<=896
replace wifeocc=53 if wifeocccode>=900 & wifeocccode<=975

gen nowifedummy=($wifeage==0)
gen wifeunioncont=.
replace wifeunioncont=1 if $wifeunion==1
replace wifeunioncont=0 if $wifeunion==5

gen wifefirmsize=$wifefirmsize
replace wifefirmsize=. if wifefirmsize==999999998 | wifefirmsize==999999999

gen husbandweeklyworkhours=$husbandworkhours
gen lnhusbandhours=ln(husbandweeklyworkhours)

gen wifeworkstatus=.
replace wifeworkstatus=1 if $wifeempstatus==1 | $wifeempstatus==2
replace wifeworkstatus=0 if $wifeempstatus==3 | $wifeempstatus==4 | $wifeempstatus==5 | $wifeempstatus==6 | $wifeempstatus==7

gen secondwifeworkstatus=.
replace secondwifeworkstatus=1 if wifeweeklyworkhours>0 & couple==1
replace secondwifeworkstatus=0 if wifeweeklyworkhours==0 & couple==1

gen wifeexpyear=$wifeexpyear
replace wifeexpyear=. if wifeexpyear==98 | wifeexpyear==99
gen wifeexpmonth=$wifeexpmonth
replace wifeexpmonth=. if wifeexpmonth==98 | wifeexpmonth==99
gen wifeexpweek=$wifeexpweek
replace wifeexpweek=. if wifeexpweek==98 | wifeexpweek==99
gen wifeexp=wifeexpweek+wifeexpmonth*4.345+wifeexpyear*52.143
drop wifeexpyear wifeexpmonth wifeexpweek


order ID wifeworkstatus secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours lnwifehours husbandweeklyworkhours lnhusbandhours ///
wifeweeklyhousehours marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc  wifefirmsize ///
wifeedu wifehealth  wifeage region wifelabourinctype wiferace wifeocc nowifedummy wifeunioncont /// 
familywealth secondfamilywealth wifeexp ///
lnhusbandweeklylabourincome 

drop wifeocccode
drop ER*

foreach var of varlist ID-lnhusbandweeklylabourincome {
rename `var' `var'2011
}

save year2011.dta, replace












*********************************
********* year 2013 *************
*********************************
use fam2013.dta, clear

***********************************
****** global variables************
***********************************
global couple ER53410 
global ID ER53002
global wifeemploy ER53411
global wifeage ER53019
global num_chi ER53020
global husbandannuallabourincome ER58038
global marital ER58225
global age_youn ER53021
global wifeedu ER58224
global wifehealth ER56360
//global WIC 
//global WICeligible 
//global foodstamp 
global annualtransfers ER58117
global husbandSSI ER58146
global wifeSSI ER58148
global mealtogether ER53678
global familywealth ER58209 
global secondfamilywealth ER58211
global region ER58215
global wiferace ER57549

global wifeannuallabourincome ER58050
global wifeworkhours ER57993
global wifehousehours ER53674

global wifejobtype ER53457
global wifeocccode ER53442
global wifeunion ER53454
global wifefirmsize ER53448

global husbandworkhours ER57972

global wifeempstatus ER53411

global wifeexpyear ER53476
global wifeexpmonth ER53477
global wifeexpweek ER53478




*******************************************************
******The following can be copied for other years *****
*******************************************************

***********************************
****** generate variables *********
***********************************
gen couple=$couple

gen ID=$ID

gen wifelfstatus=.
replace wifelfstatus=1 if $wifeemploy==1 | $wifeemploy==2 
replace wifelfstatus=0 if $wifeemploy==3 | $wifeemploy==4 | $wifeemploy==5 | $wifeemploy==6 | $wifeemploy==7
label var wifelfstatus "1: employed or temporarily laid off; 0: umemployed"

gen agedummy=($wifeage>=17 & $wifeage<=55)
label var agedummy "age of spouse is between 17 and 55"

gen wifeage=$wifeage
replace wifeage=. if wifeage==999 | wifeage==0

gen num_chi=$num_chi

gen husbandweeklylabourincome= $husbandannuallabourincome/52.143/1000
label var husbandweeklylabourincome "husband weekly labour income in 1000$"

//gen husbandweeklywage=ER71277/52.143/1000 //another wage measure for husbands, annual wage and salary
//gen husbandwagerate=ER71392 // the third wage measure for husbands

gen marital=$marital

gen age_youn=$age_youn

gen wifeedu=$wifeedu
replace wifeedu=. if wifeedu==99


gen wifehealth=$wifehealth
replace wifehealth=. if wifehealth==8 | wifehealth==9

gen lnhusbandweeklylabourincome=ln(husbandweeklylabourincome)

//gen WIC=.
//replace WIC=1 if $WIC==1
//replace WIC=0 if $WIC==5

//gen WICeligible=($WICeligible==1)

//gen foodstamp=.
//replace foodstamp=1 if $foodstamp==1
//replace foodstamp=0 if $foodstamp==5

gen weeklyfamilytransfer=$annualtransfers/52.143/1000
label var weeklyfamilytransfer "weekly transfer income in $1000"

gen weeklyfamilySSinc=($husbandSSI+ $wifeSSI)/52.143/1000
label var weeklyfamilySSinc "weekly social security income in $1000"

gen mealtogether=$mealtogether
replace mealtogether=. if mealtogether==8 | mealtogether==9

gen familywealth= $familywealth/1000000
gen secondfamilywealth=$secondfamilywealth/1000000

gen region=$region

gen regiondummy=(region==1 | region==2 | region==3 | region==4)

gen wifeweeklylabourincome=$wifeannuallabourincome/52.143/1000
label var wifeweeklylabourincome "wife weekly labour income in 1000$"
gen lnwifewage=ln(wifeweeklylabourincome)

gen wifeweeklyworkhours=$wifeworkhours
gen lnwifehours=ln(wifeweeklyworkhours)

gen wifeweeklyhousehours=$wifehousehours
replace wifeweeklyhousehours=. if wifeweeklyhousehours==998 | wifeweeklyhousehours==999


//gen wiferace=$wiferace
//replace wiferace=. if wiferace==9

gen wifelabourinctype=.
replace wifelabourinctype=1 if $wifejobtype==1 | $wifejobtype==2
replace wifelabourinctype=2 if $wifejobtype==3 | $wifejobtype==4 | $wifejobtype==6
replace wifelabourinctype=3 if $wifejobtype==7 | $wifejobtype==8 | $wifejobtype==9 | $wifejobtype==0

gen wiferace=4
replace wiferace=1 if $wiferace==1
replace wiferace=2 if $wiferace==2
replace wiferace=3 if $wiferace==4
label var wiferace "1: white; 2: black; 3: asian; 4: other"

gen wifeocccode=$wifeocccode
gen wifeocc=.
replace wifeocc=11 if wifeocccode>=1 & wifeocccode<=43
replace wifeocc=13 if wifeocccode>=50 & wifeocccode<=95
replace wifeocc=15 if wifeocccode>=100 & wifeocccode<=124
replace wifeocc=17 if wifeocccode>=130 & wifeocccode<=156
replace wifeocc=19 if wifeocccode>=160 & wifeocccode<=196
replace wifeocc=21 if wifeocccode>=200 & wifeocccode<=206
replace wifeocc=23 if wifeocccode>=210 & wifeocccode<=215
replace wifeocc=25 if wifeocccode>=220 & wifeocccode<=255
replace wifeocc=27 if wifeocccode>=260 & wifeocccode<=296
replace wifeocc=29 if wifeocccode>=300 & wifeocccode<=354
replace wifeocc=31 if wifeocccode>=360 & wifeocccode<=365
replace wifeocc=33 if wifeocccode>=370 & wifeocccode<=395
replace wifeocc=35 if wifeocccode>=400 & wifeocccode<=416
replace wifeocc=37 if wifeocccode>=420 & wifeocccode<=425
replace wifeocc=39 if wifeocccode>=430 & wifeocccode<=465
replace wifeocc=41 if wifeocccode>=470 & wifeocccode<=496
replace wifeocc=43 if wifeocccode>=500 & wifeocccode<=593
replace wifeocc=45 if wifeocccode>=600 & wifeocccode<=613
replace wifeocc=47 if wifeocccode>=620 & wifeocccode<=676
replace wifeocc=49 if wifeocccode>=700 & wifeocccode<=762
replace wifeocc=51 if wifeocccode>=770 & wifeocccode<=896
replace wifeocc=53 if wifeocccode>=900 & wifeocccode<=975

gen nowifedummy=($wifeage==0)
gen wifeunioncont=.
replace wifeunioncont=1 if $wifeunion==1
replace wifeunioncont=0 if $wifeunion==5

gen wifefirmsize=$wifefirmsize
replace wifefirmsize=. if wifefirmsize==999999998 | wifefirmsize==999999999

gen husbandweeklyworkhours=$husbandworkhours
gen lnhusbandhours=ln(husbandweeklyworkhours)

gen wifeworkstatus=.
replace wifeworkstatus=1 if $wifeempstatus==1 | $wifeempstatus==2
replace wifeworkstatus=0 if $wifeempstatus==3 | $wifeempstatus==4 | $wifeempstatus==5 | $wifeempstatus==6 | $wifeempstatus==7

gen secondwifeworkstatus=.
replace secondwifeworkstatus=1 if wifeweeklyworkhours>0 & couple==1
replace secondwifeworkstatus=0 if wifeweeklyworkhours==0 & couple==1

gen wifeexpyear=$wifeexpyear
replace wifeexpyear=. if wifeexpyear==98 | wifeexpyear==99
gen wifeexpmonth=$wifeexpmonth
replace wifeexpmonth=. if wifeexpmonth==98 | wifeexpmonth==99
gen wifeexpweek=$wifeexpweek
replace wifeexpweek=. if wifeexpweek==98 | wifeexpweek==99
gen wifeexp=wifeexpweek+wifeexpmonth*4.345+wifeexpyear*52.143
drop wifeexpyear wifeexpmonth wifeexpweek


order ID wifeworkstatus secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours lnwifehours husbandweeklyworkhours lnhusbandhours ///
wifeweeklyhousehours marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc  wifefirmsize ///
wifeedu wifehealth  wifeage region wifelabourinctype wiferace wifeocc nowifedummy wifeunioncont /// 
familywealth secondfamilywealth wifeexp ///
lnhusbandweeklylabourincome 

drop wifeocccode
drop ER*

foreach var of varlist ID-lnhusbandweeklylabourincome {
rename `var' `var'2013
}

save year2013.dta, replace














*********************************
*********************************
********* year 2015 *************
*********************************
*********************************
use fam2015.dta, clear


***********************************
****** global variables************
***********************************
global couple ER60425
global ID ER60002
global wifeemploy ER60426
global wifeage ER60019
global num_chi ER60021
global husbandannuallabourincome ER65216
global marital ER65461 
global age_youn ER60022
global wifeedu ER65460 
global wifehealth ER63482
//global WIC 
//global WICeligible 
//global foodstamp 
global annualtransfers ER65314
global husbandSSI ER65343
global wifeSSI ER65345
global mealtogether ER60693
global familywealth ER65406
global secondfamilywealth ER65408
global region ER65451 
global wiferace ER64671

global wifeannuallabourincome ER65244
global wifewageandsalary ER65228
global wifeworkhours ER65173
global wifehousehours ER60689 

global wifejobtype ER60472 
global wifeocccode ER60457
global wifeunion ER60469 
global wifefirmsize ER60463

global husbandworkhours ER65152

global wifeempstatus ER60426

global wifeexpyear ER60491
global wifeexpmonth ER60492
global wifeexpweek ER60493


*******************************************************
******The following can be copied for other years *****
*******************************************************

***********************************
****** generate variables *********
***********************************
gen couple=$couple

gen ID=$ID

gen wifelfstatus=.
replace wifelfstatus=1 if $wifeemploy==1 | $wifeemploy==2 
replace wifelfstatus=0 if $wifeemploy==3 | $wifeemploy==4 | $wifeemploy==5 | $wifeemploy==6 | $wifeemploy==7
label var wifelfstatus "1: employed or temporarily laid off; 0: umemployed"

gen agedummy=($wifeage>=17 & $wifeage<=55)
label var agedummy "age of spouse is between 17 and 55"

gen wifeage=$wifeage
replace wifeage=. if wifeage==999 | wifeage==0

gen num_chi=$num_chi

gen husbandweeklylabourincome= $husbandannuallabourincome/52.143/1000
label var husbandweeklylabourincome "husband weekly labour income in 1000$"



//gen husbandweeklywage=ER71277/52.143/1000 //another wage measure for husbands, annual wage and salary
//gen husbandwagerate=ER71392 // the third wage measure for husbands

gen marital=$marital

gen age_youn=$age_youn

gen wifeedu=$wifeedu
replace wifeedu=. if wifeedu==99

gen wifehealth=$wifehealth
replace wifehealth=. if wifehealth==8 | wifehealth==9

gen lnhusbandweeklylabourincome=ln(husbandweeklylabourincome)


//gen WIC=.
//replace WIC=1 if $WIC==1
//replace WIC=0 if $WIC==5

//gen WICeligible=($WICeligible==1)

//gen foodstamp=.
//replace foodstamp=1 if $foodstamp==1
//replace foodstamp=0 if $foodstamp==5

gen weeklyfamilytransfer=$annualtransfers/52.143/1000
label var weeklyfamilytransfer "weekly transfer income in $1000"

gen weeklyfamilySSinc=($husbandSSI+ $wifeSSI)/52.143/1000
label var weeklyfamilySSinc "weekly social security income in $1000"

gen mealtogether=$mealtogether
replace mealtogether=. if mealtogether==8 | mealtogether==9

gen familywealth= $familywealth/1000000
gen secondfamilywealth=$secondfamilywealth/1000000

gen region=$region

gen regiondummy=(region==1 | region==2 | region==3 | region==4)

gen wifeweeklylabourincome=$wifeannuallabourincome/52.143/1000
label var wifeweeklylabourincome "wife weekly labour income in 1000$"
gen lnwifewage=ln(wifeweeklylabourincome)

//gen wifewageandsalary=$wifewageandsalary/52.143/1000
//label var wifewageandsalary "wife weekly wage and salary in 1000$"
gen wifeweeklyworkhours=$wifeworkhours
gen lnwifehours=ln(wifeweeklyworkhours)


gen wifeweeklyhousehours=$wifehousehours
replace wifeweeklyhousehours=. if wifeweeklyhousehours==998 | wifeweeklyhousehours==999



//gen wiferace=$wiferace
//replace wiferace=. if wiferace==9

gen wifelabourinctype=.
replace wifelabourinctype=1 if $wifejobtype==1 | $wifejobtype==2
replace wifelabourinctype=2 if $wifejobtype==3 | $wifejobtype==4 | $wifejobtype==6
replace wifelabourinctype=3 if $wifejobtype==7 | $wifejobtype==8 | $wifejobtype==9 | $wifejobtype==0

gen wiferace=4
replace wiferace=1 if $wiferace==1
replace wiferace=2 if $wiferace==2
replace wiferace=3 if $wiferace==4
label var wiferace "1: white; 2: black; 3: asian; 4: other"

gen wifeocccode=$wifeocccode
gen wifeocc=.
replace wifeocc=11 if wifeocccode>=1 & wifeocccode<=43
replace wifeocc=13 if wifeocccode>=50 & wifeocccode<=95
replace wifeocc=15 if wifeocccode>=100 & wifeocccode<=124
replace wifeocc=17 if wifeocccode>=130 & wifeocccode<=156
replace wifeocc=19 if wifeocccode>=160 & wifeocccode<=196
replace wifeocc=21 if wifeocccode>=200 & wifeocccode<=206
replace wifeocc=23 if wifeocccode>=210 & wifeocccode<=215
replace wifeocc=25 if wifeocccode>=220 & wifeocccode<=255
replace wifeocc=27 if wifeocccode>=260 & wifeocccode<=296
replace wifeocc=29 if wifeocccode>=300 & wifeocccode<=354
replace wifeocc=31 if wifeocccode>=360 & wifeocccode<=365
replace wifeocc=33 if wifeocccode>=370 & wifeocccode<=395
replace wifeocc=35 if wifeocccode>=400 & wifeocccode<=416
replace wifeocc=37 if wifeocccode>=420 & wifeocccode<=425
replace wifeocc=39 if wifeocccode>=430 & wifeocccode<=465
replace wifeocc=41 if wifeocccode>=470 & wifeocccode<=496
replace wifeocc=43 if wifeocccode>=500 & wifeocccode<=593
replace wifeocc=45 if wifeocccode>=600 & wifeocccode<=613
replace wifeocc=47 if wifeocccode>=620 & wifeocccode<=676
replace wifeocc=49 if wifeocccode>=700 & wifeocccode<=762
replace wifeocc=51 if wifeocccode>=770 & wifeocccode<=896
replace wifeocc=53 if wifeocccode>=900 & wifeocccode<=975

gen nowifedummy=($wifeage==0)
gen wifeunioncont=.
replace wifeunioncont=1 if $wifeunion==1
replace wifeunioncont=0 if $wifeunion==5

gen wifefirmsize=$wifefirmsize
replace wifefirmsize=. if wifefirmsize==999999998 | wifefirmsize==999999999

gen husbandweeklyworkhours=$husbandworkhours
gen lnhusbandhours=ln(husbandweeklyworkhours)

gen wifeworkstatus=.
replace wifeworkstatus=1 if $wifeempstatus==1 | $wifeempstatus==2
replace wifeworkstatus=0 if $wifeempstatus==3 | $wifeempstatus==4 | $wifeempstatus==5 | $wifeempstatus==6 | $wifeempstatus==7

gen secondwifeworkstatus=.
replace secondwifeworkstatus=1 if wifeweeklyworkhours>0 & couple==1
replace secondwifeworkstatus=0 if wifeweeklyworkhours==0 & couple==1

gen wifeexpyear=$wifeexpyear
replace wifeexpyear=. if wifeexpyear==98 | wifeexpyear==99
gen wifeexpmonth=$wifeexpmonth
replace wifeexpmonth=. if wifeexpmonth==98 | wifeexpmonth==99
gen wifeexpweek=$wifeexpweek
replace wifeexpweek=. if wifeexpweek==98 | wifeexpweek==99
gen wifeexp=wifeexpweek+wifeexpmonth*4.345+wifeexpyear*52.143
drop wifeexpyear wifeexpmonth wifeexpweek


order ID wifeworkstatus secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours lnwifehours husbandweeklyworkhours lnhusbandhours ///
wifeweeklyhousehours marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc  wifefirmsize ///
wifeedu wifehealth  wifeage region wifelabourinctype wiferace wifeocc nowifedummy wifeunioncont /// 
familywealth secondfamilywealth wifeexp ///
lnhusbandweeklylabourincome 

drop wifeocccode
drop ER*

foreach var of varlist ID-lnhusbandweeklylabourincome {
rename `var' `var'2015
}

save year2015.dta, replace























******************************
**** Make a panel data set ***
******************************
******************************
**** merge 6 data sets *******
******************************

use cohort2005_ID.dta, clear
merge 1:1 ID2005 using year2005.dta
drop _merge

replace ID2007=. if ID2007==0
merge m:1 ID2007 using year2007.dta
drop if _merge==2
drop _merge

replace ID2009=. if ID2009==0
merge m:1 ID2009 using year2009.dta
drop if _merge==2
drop _merge

replace ID2011=. if ID2011==0
merge m:1 ID2011 using year2011.dta
drop if _merge==2
drop _merge

replace ID2013=. if ID2013==0
merge m:1 ID2013 using year2013.dta
drop if _merge==2
drop _merge

replace ID2015=. if ID2015==0
merge m:1 ID2015 using year2015.dta
drop if _merge==2
drop _merge

count if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=.

save cohort2005.dta, replace


*****************************
***** reshape long format ***
*****************************
// keep observaions that are between age 17 and age 55 in year 2005 and live in mainland (four regions) in the year 2005
keep if agedummy2005==1 & regiondummy2005==1
count if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=.


reshape long marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc nowifedummy wifeunioncont ///
wifeedu wifehealth  wifeage region wifeweeklylabourincome wifeweeklyworkhours wifeweeklyhousehours /// 
lnhusbandweeklylabourincome wifelabourinctype wiferace wifeocc wifefirmsize ///
familywealth secondfamilywealth lnwifewage lnwifehours husbandweeklyworkhours lnhusbandhours /// 
wifeworkstatus secondwifeworkstatus wifeexp, i(ID2005) j(year)

// generate initial agedummy and regiondummy
//bysort ID2005: gen agedummy2005=agedummy[1]
//bysort ID2005: gen regiondummy2005=regiondummy[1]
//not necessary 

//generate a reliable age variable
bysort ID2005: gen secondwifeage=wifeage[1]
bysort ID2005: gen yid=_n
replace secondwifeage=secondwifeage+(yid-1)*2
drop yid

replace wifeexp=wifeexp/52.143
label var wifeexp "wife's job experience in years"
replace wifefirmsize=wifefirmsize/1000000

gen secondhuslnwage=ln(husbandweeklylabourincome*1000)

save cohort2005_longformat.dta, replace




****************************
** Summary Statistics ******
****************************







*****************************
*** Attrition probability ***
*****************************
//count if secondwifeworkstatus!=. & year==2005
//count if secondwifeworkstatus!=. & year==2007
//count if secondwifeworkstatus!=. & year==2009
//count if secondwifeworkstatus!=. & year==2011
//count if secondwifeworkstatus!=. & year==2013
//count if secondwifeworkstatus!=. & year==2015

count if ID2005!=. & year==2005 //3618
count if ID2007!=. & year==2007 //3423
count if ID2009!=. & year==2009 //3279
count if ID2011!=. & year==2011 //3076
count if ID2013!=. & year==2013 //2886
count if ID2015!=. & year==2015 //2675

order ID2005 year ID2007 ID2009 ID2011 ID2013 ID2015 wifeworkstatus /// 
secondwifeworkstatus wifeweeklylabourincome lnwifewage wifeweeklyworkhours ///
lnwifehours husbandweeklyworkhours lnhusbandhours wifeweeklyhousehours marital ///
couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether ///
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc wifefirmsize wifeedu ///
wifehealth wifeage region wifelabourinctype wiferace wifeocc nowifedummy ///
wifeunioncont familywealth secondfamilywealth lnhusbandweeklylabourincome secondwifeage wifeexp

//average within individual over time
foreach var of varlist wifeworkstatus-secondwifeage {
bysort ID2005: egen m_`var'=mean(`var')
}


bysort ID2005: gen stay=1
bysort ID2005: replace stay=0 if (ID2007==. | ID2009==. | ID2011==. | ID2013==. | ID2015==.)

reg stay   m_wifeweeklyworkhours ///
m_wifeweeklylabourincome  m_wifeedu ///
  m_weeklyfamilytransfer m_secondfamilywealth m_secondwifeage m_weeklyfamilySSinc if year==2005

 gen stayhat=_b[_cons]+_b[m_wifeweeklyworkhours]*wifeweeklyworkhours+_b[m_wifeweeklylabourincome]*wifeweeklylabourincome ///
+_b[m_wifeedu]*wifeedu+_b[m_weeklyfamilytransfer]*weeklyfamilytransfer ///
+_b[m_secondfamilywealth]*secondfamilywealth+_b[m_secondwifeage]*secondwifeage+_b[m_weeklyfamilySSinc]*weeklyfamilySSinc




**************************************************************
**************************************************************
***** 2. panel analysis: working probability *****************
**************************************************************
**************************************************************
xtset ID2005 year
set showbaselevels on
****************************************************************
**** summary statistics and dynamics ***********
****************************************************************


//the table of statistics is from:
xtsum lnwifewage lnwifehours lnwifewagenew secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc familywealth secondfamilywealth /// 
wifeedu wifehealth wifeage secondwifeage wiferace region wifeweeklyhousehours ///
wifelabourinctype lnwifewage lnwifehours wifeweeklylabourincome wifeweeklyworkhours ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20



 // the pooled OLS models
reg secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, vce(robust)

predict workprob2 if e(sample), xb

logit secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, vce(robust)
predict workprob3 if e(sample)

reg secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc familywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50 


xtreg secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, re vce(robust)

xtreg secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
 i.wifehealth wifeage wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, fe vce(robust)

predict workprob if e(sample), xb 











xtlogit secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
 i.wifehealth wifeage wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, fe 

xtlogit secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
 i.wifehealth wifeage wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, vce(robust)
 
 
 
 
bysort ID2005: gen agedummy2005_25_55=(wifeage[1]>=25 & wifeage[1]<=55) //another age range, not necessary




xttab wifelfstatus 
xttrans wifelfstatus 

xttab region 







**************************************************************
**************************************************************
*** 3. panel analysis: hours-wage elasticities ***************
**************************************************************
**************************************************************

**************************
** summary statistics ****
**************************

order ID2005 lnwifewage lnwifehours wifeweeklylabourincome wifeweeklyworkhours wifeweeklyhousehours

xtsum wifeweeklyworkhours lnwifehours  wifeweeklylabourincome lnwifewage ///
if wifelfstatus==1 & wifeweeklyworkhours>0 & wifeweeklylabourincome>0

//average over time
bysort ID2005: egen m_lnwifehours=mean(lnwifehours)
bysort ID2005: egen m_lnwifewage=mean(lnwifewage)


//average among individuals
capture drop mm_lnwifehours mm_lnwifewage 
capture drop mm_wifehours mm_wifewage
bysort year: egen mm_lnwifehours=mean(lnwifehours) if wifelfstatus==1
bysort year: egen mm_lnwifewage=mean(lnwifewage) if wifelfstatus==1
bysort year: egen mm_wifehours=mean(wifeweeklyworkhours) if wifelfstatus==1
bysort year: egen mm_wifewage=mean(wifeweeklylabourincome) if wifelfstatus==1


//mean, standard deviation and correlation coefficient by year
tabstat lnwifewage if wifelfstatus==1, statistics(N mean sd min p25 p50 p75 max) by(year)
tabstat lnwifehours if wifelfstatus==1, statistics(N mean sd min p25 p50 p75 max) by(year)
tabstat wifeweeklyworkhours if wifelfstatus==1 & wifeweeklyworkhours>0, statistics(N mean sd min p25 p50 p75 max) by(year)

capture drop agedummy2005_20_40
bysort ID2005: gen agedummy2005_20_40=(wifeage[1]>=20 & wifeage[1]<=40)
tabstat wifeweeklyworkhours if wifelfstatus==1 & wifeweeklyworkhours>0 & agedummy2005_20_40==1, statistics(N mean sd min p25 p50 p75 max) by(year)

reg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace wifeweeklyhousehours i.region i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace wifeweeklyhousehours i.region i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
i.wifehealth wifeage wifeweeklyhousehours  i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome  num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours  i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year workprob ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

reg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year workprob2 stayhat  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, vce(robust)

reg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours i.year  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, vce(robust)

xtreg lnwifehours lnwifewage i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year workprob2 stayhat ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtivreg lnwifehours (lnwifewage=wifeexp i.wifeocc wifefirmsize i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours  i.year workprob2 stayhat ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust) first

xtivreg lnwifehours (lnwifewage=wifeexp  wifefirmsize i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
wifehealth wifeage wifeweeklyhousehours wifeedu i.region i.year  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust) first

xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu  i.year workprob3 weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust) first

xtreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
wifehealth wifeage wifeweeklyhousehours  i.year workprob2 stayhat ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust) 




xtreg lnwifehours lnwifewage husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace wifeweeklyhousehours i.region i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth /// 
 i.wifehealth wifeage wifeweeklyhousehours  i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage husbandweeklylabourincome mealtogether num_chi age_youn /// 
 i.wifehealth wifeage wifeweeklyhousehours  i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

xtreg lnwifehours lnwifewage husbandweeklylabourincome  num_chi age_youn /// 
 i.wifehealth wifeage wifeweeklyhousehours  i.year ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust)

****************************
*** models and inference ***
****************************
// pooled OLS
reg lnwifehours lnwifewage if wifelfstatus==1, vce(robust)

reg lnwifehours lnwifewage

//FE and RE 
xtreg lnwifehours lnwifewage if wifelfstatus==1, vce(robust)
xtreg lnwifehours lnwifewage if wifelfstatus==1, vce(robust) fe
xtreg lnwifehours lnwifewage if wifelfstatus==1,  be
xtreg lnwifehours lnwifewage if wifelfstatus==1,  fe
xtreg lnwifehours lnwifewage if wifelfstatus==1,  re







xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu  i.year workprob3  weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50, fe vce(robust) first

gen sampledummy=e(sample)

xtreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu  i.year workprob3  weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50 & sampledummy==1, fe vce(robust) 

reg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu  i.year workprob3  secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50 & sampledummy==1, vce(robust) 

reg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu i.year  weeklyfamilytransfer weeklyfamilySSinc secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<50 & sampledummy==1, vce(robust) 




********************************************************************************
******************************
***  For the paper ***********
******************************

// use for paper
xtset ID2005 year
set showbaselevels on
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   age_youn  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, fe vce(robust) first //.2131

gen sampledummy=e(sample)

xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   age_youn  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1,  vce(robust) first // .1888


// pooled OLS
reg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu   i.year weeklyfamilytransfer   secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, vce(robust) //  .2749

//selection equation
logit secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)

predict workprob3 if e(sample), pr

//pooled OLS with sample selection variable

reg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu   i.year weeklyfamilytransfer   secondfamilywealth workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, vce(robust)  //  .2749

//panel fixed effects
xtreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu   i.year weeklyfamilytransfer   secondfamilywealth workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust) //.2684

//panel random effects
xtreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu   i.year weeklyfamilytransfer   secondfamilywealth workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1,  vce(robust) //.2734

//Hausman test
xtreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu   i.year weeklyfamilytransfer   secondfamilywealth workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe 

estimates store fe

xtreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours wifeedu   i.year weeklyfamilytransfer   secondfamilywealth workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, re

estimates store re

hausman fe re, sigmamore

//panel fixed effects 2SLS
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust) first // .2114

//panel random effects 2SLS
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, vce(robust) first // .1882

//add interaction terms 
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont)  i.wifelabourinctype c.mealtogether##c.husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust) first 

margins, dydx( husbandweeklylabourincome ) at(mealtogether =(0(1)7))
marginsplot, noci 


capture gen secondhuslnwage=ln(husbandweeklylabourincome*1000)
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont)  i.wifelabourinctype c.mealtogether##c.secondhuslnwage num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust) first 
margins, dydx( secondhuslnwage) at(mealtogether =(0(1)7))
marginsplot, noci title("The Cross Hours-Wage Elasticities by Couple Relation", size(medium)) xtitle("Couple Relation Measure") ///
xlabel(,angle(0)) ytitle("Cross Hours-Wage Elasticity") 
graph export "/Users/bobwen/Desktop/paper_graph/cross_by_couple.png", replace



//add quadratic term of lnwifewage

// panel fe 2sls
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust) first // .2114
//equivalent
xtreg lnwifewage wifeexp i.wifeunioncont mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust)
predict lnwifewagehat if e(sample)
xtreg lnwifehours lnwifewagehat mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust)

//add quadratic term of lnwifewagehat
xtreg lnwifehours c.lnwifewagehat##c.lnwifewagehat mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust)

margins, dydx(lnwifewagehat) at(lnwifewagehat=(-2(0.5)1))
marginsplot, level(90)  title("The Wife's Hours-Wage Elasticity by own Wage with 90% CIs") xtitle("ln(wife_wage)") ///
ytitle("Hours-wage elasticity")  yline(0)
graph export "/Users/bobwen/Desktop/paper_graph/hours_wage_by_wage.png", replace

//use another measure of lnwifewage in $ instead of $1000
gen secondlnwifewage=ln(wifeweeklylabourincome*1000)
xtreg secondlnwifewage wifeexp i.wifeunioncont mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust)
predict secondlnwifewagehat if e(sample)
xtreg lnwifehours c.secondlnwifewagehat##c.secondlnwifewagehat mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, fe vce(robust)
margins, dydx(secondlnwifewagehat) at(secondlnwifewagehat=(5(0.5)7.5))
marginsplot, level(90)  title("The Wife's Hours-Wage Elasticity by own Wage with 90% CIs") xtitle("ln(wife_wage)") ///
ytitle("Hours-wage elasticity")  yline(0)
graph export "/Users/bobwen/Desktop/paper_graph/second_hours_wage_by_wage.png", replace


*******************************************
******* Boundary labour supply model ******
*******************************************



//pooled LPM
reg secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)


margins, at(husbandweeklylabourincome=(0(5)20))
marginsplot, xtitle(Husband's weekly labour income($1000/week)) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Husband's Wages, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_hus.png", replace

margins, dydx(husbandweeklylabourincome) at(husbandweeklylabourincome=(0(5)20))
marginsplot, xtitle(Husband's weekly labour income($1000/week)) ytitle(Average Partial Effects) ///
title(The Average Partial Effects of Husband's Wages on Probability of Working, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/APE_hus.png", replace

//use ln(husbandwage)
logit secondwifeworkstatus secondhuslnwage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<50, vce(robust)

margins, at(secondhuslnwage=(-4(2)10))
marginsplot, xtitle(ln(husband's wage)) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Husband's Wages, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_hus.png", replace

margins, dydx(secondhuslnwage) at(secondhuslnwage=(-4(2)10))
marginsplot, xtitle(ln(husband's wage)) ytitle(Average Partial Effects) ///
title(The Average Partial Effects of ln(husband's wage) on Wife's Probability of Working, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/APE_hus.png", replace


//panel logistic random effects
xtlogit secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<10, vce(robust)

margins, dydx(*)

margins, dydx(*) atmeans

margins, at(husbandweeklylabourincome=(0(2)10))
marginsplot, xtitle(Husband's weekly labour income($1000/week)) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Husband's Wages, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_hus.png", replace

//logit panel re
//use lnhuswage
xtlogit secondwifeworkstatus lnhuswage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)

margins, dydx(*)
margins, dydx(*) atmeans

//logit panel fe
//use lnhuswage
xtlogit secondwifeworkstatus lnhuswage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage  wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20,  fe

margins, dydx(*)
margins, dydx(*) atmeans


//panel LPM re
xtreg secondwifeworkstatus lnhuswage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)

margins, dydx(*)
margins, dydx(*) atmeans

// pooled logistic
logit secondwifeworkstatus lnhuswage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)
margins, dydx(*)
margins, dydx(*) atmeans

// pooled LPM
reg secondwifeworkstatus lnhuswage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)
margins, dydx(*)
margins, dydx(*) atmeans


\\predicted working probability graphs
xtlogit secondwifeworkstatus lnhuswage mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth wifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)

margins, at(lnhuswage=(-4(2)10))
marginsplot, xtitle(ln(husband's wage)) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Husband's Wages, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_hus.png", replace

margins, at(mealtogether=(0(1)7)) 
marginsplot, xtitle(Couple Relation Measure) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Couple Relation, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_relation.png", replace

margins, at(num_chi=(0(2)10)) 
marginsplot, xtitle(Number of Children) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Number of Children, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_child.png", replace

margins, at(age_youn=(0(2)17)) 
marginsplot, xtitle(Age of Youngest Child) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Age of Youngest Child, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_age_chi.png", replace

margins, at(secondfamilywealth=(-1(5)30)) 
marginsplot, xtitle(Family Wealth($1000,000)) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Family Wealth, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_wealth.png", replace

margins, at(wifeweeklyhousehours=(0(10)110)) 
marginsplot, xtitle(Wife's Housework(Hours/week)) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Hours on Housework, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_housework.png", replace

margins, at(wifehealth=(1(1)5)) 
marginsplot, xtitle(Wife's Health Ranking) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Health, size(medium))  xlabel(1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor",angle(45)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_health.png", replace

margins, at(wifeedu=(0(1)17)) 
marginsplot, xtitle(Wife's Education Level) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Education, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_edu.png", replace

margins, at(wifeedu=(1(1)4)) 
marginsplot, xtitle(Wife's Race) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Race, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_race.png", replace

margins, at(region=(1(1)4)) 
marginsplot, xtitle(Region) ytitle(Predicted Probability of Working) ///
title(The Married Women's Predicted Probability of Working by Region, size(medium))  xlabel(,angle(0)) 
graph export "/Users/bobwen/Desktop/paper_graph/LFP_region.png", replace


********************************
**** Fulltime vs Parttime ******
********************************
//panel fixed effects 2SLS
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, fe vce(robust) first
estimates store xtiv

//the equivalent 2 stages
xtreg lnwifewage wifeexp i.wifeunioncont mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, fe vce(robust) 
capture predict lnwifewagehat if e(sample)

xtreg lnwifehours lnwifewagehat mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, fe vce(robust) 
estimates store equivalent

estimates table xtiv equivalent, star

// fulltime vs parttime
//<=30
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & wifeweeklyworkhours<=30 & wifeweeklyworkhours>0, fe vce(robust) 
//0.2615

//>=30, <48
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & wifeweeklyworkhours<48 & wifeweeklyworkhours>=30, fe vce(robust) 
// .0160

//>=48
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 &  wifeweeklyworkhours>=48, fe vce(robust) 
// -.0432

generate var93 = 1 in 1
replace var93 = 2 in 2
replace var93 = 3 in 3
generate var94 = 0.2615 in 1
replace var94 = .0160 in 2
replace var94 = -.0432 in 3
graph twoway (connect var94 var93, ytitle(Hours-wage elasticity) xtitle(Hours of work) ///
xlabel(1 "Part-time(<=30hrs)" 2 "Full-time(30-48hrs)" 3 "Over-time(>=48hrs)",angle(0)) yline(0) graphregion(margin(r+10))), ///
title("The Hours-Wage Elasticities of Different Groups")
graph export "/Users/bobwen/Desktop/paper_graph/fulltimevsparttime.png", replace


//quantile regression
tabstat wifeweeklyworkhours if secondwifeworkstatus==1 & husbandweeklylabourincome<20, s(p10 p25 p50 p75 p90 N) c(s)
tabstat lnwifehours if secondwifeworkstatus==1 & husbandweeklylabourincome<20, s(p10 p25 p50 p75 p90 N) c(s)
sum wifeweeklyworkhours if secondwifeworkstatus==1 & husbandweeklylabourincome<20,d

//whole sample
sqreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , quantiles( 0.1 0.25 0.5 0.75 0.9)

// only hourly paid
sqreg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & wifelabourinctype==2, quantiles( 0.1 0.25 0.5 0.75 0.9)

**********************************
*** the gender wage inequality ***
**********************************

use cohort2005.dta, clear
keep if agedummy2005==1 & regiondummy2005==1
reshape long marital couple agedummy regiondummy wifelfstatus husbandweeklylabourincome mealtogether /// 
num_chi age_youn weeklyfamilytransfer weeklyfamilySSinc nowifedummy wifeunioncont ///
wifeedu wifehealth  wifeage region wifeweeklylabourincome wifeweeklyworkhours wifeweeklyhousehours /// 
lnhusbandweeklylabourincome wifelabourinctype wiferace wifeocc wifefirmsize ///
familywealth secondfamilywealth lnwifewage lnwifehours husbandweeklyworkhours lnhusbandhours /// 
wifeworkstatus secondwifeworkstatus wifeexp, i(ID2005) j(year)

bysort ID2005: gen secondwifeage=wifeage[1]
bysort ID2005: gen yid=_n
replace secondwifeage=secondwifeage+(yid-1)*2
drop yid wifeage

replace wifeexp=wifeexp/52.143
replace wifefirmsize=wifefirmsize/1000000

save cohort2005_longformat_inequality.dta, replace


//Pooled OLS without sample selection corection


gen wagegap=wifeweeklylabourincome/husbandweeklylabourincome
gen lnwagegap=ln(wagegap)

sum wagegap lnwagegap if secondwifeworkstatus==1 & husbandweeklylabourincome<20
reg lnwifehours lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, vce(robust)
//0.2148***

//pooled OLS with sample selection correction
gen thirdworkstatus=.
replace thirdworkstatus=1 if (husbandweeklylabourincome>0 & wifeweeklylabourincome>0)
replace thirdworkstatus=0 if (husbandweeklylabourincome==0 | wifeweeklylabourincome==0)

reg thirdworkstatus husbandweeklylabourincome wifeweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth secondwifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if couple==1 & husbandweeklylabourincome<50, vce(robust)
predict workpro4 if e(sample)
sum workpro4 if e(sample)

reg lnwifehours lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, vce(robust)
// 0.2008***

//panel random effects

xtset ID2005 year
set showbaselevels on

xtreg lnwifehours lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust)
// 0.1841***

//panel fixed effects
xtreg lnwifehours lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust) fe
// 0.1738***


//panel random effects 2SLS
xtivreg lnwifehours (lnwagegap=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust) 
// 0.1257**

//panel fixed effects 2SLS
xtivreg lnwifehours (lnwagegap=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust) fe
//0.1329(p=0.077)

sum wagegap lnwagegap if e(sample)



*************************************************************
** the gender wage inequality and relative hours of work ****
*************************************************************
gen  hoursgap=wifeweeklyworkhours/husbandweeklyworkhours
gen lnhoursgap=ln(hoursgap)


//pooled OLS
reg lnhoursgap lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year  ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, vce(robust)
//0.2911***

//pooled OLS with sample selection correction
gen thirdworkstatus=.
replace thirdworkstatus=1 if (husbandweeklylabourincome>0 & wifeweeklylabourincome>0)
replace thirdworkstatus=0 if (husbandweeklylabourincome==0 | wifeweeklylabourincome==0)
gen fourthworkstatus=.
replace fourthworkstatus=1 if (wifeweeklyworkhours>0 & husbandweeklyworkhours>0)
replace fourthworkstatus=0 if (wifeweeklyworkhours==0 | husbandweeklyworkhours==0)


reg thirdworkstatus husbandweeklylabourincome wifeweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth secondwifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if couple==1 & husbandweeklylabourincome<20, vce(robust)
predict workpro4 if e(sample)
sum workpro4 if e(sample)

reg fourthworkstatus husbandweeklylabourincome wifeweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer secondfamilywealth /// 
wifeedu i.wifehealth secondwifeage i.wiferace i.region wifeweeklyhousehours i.year ///
if couple==1 & husbandweeklylabourincome<50, vce(robust)
predict workpro5 if e(sample)
sum workpro5 if e(sample)


reg lnhoursgap lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, vce(robust)
// 0.2946***
reg lnhoursgap lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro5 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20, vce(robust)


//panel random effects

xtset ID2005 year
set showbaselevels on

xtreg lnhoursgap lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust)
// 0.2773***

//panel fixed effects
xtreg lnhoursgap lnwagegap mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust) fe
// 0.2584***


//panel random effects 2SLS
xtivreg lnhoursgap (lnwagegap=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust)  first
// 0.2147***

//panel fixed effects 2SLS
xtivreg lnhoursgap (lnwagegap=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth secondwifeage wifeweeklyhousehours weeklyfamilytransfer secondfamilywealth wifeedu i.region i.wiferace i.year workpro4 ///
if husbandweeklylabourincome<20, vce(robust) fe first
//0.2726***

sum wagegap lnwagegap hoursgap lnhoursgap if e(sample)



*********************
*** Dynamic model ***
*********************
use "cohort2005_longformat.dta", clear
tsset ID2005 year

//pooled OLS 
reg lnwifehours lnwifewage mealtogether husbandweeklylabourincome num_chi age_youn ///
wifehealth wifeage wifeweeklyhousehours wifeedu weeklyfamilytransfer secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) 


reg lnwifehours lnwifewage mealtogether secondhuslnwage num_chi age_youn ///
wifehealth wifeage wifeweeklyhousehours wifeedu weeklyfamilytransfer secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) 

//panel FD 2sls
bysort ID2005: gen time=_n
order ID2005 time
tsset ID2005 time



reg D.lnwifehours DL.lnwifehours D.lnwifewage D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) //specification 1

ivregress 2sls D.lnwifehours (DL.lnwifehours=L2.lnwifehours) D.lnwifewage D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) first

ivregress 2sls D.lnwifehours (DL.lnwifehours D.lnwifewage=L2.lnwifehours D.wifeexp D.wifeunioncont)  D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) first // specification 2

ivregress 2sls D.lnwifehours (DL.lnwifehours D.lnwifewage=L2D.lnwifehours D.wifeexp D.wifeunioncont)  D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) first //specification 3

//use all lags as IV
set showbaselevels off
xtabond lnwifehours lnwifewage mealtogether secondhuslnwage num_chi age_youn wifehealth wifeage wifeweeklyhousehours ///
wifeedu weeklyfamilytransfer secondfamilywealth if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , ///
vce(robust) endogenous(lnwifewage, lag(1,.))

//equivalently
xtdpd lnwifehours L.lnwifehours lnwifewage mealtogether secondhuslnwage num_chi age_youn wifehealth wifeage wifeweeklyhousehours ///
wifeedu weeklyfamilytransfer secondfamilywealth if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , ///
dgmmiv(lnwifehours) div(lnwifewage mealtogether secondhuslnwage num_chi age_youn wifehealth wifeage wifeweeklyhousehours ///
wifeedu weeklyfamilytransfer secondfamilywealth) vce(robust)









//delete obs to make a data set smaller
order ID2005 year lnwifehours lnwifewage mealtogether secondhuslnwage num_chi age_youn ///
wifehealth wifeage wifeweeklyhousehours wifeedu weeklyfamilytransfer secondfamilywealth


drop if lnwifehours==.
bysort ID2005: keep if _N==6
reg D.lnwifehours D.lnwifewage // no obs?
bysort ID2005: gen time=_n
order ID2005 time
tsset ID2005 time
reg D.lnwifehours D.lnwifewage D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) 

reg D.lnwifehours DL.lnwifehours D.lnwifewage D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) 

ivregress 2sls D.lnwifehours (DL.lnwifehours=L2.lnwifehours) D.lnwifewage D.mealtogether D.secondhuslnwage D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.wifeedu D.weeklyfamilytransfer D.secondfamilywealth ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 , vce(robust) 






ivregress 2sls D.lnwifehours D.lnwifewage D.mealtogether  D.husbandweeklylabourincome D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.weeklyfamilytransfer D.secondfamilywealth D.wifeedu D.workprob3 ///
(DL.lnwifehours=L2.lnwifehours) if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, vce(robust)



//panel data FD 2sls
ivregress 2sls D.lnwifehours D.lnwifewage D.mealtogether  D.husbandweeklylabourincome D.num_chi D.age_youn ///
D.wifehealth D.wifeage D.wifeweeklyhousehours D.weeklyfamilytransfer D.secondfamilywealth D.wifeedu D.workprob3 ///
(DL.lnwifehours=L2.lnwifehours) if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, vce(robust)

//panel random effects 2SLS
xtivreg lnwifehours (lnwifewage=wifeexp i.wifeunioncont) mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
i.wifehealth wifeage wifeweeklyhousehours weeklyfamilytransfer   secondfamilywealth wifeedu i.year   workprob3 ///
if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & sampledummy==1, vce(robust) first // .1882

************************************************
***For the poster for 2019 Stata conference ****
************************************************

//Motivation: two graphs
//1. the time series of wife's wage rates and hours of work using CPS ORG
cd "/Users/bobwen/Desktop/CPS"
use "cps_wide.dta", clear
order cpsid year month wifecpsidp huscpsidp wifeuhrsworkorg wifehourwage
sort cpsid year month
gen agedummy=(wifeage>=17 & wifeage<=65)
order year month
sort year month

replace wifehourwage=. if wifehourwage==999.99
replace wifeuhrsworkorg=. if wifeuhrsworkorg==999 | wifeuhrsworkorg==998

keep if agedummy==1
bysort year month: egen m_wifehourwage=mean(wifehourwage)
bysort year month: egen m_wifeuhrsworkorg=mean(wifeuhrsworkorg)

// generate time
capture gen mydate=.
local k 1
forvalues i=2005(1)2015 {
forvalues j=1(1)12 {
replace mydate = monthly("`i'm`j'","YM") in `k'
local k=`k'+1
}
}

//generage m_wage
capture gen m_wage=.
local k 0
forvalues i=2005(1)2015 {
forvalues j=1(1)12 {
quietly sum wifehourwage if year==`i' & month==`j'
replace m_wage=r(mean) if _n==`k'+`j'
}
local k=`k'+12
}
//generate m_hours
capture gen m_hours=.
local k 0
forvalues i=2005(1)2015 {
forvalues j=1(1)12 {
quietly sum wifeuhrsworkorg if year==`i' & month==`j'
replace m_hours=r(mean) if _n==`k'+`j'
}
local k=`k'+12
}

graph twoway (line m_wage mydate if _n<=132, ylabel(,labsize(m)) xlabel(540(12)671,format(%tm) angle(45) labsize(small)) ///
 ytitle("Average hourly wage($)",size(m)) xtitle("Time") yaxis(1)  yscale(titlegap(*15))) (line m_hours mydate if _n<=132, ///
  ytitle("Average work hours",size(m) axis(2)) yaxis(2)  lpattern(dash)), ///
  title("The Trends of Average Hourly Wage and Hours of Work for Married Women", size(m)) /// 
  legend(label(1 "Average hourly wage") label(2 "Average weekly work hours"))
graph export "/Users/bobwen/Desktop/paper_graph/trends_of_wage_and_hours.png", replace

// if for those wifeuhrsworkorg>=32, fulltime
//generage m2_wage
capture gen m2_wage=.
local k 0
forvalues i=2005(1)2015 {
forvalues j=1(1)12 {
quietly sum wifehourwage if year==`i' & month==`j' & wifeuhrsworkorg>=32
replace m2_wage=r(mean) if _n==`k'+`j'
}
local k=`k'+12
}
//generate m2_hours
capture gen m2_hours=.
local k 0
forvalues i=2005(1)2015 {
forvalues j=1(1)12 {
quietly sum wifeuhrsworkorg if year==`i' & month==`j' & wifeuhrsworkorg>=32
replace m2_hours=r(mean) if _n==`k'+`j'
}
local k=`k'+12
}

graph twoway (line m2_wage mydate if _n<=132, ylabel(,labsize(m)) xlabel(540(12)671,format(%tm) angle(45) labsize(small)) ///
 ytitle("Average hourly wage($)",size(m)) xtitle("Time") yaxis(1)  yscale(titlegap(*15))) (line m2_hours mydate if _n<=132, ///
  ytitle("Average work hours",size(m) axis(2)) yaxis(2)  lpattern(dash)), ///
  title("The Trends of Average Hourly Wage and Hours of Work for Married Women", size(m)) /// 
  legend(label(1 "Average hourly wage") label(2 "Average weekly work hours"))
graph export "/Users/bobwen/Desktop/paper_graph/trends_of_fulltime_wage_and_hours.png", replace



//2. the scatter plots of cross-sectional data of the wife's wage rates and hours of work

cd "/Users/bobwen/Desktop/PSID_1975_2017/Cohort2005"
use "cohort2005_longformat.dta", clear
xtset ID2005 year
set showbaselevels on
gen lnwifewagenew=ln(wifeweeklylabourincome*1000)

graph twoway (scatter lnwifewagenew lnwifehours if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & year==2011, msize(tiny) title("The Scatterplots of Ln(wage) and Ln(hours)") legend(off) xtitle("ln(hours)") ytitle("ln(wage)")) ///
(lfit lnwifewagenew lnwifehours if secondwifeworkstatus==1 & husbandweeklylabourincome<20 & year==2011, lwidth(thick) lcolor(black)) ///
(function y=3*x, range(0.3 3) lcolor(blue)) ///
(function y=-4+3*x, range(1.5 4) lcolor(blue)) ///
(function y=-x+3.8, range(0.5 2.5) lcolor(green)) ///
(function y=-x+9.1, range(2 4.5) lcolor(green)) ///
(pcarrowi 1 0.7 1 1.5, lwidth(medthick) lcolor(blue) text(0.5 1 "supply")) ///
(pcarrowi 2 3 2 4, lwidth(medthick) lcolor(green) text(1.5 3.5 "demand")) ///
(,text(0.5 3.5 "The actual labour supply curve could be steeper than the fitted line. ", size(small))) ///
(,text(8 4.8 "fitted line"))
graph export "/Users/bobwen/Desktop/paper_graph/simultaneity.png", replace


graph twoway  (lfit lnwifelabourincome05 lnwifehours05  if sample4==1) ///
(function y=3*x, range(0.5 3)) ///
(function y=-4+3*x, range(2 4.5) legend(off)) /// 
(function y=-x+5.3, range(0.5 2.5)) ///
(function y=-x+9.3, range(2 4.5)) ///
(scatter lnwifelabourincome05 lnwifehours05  if sample4==1, msize(tiny) title("plots of ln(hours) and ln(labour_income)") ytitle("ln(labour_income)") xtitle("ln(hours)")) ///
(pcarrowi 1 1 1 2, lwidth(medthick) lcolor(black) text(0.5 1 "supply")) ///
(pcarrowi 3 3 3 4, lwidth(medthick) lcolor(black) text(2 3.5 "demand")) ///
(,text(7 4.8 "els=0.35")) (,text(9.5 3 "els=0.2")) (,text(0.5 4 "A simple OLS is not appropriate.", size(small)))


xtsum lnwifewage lnwifehours lnwifewagenew secondwifeworkstatus husbandweeklylabourincome mealtogether num_chi age_youn ///
weeklyfamilytransfer weeklyfamilySSinc familywealth secondfamilywealth /// 
wifeedu wifehealth wifeage secondwifeage wiferace region wifeweeklyhousehours ///
wifelabourinctype lnwifewage lnwifehours wifeweeklylabourincome wifeweeklyworkhours ///
if secondwifeworkstatus!=. & husbandweeklylabourincome<20 & sampledummy==1


// missing values and sample attrition
//for hours of work sample
mdesc ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp workprob3 secondwifeage if lnwifewage!=. & lnwifehours!=. & husbandweeklylabourincome<20
//for whole sample
mdesc ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 secondwifeworkstatus wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp secondwifeage if secondwifeworkstatus!=. & husbandweeklylabourincome<20

mdesc ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 secondwifeworkstatus wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp secondwifeage if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20

mdesc ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 secondwifeworkstatus wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp secondwifeage if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & couple==1 & husbandweeklylabourincome<20

mdesc ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 secondwifeworkstatus wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp secondwifeage if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & marital==1 & husbandweeklylabourincome<20


mi set mlong

mi misstable summarize ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 secondwifeworkstatus wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp secondwifeage if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20

mi misstable pattern ID2005 ID2007 ID2009 ID2011 ID2013 ID2015 wifeweeklylabourincome ///
lnwifewage wifeweeklyworkhours lnwifehours secondhuslnwage secondwifeage ///
husbandweeklyworkhours wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace wifeunioncont secondfamilywealth ///
wifeexp secondwifeage if secondwifeworkstatus!=. & husbandweeklylabourincome<20

mi misstable pattern ID2005 secondwifeworkstatus wifeweeklylabourincome ///
wifeweeklyworkhours  secondwifeage ///
 wifeweeklyhousehours husbandweeklylabourincome ///
mealtogether num_chi age_youn weeklyfamilytransfer wifeedu wifehealth ///
region wifelabourinctype wiferace secondfamilywealth ///
  if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20

  
  
tab wifelabourinctype, gen(wifeinctypecat)

pwcorr mealtogether   wifehealth wifeweeklyhousehours  wifeedu wifeweeklylabourincome  wifeweeklyworkhours secondwifeage husbandweeklyworkhours ///
 husbandweeklylabourincome num_chi age_youn weeklyfamilytransfer region wifeinctypecat1 wifeinctypecat2 wiferace secondfamilywealth ///
   if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20

mi register imputed mealtogether wifehealth wifeweeklyhousehours wifeedu

mi register regular secondwifeworkstatus wifeweeklylabourincome ///
wifeweeklyworkhours  secondwifeage ///
 husbandweeklylabourincome ///
num_chi age_youn weeklyfamilytransfer ///
region wifeinctypecat1 wifeinctypecat2 wiferace secondfamilywealth 

mi impute regress mealtogether secondwifeworkstatus wifeweeklylabourincome ///
wifeweeklyworkhours  secondwifeage ///
 husbandweeklylabourincome ///
num_chi age_youn weeklyfamilytransfer ///
region wifeinctypecat1 wifeinctypecat2 wiferace secondfamilywealth ///
  if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20, ///
add(20) rseed(1234)  
 
 mi impute regress wifehealth secondwifeworkstatus wifeweeklylabourincome ///
wifeweeklyworkhours  secondwifeage ///
 husbandweeklylabourincome ///
num_chi age_youn weeklyfamilytransfer ///
region wifeinctypecat1 wifeinctypecat2 wiferace secondfamilywealth ///
  if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20, ///
add(20) rseed(1234)  

 mi impute regress wifeweeklyhousehours secondwifeworkstatus wifeweeklylabourincome ///
wifeweeklyworkhours  secondwifeage ///
 husbandweeklylabourincome ///
num_chi age_youn weeklyfamilytransfer ///
region wifeinctypecat1 wifeinctypecat2 wiferace secondfamilywealth ///
  if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20, ///
add(20) rseed(1234)  

 mi impute regress wifeedu secondwifeworkstatus wifeweeklylabourincome ///
wifeweeklyworkhours  secondwifeage ///
 husbandweeklylabourincome ///
num_chi age_youn weeklyfamilytransfer ///
region wifeinctypecat1 wifeinctypecat2 wiferace secondfamilywealth ///
  if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20, ///
add(20) rseed(1234)  

reg lnwifehours lnwifewage mealtogether i.wifelabourinctype husbandweeklylabourincome num_chi age_youn ///
wifehealth secondwifeage wifeweeklyhousehours wifeedu  i.year weeklyfamilytransfer  secondfamilywealth ///
  if ID2005!=. & ID2007!=. & ID2009!=. & ID2011!=. & ID2013!=. & ID2015!=. & secondwifeworkstatus!=. & husbandweeklylabourincome<20, vce(robust)

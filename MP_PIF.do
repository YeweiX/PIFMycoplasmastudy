*MP PIF program
*Demographic characteristics(table1 total)
table1, vars(caregiverage contn\ rel cat\ ethnicity cate\ regType cat\ marStatus cate\ heduc cat\ cjob cat\ inc cat\ localRes cat\ numKids cat\ childage contn\ childSex cat\)

*by group
table1, by(Group) vars(caregiverage contn\ rel cat\ ethnicity cate\ regType cat\ marStatus cate\ heduc cat\ cjob cat\ inc cat\ localRes cat\ numKids cat\ childage contn\ childSex cat\)  

*Clinical symptoms 
table1, vars(fever bin\ cough bin\ sorethroat bin\ headache bin\ nausea bin\ vomiting bin\ anorexia bin\ shortbreath bin\)

table1,by(Group) vars(fever bin\ cough bin\ sorethroat bin\ headache bin\ nausea bin\ vomiting bin\ anorexia bin\ shortbreath bin\)

*Effect size estimations
xtset Cluster

* Fit the GEE model and report risk ratios
xtgee childTestedMycoToday Group, family(binomial) link(log) eform

*proportion difference
xtgee childTestedMycoToday Group, family(binomial) link(identity)

*adjusted result-risk ratio
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(log) eform

*adjusted result-proportion difference
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(identity)

*subgroup analysis
* Subgroup analyses-caregiver education, income level
foreach var in heduc incc {
    di "Subgroup analysis for `var'"
    levelsof `var', local(levels)
    foreach l of local levels {
        di "Level: `l'"
        * Unadjusted Risk Ratio
        xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if `var' == `l'
        * Unadjusted Proportion Difference
        xtgee childTestedMycoToday Group, family(binomial) link(identity), if `var' == `l'
        * Adjusted Risk Ratio
        xtgee childTestedMycoToday Group ssite cough, family(binomial) link(log) eform, if `var' == `l'
        * Adjusted Proportion Difference
        xtgee childTestedMycoToday Group ssite cough, family(binomial) link(identity), if `var' == `l'
    }
}

* For childSex
*RR-0
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if childSex==0
xtgee childTestedMycoToday Group ssite, family(binomial) link(log) eform, if childSex==0
*PD-0
xtgee childTestedMycoToday Group, family(binomial) link(identity), if childSex==0
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(identity), if childSex==0
*RR-1
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if childSex==1
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(log) eform, if childSex==1
*PD-1
xtgee childTestedMycoToday Group, family(binomial) link(identity), if childSex==1
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(identity), if childSex==1

* For ssite
*RR-0
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if ssite==0
xtgee childTestedMycoToday Group cough, family(binomial) link(log) eform, if ssite==0
*PD-0
xtgee childTestedMycoToday Group, family(binomial) link(identity), if ssite==0
xtgee childTestedMycoToday Group cough, family(binomial) link(identity), if ssite==0
*RR-1
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if ssite==1
xtgee childTestedMycoToday Group cough, family(binomial) link(log) eform, if ssite==1
*PD-1
xtgee childTestedMycoToday Group, family(binomial) link(identity), if ssite==1
xtgee childTestedMycoToday Group cough, family(binomial) link(identity), if ssite==1

* For fever
*RR-0/ajdusted site
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if fever==0
xtgee childTestedMycoToday Group ssite, family(binomial) link(log) eform, if fever==0
*PD-0/ajdusted site
xtgee childTestedMycoToday Group, family(binomial) link(identity), if fever==0
xtgee childTestedMycoToday Group ssite, family(binomial) link(identity), if fever==0
*RR-1
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if fever==1
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(log) eform, if fever==1
*PD-1
xtgee childTestedMycoToday Group, family(binomial) link(identity), if fever==1
xtgee childTestedMycoToday Group ssite cough, family(binomial) link(identity), if fever==1

* For cough
*RR-0
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if cough==0
xtgee childTestedMycoToday Group ssite, family(binomial) link(log) eform, if cough==0
*PD-0
xtgee childTestedMycoToday Group, family(binomial) link(identity), if cough==0
xtgee childTestedMycoToday Group ssite, family(binomial) link(identity), if cough==0

*RR-1
xtgee childTestedMycoToday Group, family(binomial) link(log) eform, if cough==1
xtgee childTestedMycoToday Group ssite, family(binomial) link(log) eform, if cough==1
*PD-1
xtgee childTestedMycoToday Group, family(binomial) link(identity), if cough==1
xtgee childTestedMycoToday Group ssite, family(binomial) link(identity), if cough==1



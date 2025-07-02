*MP PIF program
*Demographic characteristics(table1 total)
table1, vars(caregiverage contn\ rel cat\ ethnicity cate\ regType cat\ marStatus cate\ educ cat\ cjob cat\ inc cat\ localRes cat\ numKids cat\ childage contn\ childSex cat\)

*by group
table1, by(Group) vars(caregiverage contn\ rel cat\ ethnicity cate\ regType cat\ marStatus cate\ educ cat\ cjob cat\ inc cat\ localRes cat\ numKids cat\ childage contn\ childSex cat\)  

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


*ICC
 icc  childTestedMycoToday Cluster
 
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



xtgee childTestedMycoToday i.Group##i.heduc, family(binomial) link(log) eform
xtgee childTestedMycoToday i.group_id##i.heduc, family(binomial) link(log) 
xtgee childTestedMycoToday i.group_id##i.heduc i.ssite i.cough, family(binomial) link(identity) eform
xtgee childTestedMycoToday i.group_id##i.heduc i.ssite i.cough, family(binomial) link(identity) 

xtgee childTestedMycoToday i.group_id##i.incc, family(binomial) link(log) eform
xtgee childTestedMycoToday i.group_id##i.incc, family(binomial) link(log) 
xtgee childTestedMycoToday i.group_id##i.incc i.ssite i.cough, family(binomial) link(identity) eform
xtgee childTestedMycoToday i.group_id##i.incc i.ssite i.cough, family(binomial) link(identity) 


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

xtgee childTestedMycoToday i.group_id##i.ssite, family(binomial) link(log) eform
xtgee childTestedMycoToday i.group_id##i.ssite, family(binomial) link(log) 
xtgee childTestedMycoToday i.group_id##i.ssite i.cough, family(binomial) link(identity) eform
xtgee childTestedMycoToday i.group_id##i.ssite i.cough, family(binomial) link(identity) 

xtgee childTestedMycoToday i.group_id##i.incc, family(binomial) link(log) eform
xtgee childTestedMycoToday i.group_id##i.incc, family(binomial) link(log) 
xtgee childTestedMycoToday i.group_id##i.incc i.ssite i.cough, family(binomial) link(identity) eform
xtgee childTestedMycoToday i.group_id##i.incc i.ssite i.cough, family(binomial) link(identity) 

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
·

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




***subgroup
*education
xtgee childTestedMycoToday i.Group##i.heduc i.ssite i.cough, family(binomial) link(log) eform robust
testparm i.Group#i.heduc
margins r.Group, at(heduc=(0 1)) post
margins, eform

*income
xtgee childTestedMycoToday i.Group##i.incc i.ssite i.cough, family(binomial) link(log) eform robust
testparm i.Group#i.incc
margins r.Group, at(incc=(0 1)) post
margins, eform

*site
xtgee childTestedMycoToday i.Group##i.ssite i.cough, family(binomial) link(log) eform robust
testparm i.Group#i.ssite
margins r.Group, at(ssite=(0 1)) post
margins, eform

*childSex
xtgee childTestedMycoToday i.Group##i.childSex i.cough, family(binomial) link(log) eform robust
testparm i.Group#i.childSex
margins r.Group, at(childSex=(0 1)) post
margins, eform

*fever
xtgee childTestedMycoToday i.Group##i.fever i.cough, family(binomial) link(log) eform robust
testparm i.Group#i.fever
margins r.Group, at(fever=(0 1)) post
margins, eform

*cough
xtgee childTestedMycoToday i.Group##i.cough, family(binomial) link(log) eform robust
testparm i.Group#i.cough
margins r.Group, at(cough=(0 1)) post
margins, eform

## Simulate data to use in the datacamp project
library(data.table)
setwd('/Users/ruddjm/Google Drive/datacamp/project_spec/')
set.seed(5)
# Simulate patient ids
n = 890
ids = formatC(sample(1:3000, size = n, replace = TRUE),
  	width = 4, flag = '0') 




## Simulate antibiotic data
antibiotic_types = c('amoxicillin', 'ciprofloxacin', 'doxycycline', 'penicillin')
antibiotic_set_up = data.table(
  id = ids,
  number_of_abx = rnbinom(n, 0.5, 0.08)
	)
samp_days = function(num_days){
  sample(1:19, prob = 19:1, size = num_days, replace = TRUE)}
antibioticDT = data.table(
  patient_id = antibiotic_set_up[ , rep(id, number_of_abx)],
  day_given = unlist(lapply(antibiotic_set_up$number_of_abx,
  	FUN = samp_days))
	)
invisible(antibioticDT[ , antibiotic_type := sample(antibiotic_types, 
  size = .N,
  replace = TRUE,
  prob = c(1, 2, 6, 2))])
setorder(antibioticDT, patient_id, day_given, antibiotic_type)
invisible(antibioticDT[ , route := sample(c('PO', 'IV'), 
  prob = c(1, 4), 
  size = .N, replace = TRUE)])
antibioticDT = unique(antibioticDT)





# Simulate blood culture data
blood_culture_set_up = data.table(
  patient_id = ids,
  number_of_cultures = sample(0:5, 
    size = n,
    prob = c(30, 6, 3, 2, 2, 1),
    replace = TRUE)
	)

blood_cultureDT = unique(data.table(
  patient_id = blood_culture_set_up[ , rep(patient_id, number_of_cultures)],
  blood_culture_day = unlist(lapply(blood_culture_set_up$number_of_cultures, 
	FUN = samp_days))
	))

setorder(blood_cultureDT, patient_id, blood_culture_day)
blood_cultureDT[1:20]


write.table(
  blood_cultureDT,
  file = 'blood_cultureDT.csv',
  #file = 'C:/Users/joann.alvarez/datacamp/blood_cultureDT.csv', 
  sep = ",",
  row.names = FALSE)
write.table(
  antibioticDT,
  file = 'antibioticDT.csv', 
  sep = ",",
  row.names = FALSE)



#antibioticDT2 = fread('antibioticDT.csv')


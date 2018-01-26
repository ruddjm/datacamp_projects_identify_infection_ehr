
## Simulate data to use in the datacamp project

setwd('/Users/ruddjm/Google Drive/datacamp/project_spec/')
set.seed(5)
# Simulate patient ids
n = 890
ids = formatC(sample(1:3000, size = n, replace = TRUE),
  	width = 4, flag = '0') 




## Simulate antibiotic data
antibiotic_types = c('do', 'am', 'cip', 'pen')
antibiotic_set_up = data.table(
  id = ids,
  number_of_abx = rnbinom(n, 0.5, 0.08)
	)
samp_days = function(num_days){
  sample(1:19, prob = 19:1, size = num_days, replace = TRUE)}
antibioticDT = data.table(
  id = antibiotic_set_up[ , rep(id, number_of_abx)],
  abx_day = unlist(lapply(antibiotic_set_up$number_of_abx,
  	FUN = samp_days))
	)
invisible(antibioticDT[ , abx_type := sample(antibiotic_types, 
  size = .N,
  replace = TRUE,
  prob = c(1, 2, 6, 2))])
setorder(antibioticDT, id, abx_day, abx_type)
invisible(antibioticDT[ , route := sample(c('PO', 'IV'), 
  prob = c(1, 4), 
  size = .N, replace = TRUE)])
antibioticDT = unique(antibioticDT)





# Simulate blood culture data
blood_culture_set_up = data.table(
  id = ids,
  number_of_cultures = sample(0:5, 
    size = n,
    prob = c(30, 6, 3, 2, 2, 1),
    replace = TRUE)
	)

blood_cultureDT = unique(data.table(
  id = blood_culture_set_up[ , rep(id, number_of_cultures)],
  blood_culture_day = unlist(lapply(blood_culture_set_up$number_of_cultures, 
	FUN = samp_days))
	))

setorder(blood_cultureDT, id, blood_culture_day)
blood_cultureDT[1:20]










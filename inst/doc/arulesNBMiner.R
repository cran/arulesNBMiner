## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----data---------------------------------------------------------------------
library(arulesNBMiner)
data("Agrawal")
Agrawal.db

## ----patterns-----------------------------------------------------------------
Agrawal.pat

## ----parameters---------------------------------------------------------------
param <- NBMinerParameters(Agrawal.db, trim = 0)
param

## ----itemsets-----------------------------------------------------------------
itemsets_NB <- NBMiner(Agrawal.db, 
                       pi = 0.99,
                       parameter = param, 
                       minlen = 2L)
itemsets_NB

## ----itemsets2----------------------------------------------------------------
inspect(head(itemsets_NB, by = "precision"))

## ----correct_patters----------------------------------------------------------
num_correct <- function(itemsets, patterns)
    table(factor(rowSums(is.subset(itemsets, patterns)) > 0,
          c(FALSE, TRUE)))

num_correct(itemsets_NB, Agrawal.pat)

## ----correct_patterns_eclat---------------------------------------------------
itemsets_supp <-  apriori(Agrawal.db, 
                          support = 0.001, 
                          target = "frequent", 
                          minlen = 2,
                          control = list(verbose = FALSE))
itemsets_supp <- head(sort(itemsets_supp, by = "support"), length(itemsets_NB))
itemsets_supp

num_correct(itemsets_supp, Agrawal.pat)

## -----------------------------------------------------------------------------
support_dist <- data.frame("NB-frequent" = support(itemsets_NB, transactions = Agrawal.db), 
                 "frequent" = support(itemsets_supp, transactions = Agrawal.db))

boxplot(support_dist, horizontal = TRUE)

## ----rules--------------------------------------------------------------------
rules <- NBMiner(Agrawal.db, 
                 parameter = param,
                 pi = 0.99,
                 rules = TRUE)
rules

## ----add_interest_measures----------------------------------------------------
quality(rules) <- cbind(quality(rules),
                        interestMeasure(rules, 
                                        c("support", "confidence", "lift"), 
                                        transactions = Agrawal.db))

inspect(head(sort(rules, by = "precision"), n = 10))


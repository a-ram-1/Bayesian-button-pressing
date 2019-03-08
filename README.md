# Bayesian-button-pressing
A Bayesian network simulation of a button-pressing task in schizophrenic patients. Directly influenced by http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3008301/. Main methods are seqprob.m and seqprobr.m-they both include essentially the same content but differ slightly in the algorithms used to calculate posteriors, etc.

A quick description of each of the relevant pieces of code: 

#### matrixp.m
Initializes a pseudorandom ordering of 6 sequences, each of which contain 2 1's and 2 0's, e.g. 1100. 

#### blikelihood.m
Calculates the binomial likelihood. See paper for more details. 

#### fbnegative.m and fbpositive.m
Calculates positive and negative feedback respectively. 

#### seqprob.m and seqprobr.m
Given a series of 6 4-button sequences, correctly infers each sequence 6 times in at most 20 trials. The two models differ only in their calculation of the reward function, rij. Seqprobr has a modifiable learning rate as well as a memory decay component, both default set to 0.5. Feedback parameters can also be adjusted.  

function likelihoodv = blikelihood(thetaij, rij, nj) %calculates the likelihood based on paper specifications
likelihoodv = (thetaij.^rij).*(1-thetaij).^(nj-rij);
    
end

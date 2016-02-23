function dstar = seqprob()
seqorderm = matrixp; %the pseudorandom block of your 6 sequences
dstar = []; %data for all the participant's choices, to fit alpha and beta to the data later 
for seq = 1:6
    correctarray = zeros(20,1);
    correctcount = 0; %how many times have you gotten a specific sequence correct?
    rij = zeros(1,8); %how many times you correctly receive positive/negative feedback-array is [correct incorrect] for each j 
    likelihoodm = zeros(20,4); %with all the likelihoods per trial for each movement, was gonna use to plot, necessary??
    posteriorm = zeros(20,4); %with all the posteriors per trial for each movement
    rightposteriorm = zeros(20,4); %posterior calculation w/p(right) > p(left)
    dseq = []; %data for the sequence itself
    for nj = 1:20
    correctj = 0; %if this == 4 when you finish iterating through the sequence you add 1 to the correctcount
    correctseq = zeros(1,4);
    for j = 1:4 
       if nj == 1 %first iteration-you initialize all the shit
           i = round(rand);%the first time you go through this you randomly guess
           dstar = [dstar i];
           dseq = [dseq i];
           if i == seqorderm(seq,j)
               thetaij = 0.85;
               feedbackguess = rand;
               if feedbackguess <= thetaij; %correctly give positive feedback
                   rij(j) = rij(j) + 1;
                   correctseq(j) = 1;
               end
               correctj = correctj + 1;
               likelihoodm(nj,j) = blikelihood(thetaij, rij(j), nj);
           else
               thetaij = 0.15;
               feedbackguess = rand;
               if feedbackguess >= thetaij; %correctly give negative feedback
                   rij(2*j) = rij(2*j) + 1;
               else
                   correctseq(j) = 1;
               end
               likelihoodm(nj,j) = blikelihood(thetaij, rij(2*j), nj);
           end
           if seqorderm(seq,j) == 1 %if the correct button press is "left" then thetaleftj = 0.85
                   thetaleft = 0.85;
                   thetaright = 0.15;
                   innerintfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj);
                   innerint = integral(innerintfn, 0, thetaleft);
                   outerintfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj)*innerint;
                   posteriorm(nj,j) = integral(outerintfn,0,1);
                   
                   innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj);
                   innerint = integral(innerintrightfn, 0, thetaright);
                   outerintrightfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj)*innerint;
                   rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
                   
           else %if the correct button press is "right"
                   thetaleft = 0.15;
                   thetaright = 0.85;
                   innerintfn = @(thetaright) blikelihood(thetaright, rij(j), nj);
                   innerint = integral(innerintfn, 0, thetaleft);
                   outerintfn = @(thetaleft) blikelihood(thetaleft, rij(2*j), nj)*innerint;
                   posteriorm(nj,j) = integral(outerintfn,0,1);
                   
                   innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj);
                   innerint = integral(innerintrightfn, 0, thetaright);
                   outerintrightfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj)*innerint;
                   rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
           end
       elseif nj == 2
           if rightposteriorm(1,j) <= posteriorm(1,j) %if it's more likely that you press left 
                   if correctseq(j) == 1;
                       i = 0;
                   else
                       i = 1;
                   end
                   dstar = [dstar i];
                   dseq = [dseq i];
           else 
                   if correctseq(j) == 1;
                       i = 1;
                   else
                       i = 0;
                   end
                   dseq = [dseq i];
                   dstar = [dstar i];                   
           end
           if i == seqorderm(seq,j) %if you guessed correctly
               thetaij = 0.85;
               feedbackguess = rand;
               if feedbackguess <= thetaij;
                   rij(j) = rij(j) + 1;
               end
               correctj = correctj + 1;
               likelihoodm(nj,j) = blikelihood(thetaij, rij(j), nj);
           else
               thetaij = 0.15;
               feedbackguess = rand;
               if feedbackguess >= thetaij;
                   rij(2*j) = rij(2*j) + 1;
               end
               likelihoodm(nj,j) = blikelihood(thetaij, rij(2*j), nj);
           end
           if seqorderm(seq,j) == 1 %if the correct button press is "left" then thetaleftj = 0.85
                   thetaleft = 0.85;
                   thetaright = 0.15;
                   innerintfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj);
                   innerint = integral(innerintfn, 0, thetaleft);
                   outerintfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj)*innerint;
                   posteriorm(nj,j) = integral(outerintfn,0,1);
                   
                   innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj);
                   innerint = integral(innerintrightfn, 0, thetaright);
                   outerintrightfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj)*innerint;
                   rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
                   
           else %if the correct button press is "right"
                   thetaleft = 0.15;
                   thetaright = 0.85;
                   innerintfn = @(thetaright) blikelihood(thetaright, rij(j), nj);
                   innerint = integral(innerintfn, 0, thetaleft);
                   outerintfn = @(thetaleft) blikelihood(thetaleft, rij(2*j), nj)*innerint;
                   posteriorm(nj,j) = integral(outerintfn,0,1);
                   
                   innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj);
                   innerint = integral(innerintrightfn, 0, thetaright);
                   outerintrightfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj)*innerint;
                   rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
           end
      else 
           if rightposteriorm(nj-1,j) <= posteriorm(nj-1,j) %if it's more likely that you press left 
                   i = 1;
                   dseq = [dseq i];
                   dstar = [dstar i];

           else
                   i = 0;
                   dseq = [dseq i];
                   dstar = [dstar i];                   
               %end
           end
           if i == seqorderm(seq,j) %if you guessed correctly
               thetaij = 0.85;
               feedbackguess = rand;
               if feedbackguess <= thetaij;
                   rij(j) = rij(j) + 1;
               end
               correctj = correctj + 1;
               likelihoodm(nj,j) = blikelihood(thetaij, rij(j), nj);
           else
               thetaij = 0.15;
               feedbackguess = rand;
               if feedbackguess >= thetaij;
                   rij(2*j) = rij(2*j) + 1;
               end
               likelihoodm(nj,j) = blikelihood(thetaij, rij(2*j), nj);
           end
           if seqorderm(seq,j) == 1 %if the correct button press is "left" then thetaleftj = 0.85
                   thetaleft = 0.85;
                   thetaright = 0.15;
                   innerintfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj);
                   innerint = integral(innerintfn, 0, thetaleft);
                   outerintfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj)*innerint;
                   posteriorm(nj,j) = integral(outerintfn,0,1);
                   
                   innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj);
                   innerint = integral(innerintrightfn, 0, thetaright);
                   outerintrightfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj)*innerint;
                   rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
                   
           else %if the correct button press is "right"
                   thetaleft = 0.15;
                   thetaright = 0.85;
                   innerintfn = @(thetaright) blikelihood(thetaright, rij(j), nj);
                   innerint = integral(innerintfn, 0, thetaleft);
                   outerintfn = @(thetaleft) blikelihood(thetaleft, rij(2*j), nj)*innerint;
                   posteriorm(nj,j) = integral(outerintrightfn,0,1);
                   
                   innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij(j), nj);
                   innerint = integral(innerintrightfn, 0, thetaright);
                   outerintrightfn = @(thetaright) blikelihood(thetaright, rij(2*j), nj)*innerint;
                   rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
           end
       end
       if j == 4 && correctj == 4
           correctcount = correctcount + 1;
       end
       correctarray(nj) = correctcount;
       seqorderm(seq,:)
       if correctcount == 6 %if you've successfully completed 6 correct trials
           likelihoodm = likelihoodm(1:nj, 1:4);
           posteriorm = posteriorm(1:nj,1:4);
           rightposteriorm = rightposteriorm(1:nj,1:4);
           plot(1:nj, correctarray(1:nj))
           break
       end
    end
    end
  % %how do i save the likelihood matrix
  % %plot some shit 
end
end 


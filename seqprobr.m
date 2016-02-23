function dstar = seqprobr() %the more intricate model with a modified r_{ij} function

seqorderm = matrixp;
dstar = [];
alpha = 0.5;
beta = 0.6;
tau = 0.5;
for seq = 1:6
    correctarray = zeros(20,1);
    correctcount = 0; %how many times have you gotten a specific sequence correct?
    likelihoodm = zeros(20,4);
    posteriorm = zeros(20,4);
    rightposteriorm = zeros(20,4);
    dseq = [];
    ut = zeros(1,80);
for nj = 1:20
    correctj = 0; %if this = 4 when you finish iterating through the sequence you add 1 to the correctcount 
    for j = 1:4 
       if nj == 1
           i = round(rand);%the first time you go through this you randomly guess
           dstar = [dstar i];
           dseq = [dseq i];
           if i == seqorderm(seq,j) 
               thetaij = 0.85;
               fbguess = rand;
               if fbguess <= thetaij;
                   ut(nj*j) = 1;
               else
                   ut(nj*j) = 0;
               end 
               for t = 1:nj*j
                   Ans(t)= exp(-tau*(nj*j - t)*(fbpositive(alpha)*ut(t) + fbnegative(beta)*(1-ut(t))));%this is where you set the parameters for alpha and beta, i just arbitrarily set them for now
               end
               rij = sum(Ans);
               correctj = correctj + 1;
           else
               thetaij = 0.15;
               fbguess = rand;
               if fbguess <= thetaij;
                   ut(nj*j) = 1;
               else
                   ut(nj*j) = 0;
               end 
               for t = 1:nj*j
                   Ans(t)= exp(-tau*(nj*j - t)*(fbpositive(alpha)*ut(t) + fbnegative(beta)*(1-ut(t))));%this is where you set the parameters for alpha and beta, i just arbitrarily set them for now
               end
               rij = sum(Ans);
           end
           likelihood = thetaij;
           likelihoodm(nj,j) = likelihood;
           if seqorderm(seq,j) == 1 %if the correct button press is "left" then thetaleftj = 0.85
               thetaleft = 0.85;
               thetaright = 0.15;
               innerintfn = @(thetaright) blikelihood(thetaright, rij, nj);
               innerint = integral(innerintfn, 0, thetaij);
               outerintfn = @(thetaij) blikelihood(thetaij, rij, nj)*innerint;
               posteriorm(nj,j) = integral(outerintfn,0,1);
           
               innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij, nj);
               innerint = integral(innerintrightfn, 0, thetaright);
               outerintrightfn = @(thetaright) blikelihood(thetaright, rij, nj)*innerint;
               rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);

           else %if the correct button press is "right"
               thetaleft = 0.15;
               thetaright = 0.85;
               innerintfn = @(thetaij) blikelihood(thetaij, rij, nj);
               innerint = integral(innerintfn, 0, thetaleft);
               outerintfn = @(thetaleft) blikelihood(thetaleft, rij, nj)*innerint;
               posteriorm(nj,j) = integral(outerintfn,0,1);
               
               innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij, nj);
               innerint = integral(innerintrightfn, 0, thetaright);
               outerintrightfn = @(thetaright) blikelihood(thetaright, rij, nj)*innerint;
               rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
           end
       elseif nj == 2
           if rightposteriorm(1,j) <= posteriorm(1,j) 
               i = 1;
           else
               i = 0;
           end
           dstar = [dstar i];
           dseq = [dseq i];
           if i == seqorderm(seq,j)
               thetaij = 0.85;
               fbguess = rand;
               if fbguess <= thetaij;
                   ut(nj*j) = 1;
               else
                   ut(nj*j) = 0;
               end 
               for t = 1:nj*j
                   Ans(t)= exp(-tau*(nj*j - t)*(fbpositive(alpha)*ut(t) + fbnegative(beta)*(1-ut(t))));%this is where you set the parameters for alpha and beta, i just arbitrarily set them for now
               end
               rij = sum(Ans);
               correctj = correctj + 1;
           else
               thetaij = 0.15;
               fbguess = rand;
               if fbguess <= thetaij;
                   ut(nj*j) = 1;
               else
                   ut(nj*j) = 0;
               end 
               for t = 1:nj*j
                   Ans(t)= exp(-tau*(nj*j - t)*(fbpositive(alpha)*ut(t) + fbnegative(beta)*(1-ut(t))));%this is where you set the parameters for alpha and beta, i just arbitrarily set them for now
               end
               rij = sum(Ans);
           end
           likelihoodm(nj,j) = blikelihood(thetaij, rij, nj);
           if seqorderm(seq,j) == 1 %if the correct button press is "left" then thetaleftj = 0.85
               thetaleft = 0.85;
               thetaright = 0.15;
               innerintfn = @(thetaright) blikelihood(thetaright, rij, nj);
               innerint = integral(innerintfn, 0, thetaij);
               outerintfn = @(thetaij) blikelihood(thetaij, rij, nj)*innerint;
               posteriorm(nj,j) = integral(outerintfn,0,1);
               
               innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij, nj);
               innerint = integral(innerintrightfn, 0, thetaright);
               outerintrightfn = @(thetaright) blikelihood(thetaright, rij, nj)*innerint;
               rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
           
           else %if the correct button press is "right"
               thetaleft = 0.15;
               thetaright = 0.85;
               innerintfn = @(thetaij) blikelihood(thetaij, rij, nj);
               innerint = integral(innerintfn, 0, thetaleft);
               outerintfn = @(thetaleft) blikelihood(thetaleft, rij, nj)*innerint;
               posteriorm(nj,j) = integral(outerintfn,0,1);

               innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij, nj);
               innerint = integral(innerintrightfn, 0, thetaright);
               outerintrightfn = @(thetaright) blikelihood(thetaright, rij, nj)*innerint;
               rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);

           end
       else
         if rightposteriorm(nj-1,j) <= posteriorm(nj-1,j) 
             i = 1;
             dseq = [dseq i];
             dstar = [dstar i];
         else
             i = 0;
             dseq = [dseq i];
             dstar = [dstar i];
         end
         if i == seqorderm(seq,j)
               thetaij = 0.85;
               fbguess = rand;
               if fbguess <= thetaij;
                   ut(nj*j) = 1;
               else
                   ut(nj*j) = 0;
               end 
               for t = 1:nj*j
                   Ans(t)= exp(-tau*(nj*j - t)*(fbpositive(alpha)*ut(t) + fbnegative(beta)*(1-ut(t))));%this is where you set the parameters for alpha and beta, i just arbitrarily set them for now
               end
               rij = sum(Ans);
               correctj = correctj + 1;
           else
               thetaij = 0.15;
               fbguess = rand;
               if fbguess <= thetaij;
                   ut(nj*j) = 1;
               else
                   ut(nj*j) = 0;
               end 
               for t = 1:nj*j
                   Ans(t)= exp(-tau*(nj*j - t)*(fbpositive(alpha)*ut(t) + fbnegative(beta)*(1-ut(t))));%this is where you set the parameters for alpha and beta, i just arbitrarily set them for now
               end
               rij = sum(Ans);
           end
        if seqorderm(seq,j) == 1 %if the correct button press is "left" then thetaleftj = 0.85
               thetaleft = 0.85;
               thetaright = 0.15;
               innerintfn = @(thetaright) blikelihood(thetaright, rij, nj);
               innerint = integral(innerintfn, 0, thetaij);
               outerintfn = @(thetaij) blikelihood(thetaij, rij, nj)*innerint;
               posteriorm(nj,j) = integral(outerintfn,0,1);
               
               innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij, nj);
               innerint = integral(innerintrightfn, 0, thetaright);
               outerintrightfn = @(thetaright) blikelihood(thetaright, rij, nj)*innerint;
               rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
           
           else %if the correct button press is "right"
               thetaleft = 0.15;
               thetaright = 0.85;
               innerintfn = @(thetaij) blikelihood(thetaij, rij, nj);
               innerint = integral(innerintfn, 0, thetaleft);
               outerintfn = @(thetaleft) blikelihood(thetaleft, rij, nj)*innerint;
               posteriorm(nj,j) = integral(outerintfn,0,1);

               innerintrightfn = @(thetaleft) blikelihood(thetaleft, rij, nj);
               innerint = integral(innerintrightfn, 0, thetaright);
               outerintrightfn = @(thetaright) blikelihood(thetaright, rij, nj)*innerint;
               rightposteriorm(nj,j) = integral(outerintrightfn, 0,1);
        end
       end   
       if j == 4 && correctj == 4
           correctcount = correctcount + 1;
       end
       correctarray(nj) = correctcount;
       seqorderm(seq,:)
    end
    if correctcount == 6
        likelihoodm = likelihoodm(1:nj,1:4);
        posteriorm = posteriorm(1:nj,1:4);
        rightposteriorm = rightposteriorm(1:nj,1:4);
        plot(1:nj, correctarray(1:nj))
        break
    end
    if nj == 20
        plot(1:nj, correctarray(1:nj))
    end
    end
    end 
end

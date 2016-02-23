function pressesm = matrixp()
presses = [[1 1 0 0]; [0 0 1 1]; [1 0 1 0]; [0 1 0 1]; [1 0 0 1]; [0 1 1 0]];
%initialize a matrix with a pseudorandom permutation of the sequences above
ix = randperm(6);
pressesm = zeros(6,4);
for i = 1:6
   a = ix(i); 
   pressesm(i,:) = presses(a,:);
end
end

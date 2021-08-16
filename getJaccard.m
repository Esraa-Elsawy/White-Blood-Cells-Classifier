function J = getJaccard(A,B)
 J = sum(A(:) & B(:))/sum(A(:) | B(:)) ;



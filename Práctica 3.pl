raiz(X,A,R):-Y=2*A, W=A*A, Z=X/W, E=Y+Z, B=E/3, D=abs(A-B), D>0.01, Ra is B,write(Ra),nl, raiz(X,B,R).
raiz(X,A,R1):-Y=2*A, W=A*A, Z=X/W, E=Y+Z, B=E/3, R1=B.
padre(oscar,omar).
padre(pedro,pablo).
padre(pablo,raul).
padre(raul,daniel).
ancestro(A,D):-padre(A,D).
ancestro(A,D):-padre(P,D), ancestro(A,P).

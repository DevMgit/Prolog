% Arithmetic operations
sum(A, B):-
    S is A + B,
    write(S).

sub(A, B):-
    D is A - B,
    write(D).

multi(A, B):-
    M is A * B,
    write(M).

pow(A, B):-
    P is A ** B,
    write(P).

div(A, B):-
    V is A / B,
    write(V).

idiv(A, B):-
    IV is A // B,
    write(IV).

% Calculate simple interest and 2% discount
si(P, T, R):-
    I is (P * T * R) / 100,
    AfterDiscount is (2 * I) / 100,
    write(I), nl,
    write(AfterDiscount).

% Find Binoy's house location (midpoint between two coordinates)
loc(X1, Y1, X2, Y2):-
    X is (X1 + X2) / 2,
    Y is (Y1 + Y2) / 2,
    write('Binoy\'s house is located at'),
    write('('),
    write(X),
    write(','),
    write(Y),
    write(')').

% Relational operators
greaterthan(A, B):-
    write('First Number is greater than Second Number'), nl,
    A > B.

lessthan(A, B):-
    write('First Number is less than Second Number'), nl,
    A < B.

equalto(A, B):-
    write('First Number is equal to Second Number'), nl,
    A == B.

notequalto(A, B):-
    write('First Number is not equal to Second Number'), nl,
    A \== B.

% Convert centigrade to Fahrenheit and check if below freezing
tempconv(C):-
    F is 9 / 5 * (C + 32),
    write(' The temperature '),
    write(C),
    write(' Centigrade '),
    write('is '),
    write(F),
    write(' Farenhite '),
    F < 0,
    write('The temperature is below freezing.').

% Set 1
% Program 1
parent(john, mary).
parent(jane, mary).
parent(john, tom).
parent(jane, tom).

sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% Query:
% ?- sibling(mary, Sibling).

% Program 2
calc_operations(A, B) :-
    Sum is A + B,
    Diff is A - B,
    Prod is A * B,
    (B =\= 0 -> Quot is A / B ; Quot = 'undefined'),
    write('Sum: '), write(Sum), nl,
    write('Difference: '), write(Diff), nl,
    write('Product: '), write(Prod), nl,
    write('Quotient: '), write(Quot), nl.

% Query:
% ?- calc_operations(10, 2).

% Set 2
% Program 1
book('Harry Potter', 'J.K. Rowling').
book('The Casual Vacancy', 'J.K. Rowling').
book('The Hobbit', 'J.R.R. Tolkien').

books_by_author(Author, Title) :- book(Title, Author).

% Query:
% ?- books_by_author('J.K. Rowling', Title).

% Program 2
price(apple, 30).
price(milk, 50).
price(bread, 20).

total_cost([Item|Rest], Total) :-
    price(Item, Cost),
    total_cost(Rest, RestTotal),
    Total is Cost + RestTotal.
total_cost([], 0).

% Query:
% ?- total_cost([apple, milk, bread], Total).

% Set 3
% Program 1
prerequisite(math101, math001).
prerequisite(cs101, math101).

can_enroll(Student, Course) :-
    prerequisite(Course, Pre),
    passed(Student, Pre).

passed(john, math001).
passed(john, math101).

% Query:
% ?- can_enroll(john, cs101).

% Program 2
rectangle(L, W) :-
    Area is L * W,
    Perimeter is 2 * (L + W),
    write('Area: '), write(Area), nl,
    write('Perimeter: '), write(Perimeter), nl.

% Query:
% ?- rectangle(5, 3).


% Set 4
% Program 1
book('Harry Potter', 'J.K. Rowling', fantasy).
book('The Hobbit', 'J.R.R. Tolkien', fantasy).
book('1984', 'George Orwell', dystopian).

books_by_genre(Genre, Title) :- book(Title, _, Genre).

% Query:
% ?- books_by_genre(fantasy, Title).

% Program 2
grade(john, math, 75).
grade(jane, math, 45).
grade(john, science, 60).

passed(Student, Subject) :-
    grade(Student, Subject, Mark),
    Mark >= 50.

% Query:
% ?- passed(john, math).

% Set 5
% Program 1
city(hyderabad, india).
city(paris, france).
city(tokyo, japan).

country_of_city(City, Country) :- city(City, Country).

% Query:
% ?- country_of_city(hyderabad, Country).

% Program 2
age(john, 20).
age(jane, 16).

can_vote(Person) :-
    age(Person, Age),
    Age >= 18.

% Query:
% ?- can_vote(john).

% Set 6
% Program 1
student_course(john, math).
student_course(john, science).
student_course(jane, english).

courses_of_student(Student, Course) :- student_course(Student, Course).

% Query:
% ?- courses_of_student(john, Course).

% Program 2
compare_numbers(A, B) :-
    (A > B -> Result = 'A is greater' ;
     A < B -> Result = 'B is greater' ;
     Result = 'Both are equal'),
    write(Result).

% Query:
% ?- compare_numbers(5, 7).

% Set 7
% Program 1
product(apple, 30).
product(banana, 10).
product(milk, 50).

cheaper_than(MaxPrice, Product) :-
    product(Product, Price),
    Price < MaxPrice.

% Query:
% ?- cheaper_than(40, Product).

% Program 2
factorial(0, 1).
factorial(N, F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

% Query:
% ?- factorial(5, F).

% Set 8
% Program 1
animal(tiger, forest).
animal(shark, ocean).
animal(deer, forest).

animals_in_habitat(Habitat, Animal) :- animal(Animal, Habitat).

% Query:
% ?- animals_in_habitat(forest, Animal).

% Program 2
distance((X1, Y1), (X2, Y2), D) :-
    DX is X2 - X1,
    DY is Y2 - Y1,
    D is sqrt(DX*DX + DY*DY).

% Query:
% ?- distance((0,0), (3,4), D).

% Set 9
% Program 1
employee(john, hr).
employee(jane, it).
employee(sam, hr).

employees_in_department(Dept, Emp) :- employee(Emp, Dept).

% Query:
% ?- employees_in_department(hr, Emp).

% Program 2
inside_rectangle(X, Y, X1, Y1, X2, Y2) :-
    X >= X1, X =< X2,
    Y >= Y1, Y =< Y2.

% Query:
% ?- inside_rectangle(3, 3, 1, 1, 5, 5).

% Set 10
% Program 1
artist_album('Adele', '30').
artist_album('Adele', '21').
artist_album('Ed Sheeran', 'Divide').

albums_by_artist(Artist, Album) :- artist_album(Artist, Album).

% Query:
% ?- albums_by_artist('Adele', Album).

% Program 2
max(X, Y, X) :- X >= Y, !.
max(_, Y, Y).

% Query:
% ?- max(7, 5, M).

% Set 11
% Program 1
movie('Inception', 'Christopher Nolan').
movie('Titanic', 'James Cameron').

director_of(Movie, Director) :- movie(Movie, Director).

% Query:
% ?- director_of('Inception', Director).

% Program 2
classify(N) :-
    N > 0, !, write('Positive').
classify(N) :-
    N < 0, !, write('Negative').
classify(_) :-
    write('Zero').

% Query:
% ?- classify(-3).

% Set 12
% Program 1
food(pizza, [cheese, tomato, dough]).
food(salad, [lettuce, tomato, cucumber]).

contains(Food, Ingredient) :-
    food(Food, Ingredients),
    member(Ingredient, Ingredients).

% Query:
% ?- contains(pizza, tomato).

% Program 2
if_then_else(Cond, Then, Else) :-
    Cond, !, Then.
if_then_else(_, _, Else) :-
    Else.

% Query:
% ?- if_then_else(3 > 2, write('Yes'), write('No')).

% Set 13
% Program 1
component(cpu, intel).
component(gpu, nvidia).
component(ram, corsair).

manufacturer(Component, Company) :- component(Component, Company).

% Query:
% ?- manufacturer(gpu, Company).

% Set 14
% Program 1
flight(hyderabad, delhi).
flight(hyderabad, mumbai).
flight(delhi, kolkata).

direct_flights_from(From, To) :- flight(From, To).

% Query:
% ?- direct_flights_from(hyderabad, To).

% Program 2
location(monkey, floor).
location(box, floor).
location(banana, ceiling).

monkey_at_banana :- location(monkey, L), location(banana, L).

% Query:
% ?- monkey_at_banana.

% Set 15
% Program 1
website('chatgpt.com', ai).
website('spotify.com', music).
website('cnn.com', news).

category_url(Category, URL) :- website(URL, Category).

% Query:
% ?- category_url(ai, URL).

% Program 2
move(monkey, L1, L2) :- location(monkey, L1), retract(location(monkey, L1)), assert(location(monkey, L2)).

% Query:
% ?- move(monkey, room1, room2).


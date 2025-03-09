% State representation: state(MonkeyPosition, MonkeyHeight, ChairPosition, HasBanana)
% MonkeyPosition: left, middle, right
% MonkeyHeight: onfloor, onchair
% ChairPosition: left, middle, right
% HasBanana: has, hasnot

% Move rules defining all possible actions
% Grab banana when monkey is on chair in middle position
move(state(middle, onchair, middle, hasnot), grab, state(middle, onchair, middle, has)).

% Climb on chair when monkey is at same position as chair
move(state(Pos, onfloor, Pos, HasBanana),
     climb,
     state(Pos, onchair, Pos, HasBanana)).

% Get down from chair
move(state(Pos, onchair, Pos, HasBanana),
     getdown,
     state(Pos, onfloor, Pos, HasBanana)).

% Push chair from one position to another (monkey must be on floor and at chair position)
move(state(Pos1, onfloor, Pos1, HasBanana),
     push(Pos1, Pos2),
     state(Pos2, onfloor, Pos2, HasBanana)).

% Walk from one position to another (monkey must be on floor)
move(state(Pos1, onfloor, ChairPos, HasBanana),
     walk(Pos1, Pos2),
     state(Pos2, onfloor, ChairPos, HasBanana)).

% Define valid positions and movements between them
valid_position(left).
valid_position(middle).
valid_position(right).

adjacent(left, middle).
adjacent(middle, right).
adjacent(middle, left).
adjacent(right, middle).

% Can only walk or push between adjacent positions
move(state(Pos1, onfloor, ChairPos, HasBanana),
     walk(Pos1, Pos2),
     state(Pos2, onfloor, ChairPos, HasBanana)) :-
    adjacent(Pos1, Pos2).

move(state(Pos1, onfloor, Pos1, HasBanana),
     push(Pos1, Pos2),
     state(Pos2, onfloor, Pos2, HasBanana)) :-
    adjacent(Pos1, Pos2).

% Goal state - monkey has banana
canget(state(_, _, _, has)).

% Recursive rule to find solution
canget(State1) :-
    move(State1, Move, State2),
    canget(State2).

% Find solution with path
solve(State, []) :-
    canget(state(_, _, _, has)).

solve(State1, [Move|Moves]) :-
    move(State1, Move, State2),
    solve(State2, Moves).

% Helper predicate to print solution path
print_solution([]).
print_solution([Move|Moves]) :-
    write('Move: '), write(Move), nl,
    print_solution(Moves).

% Example query to solve puzzle from initial state:
%?- solve(state(left, onfloor, left, hasnot), Moves), print_solution(Moves).
% or
%?- canget(state(left, onfloor, left, hasnot)).

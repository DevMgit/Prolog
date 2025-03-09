% Week 4: Monkey Banana Problem (Extended Version)

% Instead of a single room, introduce multiple rooms connected by doorways.

% Define the two rooms
room(room1).
room(room2).

% Define the doorways connecting the rooms
doorway(room1, room2).
doorway(room2, room1).

% Define the initial state
% monkey(room1) - Monkey is in room1
% box(room1) - Box is in room1
% banana(room2) - Banana is in room2
% on_floor - Monkey is on the floor
% not_having - Monkey is not having the banana
initial_state(state(monkey(room1), box(room1), banana(room2), on_floor, not_having)).

% Define the goal state
% holding - Monkey is holding the banana
goal_state(state(_,_,_, having)).

% Define the move action
% Monkey can move from one room to another through a doorway
move(state(monkey(R1), Box, Banana, Position, Having), state(monkey(R2), Box, Banana, Position, Having)) :-
    doorway(R1, R2).

% Define the push action
% Monkey can push the box from one room to another through a doorway
push(state(monkey(R1), box(R1), Banana, on_floor, Having), state(monkey(R2), box(R2), Banana, on_floor, Having)) :-
    doorway(R1, R2).

% Define the climb action
% Monkey can climb the box if it is in the same room and on the floor
climb(state(monkey(R), box(R), Banana, on_floor, Having), state(monkey(R), box(R), Banana, on_box, Having)).

% Define the grab action
% Monkey can grab the banana if it is on the box and the banana is in the same room
grab(state(monkey(R), box(R), banana(R), on_box, not_having), state(monkey(R), box(R), banana(R), on_box, having)).

% Define the solve predicate
% Recursively search for a sequence of actions to reach the goal state
solve(State, _, []) :-
    goal_state(State).
solve(State, Visited, [Action | Actions]) :-
    (move(State, NewState); push(State, NewState); climb(State, NewState); grab(State, NewState)),
    solve(NewState, [NewState | Visited], Actions).

% Define the main predicate to find a solution
monkey_banana_problem(Solution) :-
    initial_state(InitialState),
    solve(InitialState, [InitialState], Solution).

% Instead of a single chair, introduce multiple chairs.
% Note: Currently uses a single "box" (assumed to be the chair). To implement multiple chairs, define multiple boxes (e.g., box1, box2) and update state/actions.

% Add obstacles in the room(s) that the monkey, chair, or banana cannot pass through.
% Note: Not implemented. To add obstacles, define obstacle(room, position) facts and add constraints to move/push actions.

% The monkey needs to collect multiple bananas scattered around the environment.

% Facts for multiple bananas and their locations
at(banana1, ceiling).
at(banana2, ceiling).
at(banana, middle). % From earlier section
height(ceiling).
height(middle).
height(low).

% Rules to reach and grab multiple bananas
can_reach(monkey, X) :-
    at(monkey, Y),
    at(box, Z),
    at(X, ceiling),
    Y = door,
    Z = middle,
    can_climb(monkey, box),
    can_move(monkey, box).

can_climb(monkey, box).
can_move(monkey, box).

can_grab(monkey, X) :-
    can_reach(monkey, X).

% Introduce another monkey, which might cooperate or compete with the first monkey for the banana.

% Facts for multiple monkeys
at(monkey1, door).
at(monkey2, window).
at(box, middle).
height(door, low).
height(window, low).
height(banana, high).
height(box, low).
can_climb(monkey1).
can_climb(monkey2).
can_push(monkey1).
can_push(monkey2).

% Rules for grabbing the banana (competition/cooperation implied)
can_grab_banana(Monkey) :-
    at(Monkey, BoxLocation),
    at(box, BoxLocation),
    at(banana, BoxLocation),
    height(box, low),
    height(banana, high),
    can_climb(Monkey).

can_grab_banana(Monkey) :-
    at(Monkey, MonkeyLocation),
    at(box, BoxLocation),
    at(banana, BananaLocation),
    MonkeyLocation \= BananaLocation,
    BoxLocation \= BananaLocation,
    can_push(Monkey),
    can_move_box_and_monkey(Monkey, BoxLocation, BananaLocation).

can_grab_banana(Monkey) :-
    at(Monkey, MonkeyLocation),
    at(box, BananaLocation),
    at(banana, BananaLocation),
    MonkeyLocation \= BananaLocation,
    can_move_monkey(Monkey, MonkeyLocation, BananaLocation),
    can_climb(Monkey).

% Helper rules to check if the monkey can move and push the box
can_move_box_and_monkey(Monkey, _, BananaLocation) :-
    at(Monkey, MonkeyLocation),
    at(box, BoxLocation),
    MonkeyLocation \= BananaLocation,
    BoxLocation \= BananaLocation,
    MonkeyLocation = BoxLocation,
    at(banana, BananaLocation).

can_move_monkey(Monkey, _, BananaLocation) :-
    at(Monkey, MonkeyLocation),
    at(banana, BananaLocation),
    MonkeyLocation \= BananaLocation.

% Additional movement rules from later part of the original code
move(state(middle, onchair, middle, hasnot),
     grab,
     state(middle, onchair, middle, has)).

move(state(Xposition2, onfloor, Xposition2, Hasbanana),
     climb,
     state(Xposition2, onchair, Xposition2, Hasbanana)).

move(state(Xposition1, onfloor, Xposition1, Hasbanana),
     push(Xposition1, Xposition2),
     state(Xposition2, onfloor, Xposition2, Hasbanana)).

move(state(Xposition1, onfloor, Chairpos, Hasbanana),
     walk(Xposition1, Xposition2),
     state(Xposition2, onfloor, Chairpos, Hasbanana)).

canget(state(_, _, _, has)).

canget(State1):-
    move(State1, _, State2),
    canget(State2).

% Example queries:
%?- can_grab(monkey, banana1).
%?- can_grab(monkey, banana2).
%?- can_grab_banana(monkey1).
%?- can_grab_banana(monkey2).
%?- monkey_banana_problem(Solution).

% Medical diagnosis system with symptoms and conditions
% Demonstrates green and red cuts (!) in different scenarios

% Symptoms database
symptom(fever).
symptom(cough).
symptom(headache).
symptom(fatigue).
symptom(sore_throat).
symptom(runny_nose).
symptom(body_aches).
symptom(chills).

% Conditions and their symptoms
has_symptom(flu, fever).
has_symptom(flu, cough).
has_symptom(flu, fatigue).
has_symptom(flu, body_aches).
has_symptom(flu, chills).
has_symptom(cold, runny_nose).
has_symptom(cold, cough).
has_symptom(cold, sore_throat).
has_symptom(cold, fatigue).
has_symptom(covid, fever).
has_symptom(covid, cough).
has_symptom(covid, fatigue).
has_symptom(covid, body_aches).
has_symptom(covid, loss_of_taste).

% Example of Green Cut - Optimization for symptom validation
validate_symptom(Symptom) :-
    symptom(Symptom),
    !. % Green cut - just optimization, removing won't affect results
validate_symptom(Symptom) :-
    format('Warning: ~w is not a recognized symptom~n', [Symptom]), fail.

% Example of Red Cut - Severity classification
classify_severity(Condition, Severity) :-
    has_high_risk_symptoms(Condition),
    !, % Red cut - changes logic of the program
    Severity = high.
classify_severity(Condition, Severity) :-
    has_moderate_symptoms(Condition),
    !,
    Severity = moderate.
classify_severity(_, low). % Default case

% Helper predicates for severity classification
has_high_risk_symptoms(Condition) :-
    has_symptom(Condition, fever),
    has_symptom(Condition, body_aches).
has_moderate_symptoms(Condition) :-
    has_symptom(Condition, cough).

% Diagnosis predicate using green cut for optimization
diagnose(Symptoms, Condition) :-
    validate_symptoms(Symptoms),
    !, % Green cut - optimization
    find_matching_condition(Symptoms, Condition).

% Helper predicates
validate_symptoms([]).
validate_symptoms([Symptom|Rest]) :-
    validate_symptom(Symptom),
    validate_symptoms(Rest).

find_matching_condition(Symptoms, Condition) :-
    condition(Condition),
    all_symptoms_match(Symptoms, Condition).

condition(flu).
condition(cold).
condition(covid).

all_symptoms_match([], _).
all_symptoms_match([Symptom|Rest], Condition) :-
    has_symptom(Condition, Symptom),
    all_symptoms_match(Rest, Condition).

% Example usage queries:
%?- diagnose([fever, cough, fatigue], Condition).
%?- classify_severity(flu, Severity).

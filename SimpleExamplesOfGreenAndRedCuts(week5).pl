% Simple examples of green and red cuts 
% Green Cut Example - Testing if a number is positive 
is_positive(X) :-  
X > 0,  
!.    % Green cut - just optimization 
is_positive(X) :-  
write(X),  
write(' is not positive'),  
nl, 
fail. 
% Red Cut Example - Simple grade classification 
grade(Score, 'A') :- Score >= 90, !.  % Red cut - changes logic 
grade(Score, 'B') :- Score >= 80, !. 
grade(Score, 'C') :- Score >= 70, !. 
grade(_, 'F'). 
% Example queries: 
% ?- is_positive(5).    % true 
% ?- is_positive(-3).   % prints "-3 is not positive" and fails 
% ?- grade(95, Grade).  % Grade = 'A' 
% ?- grade(85, Grade).  % Grade = 'B' 
% ?- grade(65, Grade).  % Grade = 'F'

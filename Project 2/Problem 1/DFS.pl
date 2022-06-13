%DFS
%uninformed
%testcase
%threeSum([3,8,9,10,12,14],23,Output).

threeSum(InputList,Goal,OutputList):-
	path([[[InputList,[],1],nil]],[],Goal,OutputList).


path([[[List,[R1,R2,R3],_],_]|_],Closed,Goal,[R1,R2,R3]):-
	Goal is R1 + R2 + R3.


path([[Child,Parent]|Unvisited],Visited,Goal,OutputList):-
	getNodes(Child, Unvisited, Visited,NewChild),
	appendLists(NewChild,Unvisited,NewUnvisited),
	path(NewUnvisited, [[Child,Parent]| Visited], Goal,OutputList).


path([],_,_,_):-
    fail,nl,!.


getNodes(Child,Unvisited,Visited,Result):-
	findall(Var,moves(Child,Unvisited,Visited,Var),Result).

moves(Child,Unvisited,Visited,[NewChild,Child]):-
	move(Child,NewChild),
	not(membership([NewChild,_],Unvisited)),
	not(membership([NewChild,_],Visited)).

move([List,Temp,Turn],[NewList,NewT,1]):-
	listSize(Temp,Len),
	Len < 3,
	last(List,-9,Idx),
	NextToSelect is Idx+Turn,
        nthFun(NextToSelect,List,N),
	appendLists(Temp,[N],NewT),
	change(List,NextToSelect,-9,NewList).

move([List,Temp,Turn],NewState):-
	last(List,-9,Index),
	listSize(List,Len),
	Turn < Len-Index,
	NewTurn is Turn+1,
	move([List,Temp,NewTurn],NewState).


last(List, Needle, Return) :-
    last1(List, Needle, 0, -1, Return).

last1([Head|Tail], Number, Num, NumGoal, Return) :-
    Num1 is Num + 1,
    (Head == Number, !,
    last1(Tail, Number, Num1, Num, Return);
    last1(Tail, Number, Num1, NumGoal, Return)).

last1([],_,_,NumGoal,NumGoal).


%replace function
change([_|T],0,X,[X|T]).
change([H|T],Cnt,X,[H|R]):-
	Cnt > 0,
	NewCnt is Cnt-1,
	change(T,NewCnt,X,R).


%get length of list
listSize([],0) :- !.
listSize([_|B], X1) :-
	listSize(B, X0),
	X1 = X0 + 1.


%member function
membership(Member,[Member|_]).
membership(Member,[_|Tail]):-
       membership(Member,Tail).


%append function
appendLists([],L2,L2).

appendLists([H|T],L2,[H|R]):-
      appendLists(T,L2,R).


%nth0 function
nthFun(0, [Head|_], Head) :- !.

nthFun(N, [_|Tail], Elem) :-
    nonvar(N),
    M is N-1,
    nthFun(M, Tail, Elem).

nthFun(N,[_|T],Item) :-
    var(N),
    nthFun(M,T,Item),
    N is M + 1.

















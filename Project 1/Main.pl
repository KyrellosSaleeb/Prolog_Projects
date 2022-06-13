:- use_module(students_courses).

%20198065
%20198130
%Bio
%B3
% ---------------------------------------------------------------------
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%----------------------------Test Cases--------------------------------

%studentsInCourse('Robotics', Students).
%studentsInCourse('Algorithms', Students).
%
%
%numStudents('Algorithms', Num).
%numStudents('Math 1', Num).
%
%
%maxStudentGrade(stud10, MaxGrade).
%maxStudentGrade(stud08, MaxGrade).
%
%
%gradeInWords(stud04, 'Database', DigitsWords).
%gradeInWords(stud07, 'Math 2', DigitsWords).
%gradeInWords(stud01, 'Programming 1', DigitsWords).
%
%
%remainingCourses(stud01, 'Advanced Algorithms', Courses).
%remainingCourses(stud07, 'Electronics 2', Courses).
%remainingCourses(stud05, 'Computer Architecture', Courses).
%remainingCourses(stud08, 'Data Warehouses', Courses).
%remainingCourses(stud02, 'Networks', Courses).

%----------------------------------------------------------------------

% --------------------------Buit-in Functions ---------------------

%Add 2 lists funcion
appendLists([],List2,List2).
appendLists([Head|Tail],List2,[Head|List]):-
       appendLists(Tail,List2,List).


%Member funcion
membership(Member,[Member|Tail]).
membership(Member,[_|Tail]):-
       membership(Member,Tail).


%Length of list function
listCounter([],0).
listCounter([_|Tail],NewN):-
       listCounter(Tail,N),
       NewN is N+1.


%Max of list
maxElement([Head|[]], Maximum) :-
	Maximum is Head, !.

maxElement([Head|Tail], Maximum) :-
	maxElement(Tail, Maximum1),
	Maximum1 > Head,
	Maximum is Maximum1, !;
        maxElement(Tail,Maximum1),
	Maximum1 < Head,
	Maximum is Head, !.


%join funcion
combine([],List2,List2).
combine([Head|List2],Tail,[Head|Rest]):-
       combine(List2,Tail,Rest).

%reverse funcion
sorting([],[]).
sorting([Head|Tail],List):-
       sorting(Tail,List1),
       combine(List1,[Head],List).

%----------------------------------------------------------------------


%----------------------------task 1------------------------------
studentsInCourse(Course,List):-
       studentsInCourse(Course,[],List).

studentsInCourse(Course,TempList,List):-
       student(ID,Course,Grade),
       not(membership([ID,Grade],TempList)), !,
       appendLists([[ID,Grade]],TempList,NewList),
       studentsInCourse(Course,NewList,List).
studentsInCourse(Course,List,List).


%----------------------------------------------------------------------

%-----------------------------task 2--------------------------------
numStudents(Course,Num) :-
       studentsInCourse(Course, Courseslist),
       listCounter(Courseslist,Num).

%----------------------------------------------------------------------


%-------------------------------task 3-------------------------------

idStudent(ID,List):-
       idStudent(ID,[],List).

idStudent(ID,TempList,List):-
       student(ID,Courses,Grades),
       not(membership(Grades,TempList)), !,
       appendLists([Grades],TempList,NewList),
       idStudent(ID,NewList,List).

idStudent(ID,List,List).


maxStudentGrade(X,MG):-
       idStudent(X,L),
       maxElement(L,MG).       idStudent(ID,NewList,List).

idStudent(ID,List,List).


maxStudentGrade(X,MG):-
       idStudent(X,L),
       maxElement(L,MG).



%--------------------------------------------------------------------

%-----------------------------------task 4---------------------------

inttoWORD(Number,Word):-
       Number =:= 0,
       Word = 'zero';
       Number =:= 1,
       Word = 'one';
       Number =:= 2,
       Word ='two';
       Number =:= 3,
       Word = 'three';
       Number =:= 4,
       Word = 'four';
       Number =:= 5,
       Word = 'five';
       Number =:= 6,
       Word = 'six';
       Number =:= 7,
       Word = 'seven';
       Number =:= 8,
       Word = 'eight';
       Number =:= 9,
       Word= 'nine'.


divMod(Number,NumberList):-
       Number < 10,
       inttoWORD(Number,Word),
       Head = Word,
       NumberList = [Head];
       Number >= 10,
       Division is Number // 10,
       Mod is Number mod 10,
       inttoWORD(Division,Word1),
       Head = Word1,
       inttoWORD(Mod,Word2),
       Tail = Word2,
       NumberList = [Head,Tail].

gradeInWords(ID,Course,Words):-
    student(ID,Course,Grades),
    divMod(Grades,Words).

%----------------------------------------------------------------------



% --------------------------------------- task 5 -----------------------

studentcoursesList(ID,List):-
       studentcoursesList(ID,[],List).

studentcoursesList(ID,TempList,List):-
       student(ID,Course,Grades),
       not(Grades<50),
       not(membership(Course,TempList)), !,
       appendLists([Course],TempList,NewList),
       studentcoursesList(ID,NewList,List).

studentcoursesList(ID,List,List).


prerequisitecoursesList(NextCourse,List):-
       prerequisitecoursesList(NextCourse,[],List).

prerequisitecoursesList(NextCourse,TempList,List):-
       prerequisite(FirstCourse,NextCourse),
       not(membership(FirstCourse,TempList)), !,
       appendLists([FirstCourse],TempList,NewList),
       prerequisitecoursesList(FirstCourse,NewList,List).

prerequisitecoursesList(NextCourse,List,List).


isEqual(List1,List2,List):-
       isEqual(List1,List2,[],List).

isEqual(AttendedCourses,[Head|Precourses],TempList,List):-
       not(membership(Head,AttendedCourses)), !,
       appendLists([Head],TempList,NewList),
       isEqual(AttendedCourses,Precourses,NewList,List).

isEqual(List1,List2,List,List).


remainingCourses(ID,NextCourse,List):-
       remainingCourses(ID,NextCourse,[],List).

remainingCourses(ID,NextCourse,TempList,List):-
       studentcoursesList(ID,AttendedCourses),
       prerequisitecoursesList(NextCourse,Precourses),
       listCounter(Precourses,PrecoursesLength),
       sorting(Precourses,ResultedPrecourses),
       isEqual(AttendedCourses,ResultedPrecourses,TempList,List),
       listCounter(List,AttendedCoursesLength),
       PrecoursesLength =:= AttendedCoursesLength,!,fail;

       studentcoursesList(ID,AttendedCourses),
       prerequisitecoursesList(NextCourse,Precourses),
       sorting(Precourses,ResultedPrecourses),
       isEqual(AttendedCourses,ResultedPrecourses,TempList,List).

remainingCourses(ID,FirstCourse,List,List).

%------------------------------------------------------------------




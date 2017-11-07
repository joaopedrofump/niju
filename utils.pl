%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/utils.pl').

not(X) :- X, !, fail.
not(_).

%Replaces Elements of a List and returns a new List
  %param Old - element to be replaced
  %param New - new Element
  %param InitialList - Inital List
  %param FinalList - Final list with the elements replaced

replace(Old,New,InitialList,FinalList) :-
  replace(Old,New,InitialList,[],FinalList).

replace(_,_,[],FinalList, FinalList).

replace(Old, New, InitialList, AuxList, FinalList) :-

  [Old|Rest] = InitialList,
  append(AuxList,[New],AuxList2),
  replace(Old,New,Rest,AuxList2,FinalList).

replace(Old, New, InitialList, AuxList, FinalList) :-

  [Some|Rest] = InitialList,
  Some \= Old,
  append(AuxList,[Some],AuxList2),
  replace(Old,New,Rest,AuxList2,FinalList).

replaceInPosition(List,NewList,Position,Element) :-

  replaceInPosition(List, NewList, [], Position, 0, Element).

replaceInPosition(List, NewList, ListAux, Position, Position, Element) :-

  [_|T] = List,
  append(ListAux, [Element], ListAux2),
  append(ListAux2, T, NewList).


replaceInPosition(List, NewList, ListAux, Position, PositionAux, Element) :-

  write('List Aux: '),
  write(ListAux),nl,
  write('Position Aux: '),
  write(PositionAux),nl,

  Position > PositionAux,
  [H|T] = List,
  append(ListAux,[H],ListAux2),
  NewPosition is PositionAux + 1,
  replaceInPosition(T, NewList, ListAux2, Position, NewPosition, Element).

 %Remove one element of a list, the first that is found
  %param Element - Element to be removed
  %param InitialList - Inital List
  %param FinalList - Final list with the element removed

remove(Element, InitialList, FinalList) :-

  append(Left,[Element|Right],InitialList),
  append(Left,Right,FinalList).

createRow(NumberOfColumns,Cell,Row) :-

  createRow(NumberOfColumns,0,Cell,[],Row).

createRow(NumberOfColumns,NumberOfColumns,_,Row,Row).

createRow(NumberOfColumns, N,Cell ,RowAux, Row) :-

  append(RowAux,[Cell],NewRow),
  Next is N +1,
  createRow(NumberOfColumns,Next,Cell,NewRow,Row).

%Inserts one row of elements in the beggining of a matrix with the same size of the first row
  %param MatrixBefore - Initial Matrix
  %param MatrixAfter - Matrix after insertion
  %param Cell - The row is build with this element

insertRowBeggining(MatrixBefore,MatrixAfter,Cell) :-

  [Row|_] = MatrixBefore,
  length(Row,Length),
  createRow(Length, Cell, RowToInsert),
  append([RowToInsert],MatrixBefore,MatrixAfter).

%Inserts one row of elements in the end of a matrix with the same size of the first row
  %param MatrixBefore - Initial Matrix
  %param MatrixAfter - Matrix after insertion
  %param Cell - The row is build with this element
insertRowEnd(MatrixBefore,MatrixAfter,Cell) :-

  [Row|_] = MatrixBefore,
  length(Row,Length),
  createRow(Length, Cell, RowToInsert),
  append(MatrixBefore,[RowToInsert],MatrixAfter).

%Inserts one column of elements in the beggining of a matrix
  %param MatrixBefore - Initial Matrix
  %param MatrixAfter - Matrix after insertion
  %param Cell - The column is build with this element
insertColumnBeggining(MatrixBefore,MatrixAfter,Cell) :-

  insertColumnBeggining(MatrixBefore,MatrixAfter,[],Cell).

insertColumnBeggining([],MatrixAfter,MatrixAfter,_).

insertColumnBeggining(MatrixBefore,MatrixAfter,MatrixAux,Cell) :-

  [CurrentRow|Rest] = MatrixBefore,
  append([Cell],CurrentRow,NewRow),
  append(MatrixAux,[NewRow],MatrixAux2),
  insertColumnBeggining(Rest,MatrixAfter,MatrixAux2,Cell).

%Inserts one column of elements in the end of a matrix
  %param MatrixBefore - Initial Matrix
  %param MatrixAfter - Matrix after insertion
  %param Cell - The column is build with this element
insertColumnEnd(MatrixBefore,MatrixAfter,Cell) :-

  insertColumnEnd(MatrixBefore,MatrixAfter,[],Cell).

insertColumnEnd([],MatrixAfter,MatrixAfter,_).

insertColumnEnd(MatrixBefore,MatrixAfter,MatrixAux,Cell) :-

  [CurrentRow|Rest] = MatrixBefore,
  append(CurrentRow,[Cell],NewRow),
  append(MatrixAux,[NewRow],MatrixAux2),
  insertColumnEnd(Rest,MatrixAfter,MatrixAux2,Cell).


getMatrixElement(Matrix,Element, Row, Column) :-

  nth0(Row, Matrix, NthRow),
  nth0(Column, NthRow, Element).

replaceMatrixElement(Matrix, NewMatrix, Row, Column, NewElement) :-

  nth0(Row, Matrix, NthRow),
  replaceInPosition(NthRow, NewRow, Column, NewElement),
  replaceInPosition(Matrix, NewMatrix, Row, NewRow).


%
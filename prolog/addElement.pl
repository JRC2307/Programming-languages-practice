addElement(H, T, [H|T]).

addElementHard(Element,[],[Element]).
addElementHard(Element, [H|T][H,NewT]):-
  addElementHard((Element,T,NewT))

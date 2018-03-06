/* define KB */
greeting(["Hello! My name is Eliza. Please state your problem"]).

noun(["you"]).
noun(["me"]).
noun(["he"]).
noun(["she"]).
noun(["it"]).

negation(["no"]).
negation(["not"]).
negation(["i dont"]).

affirm(["yes"]).
affirm(["aye"]).
affirm(["i do"]).

goodbye(["Bye!!"]).

love(["love you"]).
/* start rules */


no_match(["im not sure i fully understand you when you say: "], Query).

no_match(["please go on"]).

no_match(["can you elaborate on that?"], Query).


negation_res(["you seem quite negative about that"]).

negation_res(["why do you say you", Neg, QueryT).

affirm_res(["you seem quite negative about that"]).
affirm_res(["why do you say you"], Pos, QueryT).

love_res(["I'm sorry, i am not capable of loving"]).

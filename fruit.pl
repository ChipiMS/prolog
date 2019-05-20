:- module(
  fruit,
  [
    add_fruit/3, % +Name:atom, +Price:float, +Color:atom
    current_fruit/3 % ?Name:atom, ?Price:float, ?Color:atom
  ]
).

:- use_module(library(persistency)).

:- persistent(fruit(name:atom, price:float, color:atom)).

:- initialization(db_attach('fruit1.pl', [])).

add_fruit(Name, Price, Color):-
  with_mutex(fruit_db, assert_fruit(Name, Price, Color)).

current_fruit(Name, Price, Color):-
  with_mutex(fruit_db, fruit(Name, Price, Color)).
-module (pricer_test).

-include_lib ("eunit/include/eunit.hrl").

price_over_one_day_test () ->
    OneDay = {tuesday(), wednesday()},
    ?assertEqual (110.0, r(pricer: price (OneDay, 100, 10))).

price_over_3_days_test () ->
    ThreeDays = {tuesday(), friday()},
    ?assertEqual (133.1, r(pricer: price (ThreeDays, 100, 10))).

price_over_weekend_test () ->
    OverWeekend = {friday(), monday()},
    ?assertEqual (110.0, r(pricer: price (OverWeekend, 100, 10))).


tuesday()   -> {2015,4,7}.
wednesday() -> {2015,4,8}.
friday()    -> {2015,4,10}.
monday()    -> {2015,4,13}.
    

r (X) ->
    floor (X * 10000) / 10000.

floor (X) when X < 0 ->
    T = trunc (X),
    case X - T == 0 of
        true -> T;
        false -> T - 1
    end;
floor (X) -> 
    trunc (X).

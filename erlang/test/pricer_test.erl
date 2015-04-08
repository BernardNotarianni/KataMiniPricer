-module (pricer_test).

-include_lib ("eunit/include/eunit.hrl").


price_over_one_day_test () ->
    ?assertEqual (110.0, r(pricer: price (1, 100, 10))).

price_over_3_days_test () ->
    ?assertEqual (133.1, r(pricer: price (3, 100, 10))).

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

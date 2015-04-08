-module (pricer).

-export ([price/3]).

price (0, InitialPrice, _) ->
    InitialPrice;
price (N, InitialPrice, Volatility) ->
    price (N-1, InitialPrice, Volatility) * (1 + Volatility/100.0).




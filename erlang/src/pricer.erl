-module (pricer).

-export ([price/3]).

price ({Today,Today}, InitialPrice, _) ->
    InitialPrice;
price ({Today,PriceDate}, InitialPrice, Volatility) ->
    Cal = mini_calendar: new (),
    NextOpenDay = mini_calendar: next_open_day (Today, Cal),
    price ({NextOpenDay, PriceDate}, InitialPrice, Volatility) * (1 + Volatility/100.0).

-module (pricer).

-export ([price/3]).

price ({Start,End}, InitialPrice, Volatility) ->
    price ({Start,End,[]}, InitialPrice, Volatility);

price ({Today,Today,_}, InitialPrice, _) ->
    InitialPrice;
price ({Today,PriceDate,Hollidays}, InitialPrice, Volatility) ->
    Cal = mini_calendar: new (Hollidays),
    NextOpenDay = mini_calendar: next_open_day (Today, Cal),
    price ({NextOpenDay, PriceDate, Hollidays}, InitialPrice, Volatility)
        * (1 + Volatility/100.0).

# Get day sessions

Get day sessions

## Usage

``` r
get_day_sessions(day, ev_models, connection_log, energy_log, charging_powers)
```

## Arguments

- day:

  Date to simulate

- ev_models:

  profiles models

- connection_log:

  Logical, true if connection models have logarithmic transformations

- energy_log:

  Logical, true if energy models have logarithmic transformations

- charging_powers:

  tibble with variables `power` and `ratio` The powers must be in kW and
  the ratios between 0 and 1.

## Value

tibble

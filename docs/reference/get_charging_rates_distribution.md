# Charging rates distribution

Get charging rates distribution in percentages from a charging sessions
data set

## Usage

``` r
get_charging_rates_distribution(sessions, unit = "year", power_interval = NULL)
```

## Arguments

- sessions:

  tibble, sessions data set in standard format marked by `{evprof}`
  package

- unit:

  character. Valid base units are `second`, `minute`, `hour`, `day`,
  `week`, `month`, `bimonth`, `quarter`, `season`, `halfyear` and
  `year`. It corresponds to `unit` parameter in
  [`lubridate::floor_date`](https://lubridate.tidyverse.org/reference/round_date.html)
  function.

- power_interval:

  numeric, interval of kW between power rates. It is used to round the
  `Power` values into this interval resolution. It can also be `NULL` to
  use all the original `Power` values.

## Value

tibble

## Examples

``` r
get_charging_rates_distribution(evsim::california_ev_sessions, unit = "year")
#> # A tibble: 2,434 × 4
#>    datetime            power     n    ratio
#>    <dttm>              <dbl> <int>    <dbl>
#>  1 2018-01-01 00:00:00  0.23     1 0.000341
#>  2 2018-01-01 00:00:00  0.38     1 0.000341
#>  3 2018-01-01 00:00:00  0.4      1 0.000341
#>  4 2018-01-01 00:00:00  0.43     2 0.000681
#>  5 2018-01-01 00:00:00  0.49     1 0.000341
#>  6 2018-01-01 00:00:00  0.5      1 0.000341
#>  7 2018-01-01 00:00:00  0.52     1 0.000341
#>  8 2018-01-01 00:00:00  0.54     1 0.000341
#>  9 2018-01-01 00:00:00  0.56     1 0.000341
#> 10 2018-01-01 00:00:00  0.57     2 0.000681
#> # ℹ 2,424 more rows

```

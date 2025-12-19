# Adapt charging features

Calculate connection and charging times according to energy, power and
time resolution

## Usage

``` r
adapt_charging_features(
  sessions,
  time_resolution = 15,
  power_resolution = 0.01
)
```

## Arguments

- sessions:

  tibble, sessions data set in standard format marked by `{evprof}`
  package. The minimum required variables are:

  - `ConnectionStartDateTime` (POSIXct)

  - `ConnectionHours` (numeric)

  - `Power` (numeric)

  - `Energy` (numeric)

- time_resolution:

  integer, time resolution (in minutes) of the sessions' datetime
  variables

- power_resolution:

  numeric, power resolution (in kW) of the sessions' power

## Value

tibble

## Details

All sessions' `Power` must be higher than `0`, to avoid `NaN` values
from dividing by zero. The `ConnectionStartDateTime` is first aligned to
the desired time resolution, and the `ConnectionEndDateTime` is
calculated according to the `ConnectionHours`. The `ChargingHours` is
recalculated with the values of `Energy` and `Power`, limited by
`ConnectionHours`. Finally, the charging times are also calculated.

## Examples

``` r
suppressMessages(library(dplyr))

sessions <- head(evsim::california_ev_sessions, 10)

sessions %>%
  select(ConnectionStartDateTime, ConnectionEndDateTime, Power)
#> # A tibble: 10 × 3
#>    ConnectionStartDateTime ConnectionEndDateTime Power
#>    <dttm>                  <dttm>                <dbl>
#>  1 2018-10-08 06:25:00     2018-10-08 17:06:00    0.6 
#>  2 2018-10-08 06:35:00     2018-10-08 17:44:00    2.19
#>  3 2018-10-08 06:59:00     2018-10-08 17:28:00    2.53
#>  4 2018-10-08 07:07:00     2018-10-08 17:13:00    0.76
#>  5 2018-10-08 07:07:00     2018-10-08 17:22:00    2.09
#>  6 2018-10-08 07:20:00     2018-10-08 17:37:00    0.5 
#>  7 2018-10-08 07:20:00     2018-10-08 17:51:00    0.87
#>  8 2018-10-08 07:27:00     2018-10-08 18:02:00    1.71
#>  9 2018-10-08 07:34:00     2018-10-08 17:20:00    1.66
#> 10 2018-10-08 07:36:00     2018-10-08 17:09:00    6.17

adapt_charging_features(
  sessions,
  time_resolution = 60,
  power_resolution = 0.01
) %>%
  select(ConnectionStartDateTime, ConnectionEndDateTime, Power)
#> # A tibble: 10 × 3
#>    ConnectionStartDateTime ConnectionEndDateTime Power
#>    <dttm>                  <dttm>                <dbl>
#>  1 2018-10-08 06:00:00     2018-10-08 16:40:00    0.6 
#>  2 2018-10-08 07:00:00     2018-10-08 18:09:00    2.19
#>  3 2018-10-08 07:00:00     2018-10-08 17:28:00    2.53
#>  4 2018-10-08 07:00:00     2018-10-08 17:05:00    0.76
#>  5 2018-10-08 07:00:00     2018-10-08 17:15:00    2.09
#>  6 2018-10-08 07:00:00     2018-10-08 17:16:00    0.5 
#>  7 2018-10-08 07:00:00     2018-10-08 17:31:00    0.87
#>  8 2018-10-08 07:00:00     2018-10-08 17:34:00    1.71
#>  9 2018-10-08 08:00:00     2018-10-08 17:46:00    1.66
#> 10 2018-10-08 08:00:00     2018-10-08 17:33:00    6.17

adapt_charging_features(
  sessions,
  time_resolution = 15,
  power_resolution = 1
) %>%
  select(ConnectionStartDateTime, ConnectionEndDateTime, Power)
#> Warning: 1 sessions have been removed from the dataset because `Power`, `Energy`, 
#>       `ConnectionHours` or `ChargingHours` were 0 or lower.
#> # A tibble: 9 × 3
#>   ConnectionStartDateTime ConnectionEndDateTime Power
#>   <dttm>                  <dttm>                <dbl>
#> 1 2018-10-08 06:30:00     2018-10-08 17:10:00       1
#> 2 2018-10-08 06:30:00     2018-10-08 17:39:00       2
#> 3 2018-10-08 07:00:00     2018-10-08 17:28:00       3
#> 4 2018-10-08 07:00:00     2018-10-08 17:05:00       1
#> 5 2018-10-08 07:00:00     2018-10-08 17:15:00       2
#> 6 2018-10-08 07:15:00     2018-10-08 17:46:00       1
#> 7 2018-10-08 07:30:00     2018-10-08 18:04:00       2
#> 8 2018-10-08 07:30:00     2018-10-08 17:16:00       2
#> 9 2018-10-08 07:30:00     2018-10-08 17:03:00       6

```

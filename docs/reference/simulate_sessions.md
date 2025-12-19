# Simulation of EV sessions

Simulate EV charging sessions given the `evmodel` object and other
contextual parameters.

## Usage

``` r
simulate_sessions(
  evmodel,
  sessions_day,
  user_profiles,
  charging_powers,
  dates,
  resolution
)
```

## Arguments

- evmodel:

  object of class `evmodel` built with `{evprof}`

- sessions_day:

  tibble with variables `time_cycle` (names corresponding to
  `evmodel$models$time_cycle`) and `n_sessions` (number of daily
  sessions per day for each time-cycle model)

- user_profiles:

  tibble with variables `time_cycle`, `profile`, `ratio` and optionally
  `power`. It can also be `NULL` to use the `evmodel` original user
  profiles distribution. The powers must be in kW and the ratios between
  0 and 1. The user profiles with a value of `power` will be simulated
  with this specific charging power. If `power` is `NA` then it is
  simulated according to the ratios of next parameter `charging_powers`.

- charging_powers:

  tibble with variables `power` and `ratio`. The powers must be in kW
  and the ratios between 0 and 1. This is used to simulate the charging
  power of user profiles without a specific charging power in
  `user_profiles` parameter.

- dates:

  date sequence that will set the time frame of the simulated sessions

- resolution:

  integer, time resolution (in minutes) of the sessions datetime
  variables

## Value

tibble

## Details

Some adaptations have been done to the output of the Gaussian models:
the minimum simulated energy is considered to be 1 kWh, while the
minimum connection duration is 30 minutes.

## Examples

``` r
library(dplyr)
library(lubridate)

# Get the example `evmodel`
ev_model <- evsim::california_ev_model

# Simulate EV charging sessions, considering that the Worktime sessions
# during Workdays have 11 kW, while all Visit sessions charge at 3.7kW or
# 11kW, with a distribution of 30% and 70% respectively.

simulate_sessions(
  ev_model,
  sessions_day = tibble(
    time_cycle = c("Workday", "Weekend"),
    n_sessions = c(15, 10)
  ),
  user_profiles = tibble(
    time_cycle = c("Workday", "Workday", "Weekend"),
    profile = c("Visit", "Worktime", "Visit"),
    ratio = c(0.5, 0.5, 1),
    power = c(NA, 11, NA)
  ),
  charging_powers = tibble(
    power = c(3.7, 11),
    ratio = c(0.3, 0.7)
  ),
  dates = seq.Date(today(), today()+days(4), length.out = 4),
  resolution = 15
)
#> # A tibble: 55 × 11
#>    Session Timecycle Profile  ConnectionStartDateTime ConnectionEndDateTime
#>    <chr>   <chr>     <chr>    <dttm>                  <dttm>               
#>  1 S1      Workday   Visit    2025-12-19 06:00:00     2025-12-19 10:49:00  
#>  2 S2      Workday   Worktime 2025-12-19 06:15:00     2025-12-19 16:01:00  
#>  3 S3      Workday   Worktime 2025-12-19 06:30:00     2025-12-19 15:56:00  
#>  4 S4      Workday   Worktime 2025-12-19 07:30:00     2025-12-19 18:29:00  
#>  5 S5      Workday   Visit    2025-12-19 07:30:00     2025-12-19 12:46:00  
#>  6 S6      Workday   Worktime 2025-12-19 07:30:00     2025-12-19 18:40:00  
#>  7 S7      Workday   Worktime 2025-12-19 08:00:00     2025-12-19 16:49:00  
#>  8 S8      Workday   Worktime 2025-12-19 08:00:00     2025-12-19 16:08:00  
#>  9 S9      Workday   Visit    2025-12-19 08:45:00     2025-12-19 10:33:00  
#> 10 S10     Workday   Worktime 2025-12-19 09:45:00     2025-12-19 20:03:00  
#> # ℹ 45 more rows
#> # ℹ 6 more variables: ChargingStartDateTime <dttm>, ChargingEndDateTime <dttm>,
#> #   Power <dbl>, Energy <dbl>, ConnectionHours <dbl>, ChargingHours <dbl>
```

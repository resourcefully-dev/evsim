# Time-series EV occupancy

Obtain time-series of simultaneously connected EVs from sessions data
set

## Usage

``` r
get_occupancy(sessions, dttm_seq = NULL, by = "Profile", resolution = 15)
```

## Arguments

- sessions:

  tibble, sessions data set in standard format marked by `{evprof}`
  package

- dttm_seq:

  sequence of datetime values that will be the `datetime` variable of
  the returned time-series data frame.

- by:

  character, being 'Profile' or 'Session'. When `by='Profile'` each
  column corresponds to an EV user profile.

- resolution:

  integer, time resolution (in minutes) of the sessions datetime
  variables. If `dttm_seq` is defined this parameter is ignored.

## Value

time-series tibble with first column of type `datetime`

## Details

Note that the time resolution of variable `ConnectionStartDateTime` must
coincide with `resolution` parameter. For example, if a charging session
in `sessions` starts charging at 15:32 and `resolution = 15`, the load
of this session won't be computed. To solve this, the function
automatically aligns charging sessions' start time according to
`resolution`, so following the previous example the session would start
at 15:30.

## Examples

``` r
library(lubridate)
library(dplyr)

# Get occupancy with the complete datetime sequence from the sessions
sessions <- head(evsim::california_ev_sessions, 100)
connections <- get_occupancy(
  sessions,
  by = "ChargingStation",
  resolution = 60
)
#> Warning: charging sessions have been aligned to 60-minute resolution.
print(connections)
#> # A tibble: 73 × 50
#>    datetime            `1-1-193-816` `1-1-179-810` `1-1-179-777` `1-1-179-791`
#>    <dttm>                      <int>         <int>         <int>         <int>
#>  1 2018-10-08 00:00:00             0             0             0             0
#>  2 2018-10-08 01:00:00             0             0             0             0
#>  3 2018-10-08 02:00:00             0             0             0             0
#>  4 2018-10-08 03:00:00             0             0             0             0
#>  5 2018-10-08 04:00:00             0             0             0             0
#>  6 2018-10-08 05:00:00             0             0             0             0
#>  7 2018-10-08 06:00:00             1             0             0             0
#>  8 2018-10-08 07:00:00             1             1             1             1
#>  9 2018-10-08 08:00:00             1             1             1             1
#> 10 2018-10-08 09:00:00             1             1             1             1
#> # ℹ 63 more rows
#> # ℹ 45 more variables: `1-1-179-799` <int>, `1-1-179-796` <int>,
#> #   `1-1-179-794` <int>, `1-1-191-803` <int>, `1-1-191-795` <int>,
#> #   `1-1-191-778` <int>, `1-1-191-784` <int>, `1-1-191-792` <int>,
#> #   `1-1-191-804` <int>, `1-1-191-812` <int>, `1-1-191-808` <int>,
#> #   `1-1-191-785` <int>, `1-1-179-815` <int>, `1-1-179-788` <int>,
#> #   `1-1-194-826` <int>, `1-1-193-819` <int>, `1-1-178-824` <int>, …

# Get occupancy with a custom datetime sequence and resolution of 15 minutes
sessions <- head(evsim::california_ev_sessions_profiles, 100)
dttm_seq <- seq.POSIXt(
  as_datetime(dmy(08102018)) %>% force_tz(tz(sessions$ConnectionStartDateTime)),
  as_datetime(dmy(11102018)) %>% force_tz(tz(sessions$ConnectionStartDateTime)),
  by = "15 mins"
)
connections <- get_occupancy(
  sessions,
  dttm_seq = dttm_seq,
  by = "Profile"
)
#> Warning: charging sessions have been aligned to 15-minute resolution.
print(connections)
#> # A tibble: 289 × 3
#>    datetime            Worktime Visit
#>    <dttm>                 <int> <int>
#>  1 2018-10-08 00:00:00        0     0
#>  2 2018-10-08 00:15:00        0     0
#>  3 2018-10-08 00:30:00        0     0
#>  4 2018-10-08 00:45:00        0     0
#>  5 2018-10-08 01:00:00        0     0
#>  6 2018-10-08 01:15:00        0     0
#>  7 2018-10-08 01:30:00        0     0
#>  8 2018-10-08 01:45:00        0     0
#>  9 2018-10-08 02:00:00        0     0
#> 10 2018-10-08 02:15:00        0     0
#> # ℹ 279 more rows
```

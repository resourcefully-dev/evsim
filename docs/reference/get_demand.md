# Time-series EV demand

Obtain time-series of EV demand from sessions data set

## Usage

``` r
get_demand(sessions, dttm_seq = NULL, by = "Profile", resolution = 15)
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

Note that the time resolution of variables `ConnectionStartDateTime` and
`ChargingStartDateTime` must coincide with `resolution` parameter. For
example, if a charging session in `sessions` starts charging at 15:32
and `resolution = 15`, the load of this session won't be computed. To
solve this, the function automatically aligns charging sessions' start
time according to `resolution`, so following the previous example the
session would start at 15:30.

## Examples

``` r
suppressMessages(library(lubridate))
suppressMessages(library(dplyr))

# Get demand with the complete datetime sequence from the sessions
sessions <- head(evsim::california_ev_sessions, 100)
demand <- get_demand(
  sessions,
  by = "Session",
  resolution = 60
)
#> Warning: charging sessions have been aligned to 60-minute resolution.
print(demand)
#> # A tibble: 73 × 101
#>    datetime               S1   S10  S100   S11   S12   S13   S14   S15   S16
#>    <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 2018-10-08 00:00:00   0    0        0  0     0     0     0     0        0
#>  2 2018-10-08 01:00:00   0    0        0  0     0     0     0     0        0
#>  3 2018-10-08 02:00:00   0    0        0  0     0     0     0     0        0
#>  4 2018-10-08 03:00:00   0    0        0  0     0     0     0     0        0
#>  5 2018-10-08 04:00:00   0    0        0  0     0     0     0     0        0
#>  6 2018-10-08 05:00:00   0    0        0  0     0     0     0     0        0
#>  7 2018-10-08 06:00:00   0.6  0        0  0     0     0     0     0        0
#>  8 2018-10-08 07:00:00   0.6  0        0  0     0     0     0     0        0
#>  9 2018-10-08 08:00:00   0.6  6.17     0  2.04  0.78  1.58  1.36  1.52     0
#> 10 2018-10-08 09:00:00   0.6  6.17     0  2.04  0.78  1.58  1.36  1.52     0
#> # ℹ 63 more rows
#> # ℹ 91 more variables: S17 <dbl>, S18 <dbl>, S19 <dbl>, S2 <dbl>, S20 <dbl>,
#> #   S21 <dbl>, S22 <dbl>, S23 <dbl>, S24 <dbl>, S25 <dbl>, S26 <dbl>,
#> #   S27 <dbl>, S28 <dbl>, S29 <dbl>, S3 <dbl>, S30 <dbl>, S31 <dbl>, S32 <dbl>,
#> #   S33 <dbl>, S34 <dbl>, S35 <dbl>, S36 <dbl>, S37 <dbl>, S38 <dbl>,
#> #   S39 <dbl>, S4 <dbl>, S40 <dbl>, S41 <dbl>, S42 <dbl>, S43 <dbl>, S44 <dbl>,
#> #   S45 <dbl>, S46 <dbl>, S47 <dbl>, S48 <dbl>, S49 <dbl>, S5 <dbl>, …

# Get demand with a custom datetime sequence and resolution of 15 minutes
sessions <- head(evsim::california_ev_sessions_profiles, 100)
dttm_seq <- seq.POSIXt(
  as_datetime(dmy(08102018)) %>% force_tz(tz(sessions$ConnectionStartDateTime)),
  as_datetime(dmy(11102018)) %>% force_tz(tz(sessions$ConnectionStartDateTime)),
  by = "15 mins"
)
demand <- get_demand(
  sessions,
  dttm_seq = dttm_seq,
  by = "Profile",
  resolution = 15
)
#> Warning: charging sessions have been aligned to 15-minute resolution.
print(demand)
#> # A tibble: 289 × 3
#>    datetime            Worktime Visit
#>    <dttm>                 <dbl> <dbl>
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

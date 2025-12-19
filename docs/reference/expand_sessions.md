# Expand sessions along time slots

Every session in `sessions` is divided in multiple time slots with the
corresponding `Power` consumption, among other variables.

## Usage

``` r
expand_sessions(sessions, resolution)
```

## Arguments

- sessions:

  tibble, sessions data set in standard format marked by `evprof`
  package

- resolution:

  integer, time resolution (in minutes) of the time slots

## Value

tibble

## Details

The `Power` value is calculated for every time slot according to the
original required energy. The columns `PowerNominal`, `EnergyRequired`
and `FlexibilityHours` correspond to the values of the original session,
and not to the expanded session in every time slot. The column `ID`
shows the number of the time slot corresponding to the original session.

## Examples

``` r
library(dplyr)

sessions <- head(evsim::california_ev_sessions, 10)
expand_sessions(
  sessions,
  resolution = 60
)
#> # A tibble: 109 × 7
#>    Session Timeslot            Power PowerNominal EnergyRequired
#>    <chr>   <dttm>              <dbl>        <dbl>          <dbl>
#>  1 S1      2018-10-08 06:25:00   0.6          0.6           6.31
#>  2 S1      2018-10-08 07:25:00   0.6          0.6           6.31
#>  3 S1      2018-10-08 08:25:00   0.6          0.6           6.31
#>  4 S1      2018-10-08 09:25:00   0.6          0.6           6.31
#>  5 S1      2018-10-08 10:25:00   0.6          0.6           6.31
#>  6 S1      2018-10-08 11:25:00   0.6          0.6           6.31
#>  7 S1      2018-10-08 12:25:00   0.6          0.6           6.31
#>  8 S1      2018-10-08 13:25:00   0.6          0.6           6.31
#>  9 S1      2018-10-08 14:25:00   0.6          0.6           6.31
#> 10 S1      2018-10-08 15:25:00   0.6          0.6           6.31
#> # ℹ 99 more rows
#> # ℹ 2 more variables: ConnectionHoursLeft <dbl>, ID <int>
```

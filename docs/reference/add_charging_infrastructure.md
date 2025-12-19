# Assign a charging station to EV charging sessions

Variable `ChargingStation` and `Socket`will be assigned to the
`sessions` tibble with a name pattern being: `names_prefix` + "CHS" +
number

## Usage

``` r
add_charging_infrastructure(
  sessions,
  resolution = 15,
  min_stations = 0,
  n_sockets = 2,
  names_prefix = NULL,
  duration_th = 0
)
```

## Arguments

- sessions:

  tibble, sessions data set in standard format marked by `{evprof}`
  package

- resolution:

  integer, time resolution in minutes

- min_stations:

  integer, minimum number of charging stations to consider

- n_sockets:

  integer, number of sockets per charging station

- names_prefix:

  character, prefix of the charging station names (optional)

- duration_th:

  integer between 0 and 100, minimum share of time (in percentage) of
  the "occupancy duration curve" (see function
  `plot_occupancy_duration_curve`). This is used to avoid sizing a
  charging infrastructure to host for example 100 vehicles when only 5%
  of time there are more than 80 vehicles connected. Then, setting
  `duration_th = 5` will ensure that we don't over-size the charging
  infrastructure for the 100 vehicles. It is recommended to find this
  value through multiple iterations.

## Value

tibble

## Examples

``` r
# Assign a `ChargingStation` to every session according to the occupancy
sessions_infrastructure <- add_charging_infrastructure(
  sessions = head(evsim::california_ev_sessions, 50),
  resolution = 60
)
#> Warning: charging sessions have been aligned to 60-minute resolution.
#> Discarded 0 % of sessions due to infrastructure
print(unique(sessions_infrastructure$ChargingStation))
#>  [1] "CHS1"  "CHS2"  "CHS3"  "CHS4"  "CHS5"  "CHS6"  "CHS7"  "CHS8"  "CHS9" 
#> [10] "CHS10" "CHS11" "CHS12" "CHS13" "CHS14"

# Now without considering the occupancy values that only represent
# a 10% of the time
sessions_infrastructure <- add_charging_infrastructure(
  sessions = head(evsim::california_ev_sessions, 50),
  resolution = 60, duration_th = 10
)
#> Warning: charging sessions have been aligned to 60-minute resolution.
#> Discarded 4 % of sessions due to infrastructure
print(unique(sessions_infrastructure$ChargingStation))
#>  [1] "CHS1"  "CHS2"  "CHS3"  "CHS4"  "CHS5"  "CHS6"  "CHS7"  "CHS8"  "CHS9" 
#> [10] "CHS10" "CHS11" "CHS12" "CHS13"

```

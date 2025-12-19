# Plot the occupancy duration curve

This term is based on the "load duration curve" and is useful to see the
behavior of occupancy over the time in your charging installation. The
steeper the curve, the shorter the duration that higher number of
connections are sustained. Conversely, the flatter the curve, the longer
the duration that higher number of connections are sustained. This
information is crucial for various purposes, such as infrastructure
planning, capacity sizing, and resource allocation.

## Usage

``` r
plot_occupancy_duration_curve(
  sessions,
  dttm_seq = NULL,
  by = "Profile",
  resolution = 15
)
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

ggplot

## Examples

``` r
library(dplyr)

sessions <- head(evsim::california_ev_sessions_profiles, 100)
plot_occupancy_duration_curve(
  sessions,
  by = "Profile",
  resolution = 15
)
#> Warning: charging sessions have been aligned to 15-minute resolution.

```

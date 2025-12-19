# Changelog

## evsim 1.7.1

- Bug fix in
  [`get_occupancy()`](https://resourcefully-dev.github.io/evsim/reference/get_occupancy.md)
- Removed `plot_ts()` function which migrated to `timefully` package

## evsim 1.7.0

CRAN release: 2025-10-08

- Replaced multi-core processing from
  [`parallel::mclapply()`](https://rdrr.io/r/parallel/mclapply.html) by
  [`purrr::in_parallel()`](https://purrr.tidyverse.org/reference/in_parallel.html)
  using `mirai` package
- Removed `mc.cores` parameter from all functions since now the parallel
  processing must be defined by the user
- Function
  [`adapt_charging_features()`](https://resourcefully-dev.github.io/evsim/reference/adapt_charging_features.md)
  now filters incorrect sessions and prints a warning

## evsim 1.6.1

CRAN release: 2025-05-07

- Bug fix in `ConnectionHours` calculation
- Bug fix in
  [`get_demand()`](https://resourcefully-dev.github.io/evsim/reference/get_demand.md)
  and
  [`get_occupancy()`](https://resourcefully-dev.github.io/evsim/reference/get_occupancy.md)
  functions
- Bug fix in
  [`adapt_charging_features()`](https://resourcefully-dev.github.io/evsim/reference/adapt_charging_features.md)
  function: need to convert timezone to UTC to avoid NA in summer time
  shift

## evsim 1.6.0

CRAN release: 2024-10-03

- Parameter `align_time` has been removed from all functions in favour
  of internal automatic alignment thanks to introduction of function
  `is_aligned`.
- Changed variable names in `expand_session` function (`NominalPower`
  -\> `PowerNominal`, `RequiredEnergy` -\> `EnergyRequired`)
- Bug fix in `adapt_charging_features` function: `ConnectionHours` now
  rounded to 2 digits to improve accuracy of calculations
- Simulated energy using log-normal distribution with a minimum of 1 kWh
  and simulated connections with a minimum of 30 minute duration, to be
  more realistic.
- Bug fix in
  [`get_evmodel_summary()`](https://resourcefully-dev.github.io/evsim/reference/get_evmodel_summary.md)
- New legend formatting for `plot_ts()`
- Added parameter `n_sockets` to function
  [`add_charging_infrastructure()`](https://resourcefully-dev.github.io/evsim/reference/add_charging_infrastructure.md)
  to specify the number of sockets per charging point

## evsim 1.5.0

CRAN release: 2024-04-11

- In `simulate_sessions` now `user_profiles` can also be `NULL` to use
  the default `evmodel` config.
- Changed `get_ev_model` to `get_custom_ev_model` to avoid using
  auxiliary functions to get GMM from parameters. Thus, the argument
  `parameters_lst` has been introduced to directly use all time-cycles
  parameters, and functions `get_connection_models_from_parameters` and
  `get_energy_models_from_parameters` are now internal and not exported.
- Custom models ratio’s in `parameters_lst` argument of function
  `get_custom_ev_model` must be now between 0 and 1 and not between 0
  and 100, to be consistent with the `evmodel` created by `evprof`.
- Introduced `power_interval` parameter in
  `get_charging_rates_distribution` function. It is used to round the
  `Power` values into this interval resolution. It can also be `NULL` to
  use all the original `Power` values.
- Now `plot_ts` function plots with the data timezone by default with
  [`dygraphs::dyOptions`](https://rdrr.io/pkg/dygraphs/man/dyOptions.html)
  parameter `useDataTimezone=TRUE`.

## evsim 1.4.0

CRAN release: 2024-03-14

- Renamed `get_n_connections` to `get_occupancy`
- Added function `plot_occupancy_duration_curve`
- Removed dependency from `xts` package
- Removed parameter `group` from `plot_ts` function
- Improved reference documentation and examples in multiple functions

## evsim 1.3.0

CRAN release: 2024-02-04

- Improved the efficiency of `get_demand` and `get_n_connections`
- Added function `plot_ts` to plot time-series in a `dygraphs` HTML plot
- Added multi-core processing for Windows distribution
- Energy GMM inside of `evmodel` also contain the `ratio` of every
  `charging_rate`
- Function `expand_sessions` is now exported
- Added functions to create summary tables from `evmodel` object

## evsim 1.2.0

CRAN release: 2024-01-23

- Improved functions for calculating demand and occupancy (now with
  multi-core processing)
- Included more example data
  ([`evsim::california_ev_sessions`](https://resourcefully-dev.github.io/evsim/reference/california_ev_sessions.md)
  and
  [`evsim::california_ev_sessions_profiles`](https://resourcefully-dev.github.io/evsim/reference/california_ev_sessions_profiles.md)).
- Included functions to create a model from Gaussian Mixture Models
  parameters.

## evsim 1.1.0

- Added `read_ev_model` function to read an EV model JSON file generated
  by package [evprof](https://github.com/resourcefully-dev/evprof/)

## evsim 1.0.0

- Bug fix in the `evmodel` class printing function
- Adding California’s EV model as example evmodel
  ([`evsim::california_ev_model`](https://resourcefully-dev.github.io/evsim/reference/california_ev_model.md)).
- Function “simulate_sessions” now requires a “user_profiles” parameter
  with the ratio of every user profile and the optional specific power.
- Add function “get_user_profiles_distribution” to facilitate the
  creation of the newly requested parameter “user_profiles” by function
  “simulate_sessions”
- Remove function `update_profiles_ratios` in favour of
  `prepare_models`. This new function is used inside the
  `simulate_sessions` function using the `sessions_day` and
  `user_profiles` parameters to modify the `evmodel` input.

## evsim 0.1.0

- First release

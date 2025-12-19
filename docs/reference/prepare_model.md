# Prepare the models from the `evmodel` object ready for the simulation

The ratios and default charging power for every user profile, and the
sessions per day for every time cycle are included.

## Usage

``` r
prepare_model(ev_models, sessions_day, user_profiles)
```

## Arguments

- ev_models:

  tibble with models from an `evmodel` object

- sessions_day:

  tibble with variables `time_cycle` (names corresponding to
  `evmodel$models$time_cycle`) and `n_sessions` (number of daily
  sessions per day for each time-cycle model)

- user_profiles:

  tibble with variables `time_cycle`, `user_profile`, `ratio` and
  optionally `power`. The powers must be in kW and the ratios between 0
  and 1. The user profiles with a value of `power` will be simulated
  with this specific charging power. If `power` is `NA` then it is
  simulated according to the ratios of parameter `charging_powers` in
  function. `simulate_sessions`.

## Value

tibble

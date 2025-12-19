# Estimate sessions parameters of a specific profile

Estimate sessions parameters of a specific profile

## Usage

``` r
estimate_sessions(
  profile_name,
  n_sessions,
  power,
  connection_models,
  energy_models,
  connection_log,
  energy_log,
  charging_powers
)
```

## Arguments

- profile_name:

  character, profile name

- n_sessions:

  integer, total number of sessions per day

- power:

  numeric, charging power of the session

- connection_models:

  tibble, bivariate GMM of the profile

- energy_models:

  tibble, univariate GMM of the profile

- connection_log:

  logical, true if connection models have logarithmic transformations

- energy_log:

  logical, true if energy models have logarithmic transformations

- charging_powers:

  tibble with variables `power` and `ratio` The powers must be in kW and
  the ratios between 0 and 1.

## Value

tibble

# Connection GMM

Get connection Gaussian Mixture Models from parameters

## Usage

``` r
get_connection_models_from_parameters(
  time_cycle_parameters,
  connection_log = FALSE
)
```

## Arguments

- time_cycle_parameters:

  tibble with Gaussian Mixture Models parameters. This tibble must have
  the following columns: `profile`, `ratio` (in %), `start_mean` (in
  hours), `start_sd` (in hours), `duration_mean` (in hours),
  `duration_sd` (in hours), `energy_mean` (in kWh), `energy_sd` (in
  kWh).

- connection_log:

  logical, true if connection models have logarithmic transformations

## Value

connection GMM tibble

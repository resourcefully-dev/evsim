# Create the custom EV model

Get the EV model object of class `evmodel`

## Usage

``` r
get_custom_ev_model(
  names,
  months_lst = list(1:12, 1:12),
  wdays_lst = list(1:5, 6:7),
  parameters_lst,
  connection_log,
  energy_log,
  data_tz
)
```

## Arguments

- names:

  character vector with the given names of each time-cycle model

- months_lst:

  list of integer vectors with the corresponding months of the year for
  each time-cycle model

- wdays_lst:

  list of integer vectors with the corresponding days of the week for
  each time-cycle model (week start = 1)

- parameters_lst:

  list of tibbles corresponding to the GMM parameters of every
  time-cycle model

- connection_log:

  logical, true if connection models have logarithmic transformations

- energy_log:

  logical, true if energy models have logarithmic transformations

- data_tz:

  character, time zone of the original data (necessary to properly
  simulate new sessions)

## Value

object of class `evmodel`

## Examples

``` r

# For workdays time cycle
workdays_parameters <- dplyr::tibble(
  profile = c("Worktime", "Visit"),
  ratio = c(80, 20),
  start_mean = c(9, 11),
  start_sd = c(1, 4),
  duration_mean = c(8, 4),
  duration_sd = c(0.5, 2),
  energy_mean = c(15, 6),
  energy_sd = c(4, 3)
)

# For weekends time cycle
weekends_parameters <- dplyr::tibble(
  profile = "Visit",
  ratio = 100,
  start_mean = 12,
  start_sd = 4,
  duration_mean = 3,
  duration_sd = 2,
  energy_mean = 4,
  energy_sd = 4
)

parameters_lst <- list(workdays_parameters, weekends_parameters)

# Get the whole model
ev_model <- get_custom_ev_model(
  names = c("Workdays", "Weekends"),
  months_lst = list(1:12, 1:12),
  wdays_lst = list(1:5, 6:7),
  parameters_lst = parameters_lst,
  connection_log = FALSE,
  energy_log = FALSE,
  data_tz = "Europe/Amsterdam"
)

```

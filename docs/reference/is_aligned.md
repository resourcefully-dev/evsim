# Is the sessions data set aligned in time?

Checks if sessions time variables (only connection/charging start times)
are aligned with a specific time resolution.

## Usage

``` r
is_aligned(sessions, resolution)
```

## Arguments

- sessions:

  tibble, sessions data set in standard format marked by `evprof`
  package

- resolution:

  integer, time resolution (in minutes) of the time slots

## Value

logical

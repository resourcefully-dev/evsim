# Expand a session along time slots within its connection time

The `session` is divided in multiple time slots with the corresponding
`Power` consumption, among other variables.

## Usage

``` r
expand_session(session, resolution)
```

## Arguments

- session:

  tibble, sessions data set in standard format marked by `evprof`
  package

- resolution:

  integer, time resolution (in minutes) of the time slots

## Value

tibble

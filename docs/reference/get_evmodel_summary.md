# Get `evmodel` parameters in a list of summary tables

Every time cycle is an element of the returned list, containing a table
with a user profile in every row and the mean and standard deviation
values of the GMM variables (connection duration, connection start time
and energy). If the energy models were built by charging rate, the
average `mean` and `sd` are provided without taking into account
different charging rates (this information is lost in this summary).

## Usage

``` r
get_evmodel_summary(evmodel)
```

## Arguments

- evmodel:

  object of class `evmodel`

## Value

list

## Examples

``` r
get_evmodel_summary(evsim::california_ev_model)
#> $Workday
#> # A tibble: 2 × 8
#>   profile  ratio start_mean start_sd duration_mean duration_sd energy_mean
#>   <chr>    <dbl>      <dbl>    <dbl>         <dbl>       <dbl>       <dbl>
#> 1 Visit    0.460      11.1      1.02          3.97        1.20        11.8
#> 2 Worktime 0.540       7.11     1.02          9.36        1.02        16.1
#> # ℹ 1 more variable: energy_sd <dbl>
#> 
#> $Weekend
#> # A tibble: 1 × 8
#>   profile ratio start_mean start_sd duration_mean duration_sd energy_mean
#>   <chr>   <int>      <dbl>    <dbl>         <dbl>       <dbl>       <dbl>
#> 1 Visit       1       10.5     1.05          4.30        1.25        13.3
#> # ℹ 1 more variable: energy_sd <dbl>
#> 
```

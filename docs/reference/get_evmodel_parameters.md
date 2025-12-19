# Get `evmodel` parameters in a list

Every time cycle is an element of the returned list, containing a list
with the user profile as elements, each one containing the ratio and the
corresponding tables with the statistic parameters of connection and
energy GMM.

## Usage

``` r
get_evmodel_parameters(evmodel)
```

## Arguments

- evmodel:

  object of class `evmodel`

## Value

list

## Examples

``` r
get_evmodel_parameters(evsim::california_ev_model)
#> $Workday
#> $Workday$Visit
#> $Workday$Visit$ratio
#> [1] 0.4603
#> 
#> $Workday$Visit$connection_models
#> # A tibble: 3 × 5
#>   start_mean start_sd duration_mean duration_sd ratio
#>        <dbl>    <dbl>         <dbl>       <dbl> <dbl>
#> 1      12.2      1.01          4.73        1.09 0.235
#> 2       7.44     1.04          4.66        1.23 0.446
#> 3      15.3      1.01          2.45        1.25 0.319
#> 
#> $Workday$Visit$energy_models
#> # A tibble: 1 × 4
#>   charging_rate energy_mean energy_sd ratio
#>   <chr>               <dbl>     <dbl> <int>
#> 1 Unknown              11.8      1.18     1
#> 
#> 
#> $Workday$Worktime
#> $Workday$Worktime$ratio
#> [1] 0.5397
#> 
#> $Workday$Worktime$connection_models
#> # A tibble: 3 × 5
#>   start_mean start_sd duration_mean duration_sd ratio
#>        <dbl>    <dbl>         <dbl>       <dbl> <dbl>
#> 1       7.31     1.00          9.75        1.01 0.305
#> 2       7.31     1.03          8.90        1.03 0.428
#> 3       6.55     1.01          9.64        1.00 0.267
#> 
#> $Workday$Worktime$energy_models
#> # A tibble: 1 × 4
#>   charging_rate energy_mean energy_sd ratio
#>   <chr>               <dbl>     <dbl> <int>
#> 1 Unknown              16.1      1.14     1
#> 
#> 
#> 
#> $Weekend
#> $Weekend$Visit
#> $Weekend$Visit$ratio
#> [1] 1
#> 
#> $Weekend$Visit$connection_models
#> # A tibble: 2 × 5
#>   start_mean start_sd duration_mean duration_sd ratio
#>        <dbl>    <dbl>         <dbl>       <dbl> <dbl>
#> 1       7.54     1.01          7.23        1.07 0.205
#> 2      11.3      1.06          3.55        1.30 0.795
#> 
#> $Weekend$Visit$energy_models
#> # A tibble: 1 × 4
#>   charging_rate energy_mean energy_sd ratio
#>   <chr>               <dbl>     <dbl> <int>
#> 1 Unknown              13.3      1.49     1
#> 
#> 
#> 
```

# User profiles distribution

Get the user profiles distribution from the original data set used to
build the model

## Usage

``` r
get_user_profiles_distribution(evmodel)
```

## Arguments

- evmodel:

  object of class `evmodel`

## Value

tibble

## Examples

``` r
get_user_profiles_distribution(evsim::california_ev_model)
#> # A tibble: 3 × 3
#>   time_cycle profile  ratio
#>   <chr>      <chr>    <dbl>
#> 1 Workday    Visit    0.460
#> 2 Workday    Worktime 0.540
#> 3 Weekend    Visit    1    
```

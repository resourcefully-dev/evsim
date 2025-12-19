# Custom evmodel

## Simplifying our model

The `evmodel` object obtained with `evprof` contains all statistic
parameters of the Gaussian Mixture Models for both connection and energy
models (see [this
article](https://resourcefully-dev.github.io/evprof/articles/evmodel.html)).
However, these GMM can be quite complex with a lot of clusters
(mixtures) and the JSON file describing the model can result in a large
file.

To check the complexity of the models and describe all parameters within
the JSON file, the function `get_evmodel_parameters` provides the model
parameters in a `list` form:

``` r

ev_model <- evsim::california_ev_model
get_evmodel_parameters(ev_model)
```

    ## $Workday
    ## $Workday$Visit
    ## $Workday$Visit$ratio
    ## [1] 0.4603
    ## 
    ## $Workday$Visit$connection_models
    ## # A tibble: 3 × 5
    ##   start_mean start_sd duration_mean duration_sd ratio
    ##        <dbl>    <dbl>         <dbl>       <dbl> <dbl>
    ## 1      12.2      1.01          4.73        1.09 0.235
    ## 2       7.44     1.04          4.66        1.23 0.446
    ## 3      15.3      1.01          2.45        1.25 0.319
    ## 
    ## $Workday$Visit$energy_models
    ## # A tibble: 1 × 4
    ##   charging_rate energy_mean energy_sd ratio
    ##   <chr>               <dbl>     <dbl> <int>
    ## 1 Unknown              11.8      1.18     1
    ## 
    ## 
    ## $Workday$Worktime
    ## $Workday$Worktime$ratio
    ## [1] 0.5397
    ## 
    ## $Workday$Worktime$connection_models
    ## # A tibble: 3 × 5
    ##   start_mean start_sd duration_mean duration_sd ratio
    ##        <dbl>    <dbl>         <dbl>       <dbl> <dbl>
    ## 1       7.31     1.00          9.75        1.01 0.305
    ## 2       7.31     1.03          8.90        1.03 0.428
    ## 3       6.55     1.01          9.64        1.00 0.267
    ## 
    ## $Workday$Worktime$energy_models
    ## # A tibble: 1 × 4
    ##   charging_rate energy_mean energy_sd ratio
    ##   <chr>               <dbl>     <dbl> <int>
    ## 1 Unknown              16.1      1.14     1
    ## 
    ## 
    ## 
    ## $Weekend
    ## $Weekend$Visit
    ## $Weekend$Visit$ratio
    ## [1] 1
    ## 
    ## $Weekend$Visit$connection_models
    ## # A tibble: 2 × 5
    ##   start_mean start_sd duration_mean duration_sd ratio
    ##        <dbl>    <dbl>         <dbl>       <dbl> <dbl>
    ## 1       7.54     1.01          7.23        1.07 0.205
    ## 2      11.3      1.06          3.55        1.30 0.795
    ## 
    ## $Weekend$Visit$energy_models
    ## # A tibble: 1 × 4
    ##   charging_rate energy_mean energy_sd ratio
    ##   <chr>               <dbl>     <dbl> <int>
    ## 1 Unknown              13.3      1.49     1

Even though the California EV model doesn’t have a lot of clusters the
composition of the model is complex enough, and the logarithmic scale
makes it difficult to interpret. Therefore, the `evsim` package also
provides a function to simplify the clusters calculating the average
connection and energy pattern for every user profile, converting the
logarithmic values to the natural scale:

``` r

get_evmodel_summary(ev_model)
```

    ## $Workday
    ## # A tibble: 2 × 8
    ##   profile  ratio start_mean start_sd duration_mean duration_sd energy_mean
    ##   <chr>    <dbl>      <dbl>    <dbl>         <dbl>       <dbl>       <dbl>
    ## 1 Visit    0.460      11.1      1.02          3.97        1.20        11.8
    ## 2 Worktime 0.540       7.11     1.02          9.36        1.02        16.1
    ## # ℹ 1 more variable: energy_sd <dbl>
    ## 
    ## $Weekend
    ## # A tibble: 1 × 8
    ##   profile ratio start_mean start_sd duration_mean duration_sd energy_mean
    ##   <chr>   <int>      <dbl>    <dbl>         <dbl>       <dbl>       <dbl>
    ## 1 Visit       1       10.5     1.05          4.30        1.25        13.3
    ## # ℹ 1 more variable: energy_sd <dbl>

Now we can see that every time-cycle is defined by a simple user profile
with an average behaviour. This format is also useful to save the model
in Excel, since it can be saved directly in an Excel file where every
time-cycle will be a different worksheet:

``` r

get_evmodel_summary(ev_model) %>% 
  writexl::write_xlsx("ev_model.xlsx")
```

## Designing a custom model

Moreover, sometimes maybe it is desired to build a custom model with
specific average connection start time and duration and average energy
charged. In this case, the Excel file created with the previous command
can be used as a template to define our custom user profiles and
parameters. After editing the file we can read it again:

``` r

custom_model <- purrr::map(
  readxl::excel_sheets("ev_model_custom.xlsx") %>% purrr::set_names(),
  ~ readxl::read_excel("ev_model_custom.xlsx", sheet = .x)
)
```

Then, these parameters can be passed to argument `parameters_lst` of
function
[`evsim::get_custom_ev_model`](https://resourcefully-dev.github.io/evsim/reference/get_custom_ev_model.md),
where every element of this list must be a different time-cycle (as our
object `custom_model` is). In the
[`evsim::get_custom_ev_model`](https://resourcefully-dev.github.io/evsim/reference/get_custom_ev_model.md)
function also the months and weekdays corresponding to every time-cycle
(worksheet in the Excel file) and the time-zone of the use case must be
configured in parameters `months_lst`, `wdays_lst` and `data_tz`,
respectively. Finally, `connection_log` and `energy_log` parameters may
be always `FALSE` since it is assumed that a custom model is built in
the natural scale:

``` r

evmodel_custom <- evsim::get_custom_ev_model(
  names = names(custom_model),
  months_lst = list(1:12, 1:12),
  wdays_lst = list(1:5, 6:7),
  parameters_lst = custom_model,
  connection_log = F,
  energy_log = F,
  data_tz = "America/Los_Angeles"
)
```

# Estimate sessions connection values

Estimate sessions connection values following a Multi-variate Gaussian
distribution. The minimum considered value for duration is 30 minutes.

## Usage

``` r
estimate_connection(n, mu, sigma, log)
```

## Arguments

- n:

  integer, number of sessions

- mu:

  numeric vector, means of bivariate GMM

- sigma:

  numeric matrix, covariance matrix of bivariate GMM

- log:

  logical, true if models have logarithmic transformation

## Value

vector of numeric values

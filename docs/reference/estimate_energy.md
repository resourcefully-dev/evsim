# Estimate sessions energy values following a Gaussian distribution. The minimum considered value is 1kWh based on real data analysis.

Estimate sessions energy values following a Gaussian distribution. The
minimum considered value is 1kWh based on real data analysis.

## Usage

``` r
estimate_energy(n, mu, sigma, log)
```

## Arguments

- n:

  integer, number of sessions

- mu:

  numeric, mean of Gaussian distribution

- sigma:

  numeric, standard deviation of Gaussian distribution. If unknown, a
  recommended value is `sd = mu/3`.

- log:

  logical, true if models have logarithmic transformation

## Value

numeric vector

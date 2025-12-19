# Parallel processing for windows

mclapply version that works on windows

## Usage

``` r
mclapply.windows(X, FUN, ..., mc.cores)
```

## Arguments

- X:

  a vector (atomic or list) or an expressions vector. Other objects
  (including classed objects) will be coerced by as.list.

- FUN:

  the function to be applied to (mclapply) each element of X.

- ...:

  For mclapply, optional named arguments to FUN.

- mc.cores:

  integer, number of cores to be used. Could be overruled if number of
  items in list is lower.

## Value

list

## Details

This is a workaround to allow parallel processing in windows since
`parallel` package only works with linux distributions. Source:
https://www.r-bloggers.com/2014/07/implementing-mclapply-on-windows-a-primer-on-embarrassingly-parallel-computation-on-multicore-systems-with-r/

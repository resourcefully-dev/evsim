
<!-- README.md is generated from README.Rmd. Please edit that file -->

# evsim <a href='https://mcanigueral.github.io/evsim/'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/evsim)](https://cran.r-project.org/package=evsim)
[![R-CMD-check](https://github.com/mcanigueral/evsim/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mcanigueral/evsim/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/mcanigueral/evsim/branch/main/graph/badge.svg)](https://app.codecov.io/gh/mcanigueral/evsim?branch=main)
<!-- badges: end -->

## Overview

evsim is part of a suite of packages to analyse, model and simulate the
charging behavior of electric vehicle users:

- [evprof](https://mcanigueral.github.io/evprof/): Electric Vehicle
  PROFiling
- [evsim](https://mcanigueral.github.io/evsim/): Electric Vehicle
  SIMulation

evsim package provides the functions for:

- Simulating new EV sessions based on Gaussian Mixture Models created
  with package {evprof}
- Calculating the power demand from a data set of EV sessions in a
  specific time resolution
- Calculating the occupancy (number of vehicles connected) in a specific
  time resolution
- Including the EV model inputs in a Shiny Dashboard (a Shiny module is
  provided)

## Usage

If you have your own data set of EV charging sessions or you have
already built your EV model with
[evprof](https://mcanigueral.github.io/evprof/), the best place to start
is the [Get started
chapter](https://mcanigueral.github.io/evsim/articles/evsim.html) in the
package website.

## Installation

Since the package is not yet in CRAN, you can install the development
version of [evsim](https://github.com/mcanigueral/evsim/) from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("mcanigueral/evsim")
```

## Getting help

If you encounter a clear bug, please open an issue with a minimal
reproducible example on
[GitHub](https://github.com/mcanigueral/evprof/issues). For questions
and other discussion, please send me a mail to
<marc.canigueral@udg.edu>.

For further technical details, you can read the following academic
articles about the methodology used in this paper:

- **Electric vehicle user profiles for aggregated flexibility
  planning**. IEEE PES Innovative Smart Grid Technologies Europe (ISGT
  Europe). IEEE, Oct. 18, 2021. [DOI
  link](https://doi.org/10.1109/isgteurope52324.2021.9639931).
- **Flexibility management of electric vehicles based on user profiles:
  The Arnhem case study**. International Journal of Electrical Power and
  Energy Systems, vol. 133. Elsevier BV, p. 107195, Dec. 2021. [DOI
  link](https://doi.org/10.1016/j.ijepes.2021.107195).
- **Potential benefits of scheduling electric vehicle sessions over
  limiting charging power**. CIRED Porto Workshop 2022: E-mobility and
  power distribution systems. Institution of Engineering and
  Technology, 2022. [DOI
  link](https://ieeexplore.ieee.org/abstract/document/9841653).
- **Assessment of electric vehicle charging hub based on stochastic
  models of user profiles**. Expert Systems with Applications (Vol. 227,
  p. 120318). Elsevier BV. May 2023. [DOI
  link](https://doi.org/10.1016/j.eswa.2023.120318).

## Acknowledgements

This work has been developed under a PhD program in the
[eXiT](https://exit.udg.edu) research group from the University of
Girona (Catalonia) in collaboration with
[Resourcefully](https://resourcefully.nl/), an energy transition
consulting company based in Amsterdam, The Netherlands.

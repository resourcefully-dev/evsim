# Time resolution

Functions
[`simulate_sessions()`](https://resourcefully-dev.github.io/evsim/reference/simulate_sessions.md),
[`get_demand()`](https://resourcefully-dev.github.io/evsim/reference/get_demand.md)
or
[`get_occupancy()`](https://resourcefully-dev.github.io/evsim/reference/get_occupancy.md)
requires a parameter called **`resolution`**, which defines the minutes
between a time-slot and the following one.

For example, if `resolution = 15`, the charging sessions simulated
during 4 PM of a specific day will start at `16:00`, `16:15`, `16:30` or
`16:45`, but not during any time between these time-slots. However, the
connection duration of every session can have any value, so the session
can finish at `16:22` for instance. The same concept is applied to the
charging times.

Therefore, the function `get_demand` gives the **average charging
power** during a certain time-slot. If we use a `resolution = 15`, a
demand of 55kW for time-slot `16:30` means that between `16:30` and
`16:45` it has been consumed the energy corresponding to an average
power of 55 kW (so 55·15/60=**13.75 kWh**). This can modify the power
profile of sessions that stop charging at a time between time-slots. For
example, considering a `resolution = 15` and a session charging at 10kW
from `16:30` to `16:55`, the demand of time-slot `16:30` will be 10kW
but the demand of time-slot `16:45` will decrease to 6.67 kW (charging
only 3/4 parts of the time-slot). The “real” power profile of the
session is a constant power step of 10kW, but the demand profile
obtained with a `resolution = 15` does not. To obtain a more accurate
power profile of the session, the `resolution` parameter should be set
to higher resolutions (until a maximum of 1 minute).

Finally, note that the `resolution` parameter of time-series functions
(i.e. [`get_demand()`](https://resourcefully-dev.github.io/evsim/reference/get_demand.md)
and `get_n_connections()`) does not have to correspond necessarily to
the `resolution` of simulated sessions, even though it would not have
much sense to obtain the time-series demand in a lower resolution
(longer time intervals) than sessions since we loose accuracy on the
power profile.

Let’s see and example simulating 10 charging sessions with a
`resolution` of 30 minutes:

``` r

sessions %>% 
  select_if(is.timepoint) %>% 
  mutate_all(format, "%d/%m/%Y %H:%M") %>% 
  knitr::kable()
```

| ConnectionStartDateTime | ConnectionEndDateTime | ChargingStartDateTime | ChargingEndDateTime |
|:---|:---|:---|:---|
| 31/01/2023 05:30 | 31/01/2023 17:17 | 31/01/2023 05:30 | 31/01/2023 06:43 |
| 31/01/2023 06:30 | 31/01/2023 14:41 | 31/01/2023 06:30 | 31/01/2023 08:49 |
| 31/01/2023 06:30 | 31/01/2023 16:58 | 31/01/2023 06:30 | 31/01/2023 07:53 |
| 31/01/2023 07:00 | 31/01/2023 16:40 | 31/01/2023 07:00 | 31/01/2023 16:40 |
| 31/01/2023 07:30 | 31/01/2023 13:20 | 31/01/2023 07:30 | 31/01/2023 07:51 |
| 31/01/2023 07:30 | 31/01/2023 16:49 | 31/01/2023 07:30 | 31/01/2023 07:55 |
| 31/01/2023 08:30 | 31/01/2023 13:42 | 31/01/2023 08:30 | 31/01/2023 10:55 |
| 31/01/2023 08:30 | 31/01/2023 15:05 | 31/01/2023 08:30 | 31/01/2023 08:49 |
| 31/01/2023 11:00 | 31/01/2023 14:57 | 31/01/2023 11:00 | 31/01/2023 14:57 |
| 31/01/2023 12:30 | 31/01/2023 16:55 | 31/01/2023 12:30 | 31/01/2023 13:26 |

If we calculate the aggregated demand of the above simulated sessions
with a `resolution` of `5`, `15` and `30`, the resulting power profile
loses accuracy when we decrease the time resolution (so higher time
intervals):

``` r

demand_5 <- sessions %>%
  get_demand(resolution = 5)

demand_15 <- sessions %>%
  get_demand(resolution = 15)

demand_30 <- sessions %>%
  get_demand(resolution = 30)
```

Then we can create a common object to compare the three vectors of EV
demand, making use of
[`dplyr::left_join`](https://dplyr.tidyverse.org/reference/mutate-joins.html)
to join by `datetime` and
[`tidyr::fill`](https://tidyr.tidyverse.org/reference/fill.html) to fill
the gaps with the previous exisiting power:

``` r

demand_comparison <- demand_5 %>% 
  rename(`5-minute resolution` = Users) %>% 
  left_join(
    rename(demand_15, `15-minute resolution` = Users)
  ) %>% 
  left_join(
    rename(demand_30, `30-minute resolution` = Users)
  ) %>% 
  tidyr::fill(-datetime, .direction = 'down')

demand_comparison %>% 
  timefully::plot_ts(stepPlot = T, strokeWidth = 2, ylab = "EV demand (kW)")
```

The power profile with a resolution of 5 minutes represents in a higher
accuracy when sessions start and finish. If we zoom-in, we can see
clearly that the average power profile really depends on the time
resolution:

``` r

demand_comparison %>% 
  filter(
    datetime >= dmy_h("31/01/2023 16", tz = ev_model$metadata$tzone),
    datetime < dmy_h("31/01/2023 19", tz = ev_model$metadata$tzone)
  ) %>% 
  timefully::plot_ts(stepPlot = T, strokeWidth = 2, ylab = "EV demand (kW)")
```

However, the total area of the three lines (energy consumed) corresponds
to the same value since the power values are the average power of every
time-slot whatever the resolution is:

``` r

sum(demand_5$Users*5/60) # in kWh
```

    ## [1] 144.26

``` r

sum(demand_15$Users*15/60) # in kWh
```

    ## [1] 144.26

``` r

sum(demand_30$Users*30/60) # in kWh
```

    ## [1] 144.26

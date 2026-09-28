library(testthat)
library(evsim)
library(dplyr)
library(lubridate)

test_that("energy never exceeds what fits in the connection window", {
  # 0.82 h is truncated to 49 minutes of connection: 11 kW * 49/60 = 8.983 kWh.
  # Rounding the connection time back up to 0.82 h used to produce 9.02 kWh.
  sessions <- tibble(
    ConnectionStartDateTime = ymd_hms("2050-01-14 12:00:00", tz = "Europe/Amsterdam"),
    ConnectionHours = 0.82,
    Power = 11,
    Energy = 20
  )
  adapted <- adapt_charging_features(sessions, time_resolution = 15)
  feasible <- adapted$Power *
    as.numeric(adapted$ConnectionEndDateTime - adapted$ConnectionStartDateTime, unit = "hours")
  expect_equal(adapted$ConnectionEndDateTime, adapted$ConnectionStartDateTime + minutes(49))
  expect_lte(adapted$Energy, feasible)
  expect_equal(adapted$Energy, 8.98)
  expect_equal(adapted$ChargingEndDateTime, adapted$ConnectionEndDateTime)
  expect_equal(adapted$ConnectionHours, 0.82)
  expect_equal(adapted$ChargingHours, 0.82)
})

test_that("energy is consistent with the charging datetimes for every session", {
  sessions <- evsim::california_ev_sessions %>%
    filter(year(ConnectionStartDateTime) == 2018, month(ConnectionStartDateTime) == 10) %>%
    adapt_charging_features(time_resolution = 15)
  charging_hours <- as.numeric(
    sessions$ChargingEndDateTime - sessions$ChargingStartDateTime, unit = "hours"
  )
  connection_hours <- as.numeric(
    sessions$ConnectionEndDateTime - sessions$ConnectionStartDateTime, unit = "hours"
  )
  expect_true(all(sessions$Energy <= sessions$Power * charging_hours + 1e-9))
  expect_true(all(sessions$Energy <= sessions$Power * connection_hours + 1e-9))
  expect_true(all(sessions$ChargingEndDateTime <= sessions$ConnectionEndDateTime))
  expect_true(all(charging_hours <= connection_hours))
  expect_equal(sessions$ConnectionHours, round(connection_hours, 2))
  # ChargingHours is the exact charging time rounded to 2 decimals, and Energy
  # is rounded down to 0.01 kWh, so they agree within both rounding steps
  expect_true(all(
    abs(sessions$ChargingHours - sessions$Energy / sessions$Power) <= 0.005 + 0.01 / sessions$Power
  ))
})

test_that("sessions with power, energy or duration of 0 are removed", {
  sessions <- tibble(
    ConnectionStartDateTime = rep(ymd_hms("2050-01-14 12:00:00", tz = "Europe/Amsterdam"), 5),
    ConnectionHours = c(2, 2, 2, 0, 2),
    Power = c(11, 0, 11, 11, 0),
    Energy = c(10, 10, 0, 10, 0)
  )
  expect_message(adapted <- adapt_charging_features(sessions, time_resolution = 15))
  expect_equal(nrow(adapted), 1)
  # An uncapped session keeps its energy: 10 kWh at 11 kW takes 54.5 minutes
  expect_equal(adapted$Energy, 10)
  expect_equal(adapted$ChargingHours, 0.91)
  expect_equal(adapted$ChargingEndDateTime, adapted$ChargingStartDateTime + minutes(55))
})

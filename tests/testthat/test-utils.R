# where_at ------------------------------------------------------------

test_that("allows valid logical, numeric, and character vectors", {
  x <- list(a = 1, b = 1, c = 1)
  expect_equal(where_at(x, TRUE), c(TRUE, TRUE, TRUE))
  expect_equal(where_at(x, 1), c(TRUE, FALSE, FALSE))
  expect_equal(where_at(x, -2), c(TRUE, FALSE, TRUE))
  expect_equal(where_at(x, "b"), c(FALSE, TRUE, FALSE))
})

test_that("errors on invalid subsetting vectors", {
  x <- list(a = 1, b = 1, c = 1)
  expect_snapshot(error = TRUE, {
    where_at(x, c(FALSE, TRUE))
    where_at(x, NA_real_)
    where_at(x, 4)
  })
})

test_that("function at is passed names", {
  x <- list(a = 1, B = 1, c = 1)
  expect_equal(where_at(x, ~ .x %in% LETTERS), c(FALSE, TRUE, FALSE))
  expect_equal(where_at(x, ~ intersect(.x, LETTERS)), c(FALSE, TRUE, FALSE))
})

test_that("where_at works with unnamed input", {
  x <- list(1, 1, 1)
  expect_equal(where_at(x, letters), rep(FALSE, 3))
  expect_equal(where_at(x, ~ intersect(.x, LETTERS)), rep(FALSE, 3))
})

test_that("validates its inputs", {
  x <- list(a = 1, b = 1, c = 1)
  expect_snapshot(where_at(x, list()), error = TRUE)
})

test_that("tidyselect `at` is deprecated", {
  expect_snapshot({
    . <- where_at(data.frame(x = 1), vars("x"))
  })
})


# vctrs compat ------------------------------------------------------------

test_that("pairlists, expressions, and calls are deprecated", {
  expect_snapshot(x <- vctrs_vec_compat(expression(1, 2)))
  expect_equal(x, list(1, 2))

  expect_snapshot(x <- vctrs_vec_compat(pairlist(1, 2)))
  expect_equal(x, list(1, 2))

  expect_snapshot(x <- vctrs_vec_compat(quote(f(a, b = 1))))
  expect_equal(x, list(quote(f), quote(a),b = 1))
})

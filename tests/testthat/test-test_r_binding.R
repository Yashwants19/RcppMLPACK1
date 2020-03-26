context("test_r_binding")

test_that("TestRunBindingCorrectly", {
  output <- testRBinding(4.0, 12, "hello", flag1=TRUE)
  expect_true(output$doubleOut == 5.0)
  expect_true(output$intOut == 13)
  expect_true(output$stringOut == "hello2")
})

test_that("TestRunBindingNoFlag", {
  output <- testRBinding(4.0, 12, "hello")
  expect_true(output$doubleOut != 5.0)
  expect_true(output$intOut != 13)
  expect_true(output$stringOut != "hello2")
})

test_that("TestRunBindingWrongString", {
  output <- testRBinding(4.0, 12, "goodbye", flag1=TRUE)
  expect_true(output$stringOut != "hello2")
})

test_that("TestRunBindingWrongInt", {
  output <- testRBinding(4.0, 15, "hello", flag1=TRUE)
  expect_true(output$intOut != 13)
})

test_that("TestRunBindingWrongDouble", {
  output <- testRBinding(2.0, 12, "hello", flag1=TRUE)
  expect_true(output$doubleOut != 5.0)
})

test_that("TestRunBadFlag", {
  output <- testRBinding(4.0, 12, "hello", flag1=TRUE, flag2=TRUE)
  expect_true(output$doubleOut != 5.0)
  expect_true(output$intOut != 13)
  expect_true(output$stringOut != "hello2")
})

test_that("TestMatrix", {
  x <- matrix ( c( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15), nrow = 5)
  y <- matrix ( c( 1, 2, 6, 4, 6, 7, 16, 9, 11, 12, 26, 14), nrow = 4)
  output <- testRBinding(4.0, 12, "hello", x)
  expect_identical(output$matrixOut, y)
})

test_that("TestModel", {
  output1 <- testRBinding(4.0, 12, "hello", buildModel=TRUE)
  output2 <- testRBinding(4.0, 12, "hello", modelIn=output1$modelOut)
  expect_true(output2$modelBwout == 20)
})


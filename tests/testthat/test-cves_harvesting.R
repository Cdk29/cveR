# WARNING - Generated by {fusen} from /dev/flat_cves-harvesting.Rmd: do not edit by hand

test_that("cves_harvesting returns FALSE when an invalid URL is given", {
    expect_false(cves_harvesting("http://this-is-an-invalid-url.csv"))
})

test_that("cves_harvesting returns TRUE when a valid URL is given", {
    expect_true(cves_harvesting("https://raw.githubusercontent.com/Cdk29/cveR/main/tests/testthat/allitems_test.csv", "test_download_from_github.csv"))
})

test_that("test_download_from_github.csv is the same as allitems_test.csv", {
    downloaded_data <- read.csv("test_download_from_github.csv")
    #following lines due to how fusen works when inflating a package
    test_data <- read.csv(test_path("allitems_test.csv"))
    expect_true(all.equal(downloaded_data, test_data))
})

test_that("read_data_CVEs correctly reads column names", {
  # Attempt to read the test data from two different locations
  test_data <- read_data_CVEs(test_path("allitems_test.csv"))
  expected_colnames <- c("Name", "Status", "Description", "References", "Phase", "Votes", "Comments")
  expect_equal(colnames(test_data), expected_colnames)
})

# # golem::disable_autoload()
# Golemantic::run_app()
#
# shiny::runApp()
library(golem)
if (!require(bsicons)) {
  # Install the package if it's not installed
  install.packages("bsicons", repos = "http://cran.r-project.org")
}
library(bsicons)
run_app()

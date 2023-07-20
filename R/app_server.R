library(dplyr)

# Change 'Archived' to 'No' for the last 30 rows

#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  archived_cve <- read.csv("archived_data_18_2023.csv")
  archived_cve <- archived_cve %>%
    mutate(Archived = ifelse(row_number() > n() - 30, 'No', Archived))
  # add map_later
  mod_fundamental_module_cveR_server("new_CVEs", archived_cve)
  # mod_fundamental_module_cveR_server("project A")

}

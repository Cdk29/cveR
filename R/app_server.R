#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # add map_later
  mod_fundamental_module_cveR_server("new_CVEs")
  mod_fundamental_module_cveR_server("project A")

}

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @import bsicons
#' @noRd
app_ui <- function(request) {
  # tagList(
    # Leave this function for adding external resources
    golem_add_external_resources()
    cve_status_df <- read.csv("archived_data_18_2023.csv")
    set.seed(123)  # Set a random seed for reproducibility

    cve_status_df <- cve_status_df %>%
      mutate(
        Project = ifelse(runif(n()) < 0.01, "project_A", Project),  # 1% of rows become "project_A"
        Archived = ifelse(Project == "project_A" & runif(n()) < 0.5, "No", Archived)  # Half of "project_A" rows become "No"
      )
    nav_content <- purrr::map(unique(cve_status_df$Project), ~mod_fundamental_module_cveR_ui(.x))

    do.call(bslib::page_navbar, c(list(
      title = "cveR",
      sidebar = sidebar(shiny::actionButton(inputId = "update_cve", label = "Update CVE Status"))),
      nav_content))
  #)
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "cveR"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

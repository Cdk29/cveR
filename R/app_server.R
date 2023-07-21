library(dplyr)

# Change 'Archived' to 'No' for the last 30 rows

#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Initialize reactive values
  rv <- reactiveValues()
  rv$all_cves <- read.csv("filtered_data_18_2023.csv")
  rv$cve_status_df <- read.csv("archived_data_18_2023.csv")

  # Use reactive to handle mutation operations on the reactive value
  cve_status_df <- reactive({
    data <- rv$cve_status_df
    data <- data %>%
      mutate(Archived = ifelse(row_number() <= 60, 'No', 'Yes'))

    set.seed(123)  # Set a random seed for reproducibility

    data <- data %>%
      mutate(
        Project = ifelse(runif(n()) < 0.01, "project_A", Project),  # 1% of rows become "project_A"
        Archived = ifelse(Project == "project_A" & runif(n()) < 0.5, "No", Archived)  # Half of "project_A" rows become "No"
      )
    data  # Return the modified data
  })

  observeEvent(input$update_cve, {
    # Call the function when the button is clicked
    cveR::cves_harvesting()

    # If you want to update the `new_cves` inside this event,
    # you need to use reactiveValues or similar reactive constructs
    # For example:
    new_cves <- cveR::read_data_CVEs("allitems.csv")
    new_cves <- filter_data(new_cves)

    # Update the reactive value
    rv$cve_status_df <- new_cves
  })

  # add filter !!!!
  # add map_later
  # ud_model_file <- "english-ewt-ud-2.5-191206.udpipe"
  # mod_fundamental_module_cveR_server("new_CVEs", cve_status_df, all_cves)
  # existing code...
  observe({
    projects <- unique(cve_status_df()$Project)  # Note the () after cve_status_df
    purrr::map(projects, ~ {
      current_project <- .x
      cve_status_df_filtered <- cve_status_df() %>% dplyr::filter(Project == current_project)  # Note the () after cve_status_df
      all_cves_filtered <- rv$all_cves %>% semi_join(cve_status_df_filtered, by = "Name")
      mod_fundamental_module_cveR_server(current_project, cve_status_df_filtered, all_cves_filtered)
    })
  })
}


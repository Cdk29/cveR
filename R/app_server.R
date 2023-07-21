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
  all_cves <- read.csv("filtered_data_18_2023.csv")
  cve_status_df <- read.csv("archived_data_18_2023.csv")
  cve_status_df <- cve_status_df %>%
    mutate(Archived = ifelse(row_number() <= 60, 'No', 'Yes'))


  set.seed(123)  # Set a random seed for reproducibility

  cve_status_df <- cve_status_df %>%
    mutate(
      Project = ifelse(runif(n()) < 0.01, "project_A", Project),  # 1% of rows become "project_A"
      Archived = ifelse(Project == "project_A" & runif(n()) < 0.5, "No", Archived)  # Half of "project_A" rows become "No"
    )

  # add filter !!!!
  # add map_later
  # ud_model_file <- "english-ewt-ud-2.5-191206.udpipe"
  # mod_fundamental_module_cveR_server("new_CVEs", cve_status_df, all_cves)
  # existing code...
  purrr::map(unique(cve_status_df$Project), ~ {
    current_project <- .x
    cve_status_df_filtered <- cve_status_df %>% dplyr::filter(Project == current_project)
    all_cves_filtered <- all_cves %>% semi_join(cve_status_df_filtered, by = "Name")
    mod_fundamental_module_cveR_server(current_project, cve_status_df_filtered, all_cves_filtered)
  })
}

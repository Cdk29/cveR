
library(tokenizers.bpe)
library(udpipe)
library(stringr)
library(stopwords)
library(dplyr)
library(BTM)
library(textplot)
library(ggraph)
library(concaveman)
library(data.table)
library(tidyverse)
library(DT)
#' fundamental_module_cveR UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import bsicons
#' @import shinipsum
#' @import bslib
mod_fundamental_module_cveR_ui <- function(id){
  ns <- NS(id)

  cards <- list(

    bslib::card(
      height = 250,
      full_screen = TRUE,
      bslib::card_header("A filling plot"),
      plotOutput(ns("btm_plot"))
      # imageOutput(ns("btm_plot"))
    ),
    bslib::navset_card_tab(
      title = "CVEs_Tabs",
      bslib::nav_panel("CVE_tab1", DT::dataTableOutput(ns("cveTableNo"))),
      bslib::nav_panel("CVE_tab2", DT::dataTableOutput(ns("cveTableYes")))
      )
  )

  box <- list(
    bslib::value_box(
      title = "Number of news CVEs",
      value = textOutput(ns("newsCveCount")),
      theme_color = "primary"
    ),
    bslib::value_box(
      title = "CVEs archived",
      value = textOutput(ns("archivedCveCount")),
      theme_color = "secondary"
    )
  )

  bslib::nav_panel(id,
                   sidebar = bslib::sidebar(
                     position = "right",
                     title = "Sidebar controls",
                     actionButton(inputId = ns("update_cve"), label = "Update CVE Status")  # Add this line for button
                   ),
                   bslib::layout_columns(
                     fill = FALSE,
                     box[[1]], box[[2]]
                   ),
                   bslib::layout_columns(
                     cards[[1]], cards[[2]]
                   )
  )
}


#' fundamental_module_cveR Server Functions
#' @noRd
mod_fundamental_module_cveR_server <- function(id, cve_status_df, all_cves){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    ud_model_file <- "english-ewt-ud-2.5-191206.udpipe"

    cve_no <- cve_status_df %>% filter(Archived == 'No')
    cve_yes <- cve_status_df %>% filter(Archived == 'Yes')

    # Join with all_cves
    cve_tab1 <- all_cves %>% semi_join(cve_no, by = "Name")
    cve_tab2 <- all_cves %>% semi_join(cve_yes, by = "Name")

    # Render data tables for each tab
    output$cveTableNo <- DT::renderDataTable(cve_tab1[c("Name", "Description")])
    output$cveTableYes <- DT::renderDataTable(cve_tab2[c("Name", "Description")])

    # other code...
    news_cves <- all_cves %>% semi_join(cve_no, by = "Name")
    output$btm_plot <- renderPlot(topic_model_BTM_plot_generation(news_cves, ud_model_file))

    # render counts of CVEs
    output$newsCveCount <- renderText(nrow(cve_tab1))
    output$archivedCveCount <- renderText(nrow(cve_tab2))
  })
}


## To be copied in the UI
# mod_fundamental_module_cveR_ui("fundamental_module_cveR_1")

## To be copied in the server
# mod_fundamental_module_cveR_server("fundamental_module_cveR_1")

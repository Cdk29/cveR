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
      bslib::nav_panel("CVE_tab1"),
      bslib::nav_panel("CVE_tab2")
      )
  )

  box <- list(
    bslib::value_box(
      title = "Number of news CVEs",
      value = 44#,
      # showcase = bsicons::bs_icon("align-bottom")
    ),
    bslib::value_box(
      title = "CVEs suggested",
      value = 24,
      # showcase = bsicons::bs_icon("align-center"),
      theme_color = "dark"
    ),
    bslib::value_box(
      title = "CVEs archived",
      value = 256,
      # showcase = bsicons::bs_icon("handbag"),
      theme_color = "secondary"
    )
  )


  # bslib::page_sidebar(
  #   title = "cveR",
  bslib::nav_panel(id,
    sidebar = bslib::sidebar(
      position = "right",
      title = "Sidebar controls"),
    bslib::layout_columns(
      fill = FALSE,
      box[[1]], box[[2]], box[[3]]
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

    news_cves <- cve_status_df %>% filter(Archived == 'No')
    news_cves <- all_cves %>% semi_join(news_cves, by = "Name")

    archived_cve <- all_cves %>% anti_join(news_cves, by = "Name")
    output$btm_plot <- renderPlot(topic_model_BTM_plot_generation(news_cves, ud_model_file))
    # output$btm_plot <- renderImage({
    #   filename <- topic_model_BTM_plot_generation(news_cves, ud_model_file)
    #   list(src = filename,
    #        contentType = 'image/png',
    #        alt = "This is an alternative text for the image",
    #        deleteFile = TRUE)
    # }, deleteFile = TRUE)

  })
}

## To be copied in the UI
# mod_fundamental_module_cveR_ui("fundamental_module_cveR_1")

## To be copied in the server
# mod_fundamental_module_cveR_server("fundamental_module_cveR_1")

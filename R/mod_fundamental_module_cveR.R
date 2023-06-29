#' fundamental_module_cveR UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom bsicons bs_icon
#' @import shinipsum
#' @import bslib
mod_fundamental_module_cveR_ui <- function(id){
  ns <- NS(id)

  cards <- list(

    navset_card_tab(
      title = "CVEs_plots",
      nav_panel("CVE_plots1", plotOutput(ns("plot1"))),
      nav_panel("CVE_plots2", plotOutput(ns("plot2"))),
    ),
    navset_card_tab(
      title = "CVEs_Tabs",
      nav_panel("CVE_tab1"),
      nav_panel("CVE_tab2")
      )
  )

  box <- list(
    value_box(
      title = "Number of news CVEs",
      value = 44,
      showcase = bsicons::bs_icon("align-bottom")
    ),
    value_box(
      title = "CVEs suggested",
      value = 24,
      showcase = bsicons::bs_icon("align-center"),
      theme_color = "dark"
    ),
    value_box(
      title = "CVEs archived",
      value = 256,
      showcase = bsicons::bs_icon("handbag"),
      theme_color = "secondary"
    )
  )


  page_sidebar(
    title = "cveR",
    sidebar = sidebar(
      position = "right",
      title = "Sidebar controls"),
    layout_columns(
      fill = FALSE,
      box[[1]], box[[2]], box[[3]]
    ),

    layout_columns(
      cards[[1]], cards[[2]]
    )
  )
}

#' fundamental_module_cveR Server Functions
#'
#' @noRd
mod_fundamental_module_cveR_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$plot1 <- renderPlot({random_ggplot()})
    output$plot2 <- renderPlot({random_ggplot()})

  })
}

## To be copied in the UI
# mod_fundamental_module_cveR_ui("fundamental_module_cveR_1")

## To be copied in the server
# mod_fundamental_module_cveR_server("fundamental_module_cveR_1")

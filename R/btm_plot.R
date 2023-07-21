#' @title BTM Topic Model Plot Generation
#' @description This function takes a dataframe and a udpipe model file, applies text annotation and the Biterm Topic Model (BTM), and then generates a plot of the BTM.
#' @param df A dataframe containing the text data.
#' @param ud_model_file A string specifying the location of the udpipe model file.
#' @return Generates a plot of the Biterm Topic Model.
#' @examples
#' df <- read.csv("filtered_data_18_2023.csv")
#' ud_model_file <- "english-ewt-ud-2.5-191206.udpipe"
#' topic_model_BTM_plot_generation(df, ud_model_file)
#' @import udpipe
#' @import BTM
#' @export
topic_model_BTM_plot_generation <- function(df, ud_model_file) {
  # Load necessary libraries
  # Convert text data from ISO-8859-1 to UTF-8
  df$Description <- iconv(df$Description, from = "ISO-8859-1", to = "UTF-8")

  # Load the udpipe model
  ud_model <- udpipe_load_model(ud_model_file)
  # Annotate the text data
  u_df <- text_annotation(df, "Description", ud_model)
  # Run Biterm Topic Model with cooccurrence
  btm_model <- btm_topic_model(u_df, k = 10)

  # Plot the topic model
  plot(btm_model)
  # filename <- tempfile(fileext = '.png')
  # png(filename)
  # plot(btm_model)
  # dev.off()
  # return(filename)
}

#' @title BTM Topic Modeling
#' @description This function applies the Biterm Topic Model (BTM) to a given annotated dataframe.
#' @param df Annotated dataframe containing the text data.
#' @param k Number of topics.
#' @param iter Number of iterations for the Gibbs sampling algorithm.
#' @return A BTM model.
#' @examples
#' data <- data.frame(doc_id = c(1,2,3), upos = c("NOUN", "PROPN", "NOUN"), lemma = c("noun1", "noun2", "noun3"))
#' model <- btm_topic_model(data, k = 5, iter = 1000)
btm_topic_model <- function(df, k = 10, iter = 1000) {


  # Filter the data to include only nouns (NN, NNP, NNS)
  # df <- subset(df, upos %in% c("PROPN", "VERB"))
  df <- subset(df, upos %in% c("PROPN", "ADJ", "VERB"))
  # Prepare the data for the BTM model
  data <- df[, c("doc_id", "token")]

  # Apply the BTM model
  model <- BTM(data, k = k, iter = iter, background = TRUE)

  return(model)
}

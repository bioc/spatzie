#' @title Plot motif occurrence
#'
#' @description
#' Plots a histogram of motif values (either counts, instances, or scores)
#' for anchor 1 and anchor 2 regions.
#'
#' @param interaction_data an interactionData object of paired genomic regions
#' @param method way to interpret motif matching for each anchor region as
#'               "counts" number of motifs per region, "instances" motif
#'               present or absent each region, or "scores" maximum motif PWM
#'               match score for each region
#' @return plot containing histogram for each anchor
#'
#' @examples
#' genome <- BSgenome.Mmusculus.UCSC.mm9::BSgenome.Mmusculus.UCSC.mm9
#' motif_file <- system.file(
#'   "extdata/consensus_HOCOMOCOv11_core_MOUSE-plus_YY1.piq",
#'   package = "spatzie")
#' motifs <- TFBSTools::readJASPARMatrix(motif_file, matrixClass = "PFM")
#'
#' yy1_pd_interaction <- scan_motifs(spatzie:::interactions, motifs, genome)
#' yy1_pd_interaction <- filter_motifs(yy1_pd_interaction, 0.4)
#' plot_motif_occurrence(yy1_pd_interaction,"counts")
#'
#' @author Jennifer Hammelman
#' @importFrom BiocGenerics colMeans
#' @importFrom SummarizedExperiment assays
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 facet_wrap
#' @importFrom ggplot2 geom_bar
#' @export
plot_motif_occurrence <- function(interaction_data,
                                  method = c("counts", "instances", "scores")) {
  id <- value <- NULL
  method <- match.arg(method, c("counts", "instances", "scores"))
  anchor1_motifs <- SummarizedExperiment::assays(
    interaction_data$anchor1_motifs)
  anchor2_motifs <- SummarizedExperiment::assays(
    interaction_data$anchor2_motifs)
  if (method == "counts") {
    anchor1_values <- BiocGenerics::colMeans(anchor1_motifs$motifCounts)
    anchor2_values <- BiocGenerics::colMeans(anchor2_motifs$motifCounts)
  } else if (method == "matches") {
    anchor1_values <- BiocGenerics::colMeans(anchor1_motifs$motifMatches)
    anchor2_values <- BiocGenerics::colMeans(anchor2_motifs$motifMatches)
  } else {
    anchor1_values <- BiocGenerics::colMeans(anchor1_motifs$motifScores)
    anchor2_values <- BiocGenerics::colMeans(anchor2_motifs$motifScores)
  }
  plotting_data <- data.frame(id = c(names(anchor1_values),
                                     names(anchor2_values)),
                              value = c(anchor1_values, anchor2_values),
                              variable = c(rep("anchor1",
                                               length(anchor1_values)),
                                           rep("anchor2",
                                               length(anchor2_values))))
  return(ggplot2::ggplot(plotting_data,
                         ggplot2::aes(x = factor(id), y = value)) +
    ggplot2::facet_wrap(~variable) +
    ggplot2::geom_bar(stat='identity',ggplot2::aes(fill = factor(id)), ylab = method))
}
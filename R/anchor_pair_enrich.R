#' @title Determine enriched motifs in anchors
#'
#' @description
#' Determine whether motifs between paired bed regions have a statistically
#' significant relationship. Options for significance are motif score
#' correlation, motif count correlation, or hypergeometric motif co-occurrence.
#'
#' @param interaction_data an interactionData object of paired genomic regions
#' @param method choice of method for co-occurrence include
#' \code{countCorrelation}, \code{scoreCorrelation}, \code{countHypergeom}, or
#' \code{countFisher}
#' @return an interactionData object where \code{obj$pair_motif_enrich} contains
#' the p-values for significance of seeing a higher co-occurrence than
#' what we get by chance.
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
#' yy1_pd_count_corr <- anchor_pair_enrich(yy1_pd_interaction,
#'                                         method = "countCorrelation")
#' @author Jennifer Hammelman
#' @importFrom stats cor.test
#' @importFrom SummarizedExperiment assays
#' @importFrom stats phyper
#' @importFrom stats fisher.test
#' @export
anchor_pair_enrich <- function(interaction_data,
                               method = c("countCorrelation",
                                          "scoreCorrelation",
                                          "countHypergeom",
                                          "countFisher")) {
  method <- match.arg(method, c("countCorrelation",
                                "scoreCorrelation",
                                "countHypergeom",
                                "countFisher"))
  significance <- matrix(data = NA,
                         nrow = length(interaction_data$anchor1_motif_indices),
                         ncol = length(interaction_data$anchor2_motif_indices))
  values <- matrix(data = NA,
                   nrow = length(interaction_data$anchor1_motif_indices),
                   ncol = length(interaction_data$anchor2_motif_indices))
  indr <- 1
  anchor1_motifs <- SummarizedExperiment::assays(
    interaction_data$anchor1_motifs)
  anchor2_motifs <- SummarizedExperiment::assays(
    interaction_data$anchor2_motifs)
  for (i in interaction_data$anchor1_motif_indices) {
    indc <- 1
    for (j in interaction_data$anchor2_motif_indices) {
      if (method == "countCorrelation") {
        significance[indr, indc] <- stats::cor.test(
          anchor1_motifs$motifCounts[, i],
          anchor2_motifs$motifCounts[, j],
          alternative = "greater", method = "pearson")$p.value
        values[indr,indc] <- stats::cor(
          anchor1_motifs$motifCounts[, i],
          anchor2_motifs$motifCounts[, j])
      } else if (method == "scoreCorrelation") {
        significance[indr, indc] <- stats::cor.test(
          anchor1_motifs$motifScores[, i],
          anchor2_motifs$motifScores[, j],
          alternative = "greater", method = "pearson")$p.value
        values[indr,indc] <- stats::cor(
          anchor1_motifs$motifScores[, i],
          anchor2_motifs$motifScores[, j])
      } else if (method == "countHypergeom") {
        significance[indr, indc] <- stats::phyper(
          sum((anchor1_motifs$motifMatches[, i]) *
                (anchor2_motifs$motifMatches[, j])),
          sum(anchor1_motifs$motifMatches[, i]),
          length(anchor1_motifs$motifMatches[, i]) -
            sum(anchor1_motifs$motifMatches[, i]),
          sum(anchor2_motifs$motifMatches[, j]), lower.tail = FALSE)
        values[indr,indc] <- sum((anchor1_motifs$motifMatches[, i]) *
                                   (anchor2_motifs$motifMatches[, j]))
        maxEP <- min(sum(anchor1_motifs$motifMatches[, i]),
                     sum(anchor2_motifs$motifMatches[, j]))
        values[indr,indc] <- values[indr,indc]/maxEP
      } else if (method == "countFisher") {
        dobpos <- sum((anchor1_motifs$motifMatches[, i]) *
                        (anchor2_motifs$motifMatches[, j]))
        dobneg <- sum((!anchor1_motifs$motifMatches[, i]) *
                        (!anchor2_motifs$motifMatches[, j]))
        fisher_mat <- matrix(c(dobpos,
                               sum(anchor1_motifs$motifMatches[, i]) - dobpos,
                               sum(anchor2_motifs$motifMatches[, j]) - dobpos,
                               dobneg), nrow = 2)
        significance[indr, indc] <- stats::fisher.test(
          fisher_mat, alternative = "greater")$p.value
        values[indr,indc] <- sum((anchor1_motifs$motifMatches[, i]) *
                                   (anchor2_motifs$motifMatches[, j]))
        maxEP <- min(sum(anchor1_motifs$motifMatches[, i]),
                     sum(anchor2_motifs$motifMatches[, j]))
        values[indr,indc] <- values[indr,indc]/maxEP
      }
      indc <- indc + 1
    }
    indr <- indr + 1
  }
  rownames(significance) <- names(interaction_data$anchor1_motif_indices)
  colnames(significance) <- names(interaction_data$anchor2_motif_indices)

  interaction_data <- list(
    interactions = interaction_data$interactions,
    anchor1_motifs = interaction_data$anchor1_motifs,
    anchor2_motifs = interaction_data$anchor2_motifs,
    anchor1_motif_indices = interaction_data$anchor1_motif_indices,
    anchor2_motif_indices = interaction_data$anchor2_motif_indices,
    pair_motif_scores = values,
    pair_motif_enrich = significance,
    is_multiple_hypothesis_corrected = FALSE)
  class(interaction_data) <- "interactionData"
  return(interaction_data)
}
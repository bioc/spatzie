#' @title Filter significant motif interactions
#'
#' @description
#' Multiple hypothesis correction applied to filter for significant motif
#' interactions.
#'
#' @param interaction_data an interactionData object of paired genomic regions
#' @param method statistical method for multiple hypothesis correction (see stats package for options)
#' @param threshold p-value threshold for significance cut-off
#' @return an interactionData object where \code{obj$pair_motif_enrich} contains
#' multiple hypothesis corrected p-values for significance of seeing a higher co-occurrence than
#' what we get by chance and \code{obj$pair_motif_enrich_sig} contains only motifs that have at least one
#' significant interaction.
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
#' yy1_pd_score_corr <- anchor_pair_enrich(yy1_pd_interaction,
#'                                         method = "scoreCorrelation")
#' yy1_pd_score_corr_adj <- filter_pair_motifs(yy1_pd_score_corr)
#'
#' @author Jennifer Hammelman
#' @importFrom stats p.adjust
#' @importFrom stats p.adjust.methods
#' @importFrom matrixStats rowMins
#' @importFrom matrixStats colMins
#' @export
filter_pair_motifs <- function(interaction_data,
                               method = stats::p.adjust.methods,
                               threshold = 0.05) {
  adjusted_p_interactions <- matrix(stats::p.adjust(
    as.vector(as.matrix(interaction_data$pair_motif_enrich, method = method))),
    ncol = dim(interaction_data$pair_motif_enrich)[2])
  rownames(adjusted_p_interactions) <- names(
    interaction_data$anchor1_motif_indices)
  colnames(adjusted_p_interactions) <- names(
    interaction_data$anchor2_motif_indices)

  anchor1_mask <- which(
    matrixStats::rowMins(adjusted_p_interactions) < threshold)
  adjusted_p_interactions_sig <- as.matrix(
    adjusted_p_interactions[anchor1_mask, ])
  if (length(anchor1_mask) == 1) {
    adjusted_p_interactions_sig <- t(adjusted_p_interactions_sig)
  }
  anchor2_mask <- which(
    matrixStats::colMins(adjusted_p_interactions) < threshold)
  adjusted_p_interactions_sig <- adjusted_p_interactions_sig[, anchor2_mask]

  interaction_data <- list(
    interactions = interaction_data$interactions,
    anchor1_motifs = interaction_data$anchor1_motifs,
    anchor2_motifs = interaction_data$anchor2_motifs,
    anchor1_motif_indices = interaction_data$anchor1_motif_indices,
    anchor2_motif_indices = interaction_data$anchor2_motif_indices,
    pair_motif_enrich = adjusted_p_interactions,
    pair_motif_enrich_sig = adjusted_p_interactions_sig,
    is_multiple_hypothesis_corrected = TRUE)
  class(interaction_data) <- "interactionData"
  return(interaction_data)
}
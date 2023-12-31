#' Mouse YY1 Enhancer - Promoter Interactions Data Set
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' and serves as example and unit test data. The same data set is used in
#' the vignette.
#'
#' @format A \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' @usage data(interactions_yy1)
"interactions_yy1"

#' Mouse YY1 Enhancer - Promoter Interactions Data Set - YY1 promoters
#'
#' This is a \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' containing proccessed results from YY1
#' ChIA-PET of interactions that contain a YY1 motif in the promoter
#' (anchor 1) region. It serves as unit test data.
#'
#' @format A \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' @usage data(interactions_yy1_promoter)
"interactions_yy1_promoter"

#' Mouse YY1 Enhancer - Promoter Interactions Data Set - YY1 enhancers
#'
#' This is a \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' containing proccessed results from YY1
#' ChIA-PET of interactions that contain a YY1 motif in the enhancer
#' (anchor 2) region. It serves as unit test data.
#'
#' @format A \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' @usage data(interactions_yy1_enhancer)
"interactions_yy1_enhancer"

#' Mouse YY1 Enhancer - Promoter Interactions Data Set - YY1 enhancers/promoters
#'
#' This is a \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' containing proccessed results from YY1
#' ChIA-PET of interactions that contain a YY1 motif in the promoter
#' (anchor 1) region and a YY1 motif in the enhancer (anchor 2) region.
#' It serves as unit test data.
#'
#' @format A \code{\link[GenomicInteractions]{GenomicInteractions}} object
#' @usage data(interactions_yy1_ep)
"interactions_yy1_ep"

#' Mouse YY1 Enhancer - Promoter Interactions Data Set
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' and serves as example and unit test data.
#'
#' @format An \code{interactionData} object
#' @usage data(int_data_yy1)
"int_data_yy1"

#' K562 Enhancer - Promoter Interactions Data Set
#'
#' This object contains genomic interactions obtained by human RAD21 ChIA-PET
#' from K562 cells and serves as unit test data.
#'
#' @format An \code{interactionData} object
#' @usage data(int_data_k562)
"int_data_k562"

#' MSLCL Enhancer - Promoter Interactions Data Set
#'
#' This object contains genomic interactions obtained by human RAD21 ChIA-PET
#' from MSLCL cells and serves as unit test data.
#'
#' @format An \code{interactionData} object
#' @usage data(int_data_mslcl)
"int_data_mslcl"

#' Interactions scanned for motifs - interactionData object
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' scanned for mouse transcription factor motifs and serves as unit test data.
#' @format An interactionData object
#'
#' @usage data(scan_interactions_example)
"scan_interactions_example"

#' Interactions with motifs filtered for significance - interactionData object
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' scanned for mouse transcription factor motifs and filtered for motifs present
#' in at least 10% of interactions. It serves as unit test data.
#'
#' @format An interactionData object
#' @usage data(scan_interactions_example_filtered)
"scan_interactions_example_filtered"


#' spatzie count correlation data set
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' scanned for mouse transcription factor motifs, filtered for motifs present
#' in at least 10% of interactions, and processed for significant motif:motif
#' interactions with count correlation. It serves as unit test data.
#'
#' @format An interactionData object
#' @usage data(anchor_pair_example_count)
"anchor_pair_example_count"

#' spatzie match association data set
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' scanned for mouse transcription factor motifs, filtered for motifs present
#' in at least 10 % of interactions, and processed for significant motif:motif
#' interactions with using the hypergeometric test. It serves as unit test data.
#'
#' @format A interactionData object
#' @usage data(anchor_pair_example_match)
"anchor_pair_example_match"

#' spatzie score correlation data set
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' scanned for mouse transcription factor motifs, filtered for motifs present
#' in at least 10 % of interactions, and processed for significant motif:motif
#' interactions with score correlation. It serves as unit test data.
#'
#' @format An interactionData object
#' @usage data(anchor_pair_example_score)
"anchor_pair_example_score"

#' spatzie score correlation filtered data set
#'
#' This object contains genomic interactions obtained by mouse YY1 ChIA-PET
#' scanned for mouse transcription factor motifs, filtered for motifs present
#' in at least 10% of interactions, processed for significant motif:motif
#' interactions with score correlation, and filtered for pairs with p < 0.5.
#' It serves as unit test data.
#'
#' @format An interactionData object
#' @usage data(filter_pairs_example)
"filter_pairs_example"

#' compare_motif_pairs example
#'
#' This is a matrix containing example result from compare_motif_pairs. It
#' serves as unit test data.
#'
#' @format A matrix
#' @usage data(compare_pairs_example)
#'
"compare_pairs_example"


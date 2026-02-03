#' spatzie
#'
#' Looks for motifs which are significantly co-enriched from enhancer-promoter
#' interaction data, derived from assays such as as HiC, ChIA-PET, etc. It can
#' also look for differentially enriched motif pairs between to interaction
#' experiments.
#'
#' @docType package
#' @author Jennifer Hammelman
#' @author Konstantin Krismer
#' @name spatzie
NULL

.onAttach <- function(libname, pkgname) {
    msg <- sprintf(
        "Package '%s' is deprecated and will be removed from Bioconductor
         version %s", pkgname, "3.24")
    .Deprecated(msg=paste(strwrap(msg, exdent=2), collapse="\n"))
}

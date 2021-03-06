% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pop-estimate.R
\name{popEstimate}
\alias{popEstimate}
\title{Estimate population/eQTL simulation parameters}
\usage{
popEstimate(gene.means, eqtl, popParams = newPopParams())
}
\arguments{
\item{gene.means}{Dataframe of real gene means across a population, where 
each row is a gene and each column is an individual in the population.}

\item{eqtl}{Txt file with all or top eQTL pairs from a real eQTL analysis.
Must include columns: 'gene_id', 'pval_nominal', and 'slope'.}

\item{popParams}{popParams object containing parameters for the 
 simulation of the mean expression levels for the population.
See \code{\link{popParams}} for details.}
}
\value{
popParams object containing the estimated parameters.
}
\description{
Estimate simulation parameters for the eQTL population simulation from
real data. See the individual estimation functions for more details on
how this is done.
}
\seealso{
\code{\link{popEstimate.ES}},  \code{\link{popEstimate.MeanCV}}
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pop-simulate.R
\name{pop.random.genes}
\alias{pop.random.genes}
\title{Generating eQTL key matrix with random genes}
\usage{
pop.random.genes(popParams, vcf)
}
\arguments{
\item{popParams}{popParams object containing parameters for the 
 simulation of the mean expression levels for the population.
See \code{\link{popParams}} for details. Default=`newPopParams()`.}

\item{vcf}{output from `pop.parse.vcf`}
}
\value{
The partial eQTL key dataframe.
}
\description{
Generating eQTL key matrix with random genes
}

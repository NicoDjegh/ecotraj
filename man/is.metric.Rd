% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is.metric.R
\encoding{UTF-8}
\name{is.metric}
\alias{is.metric}
\title{Metricity}
\usage{
is.metric(x, tol = 1e-04)
}
\arguments{
\item{x}{Either an object of class \code{trajectories},  a symmetric \code{\link{matrix}} or an object of class \code{\link{dist}} containing the distance values between pairs of ecological states.}

\item{tol}{Tolerance value for metricity}
}
\value{
A boolean indicating metric property
}
\description{
Checks whether the input dissimilarity matrix is metric (i.e. all triplets fulfill the triangle inequality).
}
\author{
Miquel De \enc{Cáceres}{Caceres}, CREAF
}

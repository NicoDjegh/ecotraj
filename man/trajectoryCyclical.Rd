% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trajectoryCyclical.R
\encoding{UTF-8}
\name{trajectoryCyclical}
\alias{trajectoryCyclical}
\alias{extractCycles}
\alias{extractFixedDateTrajectories}
\alias{cycleConvexity}
\alias{cycleShifts}
\alias{cycleMetrics}
\alias{cycles}
\alias{fd.trajectories}
\title{Functions for Cyclical Ecological Trajectory Analysis}
\usage{
extractCycles(
  x,
  cycleDuration,
  dates = NULL,
  startdate = NA,
  externalBoundary = "end",
  minEcolStates = 3
)

extractFixedDateTrajectories(
  x,
  cycleDuration,
  dates = NULL,
  fixedDate = NULL,
  namesFixedDate = NULL,
  minEcolStates = 2
)

cycleConvexity(
  x,
  cycleDuration,
  dates = NULL,
  startdate = NA,
  externalBoundary = "end",
  minEcolStates = 3,
  add = TRUE
)

cycleShifts(
  x,
  cycleDuration,
  dates = NULL,
  datesCS = NULL,
  centering = TRUE,
  minEcolStates = 3,
  add = TRUE
)

cycleMetrics(
  x,
  cycleDuration,
  dates = NULL,
  startdate = NA,
  externalBoundary = "end",
  minEcolStates = 3,
  add = TRUE
)
}
\arguments{
\item{x}{An object of class \code{\link{trajectories}} describing a cyclical trajectory.}

\item{cycleDuration}{A value indicating the duration of a cycle. Must be in the same units as times.}

\item{dates}{An optional vector indicating the dates (< \code{cycleDuration}) corresponding to each ecosystem state. Must be in the same units as times. Defaults to times modulo cycleDuration (see details).}

\item{startdate}{An optional value indicating at which date the cycles must begin. Must be in the same units as times. Defaults to \code{min(dates)}.}

\item{externalBoundary}{An optional string, either \code{"end"} or \code{"start"}, indicating whether the start or end of the cycles must be considered "external". Defaults to \code{"end"}.}

\item{minEcolStates}{An optional integer indicating the minimum number of ecological states to return a fixed-date trajectory. Fixed-date trajectories comprising less ecological states than minEcolStates are discarded and do not appear in the output of the function. Defaults to 2.}

\item{fixedDate}{An optional vector of dates for which fixed-date trajectories must be computed. Defaults to \code{unique(dates)}, resulting in returning all possible fixed-date trajectories.}

\item{namesFixedDate}{An optional vector of names associated to each \code{fixedDate}. Defaults to \code{round(fixedDate,2)}.}

\item{add}{Flag to indicate that constant values should be added (local transformation) to correct triplets of distance values that do not fulfill the triangle inequality.}

\item{datesCS}{An optional vector indicating the dates for which a cyclical shift must be computed. Default to \code{unique(dates)} resulting in the computation of all possible cyclical shifts.}

\item{centering}{An optional boolean. Should the cycles be centered before computing cyclical shifts? Defaults to \code{TRUE}.}
}
\value{
Function \code{extractCycles} returns the base information needed to describe cycles. Its outputs are meant to be used as input for other ETA functions. Importantly, within cycles, ecological states can be considered "internal" or "external". Some operations and metrics within ETA use all ecological states whereas others use only "internal" ones (see details). Function \code{extractCycles} returns an object of class \code{cycles} containing:
\itemize{
\item{\code{d}: an object of class \code{\link{dist}}, the new distance matrix describing the cycles. To take in account ecological states that are both the end of a cycle and the start of another,\code{d} contains duplications. As compared to the input matrix, \code{d} may present deletions of ecological states that do not belong to any cycles (e.g. due to \code{minEcolStates}))}
\item{\code{metadata}: an object of class \code{\link{data.frame}} describing the ecological states in \code{d} with columns:
\itemize{
\item{\code{sites}: the sites associated to  each ecological states.}
\item{\code{Cycles}: the names of the cycle each ecological states belongs to. The cycle name is built by combining the site name with C1, C2, C3... in chronological order.}
\item{\code{surveys}: renumbering of the surveys to describe individual Cycles.}
\item{\code{times}: the times associated to each ecological states.}
\item{\code{internal}: a boolean vector with \code{TRUE} indicating "internal" ecological states whereas \code{FALSE} indicates "external" ecological states. This has implications for how the outputs of \code{extractCycles} are treated by other ETA functions (see details).}
\item{\code{dates}: the dates associated to each ecological states.}
}
}
\item{\code{interpolationInfo}: an output that only appear if ecological states have been interpolated. It is used internally by plotting functions (see \code{\link{cyclePCoA}}) but is not intended to be of interest to the end user.}
}

Function \code{extractFixedDateTrajectories} returns the base information needed to describe fixed-date trajectories. Its outputs are meant to be used as inputs for other ETA functions in order to obtain desired metrics. Function \code{extractFixedDateTrajectories} returns an object of class \code{fd.trajectories} containing:
\itemize{
\item{\code{d}: an object of class \code{\link{dist}}, the new distance matrix describing the fixed-date trajectories. As compared to the input matrix, \code{d} may present deletions of ecological states that do not belong to any fixed-date trajectories (e.g. due to \code{minEcolStates}))}
\item{\code{metadata}: an object of class \code{\link{data.frame}} describing the ecological states in \code{d} with columns:
\itemize{
\item{\code{sites}: the sites to  each ecological states.}
\item{\code{fdT}: the names of the fixed-date trajectory each ecological states belongs to. The fixed-date trajectory name is built by combining the site name with "fdT" and the name of the fixed date (from \code{namesFixedDate}).}
\item{\code{surveys}: renumbering of the surveys to describe individual fixed date trajectories.}
\item{\code{times}: the times associated to each ecological states.}
\item{\code{dates}: the dates associated to each ecological states.}
}
}
}

Function \code{cycleConvexity} returns the a vector containing values between 0 and 1 describing the convexity of cycles. Importantly, outputs of \code{extractCycles} should not be used as inputs for \code{cycleConvexity} (see details).

Function \code{cycleShifts} returns an object of class \code{\link{data.frame}} describing cyclical shifts (i.e. advances and delays). Importantly, outputs of \code{extractCycles} should not be used as inputs for \code{cycleShifts} (see details). The columns of the \code{\link{data.frame}} are:
\itemize{
\item{\code{site}: the site for which each cycle shift has been computed.}
\item{\code{dateCS}: the date for which a cycle shift has been computed.}
\item{\code{timeCS}: the time of the ecological state for which a cycle shift has been computed (i.e. the time associated to the projected ecological state).}
\item{\code{timeRef}: the time associated to the reference ecological state.}
\item{\code{timeScale}: the time difference between the reference and the projected ecological state.}
\item{\code{cyclicalShift}: the cyclical shift computed (an advance if positive, a delay if negative) in the same units as the times input.}
}

Function \code{cycleMetrics} returns a data frame where rows are cycles and columns are different cycle metrics.
}
\description{
The Cyclical extension of Ecological Trajectory Analysis (CETA) aims at allowing ETA to describe ecological trajectories presenting cyclical dynamics such as seasonal or day/night cycles. We call such trajectories "cyclical".
CETA operates by subdividing cyclical trajectories into two types of sub-trajectories of interest: cycles and fixed-date trajectories.
\itemize{
\item{Cycles are sub-trajectories joining the ecological states belonging to the same cycle.}
\item{Fixed-date trajectories are sub-trajectories joining the ecological states of the same date in different cycles (e.g. in a multi-annual cyclical trajectory with seasonality, a fixed-date trajectory might join all the ecological states associated with the January months of the different years).}
}
We recommend reading the vignette on CETA prior to use it.The CETA functions provided here achieve one of two goals:
\enumerate{
\item Reformatting data to analyze either cycles or fixed-date trajectories. The reformatted data can then be fed into existing ETA functions to obtain desired metrics (although special care need to be taken with cycles, see details).
\item Providing new metrics relevant to cycles complementing other ETA functions.
}
}
\details{
CETA functions:
\itemize{
\item{Function \code{extractCycles} reformats an object of class \code{\link{trajectories}} describing one or more cyclical trajectories into a new object of class \code{\link{trajectories}} designed for the analysis cycles.}
\item{Function \code{extractFixedDateTrajectories} reformats an object of class \code{\link{trajectories}} describing one or more cyclical trajectories into a new object of class \code{\link{trajectories}} designed for the analysis fixed-date trajectories.}
\item{Function \code{cycleConvexity} computes the "convexity" of the cycles embedded in one or more cyclical trajectories.}
\item{Function \code{cycleShifts} computes the cyclical shifts (i.e. advances and delays) that can be obtain from one or more cyclical trajectories.}
}

CETA is a little more time-explicit than the rest of ETA. Hence the parameter \code{times} is needed to initiate the CETA approach (classical ETA functions can work from \code{surveys} which is only ordinal).
CETA also distinguishes between times and dates. Times represent linear time whereas dates represent circular time (e.g. the month of year). Dates are circular variables, coming back to zero when reaching their maximum value \code{cycleDuration} corresponding to the duration of a cycle.
In CETA, dates are by default assumed to be \code{times} modulo \code{cycleDuration}. This should fit many applications but if this is not the case (i.e. if there is an offset between times and dates), dates can be specified. \code{dates} however need to remain compatible with \code{times} and \code{cycleDuration} (i.e. (times modulo cycleDuration) - (dates modulo cycleDuration) needs to be a constant).

IMPORTANT: Cycles within CETA comprises both "internal" and "external" ecological states (see the output of function \code{extractCycles}). This distinction is a solution to what we call the "December-to-January segment problem". Taking the example of a monthly resolved multi-annual time series, a way to make cycles would be to take the set of ecological states representing months from January to December of each year. However, this omits the segment linking December of year Y to January of year Y+1. However, including this segments means having two January months in the same cycle.
The proposed solution in CETA (in the case of this specific example) is to set the January month of year Y+1 as "external". "external" ecological states need a specific handling for some operation in ETA, namely:
\itemize{
\item{Centering where external ecological states must be excluded from computation but included nonetheless in the procedure. This is handled automatically by the function \code{\link{centerTrajectories}}.}
\item{Trajectory internal variability, where external ecological states must be excluded. This handled directly by the \code{\link{trajectoryInternalVariation}} function.}
\item{Visualization through principal coordinate analysis of the cycles. The dedicated function \code{\link{cyclePCoA}} must be preferred over \code{\link{trajectoryPCoA}}.}
}

As a general rule the outputs of \code{extractCycles} should be used as inputs in other, non-CETA function (e.g. \code{trajectoryDistances}).
There is three important exceptions to that rule: the functions \code{cycleConvexity}, \code{cycleShifts} and \code{cycleMetrics}. Instead, the inputs of these three functions should parallel the inputs of \code{extractCycles} in a given analysis.
For \code{cycleConvexity}, this is because convexity uses angles obtained from the whole cyclical trajectory, and not only the cycles. For \code{cycleShifts}, this is because cyclical shifts are not obtained with respect to a particular set of cycles. For \code{cycleMetrics}, this is because it calls \code{cycleConvexity}.
The function instead compute the most adapted set of cycles to obtain the metric.

Note: Function \code{cycleShifts} is computation intensive for large data sets, it may not execute immediately.

Further information and detailed examples of the use of CETA functions can be found in the associated vignette.
}
\examples{
#First build a toy dataset with:
#The sampling times of the time series
timesToy <- 0:30 

#The duration of the cycles (i.e. the periodicity of the time series)
cycleDurationToy <- 10 

#The sites sampled (only one named "A")
sitesToy <- rep(c("A"),length(timesToy)) 

#And prepare a trend term
trend <- 0.05

#Build cyclical data (note that we apply the trend only to x):
x <- sin((timesToy*2*pi)/cycleDurationToy)+trend*timesToy
y <- cos((timesToy*2*pi)/cycleDurationToy)
matToy <- cbind(x,y)

#And express it as distances:
dToy <- dist(matToy)

#Make it an object of class trajectory:
cyclicalTrajToy <- defineTrajectories(d = dToy,
                                      sites = sitesToy,
                                      times = timesToy)

#At this stage, cycles and / or fixed date trajectories are not isolated.
#This done with the two CETA "extract" functions:
cyclesToy <- extractCycles(x = cyclicalTrajToy,
                           cycleDuration = cycleDurationToy)
fdTrajToy <- extractFixedDateTrajectories(x = cyclicalTrajToy,
                                          cycleDuration = cycleDurationToy)

#The output of these functions can be used as input
#for other ETA functions to get metrics of interest
#such as trajectory length:
trajectoryLengths(x = cyclesToy)
trajectoryLengths(x = fdTrajToy)

#or distances between trajectories:
trajectoryDistances(x = cyclesToy)
trajectoryDistances(x = fdTrajToy)

#In addition CETA adds two additional specific metrics.
#that require the same inputs as function extractCycles():
cycleConvexity(x = cyclicalTrajToy,
               cycleDuration = cycleDurationToy)
#The NA with the first cycle, is expected:
#Cycle convexity cannot be computed right at the boundary of the time series
cycleShifts(x = cyclicalTrajToy,
            cycleDuration = cycleDurationToy)
#Note that because our cycles are perfectly regular here, the cyclicalShift
#computed are all 0 (or close because of R's computing approximations)

#Subsetting cycles and fixed date trajectories:
subsetTrajectories(cyclesToy,
                   subtrajectory_selection = "A_C1") 
subsetTrajectories(fdTrajToy,
                   subtrajectory_selection = c("A_fdT_2","A_fdT_4"))
                
#General metrics describing the geometry of cycles:
cycleMetrics(x = cyclicalTrajToy,
             cycleDuration = cycleDurationToy)
             

}
\references{
Djeghri et al. (in preparation) Going round in cycles, but going somewhere: Ecological Trajectory Analysis as a tool to decipher seasonality and other cyclical dynamics.
}
\seealso{
\code{\link{trajectoryCyclicalPlots}}, \code{\link{trajectoryMetrics}}, \code{\link{trajectoryComparison}}
}
\author{
Nicolas Djeghri, UBO

Miquel De \enc{Cáceres}{Caceres}, CREAF
}

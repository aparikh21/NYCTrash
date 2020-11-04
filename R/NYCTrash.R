#' Monthly NYC Trash by Borough
#'
#' This package contains specifications of the different types of trash
#' collected monthly by borough in NYC
#' @docType package
#' @name NYCTrash
#' @aliases NYCTrash NYCTrash-package
NULL

#' "NYCTrash"
#'
#' A data set containing different types of trash
#' collected monthly by borough in NYC
#' as of October 8, 2020
#'
#' @source \url{https://data.cityofnewyork.us/City-Government/DSNY-Monthly-Tonnage-Data/ebb7-mvp5}
#' @format A dataframe with 21048 elements
#' \describe{
#'   \item{year}{Trash collected in which year}
#'   \item{month}{Trash collected in which month}
#'   \item{borough}{One of the 5 Boroughs within NYC}
#'   \item{community_district}{One of NYC's 59 community districts corresponding to sanitation districts}
#'   \item{refuse_tons_collected}{Tons of trash of refuse collected from NYC residences}
#'   \item{paper_tons_collected}{Tons of source-separated recycable paper collected}
#'   \item{mpg_tons_collected}{Tons of ecyclable metal, glass, and plastics collected}
#'   \item{organics_tons_collected}{Tons of source-separated residential organics collected}
#'   \item{school_organics}{Tons of source-separated organics collected from NYC schools}
#'   \item{leaves_organics}{Tons of source-separated leaves collected in November and December}
#'   \item{xmas_trees}{Tons of Christmas trees collected curbside}
#'   \item{borough_id}{ID used to identify NYC Boroughs}
#' }
"NYCTrash"


<!-- README.md is generated from README.Rmd. Please edit that file -->

# NYCTrash

<!-- badges: start -->

![R-CMD-check](https://github.com/aparikh21/NYCTrash/workflows/R-CMD-check/badge.svg)
<!-- badges: end -->

The goal of NYCTrash is to understand chnages in monthly trash patterns
in NYC by borough.

## Installation

You can install the released version of NYCTrash from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("NYCTrash")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aparikh21/NYCTrash")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(NYCTrash)
library(mosaic)
#> Registered S3 method overwritten by 'mosaic':
#>   method                           from   
#>   fortify.SpatialPolygonsDataFrame ggplot2
#> 
#> The 'mosaic' package masks several functions from core packages in order to add 
#> additional features.  The original behavior of these functions should not be affected by this.
#> 
#> Attaching package: 'mosaic'
#> The following objects are masked from 'package:dplyr':
#> 
#>     count, do, tally
#> The following object is masked from 'package:Matrix':
#> 
#>     mean
#> The following object is masked from 'package:ggplot2':
#> 
#>     stat
#> The following objects are masked from 'package:stats':
#> 
#>     binom.test, cor, cor.test, cov, fivenum, IQR, median, prop.test,
#>     quantile, sd, t.test, var
#> The following objects are masked from 'package:base':
#> 
#>     max, mean, min, prod, range, sample, sum
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ tibble  3.0.4     ✓ purrr   0.3.4
#> ✓ tidyr   1.1.2     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.0
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x mosaic::count()            masks dplyr::count()
#> x purrr::cross()             masks mosaic::cross()
#> x mosaic::do()               masks dplyr::do()
#> x tidyr::expand()            masks Matrix::expand()
#> x dplyr::filter()            masks stats::filter()
#> x ggstance::geom_errorbarh() masks ggplot2::geom_errorbarh()
#> x dplyr::lag()               masks stats::lag()
#> x tidyr::pack()              masks Matrix::pack()
#> x mosaic::stat()             masks ggplot2::stat()
#> x mosaic::tally()            masks dplyr::tally()
#> x tidyr::unpack()            masks Matrix::unpack()
library(ggplot2)
knitr::opts_chunk$set(
  tidy=FALSE,     # display code as typed
  size="small")   # slightly smaller font for code
```

``` r
time <- NYCTrash %>%
  group_by(year, borough) %>%
  summarize(refuse_tons_collected = sum(refuse_tons_collected))

ggplot(
  time,
  aes(x = as.numeric(year), y = refuse_tons_collected, color = borough)
) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(1990, 2020, 5)) +
  labs(x = "Year", y = "Tons of Refuse Trash Collected") +
  ggtitle("Changes in Tons of Trash Collected with Time by Borough")
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

Tons of trash collected in NYC have not significantly increased or
decreased since the 1990s. 2020 seems to be an unusual year where the
tons of trash collected has significantly decreased which could be due
to less consumption caused by the pandemic.

Brooklyn is the borough with the most refuse tons of trash collected
every year after 1991 while Queens is the borough with the second most
tons of refuse trash collected. It is interesting to note that the trash
collected in Queens, Brooklyn and Manhattan increase dramatically
between 1990 and 1991. It could be worth examining the reason behind
this dramatic increase in trash collected.

The trends during the last 20 years have been similar for all boroughs.
All boroughs saw a spike in trash collected in 2003 and all saw declines
in trash collected in 2020. The fact that trends have stayed the same
between all boroughs could reveal the fact that no borough is
significantly improving or becoming worse, hence keeping the ratio of
the population in the boroughs roughly
similar.

### b) Is there an association between time of year and the amount of refuse trash collected?

SOLUTION:

``` r
seasonal_trash <- NYCTrash %>%
  group_by(month, year) %>%
  summarize(refuse = sum(refuse_tons_collected)) %>%
  mutate(month = as.numeric(month)) %>%
  mutate(season = ifelse(month %in% 3:5, "Spring",
                                     ifelse(month %in% 6:8, "Summer", 
                                            ifelse(month %in% 9:11, "Fall", "Winter"))))


ggplot(seasonal_trash,
  aes(x = as.numeric(year), y = refuse, color = season)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE, span = 0.5) + 
  scale_x_continuous(breaks=seq(1990, 2020, 5)) +
  scale_color_manual(breaks = c("Fall", "Spring", "Summer", "Winter"),
                        values=c("tomato3", "limegreen", "deepskyblue3", "black")) +
  labs(x = "Year", y = "Tons of Trash Collected") + 
  ggtitle("Trash Collected in NYC by season since 1990")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" /> The
winter months of December, January and February have consistently had
the lowest amount of trash collected. A possible reason for this could
be that people do not go out and consume less during the colder months.
On the other hand, the summer months of June, July and August have had
the most trash collected suggesting that people consume the most during
the warmest months.

The fall months and spring months have more or less followed similar
trends (the decline in the fall line after 2015 is misleading because
the line is severely influenced by 2020 fall trash collection.) It would
be interesting to investigate the reason behind this drop in tons of
trash collected in the fall months of 2020, but it would presumably be
because of the pandemic.

Yearly changes in trash collection seems to affect seasonal consumption
evenly because the four lines seem to follow similar trends\!

# source('init.r')

# ----------- # # ----------- # # ----------- #
# DEPENDENCIES
# dependencies <- c('reshape', 'knitr', 'markdown', 'ggplot2', 'scales', 'dplyr', 'RColorBrewer', 'stringr', 'lubridate', 'readr', 'googleAnalyticsR', 'gtrendsR', 'tm', 'bcrypt', 'data.table')
dependencies <- c('reshape', 'knitr', 'markdown', 'ggplot2', 'scales', 'dplyr', 'RColorBrewer', 'stringr', 'lubridate', 'readr', 'googleAnalyticsR', 'gtrendsR')
lapply(dependencies, require, character.only = TRUE)

# ----------- # # ----------- # # ----------- #
# SET UP

# Env
source('env.R')

# helper functions

loadDir <- function(dir) {
  if (file.exists(dir)) {
    files <- dir(dir , pattern = '[.][rR]$')
    lapply(files, function(file) loadFile(file, dir))
  }
}

loadFile <- function(file, dir) {
  filename <- paste0(dir, '/', file)
  source(filename)
}

setReportingWd <- function() {
  if(basename(getwd()) == 'templates') {
    setwd('../../')
  }
}

# knitrGlobalConfig <- function() {
#   opts_chunk$set(fig.width = 14, fig.height = 6,
#     fig.path = paste0(getwd(), '/reports/output/figures/',
#     set_comment = NA))
# }

setEnvVars <- function() {
  source('env.R')
}

# Google Analytics
gaSetUp <- function() {
  googleAuthR::gar_set_client(json = 'secrets/google-oauth.json')
  ga_auth(email = Sys.getenv('GA_EMAIL'), json_file = 'secrets/ga-key.json')
}

# Config env
setReportingWd()
# knitrGlobalConfig()
# setEnvVars() if you have env vars

# Load code
dirs <- c('extract', 'load', 'transform', 'plots', 'lib', 'models')
lapply(dirs, loadDir)
source('./reports/run.R')

# No scientific notation
options(scipen = 999)

# ----------- # # ----------- # # ----------- #
# GA VARS
GA_ID = Sys.getenv('GA_ID')
GA_START_DATE = '2020-05-01'
GA_END_DATE = Sys.Date() - 1
GA_PURCHASE_GOAL = 'goal1Completions'
GA_VALUE = 'goalValueAll'

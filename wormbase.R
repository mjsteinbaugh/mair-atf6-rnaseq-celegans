# Gene annotations from WormBase
# Michael Steinbaugh
# 2018-04-26
# BiocInstaller::biocLite("steinbaugh/basejump")
# BiocInstaller::biocLite("steinbaugh/wormbase")
# BiocInstaller::biocLite("tidyverse")
library(basejump)
library(wormbase)
library(tidyverse)

dir <- "wormbase"
version <- "WS263"

description <- description(version = version)
geneOtherIDs <- geneOtherIDs(version = version)
orthologs <- orthologs(version = version)
saveData(description, geneOtherIDs, orthologs, dir = file.path("data", Sys.Date()))

# Collapse nested data frames before writing as CSV
geneOtherIDs <- geneOtherIDs %>%
    rowwise() %>%
    mutate_if(is.list, funs(paste(., collapse = ", "))) %>%
    ungroup() %>%
    fixNA()
orthologs <- orthologs %>%
    rowwise() %>%
    mutate_if(is.list, funs(paste(., collapse = ", "))) %>%
    ungroup() %>%
    fixNA()

# Write out the CSV files
dir.create("wormbase")
x <- list(
    description = description,
    geneOtherIDs = geneOtherIDs,
    orthologs = orthologs
)
invisible(mapply(
    FUN = write_csv,
    x = x,
    path = file.path("wormbase", paste0(names(x), ".csv.gz"))
))

library(bcbioRNASeq)  # v0.2.2
bcb <- bcbioRNASeq(
    uploadDir = "bcbio/final",
    sampleMetadataFile = "sample_metadata.csv",
    organism = "Caenorhabditis elegans",
    ensemblRelease = 90L
)
flatFiles <- flatFiles(bcb)
saveData(bcb, flatFiles, dir = file.path("data", Sys.Date()))

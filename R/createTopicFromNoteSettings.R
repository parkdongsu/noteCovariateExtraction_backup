#' Custom createCoveriate Settings
#'
#' This function is Custom createCoveriate Settings.
#' @param useTopicFromNote use = TURE, not use = FALSE
#' @keywordsa createCovariateSetting
#' @export
#' @examples
#' createTopicFromNoteSettings()
createTopicFromNoteSettings <- function(useTopicFromNote = TRUE,
                                        noteConceptId = c(44814637),
                                        useDictionary=TRUE,
                                        targetLanguage = c('KOR','ENG'),
                                        limitedMedicalTermOnlyLanguage = c('KOR','ENG'),
                                        nGram = 1L,
                                        buildTopicModeling= FALSE,
                                        buildTopidModelMinFrac = 0.01,
                                        existingTopicModel = NULL,
                                        useTextToVec = FALSE,
                                        useTopicModeling=FALSE,
                                        numberOfTopics=10L,
                                        optimalTopicValue =TRUE,
                                        useGloVe = FALSE,
                                        latentDimensionForGlove = 100L,
                                        useAutoencoder=FALSE,
                                        latentDimensionForAutoEncoder = 100L,
                                        sampleSize=-1){
    #if(!useDictionary) stop('Currently you should use at least one dictionary to extract medical terms only')
    if ( sum(limitedMedicalTermOnlyLanguage %in% targetLanguage==FALSE)>=1 ) stop (paste('Select dictionary among target Languages :',
                                                                                         paste(targetLanguage,collapse=" ")))
    if (sum(targetLanguage %in% limitedMedicalTermOnlyLanguage) != length(targetLanguage)) stop("It contains an unimplemented language.
                                                                                                Implemented languages are c ('KOR', 'ENG').")
    if (sum (useTextToVec,useTopicModeling,useGloVe,useAutoencoder) != 1 ) {
        stop("Choose only one among useTextToVec,useTopicModeling,useGloVe,useAutoencoder")
    }
    if(!(useTextToVec|useTopicModeling) & !(nGram > 1)){
        stop('Use ngram only for useTextToVec,useTopicModeling')
    }
    covariateSettings <- list(useTopicFromNote = useTopicFromNote,
                              noteConceptId = noteConceptId,
                              useDictionary=useDictionary,
                              limitedMedicalTermOnlyLanguage=limitedMedicalTermOnlyLanguage,
                              nGram=nGram,
                              buildTopicModeling = buildTopicModeling,
                              buildTopidModelMinFrac = buildTopidModelMinFrac,
                              existingTopicModel = if(is.null(existingTopicModel)){existingTopicModel = NULL}else{readRDS(existingTopicModel)},
                              targetLanguage = targetLanguage,
                              useTextToVec=useTextToVec,
                              useTopicModeling=useTopicModeling,
                              numberOfTopics = numberOfTopics,
                              optimalTopicValue =optimalTopicValue,
                              useGloVe=useGloVe,
                              useAutoencoder=useAutoencoder,
                              sampleSize=sampleSize)
    if(buildTopicModeling == FALSE){
        attr(covariateSettings,'fun') <- 'getTopicFromNoteSettings'
    }
    else{
        attr(covariateSettings,'fun') <- 'buildTopicModeling'
    }
    class(covariateSettings) <- 'covariateSettings'
    return(covariateSettings)
}

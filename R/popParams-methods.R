#' @rdname newParams
#' @importFrom methods new
#' @export
newPopParams <- function(...) {
    
    params <- new("popParams")
    params <- setParams(params, ...)

    return(params)
}


#' @importFrom checkmate checkInt checkIntegerish checkNumber checkNumeric
#' checkFlag
setValidity("popParams", function(object) {
    
    v <- getParams(object, c(slotNames(object)))
    
    checks <- c(eqtl.n = checkNumber(v$eqtl.n, lower = 0),
                eqtl.dist = checkInt(v$eqtl.dist, lower = 1),
                eqtl.maf.min = checkNumber(v$eqtl.maf.min, lower = 0, upper = 0.5),
                eqtl.maf.max = checkNumber(v$eqtl.maf.max, lower = 0, upper = 0.5),
                eqtl.ES.shape = checkNumber(v$eqtl.ES.shape, lower = 0),
                eqtl.ES.rate = checkNumber(v$eqtl.ES.rate, lower = 0),
                eqtl.groups = checkNumber(v$eqtl.groups, lower = 1),
                eqtl.group.specific =checkNumber(v$eqtl.group.specific, 
                                                 lower = 0, upper = 1),
                pop.mean.shape = checkNumber(v$pop.mean.shape, lower = 0),
                pop.mean.rate = checkNumber(v$pop.mean.rate, lower = 0),
                pop.cv.bins = checkInt(v$pop.cv.bins, lower=1),
                pop.cv.param = checkDataFrame(v$pop.cv.param))
    
    if (all(checks == TRUE)) {
        valid <- TRUE
    } else {
        valid <- checks[checks != TRUE]
        valid <- paste(names(valid), valid, sep = ": ")
    }
    
    return(valid)
})


#' @importFrom methods callNextMethod
setMethod("show", "popParams", function(object) {
    
    pp <- list("eQTL.General:" = c("[eqtl.n]"    = "eqtl.n",
                                   "[eqtl.dist]" = "eqtl.dist",
                                   "[eqtl.maf.min]" = "eqtl.maf.min",
                                   "[eqtl.maf.max]" = "eqtl.maf.max",
                                   "[eqtl.groups]" = "eqtl.groups",
                                   "[eqtl.group.specific]" = "eqtl.group.specific"),
               "eQTL.Effect Size:" = c("(eqtl.ES.shape)" = "eqtl.ES.shape",
                                       "(eqtl.ES.rate)" = "eqtl.ES.rate"),
               "eQTL.Population:" = c("(mean.shape)" = "pop.mean.shape",
                                "(mean.rate)" = "pop.mean.rate",
                                "[cv.bins]" = "pop.cv.bins",
                                "(cv.params)" = "pop.cv.param"))
    
    callNextMethod()
    showPP(object, pp)
})


#' @rdname setParam
setMethod("setParam", "popParams", function(object, name, value) {
    checkmate::assertString(name)
    
    if (name == "nCells") {
        warning(name, " only used if genes='random'")
    }
    
    if (name == "pop.cv.param") {
        if (getParam(object, "pop.cv.bins") != nrow(value)) {
            stop("Need to set pop.cv.bins to length of pop.cv.param")
        }
    }
    
    if (name == "eqtl.groups") {
        if (getParam(object, "eqtl.groups") > 1 & 
            getParam(object, "eqtl.group.specific") == 0) {
            stop("Simulating multiple groups with 0% group-specific eQTL
                 will result in identical groups... Change eqtl.groups to 1
                 or specify a eqtl.group.specific => 0.01")
        }
    }
    
    if (name == "eqtl.maf.min") {
        if (getParam(object, "eqtl.maf.min") >= getParam(object, "eqtl.maf.max")) {
            stop("Range of acceptable Minor Allele Frequencies is too small...
                 Be sure eqtl.maf.min < eqtl.maf.max.")
        }
    }
    
    object <- callNextMethod()
    
    return(object)
})

#' @rdname setParams
setMethod("setParams", "popParams", function(object, update = NULL, ...) {
    
    checkmate::assertClass(object, classes = "popParams")
    checkmate::assertList(update, null.ok = TRUE)
    
    update <- c(update, list(...))
    
    object <- callNextMethod(object, update)
    
    return(object)
})

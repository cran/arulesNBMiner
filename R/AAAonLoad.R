.onLoad <-
function(libname, pkgname) {
    ## methods for S4
    ## require("methods", character = TRUE, quietly = TRUE)
    
    ## Currently, rJava has no namespace, so we have to do this:
    require("rJava")
    .jinit(c(system.file("jar", "arulesNBMiner.jar", 
                package = "arulesNBMiner")))
}

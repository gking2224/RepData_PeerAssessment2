# Turns a number and a (case-insensitive) exponent ("K", "M", "B", "T")
# into an absolute number
# e.g. (2, "K"), becomes 2000
# in the case of NA or empty exponent, the number is returned unmodified
# in the case of an unknown exponent, NA is returned
makenum <- function(n,e) {
    e <- toupper(e)
    if (is.na(e) | e == "") n
    else if (e == "K") n*10^3
    else if (e == "M") n*10^6
    else if (e == "B") n*10^9
    else if (e == "T") n*10^12
    else NA
}
source("incl/start.R")

message("*** FutureError class ...")

## Minimal
ex <- FutureError(message = "Woops")
print(ex)

cond <- tryCatch(message("Woops", appendLF = FALSE), message = identity)
ex2 <- FutureError(message = cond)
print(ex2)
stopifnot(conditionMessage(ex2) == conditionMessage(ex))

f <- future({ 42L; stop("woops") })
v <- value(f, signal = FALSE)
print(v)
ex <- FutureError(message = "Woops", future = f)
print(ex)

## Deprecated
res <- tryCatch({
  FutureError(message = "Woops", future = f, output = "Boom")
}, warning = identity)
stopifnot(inherits(res, "warning"))

message("*** FutureError class ... DONE")

source("incl/end.R")

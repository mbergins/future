source("incl/start.R")
session_uuid <- future:::session_uuid

message("*** session_uuid() ...")

id0 <- session_uuid()
print(id0)

## Reset session UUID (hack)
environment(session_uuid)$uuids <- list()

id <- session_uuid()
print(id)
stopifnot(id != id0)

## Assert that forked child processes get a unique session id
## Issue: https://github.com/HenrikBengtsson/future/issues/187
if (supportsMulticore()) {
  plan(multicore, workers = 2L)
  fs <- lapply(1:2, FUN = function(i) {
    future({
      Sys.sleep(0.2)
      session_uuid()
    })
  })
  ids <- unlist(values(fs))
  print(ids)
  stopifnot(all(ids != id), length(unique(ids)) == 2L)
}

message("*** session_uuid() ... DONE")

source("incl/end.R")

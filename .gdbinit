set disassembly-flavor intel
set history save on
set confirm no
# set new-console on
# add-auto-load-safe-path /home/pg/go/src/runtime/runtime-gdb.py
# add-auto-load-safe-path /home/pg/go/pkg/mod/golang.org/toolchain@v0.0.1-go1.21.5.linux-amd64/src/runtime/runtime-gdb.py


# Automatically go up the call frame on a failed `assert()`.
# if !$_isvoid($_any_caller_matches)
#     define hook-stop
#         while $_thread && $_any_caller_matches("^__")
#             up-silently
#         end
#     end
# end
# source /home/pg/.gdbinit-gef.py

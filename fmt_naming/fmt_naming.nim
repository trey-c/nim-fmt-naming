# Nim Fmt Naming
# GNU Lesser General Public License, version 2.1
#
# Copyright © 2020 Trey Cutter <treycutter@protonmail.com>

import os
import private/format
import compiler/pathutils

proc main() =
  if param_count() >= 1:
    var file = param_str(1)
    if file_exists(
        file) == false:
      echo "File " &
          file & " not found"
      return
    if param_count() < 2:
      echo "Need naming_style"
      return

    var write = false
    if param_count(
        ) >=
        3 and
            param_str(
        3) == "write":
      write = true
    echo fmt_naming_in_file(
        AbsoluteFile(
        file),
        param_str(
        2), write)
  else:
    echo("Usage: fmt_naming <file> <naming_style> <optional:write>")

when is_main_module:
  main()


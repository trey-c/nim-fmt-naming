version = "0.1.0"
author = "Trey Cutter"
description = "TODO"
license = "LGPL-2.1"
bin = @["fmt_naming"]
srcDir = "fmt_naming"
backend = "cpp"

# Dependencies
requires "nim >= 1.0.4"

import strutils
from os import walkDirRec
from system import gorge_ex

task dev, "Build's fmt_naming":
  exec("nim c -d:nimpretty --nimcache:/tmp/nimcache/ fmt_naming/fmt_naming.nim")

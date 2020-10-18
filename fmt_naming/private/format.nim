# Nim Fmt Naming
# GNU Lesser General Public License, version 2.1
#
# Copyright © 2020 Trey Cutter <treycutter@protonmail.com>

import
  compiler/llstream,
  compiler/idents,
  compiler/options,
  compiler/parser,
  compiler/pathutils,
  compiler/layouter,
  strutils

proc str_to_snake_case(
  str: string): string =
  for c in str:
    if c.is_upper_ascii():
      result.add("_")
      result.add(
          c.to_lower_ascii())
    else:
      result.add(c)

proc str_to_camel_case(
  str: string): string =
  var go_up = false
  for c in str:
    if go_up:
      result.add(
          c.to_upper_ascii())
      go_up = false
      continue
    if c == '_':
      go_up = true
    else:
      result.add(c)

proc fmt_naming_in_file*(
  file: AbsoluteFile,
    style: string,
    write: bool): string =
  var
    stream = ll_stream_open(
        read_file($file))
    parser: Parser
  open_parser(
      parser,
      file,
      stream,
      new_ident_cache(),
      new_config_ref())
  discard parser.parse_all()

  for i in
    0..parser.em.tokens.high:
    if parser.em.kinds[
        i] == lt_ident:
      var str = parser.em.tokens[i]
      if str[
          0].is_upper_ascii():
        continue
      case style:
      of "snake_case":
        parser.em.tokens[
            i] = str_to_snake_case(str)
      of "camel":
        parser.em.tokens[
            i] = str_to_camel_case(str)
      else:
        echo(
            "Unkown style " & style)

  result = parser.em.render_tokens()
  if write == true:
    write_file(
        file, result)

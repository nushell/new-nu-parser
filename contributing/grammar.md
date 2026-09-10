# Nushell Grammar in EBNF format

This is a descriptive, context-free grammar for the Nushell surface syntax targeted
by this repository. It is intentionally written in the reader-friendly EBNF style
used in [Crafting Interpreters](https://craftinginterpreters.com/parsing-expressions.html), rather than in executable PEG syntax.

Note that the rule name in this grammar does not map directly to [parser.rs](../src/parser.rs), still you can use it as a grammar reference.

## Notation

- `a → b` means “`a` is composed of `b`”.
- `a | b` means “choose one of `a` or `b`”.
- `x*`, `x+`, and `x?` mean zero-or-more, one-or-more, and optional `x`.
- Parentheses group alternatives.
- Quoted text is literal source text; uppercase names are lexer tokens.
- This grammar describes syntax only unless a rule is marked **parse-time semantic
  requirement** below.

## Program structure

```text
program        → shebang? terminator* statement_sequence? terminator* EOF ;
statement_sequence
               → statement (terminator+ statement)* ;
terminator     → NEWLINE | ";" ;

statement      → declaration
               | loop_statement
               | flow_statement
               | assignment
               | pipeline ;

pipeline       → pipe_element (pipe pipe_element)* ;
pipe_element    → expression_command redirection* ;
pipe           → "|" | "e>|" | "err>|" | "out+err>|" | "err+out>|" ;
redirection    → file_redirection expression ;
file_redirection
               → ">" | "o>" | ">>" | "o>>"
               | "e>" | "err>" | "e>>" | "err>>"
               | "out+err>" | "err+out>" | "o+e>" | "e+o>"
               | "out+err>>" | "err+out>>" | "o+e>>" | "e+o>>" ;
```

## Declarations, modules, and overlays

```text
declaration    → let_decl | mut_decl | const_decl | def_decl | extern_decl
               | alias_decl | module_decl | use_decl | source_decl
               | export_decl | export_env_decl | hide_decl | overlay_decl
               | plugin_use_decl ;

let_decl        → "let" binding "=" pipeline ;
mut_decl        → "mut" binding "=" pipeline ;
const_decl      → "const" binding "=" expression ;
binding        → variable_decl type_annotation? ;
variable_decl   → "$"? IDENTIFIER ;

def_decl        → "def" def_option* command_name type_params? signature
                 io_signature? block ;
def_option      → "--env" | "--wrapped" ;
extern_decl     → "extern" command_name signature ;
alias_decl       → "alias" command_name "=" pipeline ;

module_decl     → "module" module_name block | "module" module_path ;
use_decl        → "use" import_pattern ;
source_decl     → ("source" | "source-env") expression ;
export_decl     → "export" exportable_declaration ;
exportable_declaration
               → def_decl | extern_decl | alias_decl | const_decl | module_decl
               | use_decl ;
export_env_decl  → "export-env" block ;
hide_decl       → "hide" import_pattern ;

plugin_use_decl  → "plugin" "use" expression ;
overlay_decl    → "overlay" overlay_action ;
overlay_action  → "use" "--prefix"* import_pattern ("as" command_name)?
               | "hide" overlay_hide_option* command_name? overlay_hide_option*
               | "new" command_name
               | "list" ;
overlay_hide_option
               → "--keep-custom" | "--keep-env" list ;
```

## Statements and command calls

```text
assignment     → cell_ref assign_op pipeline ;
assign_op       → "=" | "+=" | "++=" | "-=" | "*=" | "/=" ;

loop_statement  → for_statement | while_statement | loop_forever ;
for_statement   → "for" variable_decl "in" expression block ;
while_statement → "while" expression block ;
loop_forever    → "loop" block ;

flow_statement  → "return" expression? | "break" | "continue" ;

expression_command
               → environment_assignment* command ;
environment_assignment
               → ENV_NAME "=" (string | variable | bare_word) ;
command        → external_call | internal_call | expression ;
external_call   → "^" external_name external_argument* ;
external_name   → command_name | variable | string ;
external_argument
               → spread | expression | bare_word | string ;
internal_call   → command_name argument* ;
argument       → flag | spread | expression | bare_word ;
flag           → long_flag (("=" expression) | expression)?
               | short_flag (("=" expression) | expression)? ;
long_flag       → "--" FLAG_NAME ;
short_flag      → "-" SHORT_FLAGS ;
spread         → "..." expression ;

command_name    → string | known_command_name | IDENTIFIER ;
known_command_name
               → IDENTIFIER IDENTIFIER+ ;
```

**Command-name semantic requirement:** command heads are scope-sensitive. The
parser/resolver must select the longest name that is a command known in the current
parse-time scope, then parse the remaining words as arguments. The EBNF rule above
only admits the possible word sequence; it does not perform name resolution.

## Expressions and precedence

Each rule accepts its own precedence level and every tighter level below it. This
makes expressions such as `1 + 2 * 3` unambiguous without precedence metadata.
Binary repetition in the following rules is left-associative unless stated otherwise.

```text
expression     → range ;
range          → logical_or (range_op logical_or? (range_op logical_or?)?)?
               | range_op logical_or? ;
range_op        → ".." | "..<" ;

logical_or      → logical_xor ("or" logical_xor)* ;
logical_xor     → logical_and ("xor" logical_and)* ;
logical_and     → bit_or ("and" bit_or)* ;
bit_or          → bit_xor ("bit-or" bit_xor)* ;
bit_xor         → bit_and ("bit-xor" bit_and)* ;
bit_and         → comparison ("bit-and" comparison)* ;
comparison     → shift (compare_op shift)* ;
compare_op      → "==" | "!=" | "<" | "<=" | ">" | ">="
               | "=~" | "!~" | "in" | "not-in" | "has" | "not-has"
               | "like" | "not-like" | "starts-with" | "not-starts-with"
               | "ends-with" | "not-ends-with" | "++" ;
shift          → addition (("bit-shl" | "bit-shr") addition)* ;
addition       → multiply (("+" | "-") multiply)* ;
multiply       → power (("*" | "/" | "//" | "mod") power)* ;
power          → unary ("**" power)? ;  // right-associative
unary          → ("not" | "+" | "-") unary | postfix ;
postfix        → primary cell_path? ;

primary        → if_expression | try_expression | match_expression
               | literal | variable | cell_path_literal | table | list | closure
               | record | block | subexpression ;
subexpression  → "(" statement_sequence? ")" ;
block          → "{" statement_sequence? "}" ;
```

## Values, collections, and paths

```text
literal        → FILESIZE | DURATION | DATE | BINARY | interpolated_string
               | raw_string | string | FLOAT | INT | BOOL | "null" ;
string         → single_quoted_string | double_quoted_string | backtick_string ;
variable       → special_variable | "$" IDENTIFIER ;
special_variable
               → "$env" | "$in" | "$it" | "$nu"
               | "$NU_LIB_DIRS" | "$NU_PLUGIN_DIRS" ;

cell_ref        → variable cell_path? | cell_path_literal ;
cell_path_literal
               → "$" cell_path ;
cell_path       → cell_member+ ;
cell_member     → "." path_member "?"? ;
path_member     → string | INT | IDENTIFIER ;

list           → "[" list_item (separator? list_item)* separator? "]"
               | "[" "]" ;
list_item       → spread | expression | bare_word ;

table          → "[" table_header ";" table_row* "]" ;
table_header    → "[" table_header_name (separator? table_header_name)* separator? "]"
               | "[" "]" ;
table_header_name
               → string | IDENTIFIER ;
table_row       → "[" table_row_value (separator? table_row_value)* separator? "]"
               | "[" "]" ;
table_row_value  → expression | bare_word ;

record         → "{" record_item (separator? record_item)* separator? "}"
               | "{" "}" ;
record_item     → record_key ":" expression ;
record_key      → string | IDENTIFIER ;

closure        → "{" "|" closure_parameter ("," closure_parameter)* ","? "|"
                 statement_sequence? "}"
               | "{" "|" "|" statement_sequence? "}"
               | "{" statement_sequence? "}" ;
closure_parameter
               → IDENTIFIER type_annotation? ;
separator      → "," | NEWLINE | ";" ;
```

## Control expressions and patterns

```text
if_expression   → "if" expression block else_clause? ;
else_clause     → "else" if_expression | "else" match_expression | "else" block ;
try_expression  → "try" block catch_clause? finally_clause? ;
catch_clause    → "catch" (closure | block) ;
finally_clause  → "finally" block ;

match_expression
               → "match" expression "{" match_arm (separator match_arm)*
                 separator? "}" ;
match_arm       → pattern guard? "=>" (expression | block) ;
guard          → "if" expression ;
pattern        → single_pattern ("|" single_pattern)* ;
single_pattern  → "_" | literal | variable | list_pattern | record_pattern ;
list_pattern    → "[" pattern ("," pattern)* ","? "]" ;
record_pattern  → "{" record_pattern_item ("," record_pattern_item)* ","? "}" ;
record_pattern_item
               → record_key ":" pattern ;
```

## Signatures, types, imports

```text
signature      → "[" signature_parameter (separator? signature_parameter)*
                 separator? "]" ;
signature_parameter
               → rest_parameter | flag_parameter | short_only_flag | positional_parameter ;
positional_parameter
               → IDENTIFIER "?"? type_annotation? default_value? ;
rest_parameter  → "..." IDENTIFIER type_annotation? ;
flag_parameter  → long_flag ("(" short_flag ")")? type_annotation? default_value? ;
short_only_flag  → short_flag type_annotation? default_value? ;
default_value   → "=" expression ;
io_signature    → ":" "[" in_out_type (separator? in_out_type)* separator? "]"
               | ":" in_out_type ;
in_out_type      → type "->" type ;
type_annotation → ":" type ("@" command_name)? ;
type           → "record" "<" record_type_field ("," record_type_field)* ","? ">" "?"?
               | IDENTIFIER type_arguments? "?"? ;
type_arguments  → "<" type ("," type)* ","? ">" ;
record_type_field
               → record_key type_annotation? ;
type_params     → "<" IDENTIFIER ("," IDENTIFIER)* ","? ">" ;

import_pattern  → module_ref import_members? ;
module_ref      → module_path | module_name ;
module_path     → PATH | string ;
module_name     → string | command_name ;
import_members  → "*" | command_name
               | "[" import_member (separator? import_member)* separator? "]"
               | "[" "]" ;
import_member   → "*" | string | command_name ;
```

## Lexer contracts

The lexer owns token boundaries, comments, escape decoding, and raw-string delimiter
matching. These are deliberately not expressed as ordinary context-free productions.

```text
line_comment    → "#" characters_until_newline ;
shebang        → "#!" characters_until_newline NEWLINE ;
skip           → (space | tab | line_comment)* ;

single_quoted_string
               → "'" any_character_until("'") "'" ;
double_quoted_string
               → '"' (escape | character_except_quote_backslash_or_newline)* '"' ;
backtick_string → "`" any_character_until("`") "`" ;
interpolated_string
               → '$"' interpolation_part* '"'
               | "$'" interpolation_part* "'" ;
```

### Raw-string lexer algorithm

Nushell raw strings begin with one or more `#` characters and use the *same count*
in their closing delimiter:

```text
raw_string       → "r" raw_delimiter raw_content raw_closing_delimiter ;
raw_delimiter    → "#"+ "'" ;
```

The equality between the number of opening and closing `#` characters is not a
regular EBNF/PEG relationship. Implement it in the lexer:

1. After reading `r`, count consecutive `#` characters as `hash_count`. Require
   `hash_count >= 1` and then require an opening `'`.
2. Scan raw content without processing escapes or interpolation.
3. At each `'`, check whether it is immediately followed by `hash_count` `#`
   characters.
4. If so, consume that quote and those hashes and emit one `RAW_STRING` token.
   Otherwise, keep scanning; that quote belongs to the content.
5. If EOF is reached first, emit an unterminated-raw-string error whose span starts
   at the opening `r`.

Examples:

```text
r#'text with 'quotes''#            // one-hash delimiter
r###'r##'nested-looking text'##'### // three-hash delimiter
r##'a '# is content; '## closes'##  // only quote + two hashes closes
```

A PEG may retain a placeholder such as `RAW_STRING ← lexer_raw_string`, but it should
not use independent `'#'+` expressions for the opener and closer because that admits
mismatched delimiters.

## Parse-time semantic requirements (not PEG)

Nushell parses a complete source unit before ordinary evaluation. Some declarations
and commands therefore have syntax *and* parse-time effects. The PEG/EBNF should
accept their structure; a resolver/semantic pass must enforce the following rules in
source order.

### Parse-time declarations and scope

- `const name = expression` requires a constant-evaluable expression. Store the
  resulting value in the parse-time constant scope.
- `def`, `extern`, `alias`, `module`, and their `export` variants register names in
  the parse-time declaration/module scope when their declaration is processed.
- Parse-time scope determines multiword command resolution and which imported or
  overlaid names are available to subsequent source.

### Parse-time loading and mutation

- `source`, `source-env`, `use`, `overlay use`, and `plugin use` require arguments
  that the parser can resolve without ordinary runtime evaluation. Where Nushell
  permits computed inputs, they must be constant-evaluable.
- Resolve the module/script/plugin during parsing, parse its contents or signatures,
  and merge the resulting declarations into the appropriate parse-time scope.
- `hide` and `overlay hide` operate on names/overlays that are known in that scope.
- Context checks are semantic: for example, `export` forms are valid only where the
  module/export context allows them.

### Diagnostics

The resolver should diagnose a non-constant parser-keyword argument at its argument
span, an unresolved path/name at the corresponding operand, and a source-order
failure with a note that Nushell resolves parser keywords before normal evaluation.

```nu
# Valid: `root` is known while this source unit is parsed.
const root = $nu.default-config-dir | path join "modules"
use $"($root)/tools.nu" *

# Invalid: ordinary `let` values do not exist until evaluation.
let root = $nu.default-config-dir
use $"($root)/tools.nu" *
```

This separation is required by Nushell's parse-then-evaluate execution model and its
restricted parse-time constant evaluation.

## Deliberate omissions

This document does not enumerate every built-in command. Built-ins and subcommands
are accepted by `internal_call`/`command_name`; their command-specific signatures and
semantics belong in the command registry, not the grammar.


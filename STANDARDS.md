## Project Coding Standards

### Build system scripts and config:

* All LibreELEC build system scripts are bash scripts (`/bin/bash`)
* Avoid backticks. Use `$()` instead
* String comparison: use `=` not `==`
* Numeric comparison: use `-eq` not `=` etc.
* For tests, `[ expr1 -o expr2 ]/[ expr1 -a expr2 ]` is preferred to the extended form `[[ expr1 ]] || [[ expr2 ]]`/`[[ expr1 ]] && [[ expr2 ]]` etc., unless short-cicruit evaluation is required as this is not supported by `-a` or `-o`. Use of the extended test syntax can result in a small optimisation due to short-circuit evaluation, which may be an important consideration. See [test constructs](https://www.tldp.org/LDP/abs/html/testconstructs.html)
* Shell variables should use braces ie. use `${FOO}` not `$FOO`
* Use double-quotes (") around variables (or sequences that include variables) when possible to avoid issues with special characters, eg. `cd "$PKG_DIR/scripts"`, although paths should no longer include spaces after #3351. See [quoting variables](https://www.tldp.org/LDP/abs/html/quotingvar.html)
* Use `. config/blah` to source a file, don't use `source config/blah`
* To be efficient, avoid forking child processes (`sed`, `cut`, etc.) when a shell built-in can be used instead
* Avoid long lines (> 90 columns) unless it aids maintainability/processing (eg. `LINUX_DEPENDS`, `PKG_DEPENDS_TARGET` etc.)
* Indent using 2 spaces within comments:
```
# include helper functions
  . config/functions

# include versioning
  . config/version
```

### Within `package.mk`:

* See [packages/readme.md](packages/readme.md) for more detailed package structure information
* When using git revisions, the full 40-char revision is to be used
* Prefix package specific variables with `PKG_` as they are automatically unset before `package.mk` is sourced
* When creating a directory, related lines are indented:
```
  cd $INSTALL/blah
    cp -P foo $INSTALL/blah
```
* The use of `foo && bar` is allowed, but care should be taken so that package functions do not unintentionally exit with a non-zero exit code in which case `foo && bar || true` may be required, or alternatively use the multi-line `if foo then; bar fi` pattern in place of `foo && bar`


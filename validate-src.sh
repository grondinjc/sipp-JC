#!/bin/sh
err=0
TAB=`printf '\t'`

files_with_tabs=`\
    find src -name '*.cpp' -o -name '*.hpp' -o -name '*.c' -o -name '*.h' |
    xargs grep -l "$TAB" | sed -e 's/^/  /'`
if test -n "$files_with_tabs"; then
    echo "tabs encountered in one or more source files:" >&2
    echo "$files_with_tabs" >&2
    echo >&2
    err=$((err+1))
fi

files_with_trailing_ws=`\
    find src -name '*.cpp' -o -name '*.hpp' -o -name '*.c' -o -name '*.h' |
    xargs grep -l '[[:blank:][:cntrl:]]$' | sed -e 's/^/  /'`
if test -n "$files_with_trailing_ws"; then
    echo "trailing whitespace found in one or more source files:" >&2
    echo "$files_with_trailing_ws" >&2
    echo >&2
    err=$((err+1))
fi

files_with_two_spaces=`\
    find src -name '*.cpp' -o -name '*.hpp' -o -name '*.c' -o -name '*.h' |
    xargs grep -lE '^(  \}| [a-z_])' | sed -e 's/^/  /'`
if test -n "$files_with_two_spaces"; then
    echo "files with non-standard indentation found:" >&2
    echo "$files_with_two_spaces" >&2
    echo >&2
    err=$((err+1))
fi

exit $err

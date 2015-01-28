#!/bin/sh

CLASS_MATCH='NS([[:alpha:]]+)\*?'
CLASS_REPLACE='CP\1'

METHOD_MATCH='([[:alpha:]]+)'

VAR_MATCH='[[:alnum:]_]+'

WS='[[:blank:]]+'

M_FILE=$1
H_FILE=${1%.m}.h
H_FILE_BASE=$(basename $H_FILE)

H_FILE_MATCH="#import \"${H_FILE_BASE}\""
# H_FILE_REPLACE=$(cat $H_FILE | awk 'BEGIN { ORS="\\n"} /#import .*/ {print $0}')
H_FILE_REPLACE='@import <Foundation/Foundation.j>\n@import <AppKit/AppKit.j>\n@import \"StyleKitMock.j\"\n'

cat $1 | \
	awk "/${H_FILE_MATCH}/ { print \"${H_FILE_REPLACE}\"}; !/${H_FILE_MATCH}/ { print \$0}" | \
	sed -E -e "
		s/NSOffsetRect/CGRectOffset/g;
		s/#import/@import/g;
		s/\(${CLASS_MATCH}\)/\(${CLASS_REPLACE}\)/g;
		s/${CLASS_MATCH}(${WS}${VAR_MATCH}${WS}=)/var\2/g;
		s/[[:alpha:]]+(${WS}${VAR_MATCH}${WS}=)/var\1/g;
		s/${CLASS_MATCH}\.${METHOD_MATCH}/[CP\1 \2]/g;
		s/(\[.+\]).${METHOD_MATCH}/\[\1 \2]/g;
		s/(${VAR_MATCH})\.${METHOD_MATCH}${WS}=${WS}(.*);/\[\1 set_\2:\3\];/g
		s/${CLASS_MATCH}/CP\1/g;
		s/(=${WS})\([[:alpha:]]+\Ref\)/\1/g;
		s/\[CPImage imageNamed: (.*)\];/CPImageInBundle(\1);/g;
		s/([a-zA-Z0-9_]+)\.size/[\1 size]/g;
		" | \
	perl -0pe "s/^(\s+)var(\s+.*);\n\s+var\s(.*)\n/\1var\2,\n    \1\3/gm"

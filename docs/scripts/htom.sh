#!/usr/bin/env bash

echo "Processing $1"
base=${1//.html/}

# split .html into an empty file, a .yaml and an .htm
csplit \
	--prefix="$base." \
	--suppress-matched \
	-q \
	"$base.html" \
	'/---/' '{1}'
rm $base.00 # empty file
mv $base.01 $base.yaml
mv $base.02 $base.htm
rm $base.html

echo -e "---\n$(cat $base.yaml)" > $base.yaml
# convert html to markdown (.content)
pandoc --from html --to markdown $base.htm -o $base.content
rm $base.htm

# concat .yaml and .content into .md
cat $base.yaml $base.content > $base.markdown
rm $base.yaml $base.content


dot_dir=./dot
svg_dir=./svg
pdf_dir=./pdf
for FILE in `ls $dot_dir/*.dot`;
do
    base=$(basename "$FILE" ".dot")
    dot_file=$FILE
    pdf_file=$pdf_dir/$base.pdf
    dot -Tpdf $dot_file > $pdf_file
done

for FILE in `ls $svg_dir/*.svg`;
do
    base=$(basename "$FILE" ".svg")
    svg_file=$FILE
    pdf_file=$pdf_dir/$base.pdf
    inkscape "$svg_file" --export-filename="$pdf_file"
done

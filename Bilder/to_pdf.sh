dot_dir=./dot
svg_dir=./svg
r_dir=./R
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

for FILE in `ls $r_dir/*.R`;
do
    base=$(basename "$FILE" ".R")
    r_file=$FILE
    pdf_file=$pdf_dir/$base.pdf
    Rscript $r_file $pdf_file
done

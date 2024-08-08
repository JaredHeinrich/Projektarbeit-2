code_dir="./code/"
tex_dir="./tex/"
for filename in `ls $code_dir`;
do
    IFS='.' read base_name extension <<< "${filename}"
    chromacode -i "${code_dir}${filename}" -o "${tex_dir}${base_name}.tex" -c "" -l "" -g -f --tab-size 2 -r
done

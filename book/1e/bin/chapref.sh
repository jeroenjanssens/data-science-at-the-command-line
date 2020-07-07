function chapref() {
    sed -re 's/([\^ \-])(Chapter '$1')([;:., ])/\1\[\2\]\(#'$2'\)\3/g'
}

function allchaprefs() {
    cat $1 |
    sed -re 's/\[(Chapter [0-9]{1,2})\]\(#[a-z0-9\-]+\)/\1/g' |
    chapref "1" "chapter-1-introduction" |
    chapref "2" "chapter-2-getting-started" |
    chapref "3" "chapter-3-obtaining-data" |
    chapref "4" "chapter-4-creating-reusable-command-line-tools" |
    chapref "5" "chapter-5-scrubbing-data" |
    chapref "6" "chapter-6-managing-your-data-workflow" |
    chapref "7" "chapter-7-exploring-data" |
    chapref "8" "chapter-8-parallel-pipelines" |
    chapref "9" "chapter-9-modeling-data" |
    chapref "10" "chapter-10-conclusion" > $1.bak
    mv $1.bak $1
}

function addid() {
    sed -i -re '1s/^# ([^{]+)(\{.*$)?/# \1{#'$2'}/' $1.Rmd
}

addid "01" "chapter-1-introduction"
addid "02" "chapter-2-getting-started"
addid "03" "chapter-3-obtaining-data"
addid "04" "chapter-4-creating-reusable-command-line-tools"
addid "05" "chapter-5-scrubbing-data"
addid "06" "chapter-6-managing-your-data-workflow"
addid "07" "chapter-7-exploring-data"
addid "08" "chapter-8-parallel-pipelines"
addid "09" "chapter-9-modeling-data"
addid "10" "chapter-10-conclusion"

allchaprefs "01.Rmd"
allchaprefs "02.Rmd"
allchaprefs "03.Rmd"
allchaprefs "04.Rmd"
allchaprefs "06.Rmd"
allchaprefs "06.Rmd"
allchaprefs "07.Rmd"
allchaprefs "08.Rmd"
allchaprefs "09.Rmd"
allchaprefs "10.Rmd"


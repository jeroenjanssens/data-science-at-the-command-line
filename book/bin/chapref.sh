function chapref() {
    sed -re 's/([\^ ])(Chapter '$1')([;:., ])/\1\[\2\]\(#'$2'\)\3/g'
}

function allchaprefs() {
    cat $1 |
    sed -re 's/\[(Chapter [0-9]{1,2})\]\([a-z\-]+\)/\1/g' |
    chapref "1" "chapter-introduction" |
    chapref "2" "chapter-getting-started" |
    chapref "3" "chapter-obtaining-data" |
    chapref "4" "chapter-creating-reusable-command-line-tools" |
    chapref "5" "chapter-scrubbing-data" |
    chapref "6" "chapter-managing-your-data-workflow" |
    chapref "7" "chapter-exploring-data" |
    chapref "8" "chapter-parallel-pipelines" |
    chapref "9" "chapter-modeling-data" |
    chapref "10" "chapter-conclusion" > $1.bak
    mv $1.bak $1
}

function addid() {
    sed -i -re '1s/^# ([^{]+)(\{.*$)?/# \1{#'$2'}/' $1.Rmd
}

addid "01" "chapter-introduction"
addid "02" "chapter-getting-started"
addid "03" "chapter-obtaining-data"
addid "04" "chapter-creating-reusable-command-line-tools"
addid "05" "chapter-scrubbing-data"
addid "06" "chapter-managing-your-data-workflow"
addid "07" "chapter-exploring-data"
addid "08" "chapter-parallel-pipelines"
addid "09" "chapter-modeling-data"
addid "10" "chapter-conclusion"

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


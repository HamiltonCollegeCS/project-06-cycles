#! /bin/bash

echo "------------BEGIN TEST------------"
echo "Input to Student Program: "
cat .testing/input$1.txt
echo "Output from Student Program: "
cat .testing/input$1.txt | ./a.out | tee output$1.txt
diff output$1.txt ./.testing/output$1.txt.baseline 2>&1 > /dev/null
if [ "$?" == "0" ]; then
    echo "Woohoo! Received expected output!"
    echo "-------------END TEST-------------"
    exit "0"
else
    echo "Uh-oh...there's an issue!"
    echo "Expected: ($ = line end, weird chars = non-printable characters)"
    cat -vet ./.testing/output$1.txt.baseline
    echo "But got: ($ = line end, weird chars = non-printable characters)"
    cat -vet ./output$1.txt
    echo "-------------END TEST-------------"
    echo "Having Difficulty? Troubleshoot: "
    echo "Did your program not produce output? Run it on your own."
    echo "Don't see a difference? Double check spaces and line endings."
    exit "1"
fi

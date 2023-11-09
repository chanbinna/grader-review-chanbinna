CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# Clone the repository of the student submission to a well-known directory name (provided in starter code) This is done by the git clone command in the provided script
# Check that the student code has the correct file submitted. If they didn’t, detect and give helpful feedback about it. This is not done by the provided code, you should figure out where to add it
# Useful tools here are if and -e/-f. You can use the exit command to quit a bash script early. These are summarized in the week 5 Wednesday lecture handout
# Get the student code, the .java file with the grading tests, and any other files the script needs into the grading-area directory. The grading-area directory is created for you, but you should move the files there.
# Useful tools here might be cp (also look up the -r option to cp)
# Compile your tests and the student’s code from the appropriate directory with the appropriate classpath commands (remember that if you’re testing locally on Windows, the classpath is different). If the compilation fails, detect and give helpful feedback about it. You should add this
# Aside from the necessary javac, useful tools here are output redirection and error codes ($?) along with if
# This might be a time where you need to turn off set -e. Why?
# Run the tests and report the grade based on the JUnit output. You should add this
# Again output redirection will be useful, and also tools like grep could be helpful here


if [ ! -f "student-submission/ListExamples.java" ]; then
    echo "Error: Expected file is not found in the submission."
    exit 1
fi

cp student-submission/ListExamples.java grading-area 
cp TestListExamples.java grading-area
cp -r lib grading-area
cd grading-area

javac -cp "$CPATH" *.java || { echo "Failure to compile file"; exit 1; }
java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples > result.txt

if grep -q "Failures" result.txt; then
    echo "There are some failures in the code"
elif grep -q -i "Ok" result.txt; then
    echo "You are passed"
elif grep -q -i "Errors:" result.txt; then
    echo "There were error when running the file"
else 
    echo "We are encountering problem running the file" 
fi
exit 0

#!/bin/bash

CODE_DIR=./Code00
BUILD_DIR=./build
TEST_FOLDER=$CODE_DIR/tests

AUTO_TESTER=$BUILD_DIR/src/autotester/autotester
INTEGRATION_TEST=$BUILD_DIR/src/integration_testing/integration_testing
UNIT_TEST=$BUILD_DIR/src/unit_testing/unit_testing


stopIfFail () {
    if [ $? -ne 0 ]
    then
        echo $1
        rm -rf $BUILD_DIR
        exit 1
    fi
}

# Building the files

mkdir -p $BUILD_DIR

# clean the build files in case host make changes
rm -rf $BUILD_DIR/*
cmake -S $CODE_DIR -B $BUILD_DIR
make -C $BUILD_DIR -j4

# if build unsuccessful, exit immediately
stopIfFail "Build failed"

# Test the files
echo "Unit Testing"
$UNIT_TEST
stopIfFail "Unit testing Failed"


echo "Integration Testing"
$INTEGRATION_TEST
stopIfFail "Integration Testing Failed"

echo "Auto tester"
$AUTO_TESTER $TEST_FOLDER/Sample_source.txt $TEST_FOLDER/Sample_queries.txt $TEST_FOLDER/out.xml
stopIfFail "Auto Testing Failed"

# Clean up the build file
rm -rf $BUILD_DIR

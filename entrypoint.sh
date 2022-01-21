#!/bin/bash

CODE_DIR=./Code00
BUILD_DIR=./build
TEST_FOLDER=$CODE_DIR/tests

AUTO_TESTER=$BUILD_DIR/src/autotester/autotester
INTEGRATION_TEST=$BUILD_DIR/src/integration_testing/integration_testing
UNIT_TEST=$BUILD_DIR/src/unit_testing/unit_testing


fail () {
    echo $1
    rm -rf $BUILD_DIR
    exit 1
}

# Building the files

mkdir -p $BUILD_DIR

# clean the build files in case host make changes
rm -rf $BUILD_DIR/*
cmake -S $CODE_DIR -B $BUILD_DIR
make -C $BUILD_DIR -j4


# if build unsuccessful, exit immediately
if [ $? -ne 0 ]
then
    fail "Build failed"
fi

# Test the files
echo "Unit Testing"
$UNIT_TEST

if [ $? -ne 0 ]
then
    fail "Unit testing Failed"
fi


echo "Integration Testing"
$INTEGRATION_TEST

if [ $? -ne 0 ]
then
    fail "Integration Testing Failed"
fi

echo "Auto tester"
$AUTO_TESTER $TEST_FOLDER/Sample_source.txt $TEST_FOLDER/Sample_queries.txt $TEST_FOLDER/out.xml

if [ $? -ne 0 ]
then
    fail "Auto Testing Failed"
fi

# Clean up the build file
rm -rf $BUILD_DIR

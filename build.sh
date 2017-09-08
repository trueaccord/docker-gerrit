#!/bin/bash
FULLID="rev_${REV}_${TRAVIS_BUILD_NUMBER}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
echo "Building $DESTREPO:$fullid"

docker build . -t $DESTREPO:$FULLID
docker tag $DESTREPO:$FULLID  $DESTREPO:latest
docker push $DESTREPO:$FULLID
docker push $DESTREPO:latest


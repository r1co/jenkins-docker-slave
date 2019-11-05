#!/bin/bash

function buildImage() {
  git checkout $1
  docker build -t r1co/jenkins-docker-slave:$1 .
  docker push r1co/jenkins-docker-slave:$1
}

buildImage 'node-8'
buildImage 'node-10'
buildImage 'node-11'
buildImage 'node-12'

git checkout develop
echo "done!"

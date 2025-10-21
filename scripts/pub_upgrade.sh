#!/bin/sh

cat <<EOF
Flutter Setup

Running models pub upgrade...
EOF
cd modules/models/
dart pub upgrade --major-versions
cd ../..

echo ''
echo 'Running domain pub upgrade...'
cd modules/domain/
dart pub upgrade --major-versions
cd ../..

echo ''
echo 'Running data pub upgrade...'
cd modules/data/
dart pub upgrade --major-versions
cd ../..

echo ''
echo 'Running ui pub upgrade...'
cd modules/frameworks/ui/
dart pub upgrade --major-versions
cd ../../..

echo ''
echo 'Running api_source pub upgrade...'
cd modules/frameworks/api_source/
dart pub upgrade --major-versions
cd ../../..

echo ''
echo 'Running db_source pub upgrade...'
cd modules/frameworks/db_source/
dart pub upgrade --major-versions
cd ../../..

echo ''
echo 'Running root pub upgrade...'
dart pub upgrade --major-versions
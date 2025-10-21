#!/bin/sh

cat <<EOF
Flutter Setup

Running models build runner...
EOF
cd modules/models/
dart run build_runner build --delete-conflicting-outputs
cd ../..

echo ''
echo 'Running domain build runner...'
cd modules/domain/
dart run build_runner build --delete-conflicting-outputs
cd ../..

echo ''
echo 'Running data build runner...'
cd modules/data/
dart run build_runner build --delete-conflicting-outputs
cd ../..

echo ''
echo 'Running ui build runner...'
cd modules/frameworks/ui/
dart run build_runner build --delete-conflicting-outputs
cd ../../..

echo ''
echo 'Running api_source build runner...'
cd modules/frameworks/api_source/
dart run build_runner build --delete-conflicting-outputs
cd ../../..

echo ''
echo 'Running db_source build runner...'
cd modules/frameworks/db_source/
dart run build_runner build --delete-conflicting-outputs
cd ../../..

echo ''
echo 'Running root build runner...'
dart run build_runner build --delete-conflicting-outputs
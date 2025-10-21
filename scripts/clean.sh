#!/bin/sh

cat <<EOF
Flutter Setup

Running models flutter clean...
EOF
cd modules/models/
flutter clean
cd ../..

echo ''
echo 'Running domain flutter clean...'
cd modules/domain/
flutter clean
cd ../..

echo ''
echo 'Running data flutter clean...'
cd modules/data/
flutter clean
cd ../..

echo ''
echo 'Running ui flutter clean...'
cd modules/frameworks/ui/
flutter clean
cd ../../..

echo ''
echo 'Running api_source flutter clean...'
cd modules/frameworks/api_source/
flutter clean
cd ../../..

echo ''
echo 'Running db_source flutter clean...'
cd modules/frameworks/db_source/
flutter clean
cd ../../..

echo ''
echo 'Running root packages get...'
flutter clean
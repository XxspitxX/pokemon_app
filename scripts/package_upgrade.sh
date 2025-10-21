#!/bin/sh

cat <<EOF
Flutter Setup

Running models packages upgrade...
EOF
cd modules/models/
flutter packages upgrade
cd ../..

echo ''
echo 'Running domain packages upgrade...'
cd modules/domain/
flutter packages upgrade
cd ../..

echo ''
echo 'Running data packages upgrade...'
cd modules/data/
flutter packages upgrade
cd ../..

echo ''
echo 'Running user_interface packages upgrade...'
cd modules/frameworks/ui/
flutter packages upgrade
cd ../../..

echo ''
echo 'Running api_source packages upgrade...'
cd modules/frameworks/api_source/
flutter packages upgrade
cd ../../..

echo ''
echo 'Running db_source packages upgrade...'
cd modules/frameworks/db_source/
flutter packages upgrade
cd ../../..

echo ''
echo 'Running root packages upgrade...'
flutter packages upgrade
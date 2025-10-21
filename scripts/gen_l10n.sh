#!/bin/sh

cat <<EOF
Flutter Setup

Running user_interface gen l10n...
EOF
cd modules/frameworks/ui/
flutter gen-l10n
cd ../../..
#!/bin/sh
cat <<EOF
Business Flow Builder

Define Class Name (IE: Family):
        **CamelCase**
EOF

read name

SNAKE_NAME=$(echo $name | sed 's/\([A-Z]\)/_\1/g;s/^_//' | tr '[:upper:]' '[:lower:]')

FILE="./domain/lib/"$SNAKE_NAME"_use_case.dart"

if [ -f "$FILE" ]; then
  clear
  cat <<EOF
  BUSINESS FLOW ALREADY EXISTS!!
    PATH: $FILE
EOF
else
  #DOMAIN
  echo "RUNNING DOMAIN..."
  USE_CASE_EXT="_use_case.dart"
  DOMAIN_DIR="./modules/domain/lib/"
  DOMAIN_SNAKE_NAME=$SNAKE_NAME
  USE_CASE_FILE_NAME=$DOMAIN_SNAKE_NAME$USE_CASE_EXT
  DOMAIN_PATH=$DOMAIN_DIR$USE_CASE_FILE_NAME

  CLASS_REPOSITORY=$name"Repository"
  CLASS_USE_CASE=$name"UseCase"
  CLASS_USE_CASE_ADAPTER=$CLASS_USE_CASE"Adapter"

  cat >$DOMAIN_PATH <<EOF
import 'package:injectable/injectable.dart';

mixin $CLASS_REPOSITORY {}

mixin $CLASS_USE_CASE {}

@Injectable(as: $CLASS_USE_CASE)
class $CLASS_USE_CASE_ADAPTER implements $CLASS_USE_CASE {
  @override
  final $CLASS_REPOSITORY repository;

  $CLASS_USE_CASE_ADAPTER(this.repository);
}
EOF

  #DATA
  echo "RUNNING DATA..."
  REPOSITORY_EXT="_repository.dart"
  DATA_DIR="./modules/data/lib/"
  DATA_SNAKE_NAME=$SNAKE_NAME
  REPOSITORY_FILE_NAME=$DATA_SNAKE_NAME$REPOSITORY_EXT
  DATA_PATH=$DATA_DIR$REPOSITORY_FILE_NAME

  CLASS_API_SOURCE=$name"ApiSource"
  CLASS_REPOSITORY_ADAPTER=$name"RepositoryAdapter"
  cat >$DATA_PATH <<EOF
import 'package:domain/$USE_CASE_FILE_NAME';
import 'package:injectable/injectable.dart';

mixin $CLASS_API_SOURCE {}


@Injectable(as: $CLASS_REPOSITORY)
class $CLASS_REPOSITORY_ADAPTER implements $CLASS_REPOSITORY {
  @override
  final $CLASS_API_SOURCE apiSource;

  $CLASS_REPOSITORY_ADAPTER(this.apiSource);
}

EOF

  #LIB/DATA_SOURCE
  echo "RUNNING DATA_SOURCE API..."
  CLASS_API_SOURCE_ADAPTER=$CLASS_API_SOURCE"Adapter"
  DATA_SOURCE_API_DIR="./modules/frameworks/api_source/lib/"
  API_SOURCE_EXT="_api_source.dart"
  API_SOURCE_PATH=$DATA_SOURCE_API_DIR$SNAKE_NAME$API_SOURCE_EXT

  cat >$API_SOURCE_PATH <<EOF
import 'package:api_source/base/api_source.dart';
import 'package:data/$REPOSITORY_FILE_NAME';
import 'package:injectable/injectable.dart';

@Injectable(as: $CLASS_API_SOURCE)
class $CLASS_API_SOURCE_ADAPTER implements $CLASS_API_SOURCE {
  final ApiSource _apiSource;
  
  $CLASS_API_SOURCE_ADAPTER(this._apiSource);
}

EOF

  echo "RUNNING DATA_SOURCE DB..."
  CLASS_DB_SOURCE_ADAPTER=$name"DbSourceAdapter"
  DATA_SOURCE_DB_DIR="./modules/frameworks/db_source/lib/"
  DB_SOURCE_EXT="_db_source.dart"
  DB_SOURCE_FILE=$SNAKE_NAME$DB_SOURCE_EXT
  DB_SOURCE_PATH=$DATA_SOURCE_DB_DIR$DB_SOURCE_FILE

  cat >$DB_SOURCE_PATH <<EOF
import 'package:data/$REPOSITORY_FILE_NAME';
import 'package:db_source/base/base_database.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: $CLASS_DB_SOURCE)
class $CLASS_DB_SOURCE_ADAPTER extends BaseDatabase<T> implements $CLASS_DB_SOURCE {
}
EOF

fi

./scripts/dart_build_runner_all_modules.sh

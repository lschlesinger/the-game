#!/usr/bin/env bash

if [[ ${#@} < 1 ]]; then
  echo "Usage: $0 OPEN_API_FILE_OR_URL"
  echo "* OPEN_API_FILE_OR_URL: File path or URL to OpenAPI specification."
  exit 1
fi

OPEN_API_INPUT=$1
SCRIPT_DIR="$(dirname $0)"
OUTPUT_DIR=$SCRIPT_DIR/src/app/shared/openapi

rm -rf "$OUTPUT_DIR"
swagger-codegen generate -i "$OPEN_API_INPUT" -l typescript-angular -o "$OUTPUT_DIR" --additional-properties ngVersion=11.1.0
sed -i '' 's/: ModuleWithProviders/: ModuleWithProviders\<ApiModule\>/g' "$OUTPUT_DIR"/api.module.ts
find "$OUTPUT_DIR"/api/ -name '*.service.ts' -exec sed -i '' "s/basePath = '.*'/basePath = ''/" {} \;

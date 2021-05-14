#!/usr/bin/env sh

. ./.env

if [ ${GET_LATEST_VERSION} = "true" ]; then
  echo "# ------------------------------------------"
  echo "# UPDATE: The tag number with the latest version."
  echo "# ------------------------------------------"
  URL="https://api.github.com/repos/${REPOSITORY}/tags"
  curl \
    -H "Accept: application/vnd.github.v3+json" \
    ${URL} \
    | jq -r ".[0] | .name" \
    | sed 's|.*|s/TAG_NUMBER=.*/TAG_NUMBER=&/g|' \
    | sed -f - -i .env
  . ./.env
fi

if [ ! -f "${TAG_NUMBER}${COMPRESS_FORMAT}" ]; then
  echo "# ------------------------------------------"
  echo "# DOWNLOAD: The latest FreeCAD version."
  echo "# https://github.com/FreeCAD/FreeCAD/archive/refs/tags/${TAG_NUMBER}${COMPRESS_FORMAT}"
  echo "# ------------------------------------------"
  curl \
    -L "https://github.com/FreeCAD/FreeCAD/archive/refs/tags/${TAG_NUMBER}${COMPRESS_FORMAT}" \
    -o "${TAG_NUMBER}${COMPRESS_FORMAT}"
fi

echo "# ------------------------------------------"
echo "# UNCOMPRESS: The FreeCAD source code."
echo "# ------------------------------------------"
rm -fR "${FOLDER_SOURCE}"
mkdir -p "${FOLDER_SOURCE}"

if [ ${COMPRESS_FORMAT} = ".tar.gz" ]; then
  tar -zxf "${TAG_NUMBER}${COMPRESS_FORMAT}" --strip-components 1 -C "${FOLDER_SOURCE}"
fi

if [ ${COMPRESS_FORMAT} = ".zip" ]; then
  TEMPORAL_DIRECTORY=$(mktemp -d)
  unzip -q "${TAG_NUMBER}${COMPRESS_FORMAT}" -d "${TEMPORAL_DIRECTORY}"
  # shellcheck disable=SC2039
  mv "${TEMPORAL_DIRECTORY}"/*/{.[!.],}* "${FOLDER_SOURCE}"
  rm -fR "${TEMPORAL_DIRECTORY}"
fi

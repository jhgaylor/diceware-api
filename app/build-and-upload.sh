#!/bin/sh

APP_NAME="diceware"
SW_RELEASE_BUCKET="jhg-sw-releases"
SOURCE_DIR="./app"
APP_VERSION=$(node -p -e "require('${SOURCE_DIR}/package.json').version")
ARTIFACT_FILENAME="${APP_NAME}-${APP_VERSION}.tar.gz"
ARTIFACT_PATH="./${ARTIFACT_FILENAME}"
APP_S3_PATH="s3://${SW_RELEASE_BUCKET}/${APP_NAME}/${ARTIFACT_FILENAME}"

if [ ! -d "./deploy" ]; then
  echo "Please run this script from the root of the git repo in which this script lives."
  exit 1
fi

echo "Building App"
if [ -e "${ARTIFACT_PATH}" ]; then
  rm ${ARTIFACT_PATH}
fi

tar -czf ${ARTIFACT_PATH} -C ${SOURCE_DIR} . > /dev/null
echo "App successfully built"
ARTIFACT_EXISTS_AWS=$(aws s3 ls ${APP_S3_PATH})

if [ ! -z "${ARTIFACT_EXISTS_AWS}" ]; then
  echo "This file exists in s3 already. Cancel this script with ^C within 5s or it will be overwritten."
  sleep 5
fi
echo "Uploading artifact ${ARTIFACT_PATH} to ${APP_S3_PATH}"
aws s3 cp ${ARTIFACT_PATH} ${APP_S3_PATH}
echo "Finished uploading artifact to ${APP_S3_PATH}"

rm ${ARTIFACT_PATH}
echo "Removed the local copy of the artifact."

# pushd "./deploy/packer"
#   ./build-ami.sh
# popd

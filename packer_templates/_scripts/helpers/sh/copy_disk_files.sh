#!/bin/sh -eu

SRC_DIR="${SOURCE_DIR}"

if [ "${PACKER_BUILDER_TYPE}" == "virtualbox-iso" ]; then
  TRG_DIR="${TARGET_DIR}/ovf"

  # Test if target folder exists and if not then create it
  if [ ! -d "${TRG_DIR}" ]; then
    echo "===> Creating folder ${TRG_DIR}"
    mkdir -p ${TRG_DIR}
  fi

  # Copy all files matching the file pattern from the source to the target folder
  echo "===> Copying all files starting with ${FILE_PATTERN} from ${SRC_DIR} to ${TRG_DIR}"
  cp ${SRC_DIR}/${FILE_PATTERN} ${TRG_DIR}
elif [ "${PACKER_BUILDER_TYPE}" == "parallels-iso" ]; then
  TRG_DIR="${TARGET_DIR}/pvm"

  # Test if target folder exists and if not then create it
  if [ ! -d "${TRG_DIR}" ]; then
    echo "===> Creating folder ${TRG_DIR}"
    mkdir -p ${TRG_DIR}
  fi

  # Copy all files matching the file pattern from the source to the target folder
  echo "===> Copying all files starting with ${FILE_PATTERN} from ${SRC_DIR} to ${TRG_DIR}"
  cp -R ${SRC_DIR}/${FILE_PATTERN} ${TRG_DIR}/
else
  echo "The '${PACKER_BUILDER_TYPE}' builder is not supported yet."
fi

exit 0

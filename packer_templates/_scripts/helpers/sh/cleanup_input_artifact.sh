#!/bin/sh -eu

SRC_DIR=${SOURCE_DIR}

# Delete the source folder after it is no longer needed
echo "===> Deleting artifacts in source folder ${SRC_DIR}"
rm -Rf ${SRC_DIR}

# Delete the source folder after it is no longer needed
echo "INFO: Deleting artifacts in source folder $env:SOURCE_DIR"
Remove-Item -Recurse -Force $env:SOURCE_DIR

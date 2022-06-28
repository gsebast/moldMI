# Test if target folder exists and if not then create it
if (!(Test-Path -Path $env:TARGET_DIR)) {
  echo "INFO: Creating folder $env:TARGET_DIR"
  New-Item -ItemType directory -Path $env:TARGET_DIR
}

# Copy all files matching the file pattern from the source to the target folder
echo "INFO: Copying all files starting with $env:FILE_PATTERN from $env:SOURCE_DIR to $env:TARGET_DIR"
Copy-Item -Path $env:SOURCE_DIR/$env:FILE_PATTERN -Destination $env:TARGET_DIR

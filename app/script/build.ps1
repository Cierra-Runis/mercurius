# Build script for release

# Get the current time and format it
$builtAt = Get-Date -Format "yyyy-MM-dd HH:mm"

# public parameters
$common = @(
    '--obfuscate',
    '--split-debug-info=splitMap',
    '--dart-define-from-file=.env',
    "--dart-define=builtAt=`"$builtAt`""
    # '--verbose' # If you need detailed logs, you can uncomment
)

# Android parameters
$android = @(
    'build',
    'apk',
    '--target-platform android-arm64',
    '--split-per-abi'
) + $common


# Start the build process
Write-Output "Building for Android..."
Start-Process -FilePath 'flutter' -ArgumentList $android -NoNewWindow -Wait

# Copy the built APK to the out directory
$androidCopySource = 'build\app\outputs\flutter-apk\app-arm64-v8a-release.apk'
$androidCopyDestination = 'out\app-arm64-v8a-release.apk'

Write-Output "Copying the Android APK..."
Copy-Item -Path $androidCopySource -Destination $androidCopyDestination

# Windows parameters
$windows = @(
    'build',
    'windows'
) + $common

# Start the build process
Write-Output "Building for Windows..."
Start-Process -FilePath 'flutter' -ArgumentList $windows -NoNewWindow -Wait

# Zip the built Windows app
$windowsZipSource = 'build\windows\x64\runner\Release'
$windowsZipDestination = 'out\Mercurius for Windows.zip'

Write-Output "Zipping the Windows app..."
Compress-Archive -Path $windowsZipSource -DestinationPath $windowsZipDestination -Force

exit 0

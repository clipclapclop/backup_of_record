# Releasing

Backup of Record uses GitHub Releases for installable Android updates.

## Release Channel

Install and update with Obtainium:

- Source: `https://github.com/clipclapclop/backup_of_record`
- Asset filter: `backup-of-record-android-arm64.apk`

## Prepare a Release

1. Update `pubspec.yaml`:

   ```yaml
   version: MAJOR.MINOR.PATCH+BUILD
   ```

   Keep the build number increasing.

2. Commit the release-ready changes.

3. Push `main`.

4. Create and push a version tag:

   ```sh
   git tag vMAJOR.MINOR.PATCH
   git push origin vMAJOR.MINOR.PATCH
   ```

## What CI Publishes

On a `v*` tag, GitHub Actions builds a signed arm64 APK and publishes a GitHub Release with:

- `backup-of-record-android-arm64.apk`
- `backup-of-record-android-arm64.apk.sha256`

Normal pushes to `main` run validation and build artifacts, but do not create GitHub Releases.

## Signing

CI signing uses repository secrets:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_KEY_ALIAS`

The APK must be signed with the same release certificate as the app already installed on the phone, or Android will reject it as an update.

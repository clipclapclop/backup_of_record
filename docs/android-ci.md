# Android CI

GitHub Actions builds Android APKs on every push to `main`, pull request, manual workflow run, and version tag.

## Artifacts

- `backup-of-record-debug-apk`: always built after analyze/test pass.
- `backup-of-record-release-apk`: built only when Android signing secrets are configured.

The signed release artifact contains:

- `backup-of-record-android-arm64.apk`
- `backup-of-record-android-arm64.apk.sha256`

For phone updates without uninstalling, use the signed arm64 release APK. Android requires update APKs to be signed with the same key as the currently installed app.

## Signing Secrets

Add these repository secrets in GitHub:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_KEY_ALIAS`

Create `ANDROID_KEYSTORE_BASE64` from the same keystore referenced by local `android/key.properties`:

```sh
base64 -w 0 /path/to/release.keystore
```

The workflow reconstructs `android/key.properties` during CI and writes the keystore into the runner temp directory. The keystore and passwords are never committed.

## GitHub Releases

Push a version tag to publish an Obtainium-friendly GitHub Release:

```sh
git tag v1.0.1
git push origin v1.0.1
```

Tag releases attach `backup-of-record-android-arm64.apk` and its checksum directly to the GitHub Release.

Normal pushes to `main` still build CI artifacts without creating release noise.

## Obtainium

Add this app source:

```text
https://github.com/clipclapclop/backup_of_record
```

Filter release assets to:

```text
backup-of-record-android-arm64.apk
```

Enable scheduled checks if desired, and allow Obtainium to install updates.

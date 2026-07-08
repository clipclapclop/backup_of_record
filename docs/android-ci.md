# Android CI

GitHub Actions builds Android APKs on every push to `main`, pull request, and manual workflow run.

## Artifacts

- `backup-of-record-debug-apk`: always built after analyze/test pass.
- `backup-of-record-release-apk`: built only when Android signing secrets are configured.

For phone updates without uninstalling, use the signed release APK. Android requires update APKs to be signed with the same key as the currently installed app.

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

## Current Behavior

The workflow does not create GitHub Releases. It stores APKs as workflow artifacts to avoid release noise while the app is still only for personal use.

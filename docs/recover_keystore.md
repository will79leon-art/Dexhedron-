# Recovering lost keystore and app signing

If you've lost an Android app keystore, updating the existing app in Google Play is only possible if you enrolled in Play App Signing or can rotate the upload key. This document explains steps to locate/recover a keystore and options if recovery fails.

1. Search for backups
- Check local machines, external drives, cloud backups (Google Drive, Dropbox), old email attachments, and USB drives.
- Search for files with extensions: .keystore, .jks, .keystore.bak

2. Inspect keystore files you find
- Use keytool to list contents and fingerprints:
  keytool -list -v -keystore path/to/keystore.jks
- Note the certificate fingerprints (SHA-1, SHA-256) and alias names.

3. If you used Google Play App Signing
- Google stores the app signing key; you only need to recover/rotate the upload key.
- If you've lost your upload key, follow Play Console docs to create a new upload key and request a key reset using Play Console support.

4. If you did NOT enroll and cannot recover the keystore
- You cannot update the existing app with the same package name on Google Play. Options:
  - Create a new app with a new package name and upload a new keystore.
  - Contact Google Play Developer Support with strong proof of ownership; success is not guaranteed.

5. Prevention and best practices
- Store keystores in multiple secure locations
- Use a password manager or an enterprise secrets manager
- Enroll in Google Play App Signing for future flexibility

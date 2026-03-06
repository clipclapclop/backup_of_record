/// Orchestrates a single backup job run.
///
/// Responsible for:
///   - Scanning source files
///   - Comparing against FileRecords (metadata or hash)
///   - Uploading changed/new files via WebDavService
///   - Applying retention policy (Type B)
///   - Updating JobRuns and FileRecords in the DB
///   - Emitting progress events
///
/// TODO: implement in phase 2.
class BackupEngine {
  // Will be wired up with AppDatabase, WebDavService, NotificationService.
}

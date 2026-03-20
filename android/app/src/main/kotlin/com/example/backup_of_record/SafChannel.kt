package com.clipclapclop.backupofrecord

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

private const val PICK_FOLDER_REQUEST = 9421

class SafChannel(private val activity: FlutterActivity) : MethodChannel.MethodCallHandler {

    private var pendingResult: MethodChannel.Result? = null

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != PICK_FOLDER_REQUEST) return
        val result = pendingResult ?: return
        pendingResult = null

        if (resultCode != Activity.RESULT_OK || data?.data == null) {
            result.success(null)
            return
        }
        val uri = data.data!!
        val flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
        activity.contentResolver.takePersistableUriPermission(uri, flags)
        // Also persist in SharedPreferences so background workers can read it
        activity.getSharedPreferences("backup_prefs", Context.MODE_PRIVATE)
            .edit().putString("saf_backup_uri", uri.toString()).apply()
        result.success(uri.toString())
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "pickFolder" -> {
                pendingResult = result
                val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
                    addFlags(
                        Intent.FLAG_GRANT_READ_URI_PERMISSION or
                        Intent.FLAG_GRANT_WRITE_URI_PERMISSION or
                        Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION
                    )
                }
                activity.startActivityForResult(intent, PICK_FOLDER_REQUEST)
            }
            "writeFile" -> {
                val uriString = call.argument<String>("uri")!!
                val fileName  = call.argument<String>("fileName")!!
                val bytes     = call.argument<ByteArray>("bytes")!!
                try {
                    val treeUri = Uri.parse(uriString)
                    val tree = DocumentFile.fromTreeUri(activity, treeUri)
                        ?: throw Exception("Could not open folder URI")
                    val existing = tree.findFile(fileName)
                    val target = existing
                        ?: tree.createFile("application/zip", fileName)
                        ?: throw Exception("Could not create file in selected folder")
                    activity.contentResolver.openOutputStream(target.uri, "wt")!!.use {
                        it.write(bytes)
                    }
                    result.success(null)
                } catch (e: Exception) {
                    result.error("WRITE_FAILED", e.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }
}

package com.example.flutter_gallery

import android.Manifest
import android.content.pm.PackageManager
import android.database.Cursor
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutter_gallery/gallery"
    private val PERMISSION_REQUEST_CODE = 101
    private var result: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermissions" -> {
                    val granted = checkPermissions()
                    result.success(granted)
                }

                "requestPermissions" -> {
                    this.result = result
                    requestPermissions()
                }

                "fetchAlbums" -> result.success(fetchAlbums())
                "fetchPhotos" -> {
                    val albumPath = call.argument<String>("albumName")
                    result.success(fetchPhotos(albumPath))
                }

                else -> result.notImplemented()
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSION_REQUEST_CODE) {
            val granted =
                grantResults.isNotEmpty() && grantResults.first() == PackageManager.PERMISSION_GRANTED
            result?.success(granted)
        }
    }

    private fun checkPermissions(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_MEDIA_IMAGES
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }

    private fun requestPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (checkPermissions()) {
                result?.success(true)
            } else {
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.READ_MEDIA_IMAGES),
                    PERMISSION_REQUEST_CODE
                )
            }
        } else {
            result?.success(true)
        }
    }

    private fun fetchAlbums(): List<Map<String, Any>> {
        val albums = mutableMapOf<String, Pair<String, Int>>() // Map to store album name, thumbnail path, and count
        val projection = arrayOf(
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media.DATA,
            MediaStore.Images.Media.DATE_MODIFIED
        )
        val uri: Uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val sortOrder = "${MediaStore.Images.Media.DATE_MODIFIED} DESC"

        val cursor: Cursor? = contentResolver.query(
            uri,
            projection,
            null,
            null,
            sortOrder
        )

        cursor?.use {
            while (it.moveToNext()) {
                val albumName =
                    it.getString(it.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME))
                val imagePath = it.getString(it.getColumnIndexOrThrow(MediaStore.Images.Media.DATA))

                if (!albums.containsKey(albumName)) {
                    albums[albumName] = Pair(imagePath, 1) // Add new album with initial count as 1
                } else {
                    val (thumbnail, count) = albums[albumName]!!
                    albums[albumName] = Pair(thumbnail, count + 1) // Increment count for existing album
                }
            }
        }

        return albums.map {
            mapOf(
                "albumName" to it.key,
                "thumbnailPath" to it.value.first,
                "totalImageCount" to it.value.second
            )
        }
    }

    private fun fetchPhotos(albumPath: String?): List<String> {
        val photos = mutableListOf<String>()
        val projection = arrayOf(MediaStore.Images.Media.DATA)
        val selection = "${MediaStore.Images.Media.BUCKET_DISPLAY_NAME} = ?"
        val selectionArgs = arrayOf(albumPath)
        val uri: Uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val sortOrder = "${MediaStore.Images.Media.DATE_MODIFIED} DESC"

        val cursor: Cursor? = contentResolver.query(
            uri,
            projection,
            selection,
            selectionArgs,
            sortOrder
        )

        cursor?.use {
            while (it.moveToNext()) {
                val photoPath = it.getString(it.getColumnIndexOrThrow(MediaStore.Images.Media.DATA))
                photos.add(photoPath)
            }
        }
        return photos
    }
}
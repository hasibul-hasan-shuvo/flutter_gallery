import UIKit
import Flutter
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.example.flutter_gallery/gallery"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let galleryChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

        galleryChannel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "checkPermissions":
                self?.checkPermissions(result: result)
            case "requestPermissions":
                self?.requestPermissions(result: result)
            case "fetchAlbums":
                self?.fetchAlbums(result: result)
            case "fetchPhotos":
                if let args = call.arguments as? [String: Any],
                   let albumName = args["albumName"] as? String {
                    self?.fetchPhotos(albumName: albumName, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Album name not provided", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func checkPermissions(result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            if #available(iOS 14, *) {
                let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                result(status == .authorized || status == .limited)
            } else {
                let status = PHPhotoLibrary.authorizationStatus()
                result(status == .authorized)
            }
        }
    }

    private func requestPermissions(result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    DispatchQueue.main.async {
                        result(status == .authorized || status == .limited)
                    }
                }
            } else {
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        result(status == .authorized)
                    }
                }
            }
        }
    }

    private func fetchAlbums(result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            var albums: [[String: Any]] = []
            let dispatchGroup = DispatchGroup()

            // Fetch Smart Albums (like Camera Roll)
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            smartAlbums.enumerateObjects { collection, _, _ in
                dispatchGroup.enter()
                self.getAlbumInfo(collection) { albumInfo in
                    if let albumInfo = albumInfo {
                        albums.append(albumInfo)
                    }
                    dispatchGroup.leave()
                }
            }

            // Fetch User Created Albums
            let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            userAlbums.enumerateObjects { collection, _, _ in
                dispatchGroup.enter()
                self.getAlbumInfo(collection) { albumInfo in
                    if let albumInfo = albumInfo {
                        albums.append(albumInfo)
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                result(albums)
            }
        }
    }

    private func getAlbumInfo(_ collection: PHAssetCollection, completion: @escaping ([String: Any]?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
        guard let firstAsset = assets.firstObject else {
            completion(nil) // No images in the album
            return
        }

        let imageManager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.isSynchronous = false

        // Request the file URL for the image
        firstAsset.requestContentEditingInput(with: nil) { contentEditingInput, _ in
            if let fileURL = contentEditingInput?.fullSizeImageURL {
                let albumInfo: [String: Any] = [
                    "albumName": collection.localizedTitle ?? "Unknown Album",
                    "lastImagePath": fileURL.path // Pass the file path to Flutter
                ]
                completion(albumInfo)
            } else {
                completion(nil) // Could not fetch file URL
            }
        }
    }

    private func fetchPhotos(albumName: String, result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            collections.enumerateObjects { collection, _, stop in
                if collection.localizedTitle == albumName {
                    let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                    let imageManager = PHImageManager.default()
                    var photoAssets: [[String: Any]] = []

                    let dispatchGroup = DispatchGroup()
                    assets.enumerateObjects { asset, _, _ in
                        dispatchGroup.enter()
                        let options = PHImageRequestOptions()
                        options.isNetworkAccessAllowed = true
                        options.deliveryMode = .highQualityFormat

                        imageManager.requestImageData(for: asset, options: options) { data, _, _, info in
                            if let data = data {
                                let photoInfo: [String: Any] = [
                                    "identifier": asset.localIdentifier,
                                    "data": FlutterStandardTypedData(bytes: data),
                                    "creationDate": asset.creationDate?.timeIntervalSince1970 ?? 0,
                                    "width": asset.pixelWidth,
                                    "height": asset.pixelHeight
                                ]
                                photoAssets.append(photoInfo)
                            }
                            dispatchGroup.leave()
                        }
                    }

                    dispatchGroup.notify(queue: .main) {
                        result(photoAssets)
                    }
                    stop.pointee = true
                }
            }
        }
    }
}
//
//  FileService.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

class FileService {

    private static func message(_ text: String) -> String {
        let serviceType = type(of: self)
        return "\(serviceType): \(text)"
    }

    static func directoryPath(directory: FileManager.SearchPathDirectory) -> String? {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first
    }

    static func copyFile(_ fileURL: URL, to directory: FileManager.SearchPathDirectory, overwrite: Bool = false) -> (isSuccess: Bool, message: String) {

        let filePath = fileURL.absoluteString

        guard FileManager.default.fileExists(atPath: filePath) == true else {
            return (false, message("File is not exist at origin path. \(filePath)") )
        }

        guard let directoryPath = directoryPath(directory: directory) else {
            return (false, message("Destination directory was not found."))
        }
        let directoryURL = URL(fileURLWithPath: directoryPath)
        let destinationURL = directoryURL.appendingPathComponent(fileURL.lastPathComponent)
        let isFileExistAtDestination = FileManager.default.fileExists(atPath: destinationURL.absoluteString)

        if isFileExistAtDestination == true, overwrite == false {
            return (true, message("File is already exist at destination. \(destinationURL.absoluteString)"))
        }

        do {
            try FileManager.default.copyItem(at: fileURL, to: destinationURL)
            return (true, message("File is copy to destination successfully. \(destinationURL.absoluteString)"))
        } catch {
            return(false, message("\(error)"))
        }
    }

    static func copyBundleResource(_ resourceName: String,
                                   to directory: FileManager.SearchPathDirectory,
                                   overwrite: Bool = false) -> (isSuccess: Bool, message: String) {

        let resourceInfo = resourceName.split(separator: ".")
        guard resourceInfo.count == 2, let nameOfResource = resourceInfo.first, let typeOfResource = resourceInfo.last else {
            return (false, message("Bundle resource name is not valid. \(resourceName)"))
        }

        let name = String(nameOfResource)
        let type = String(typeOfResource)
        guard let resourceURL = Bundle.main.url(forResource: name, withExtension: type) else {
            return (false, message("File could not be located in bundle. \(resourceName)"))
        }
        return copyFile(resourceURL, to: directory, overwrite: overwrite)
    }
}

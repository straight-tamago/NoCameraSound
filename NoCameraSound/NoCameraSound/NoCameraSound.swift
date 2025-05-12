//
//  OverwriteFontImpl.swift
//  NoCameraSound
//
//  Created by straight-tamago★ on 2022/12/28.
//

import UIKit
import SwiftUI

func overwrite(targetFilePath: String, overwriteData: String) -> String {
    let base = "0123456789"
    let randomStr = String((0..<2).map{ _ in base.randomElement()! })
    let overwriteFileData = overwriteData.data(using: .utf8)!
    let fd = open(targetFilePath, O_RDONLY | O_CLOEXEC)
    defer { close(fd) }
    let map = mmap(nil, overwriteFileData.count, PROT_READ, MAP_SHARED, fd, 0)
    if map == MAP_FAILED {
        print("mmap Error")
        return "mmap Error - "+randomStr
    }
    guard mlock(map, overwriteFileData.count) == 0 else {
        print("mlock Error")
        return "mlock Error - "+randomStr
    }
    for chunkOff in stride(from: 0, to: overwriteFileData.count, by: 0x4000) {
        let dataChunk = overwriteFileData[chunkOff..<min(overwriteFileData.count, chunkOff + 0x3fff)]
        var overwroteOne = false
        for _ in 0..<2 {
            let overwriteSucceeded = dataChunk.withUnsafeBytes { dataChunkBytes in
                return unaligned_copy_switch_race(
                    fd, Int64(chunkOff), dataChunkBytes.baseAddress, dataChunkBytes.count)
            }
            if overwriteSucceeded {
                overwroteOne = true
                break
            }
            sleep(1)
        }
        guard overwroteOne else {
            print("unknown Error")
            return "unknown Error - "+randomStr
        }
    }
    print("Success")
    return "Success - "+randomStr
}

func isSucceeded(targetFilePath: String) -> Bool {
    guard let data = try? Data(contentsOf: URL(string: targetFilePath)!) else {
        return false
    }
    var dataBinary = data[0..<3].map { String(format: "%02X", $0)}
    var dataString = dataBinary.joined()
    print(dataString)
    if dataString != "787878" {
        return false
    }
    return true
}

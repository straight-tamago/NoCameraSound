import SwiftUI

struct TargetFilePathItem: Identifiable {
  var  id = UUID()
  let title: String
  let path: String
}

let defaultTargetFilePathItems: [TargetFilePathItem] = [
    TargetFilePathItem(
        title: "photoShutter.caf",
        path: "/System/Library/Audio/UISounds/photoShutter.caf"
    ),
    TargetFilePathItem(
        title: "begin_record.caf",
        path: "/System/Library/Audio/UISounds/begin_record.caf"
    ),
    TargetFilePathItem(
        title: "end_record.caf",
        path: "/System/Library/Audio/UISounds/end_record.caf"
    ),
    TargetFilePathItem(
        title: "camera_shutter_burst.caf",
        path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf"
    ),
    TargetFilePathItem(
        title: "camera_shutter_burst_begin.caf",
        path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf"
    ),
    TargetFilePathItem(
        title: "camera_shutter_burst_end.caf",
        path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf"
    ),
]

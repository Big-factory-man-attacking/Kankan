import QtQuick
import QtQuick.Dialogs

Item {
    property alias fileImageDialog: fileImageDialog
    property alias fileVideoDialog: fileVideoDialog
    property alias coverImageDialog: coverImageDialog
    FileDialog{
        id: fileImageDialog
        title: "请选择一张图片"
        nameFilters: ["Image files (*.png *.jpeg *.jpg)"]
        onAccepted: {
            accountInfor.imageSource = fileImageDialog.currentFile
            //存储到数据库中

        }
    }
    FileDialog{
        id: coverImageDialog
        title: "请选择一张图片"
        nameFilters: ["Image files (*.png *.jpeg *.jpg)"]
        onAccepted: {
//            accountInfor.imageSource = fileImageDialog.currentFile
        }
    }
    FileDialog{
        id: fileVideoDialog
        title: "请选择视频"
        nameFilters: ["Video files (*.mkv *.avi)"]

        onAccepted: {
            console.log(fileVideoDialog.currentFile)
            publishPage.video.source = fileVideoDialog.currentFile
        }
    }
}

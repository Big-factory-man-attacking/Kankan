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
            mainPage.personalPage.headPortrait = fileImageDialog.currentFile
            mainPage.personalPage.netizen["headportrait"] = mainPage.personalPage.headPortrait
            videoSocialControl.modifyHeadportrait(mainPage.personalPage.netizen["id"], accountInfor.imageSource);
            mainPage.homePage.changeHeadPortrait()

        }
    }
    FileDialog{
        id: coverImageDialog
        title: "请选择一张图片"
        nameFilters: ["Image files (*.png *.jpeg *.jpg)"]
        onAccepted: {
            manuscriptPage.editManuscript.source = coverImageDialog.currentFile
            console.log(coverImageDialog.currentFile)
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

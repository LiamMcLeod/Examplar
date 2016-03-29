//var pBar = $('.progress-bar');
//var uBtn = $('.btn-upload');
//var uInput = $('#input-upload');
//var form = $('.upload');
//var panel = $('.panel');

var droppedFiles = false;

function $id(id) {
    var ele = document.getElementById(id);
    if (ele === ""){
        return document.getElementsByClassName(id)
    }
    else return document.getElementById(id);
}


function uploadInit() {

    var fileSelect = $id("input-upload"),
        fileDrag = $id("panel-upload"),
        submitButton = $id("btn-upload");

    // file select
    fileselect.addEventListener("change", fileHandler, false);

    // is XHR2 available?
    var xhr = new XMLHttpRequest();
    if (xhr.upload) {

        // file drop
        fileDrag.addEventListener("dragover dragenter", dragOver, false);
        fileDrag.addEventListener("dragleave dragend", dragOver, false);
        fileDrag.addEventListener("drop", fileHandler, false);
        fileDrag.style.display = "block";

        // remove submit button
        submitButton.style.display = "none";
    }

}
function dragOver(e){
    e.stopPropagation();
    e.preventDefault();
    e.target.className=(e.type=="dragover"?"hover": "");
}
function fileHandler(e) {

    // cancel event and hover styling
    dragOver(e);

    // fetch FileList object
    var files = e.target.files || e.dataTransfer.files;

    // process all File objects
    for (var i = 0, f; f = files[i]; i++) {
        parseFile(f);
    }
}
//function parseFile(file){
//
//}


//uBtn.on('click', function () {
//    uInput.click();
//    pBar.text('0%');
//    pBar.width('0%');
//});
//
//uInput.on('change', function () {
//    var file = $(this).get(0).file;
//    if (file.length > 0) {
//        var formData = new FormData();
//        formData.append('upload', file);
//    }
//
//    $.ajax({
//        url: '/upload',
//        type: 'POST',
//        data: formData,
//        processData: false,
//        contentType: false,
//        success: function (data) {
//            console.log('Upload Successful!');
//        },
//        xhr: function () {
//            var xhr = new XMLHttpRequest();
//
//            xhr.upload.addEventListener('progress', function (e) {
//                if (e.lengthComputable) {
//                    var percentComplete = e.loaded / e.total;
//                    percentComplete = parseInt(percentComplete * 100);
//
//                    pBar.text = percentComplete + '%';
//                    pBar.width = percentComplete + '%';
//
//                    if (percentComplete === 100) {
//                        pBar.html('Done');
//                    }
//                }
//            }, false);
//            return xhr;
//        }
//    });
//});
//

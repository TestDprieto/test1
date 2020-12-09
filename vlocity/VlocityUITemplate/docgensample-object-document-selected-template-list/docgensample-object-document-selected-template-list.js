baseCtrl.prototype.setDocXDocTempSortingList = function(control,scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];
    if (afterSlash === 'apex') {
        afterSlash = '';
    }

    window.bpTreeSortingResponseSent = false;
    window.addEventListener('message', function(event) {
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('GET_BPTREE_RESPONSE_SORTING')) {
            if (!window.bpTreeSortingResponseSent) {
                window.bpTreeSortingResponseSent = true;
                var sortingObjectIFrame = document.getElementById('obj-doc-sorting-os-iframe')
                var fContentWindow = sortingObjectIFrame.contentWindow;
                fContentWindow.postMessage({'clmDocxSortingBpTreeResponse': baseCtrl.prototype.$scope.bpTree.response}, '*');

            }
        }
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('listLoaded')) {// resize when list is loaded         
            console.log("listLoaded")
            var sortingObjectIFrame = document.getElementById('obj-doc-sorting-os-iframe')
            var fContentWindow = sortingObjectIFrame.contentWindow;
                sortingObjectIFrame.height = fContentWindow.document.body.scrollHeight;
            console.log(fContentWindow.document.body.scrollHeight);

        }
        
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('reorderDocumentTemplateList')) {                
                baseCtrl.prototype.$scope.bpTree.response.templates = event.data.reorderDocumentTemplateList; //needs to be called after applyCallResp since array contents gets lost after invoking applyCallResp 
        }

    }, false);
 };
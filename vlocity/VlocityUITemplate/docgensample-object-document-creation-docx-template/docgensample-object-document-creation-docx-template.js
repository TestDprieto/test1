baseCtrl.prototype.setDocXIPScope = function(scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];

    delete window.bpTreeResponseSent;
    delete window.vlocObjDocCreation;
    delete baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone;
    delete baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone;
    document.getElementById('obj-doc-creation-docx-os-iframe').contentWindow.location.reload();

    window.VlocOmniSI = scp;
    if (afterSlash === 'apex') {
        afterSlash = '';
    }
    scp.applyCallResp({
        urlPrefix: window.location.origin + afterSlash
    });

    window.bpTreeResponseSent = false;
    window.addEventListener('message', function(event) {
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('docGenContentVersionId')) {
            baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone = true;
            scp.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
        }
        else if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('pdfGenContentVersionId')) {
            baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone = true;
            scp.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
        }
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('GET_BPTREE_RESPONSE')) {
            if (!window.bpTreeResponseSent) {
                var fContentWindow = document.getElementById('obj-doc-creation-docx-os-iframe').contentWindow;
                fContentWindow.postMessage({'clmDocxBpTreeResponse': baseCtrl.prototype.$scope.bpTree.response}, '*');
                window.bpTreeResponseSent = true;
            }
        }
		baseCtrl.prototype.$scope.$apply();
    }, false);
};
baseCtrl.prototype.setIPScope = function(scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];

    delete baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone;
    delete baseCtrl.prototype.$scope.bpTree.response.docGenAttachmentId;
    delete baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone;
    delete baseCtrl.prototype.$scope.bpTree.response.pdfGenAttachmentId;
    
    window.VlocOmniSI = scp;
    if (afterSlash === 'apex') {
        afterSlash = '';
    }
    scp.applyCallResp({
        urlPrefix: window.location.origin + afterSlash
    });

    window.addEventListener('message', function(event) {
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('docGenAttachmentId')) {
            baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone = true;
            scp.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
        }
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('pdfGenAttachmentId')) {
            baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone = true;
            scp.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
        }
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('deleteAttachment')) {
            delete baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone;
            delete baseCtrl.prototype.$scope.bpTree.response.docGenAttachmentId;
            delete baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone;
            delete baseCtrl.prototype.$scope.bpTree.response.pdfGenAttachmentId;
            delete event.data.deleteAttachment;
            scp.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
        }
		baseCtrl.prototype.$scope.$apply();
    }, false);
};
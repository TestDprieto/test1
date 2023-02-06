baseCtrl.prototype.setDocXIPSortingScope = function(scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];
    window.VlocOmniSI = scp;
    if (afterSlash === 'apex') {
        afterSlash = '';
    }
    scp.applyCallResp({
        urlPrefix: window.location.origin + afterSlash
    });

    window.addEventListener('message', function(event) {
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('GET_Merge_BPTREE_RESPONSE')) {
            if (!window.responseSent) {
                var fContentWindow = document.getElementById('obj-doc-merge-pdf-os-iframe').contentWindow;
                fContentWindow.postMessage({'clmDocxMergeBpTreeResponse': baseCtrl.prototype.$scope.bpTree.response}, '*');
                window.responseSent = true;
            }
        }
    }, false);
};
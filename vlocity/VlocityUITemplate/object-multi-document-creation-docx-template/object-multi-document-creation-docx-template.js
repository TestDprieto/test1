baseCtrl.prototype.setMultiDocXIPScope = function(scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];
    window.VlocOmniSI = scp;
    if (afterSlash === 'apex') {
        afterSlash = '';
    }
    scp.applyCallResp({
        urlPrefix: window.location.origin + afterSlash
    });

    var insightFeed = {
        url: baseCtrl.prototype.$scope.bpTree.response.urlPrefix + '/apex/' + baseCtrl.prototype.$scope.nsPrefix + 'ObjectDocumentCreationDocXTemplate', 
        loadIframe: function(templateId) {
            var wvElement = document.getElementById('viewer');
            // wvElement.setAttribute('height','500px');
            // wvElement.setAttribute('width','500px');
            var iframe = document.createElement('iframe');
            iframe.style.display = "block";
            iframe.style.height = "420px";
            iframe.style.width = "700px";
            iframe.style.border = "none";
            iframe.src = insightFeed.url;
            iframe.Id = templateId;
            iframe.setAttribute('Id', templateId);
            wvElement.appendChild(iframe);
            console.log(wvElement);
            baseCtrl.prototype.$scope.bpTree.response.currentTemplateId = templateId;
            
        }
    };


    if(baseCtrl.prototype.$scope.bpTree.response.tracker === undefined && baseCtrl.prototype.$scope.bpTree.response.generateMultipleDocument) {
        insightFeed.loadIframe(baseCtrl.prototype.$scope.bpTree.response.PickTemplate.MultiDocumentTemplate[0].Id);
        baseCtrl.prototype.$scope.bpTree.response.tracker = 0;
    }
    window.addEventListener('message', function(event) { 
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('docGenContentVersionId')) {
            baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone = true;
            window.VlocOmniSI.applyCallResp(event.data);
            baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone = false;
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
            var attachFileFormat = baseCtrl.prototype.$scope.bpTree.response.attachFileFormat && baseCtrl.prototype.$scope.bpTree.response.attachFileFormat.toLowerCase();
            var documentType = ((baseCtrl.prototype.$scope.bpTree.response.documentType && baseCtrl.prototype.$scope.bpTree.response.documentType) || 'all')
            var showDownloadPDF = (documentType === 'all' || documentType === 'pdf');

            if((attachFileFormat && attachFileFormat.indexOf("pdf") < 0 && !showDownloadPDF) && (baseCtrl.prototype.$scope.bpTree.response.docGenerationContentVersionId != event.data.docGenContentVersionId)) {
                var i = baseCtrl.prototype.$scope.bpTree.response.tracker + 1;
                if(i < baseCtrl.prototype.$scope.bpTree.response.PickTemplate.MultiDocumentTemplate.length){
                    baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone = false;
                    baseCtrl.prototype.$scope.bpTree.response.docGenerationContentVersionId = event.data.docGenContentVersionId;
                    window.bpTreeResponseSent = false;
                    insightFeed.loadIframe(baseCtrl.prototype.$scope.bpTree.response.PickTemplate.MultiDocumentTemplate[i].Id);
                    baseCtrl.prototype.$scope.bpTree.response.tracker++;
                    baseCtrl.prototype.$scope.bpTree.response.previousTemplateId = baseCtrl.prototype.$scope.bpTree.response.PickTemplate.MultiDocumentTemplate[i].Id

                }
            }
        }
        else if (event.data && event.data.constructor === Object && baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone == false && event.data.hasOwnProperty('pdfGenContentVersionId')) {
            baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone = true;
            window.VlocOmniSI.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
            var i = baseCtrl.prototype.$scope.bpTree.response.tracker + 1; 
            if(i < baseCtrl.prototype.$scope.bpTree.response.PickTemplate.MultiDocumentTemplate.length){
                window.bpTreeResponseSent = false;
                insightFeed.loadIframe(baseCtrl.prototype.$scope.bpTree.response.PickTemplate.MultiDocumentTemplate[i].Id);
                baseCtrl.prototype.$scope.bpTree.response.tracker++;
            }
        }
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('GET_BPTREE_RESPONSE')) {
            
            // if(i < document.getElementsByTagName('iframe').length){
            //     window.bpTreeResponseSent = false;
            // }
            if (!window.bpTreeResponseSent) {

                var frameId = baseCtrl.prototype.$scope.bpTree.response.currentTemplateId;
                var tempId = baseCtrl.prototype.$scope.bpTree.response.currentTemplateId;
            //    // window.alert('templateId')
                baseCtrl.prototype.$scope.bpTree.response.templateId = tempId;
                //window.VlocOmniSI.applyCallResp(baseCtrl.prototype.$scope.bpTree.response);
                scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
                //window.alert('baseCtrl.prototype.$scope.bpTree.response.templateId::'+baseCtrl.prototype.$scope.bpTree.response.templateId);
                var fContentWindow = document.getElementById(frameId).contentWindow;
                fContentWindow.postMessage({'clmDocxBpTreeResponse': baseCtrl.prototype.$scope.bpTree.response}, '*');
                window.bpTreeResponseSent = true;
                //baseCtrl.prototype.$scope.bpTree.response.tracker++;
            }
        }
    }, false);
};
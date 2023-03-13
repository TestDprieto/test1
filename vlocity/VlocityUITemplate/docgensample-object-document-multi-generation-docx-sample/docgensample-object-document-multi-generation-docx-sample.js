baseCtrl.prototype.setMultiDocXIPScope = function(scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];
    window.VlocOmniSI = scp;
    if (afterSlash === 'apex') {
        afterSlash = '';
    }
    window.bpTreeResponseSent = false;
    scp.applyCallResp({
        urlPrefix: window.location.origin + afterSlash
    });

    var insightFeed = {
        url: baseCtrl.prototype.$scope.bpTree.response.urlPrefix + '/apex/' + baseCtrl.prototype.$scope.nsPrefix + 'ObjectDocumentCreationDocXTemplate', 
        loadIframe: function(templateId) {
            var wvElement = document.getElementById('viewer');
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


    if(baseCtrl.prototype.$scope.bpTree.response.tracker === undefined) {
        //Disable the Next button on the page untill the pdf generation is done for all the selected templates.
        $("#GenerateDocument_nextBtn").addClass('buttonDisable');
        var attachFileFormat = baseCtrl.prototype.$scope.bpTree.response.attachFileFormat && baseCtrl.prototype.$scope.bpTree.response.attachFileFormat.toLowerCase();
        var documentType = ((baseCtrl.prototype.$scope.bpTree.response.documentType && baseCtrl.prototype.$scope.bpTree.response.documentType) || 'all')
        var showDownloadPDF = (documentType === 'all' || documentType === 'pdf');
        
        //pdf document is generated for the template, only if either attachFileFormat is pdf or showDownloadPDF is true.
        if((attachFileFormat && attachFileFormat.indexOf("pdf") > -1 || showDownloadPDF)) {
            baseCtrl.prototype.$scope.bpTree.response.generatePdfDocument = true;
        }

        baseCtrl.prototype.$scope.bpTree.response.useTemplateDRExtract = baseCtrl.prototype.$scope.bpTree.response.templates[0].useTemplateDRExtract ? 'yes': 'no';
        insightFeed.loadIframe(baseCtrl.prototype.$scope.bpTree.response.templates[0].Id);
        baseCtrl.prototype.$scope.bpTree.response.tracker = 0;
    }
    window.addEventListener('message', function(event) { 
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('docGenContentVersionId')) {
            baseCtrl.prototype.$scope.bpTree.response.templates[baseCtrl.prototype.$scope.bpTree.response.tracker].docGenContentVersionId = event.data.docGenContentVersionId;
            baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone = true;
            scp.applyCallResp(event.data);
            baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone = false;
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);

            //load the next Iframe(template) once the word document generation is done, if the attachFileFormat is not pdf or showDownloadPDF is false.
            if(!baseCtrl.prototype.$scope.bpTree.response.generatePdfDocument && (baseCtrl.prototype.$scope.bpTree.response.docGenerationContentVersionId != event.data.docGenContentVersionId)) {
                var i = baseCtrl.prototype.$scope.bpTree.response.tracker + 1;
                if(i < baseCtrl.prototype.$scope.bpTree.response.templates.length){
                    baseCtrl.prototype.$scope.bpTree.response.isWordAttachDone = false;
                    baseCtrl.prototype.$scope.bpTree.response.docGenerationContentVersionId = event.data.docGenContentVersionId;
                    window.bpTreeResponseSent = false;
                    baseCtrl.prototype.$scope.bpTree.response.useTemplateDRExtract = baseCtrl.prototype.$scope.bpTree.response.templates[i].useTemplateDRExtract ? 'yes': 'no';
                    insightFeed.loadIframe(baseCtrl.prototype.$scope.bpTree.response.templates[i].Id);
                    baseCtrl.prototype.$scope.bpTree.response.tracker++;
                }else {
                    //Enable the Next button on the page, once the pdf generation for all the selected templates are done.
                    $("#GenerateDocument_nextBtn").removeClass('buttonDisable');
                }
            }
        }
        else if (event.data && event.data.constructor === Object && baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone == false && event.data.hasOwnProperty('pdfGenContentVersionId')) {
            baseCtrl.prototype.$scope.bpTree.response.isPDFAttachDone = true;
            scp.applyCallResp(event.data);
            scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
            baseCtrl.prototype.$scope.bpTree.response.templates[baseCtrl.prototype.$scope.bpTree.response.tracker].pdfGenContentVersionId = event.data.pdfGenContentVersionId;
            var i = baseCtrl.prototype.$scope.bpTree.response.tracker + 1; 
            if(i < baseCtrl.prototype.$scope.bpTree.response.templates.length){
                window.bpTreeResponseSent = false;
                baseCtrl.prototype.$scope.bpTree.response.useTemplateDRExtract = baseCtrl.prototype.$scope.bpTree.response.templates[i].useTemplateDRExtract ? 'yes': 'no';
                insightFeed.loadIframe(baseCtrl.prototype.$scope.bpTree.response.templates[i].Id);
                baseCtrl.prototype.$scope.bpTree.response.tracker++;
            } else {
                //Enable the Next button on the page, once the pdf generation is done for all the selected templates.
                $("#GenerateDocument_nextBtn").removeClass('buttonDisable');

                baseCtrl.prototype.$scope.applyCallResp(baseCtrl.prototype.$scope.bpTree.response); 
            }
        }
        if (event.data && event.data.constructor === Object && event.data.hasOwnProperty('GET_BPTREE_RESPONSE')) {
            if (!window.bpTreeResponseSent) {

                var frameId = baseCtrl.prototype.$scope.bpTree.response.currentTemplateId;
                var tempId = baseCtrl.prototype.$scope.bpTree.response.currentTemplateId;
                baseCtrl.prototype.$scope.bpTree.response.templateId = tempId;
                scp.aggregate(scp, scp.control.index, scp.control.indexInParent, true, -1);
                var fContentWindow = document.getElementById(frameId).contentWindow;
                fContentWindow.postMessage({'clmDocxBpTreeResponse': baseCtrl.prototype.$scope.bpTree.response}, '*');
                window.bpTreeResponseSent = true;
            }
        }
    }, false);
};
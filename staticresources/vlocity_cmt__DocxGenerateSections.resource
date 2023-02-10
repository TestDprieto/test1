    //Method to Generate Docx Document Sections.
    function generateDocxContractSections(remoteActions, inputMap){
        console.log('####Docx Document Sections Begin...');
        return new Promise(function(resolve, reject) {
            var documentXml, styleFileContents, relationshipsFileContents, wordDocContentsMap, numberingFileContents;
            var zip = new JSZip(inputMap.fileContentData, {base64: true});
            var file = zip.file('word/document.xml');
            var styleFile = zip.file('word/styles.xml');
            var numberingFile = zip.file('word/numbering.xml');
            var relationshipsFile = zip.file('word/_rels/document.xml.rels');
            if (file != null) {
                documentXml = file.asText();
                let fitleredDocXML = filteredSectionContent(documentXml);
                 if(fitleredDocXML !== null) {
                    relationshipsFileContents = relationshipsFile.asText();
                    if(numberingFile){
                        numberingFileContents = numberingFile.asText();
                    }
                    if (styleFile != null){
                        styleFileContents = styleFile.asText();
                    }
                    wordDocContentsMap = {
                        contractId: inputMap.contractId,
                        versionId: inputMap.versionId,
                        wordDocContents: fitleredDocXML,
                        styleContents: styleFileContents,
                        relationshipsContents: relationshipsFileContents,
                        numberingContents: numberingFileContents
                    };
                    remoteActions.getDocxSectionHtmlContent(wordDocContentsMap).then(function(result){
                        // Save the Document Sections for Docx Templates
                        if(result !== null) {
                            saveNewDocumentSections(remoteActions,result).then(function(sectionsMap){
                                console.log('####Docx Document Sections created!');
                                resolve(sectionsMap);
                            });
                        } else {
                            resolve('DocHasNoSections');
                        }
                    },function(error) {
                       reject(error);
                    });
                }
                else {
                    resolve('DocHasNoSections');
                }
            }
        });
    }


    //Method to extract only <sdt> contents of the word document.
    function filteredSectionContent(fileContents){
        const boundaryMarker = '<w:alias w:val="Contract Section boundary"';
        let tempArray = fileContents.split(boundaryMarker);

        let sdtContentArray=[];
        //return empty Array when no sections found
        if(tempArray.length == 1){
            return null;
        }
        for(var i=0; i < tempArray.length; i++ ){
            if(i == 0) {
                let headerContent = tempArray[i].split('<w:body>')[0] + '<w:body>';
                sdtContentArray.push(headerContent);
            }
            else {
                let contractSectionBoundaryStartIndex = tempArray[i-1].lastIndexOf('<w:sdt>');
                let contractSectionBoundaryStart = tempArray[i-1].substring(contractSectionBoundaryStartIndex);
                const boundaryEndIndex = tempArray[i].lastIndexOf('</w:sdt>');
                let sdtConent = contractSectionBoundaryStart+boundaryMarker + tempArray[i].substring(0, boundaryEndIndex) + '</w:sdt>';
                sdtContentArray.push(sdtConent);
            }
        }
        return sdtContentArray.join('') + '</w:body> </w:document>';
    };

    // Attach template sections to contract version
    function saveNewDocumentSections(remoteActions, sectionDocStructure) {
       return new Promise(function(resolve, reject) {
            remoteActions.saveDocxNewContractSections(sectionDocStructure).then(function(result) {
                console.log('Saved new document sections' + result);
                    resolve(result);
                    //window.location.reload();
            }, function(error) {
               reject(error);
            });
       });
    }


    //Method to insert the Document Section Id in to the Document
    function addSectionIdtoWordDoc(fileContentData, inputMap){
        return new Promise(function(resolve, reject) {
            let docSectionData = inputMap.documentSectionData;
            let remoteActions = inputMap.remoteActions;
            let ns = inputMap.ns;

            let zip = new JSZip(fileContentData, {base64: true});
            var docXmlContent = zip.files["word/document.xml"].asText();
            docSectionData.map(function(ele){
               let tempSecId = ele[ns + 'DocumentTemplateSectionId__c'];
               let docSecId = ele['Id'];
               docXmlContent = docXmlContent.replace(tempSecId, docSecId);
            });
            zip.file("word/document.xml", docXmlContent);
            getBase64Content(zip, inputMap.docName).then(function(outputContentBase64){
                resolve(outputContentBase64);
            });
        });
    }

    //Method to replace old sectionId with new -- for Clone Template and Create New Version docxTemplates.
    replaceOldSectionIdWithNewId = function (fileContentData, inputMap) {
        return new Promise(function (resolve, reject) {
            let docSectionData = inputMap.docSectionData;
            let fileName = inputMap.docName;
            let newSectionData = inputMap.newTempSectionData;

            let zip = new JSZip(fileContentData, {
                base64: true
            });
            
            var docXmlContent = zip.files["word/document.xml"].asText();
            var isSectionIdsReplaced = false;
            for (var i = 0; i < docSectionData.length; i++) {
                let oldSecId = docSectionData[i].sectionId;
                let newSecId = newSectionData[i]['Id'];
                isSectionIdsReplaced = docXmlContent.indexOf(oldSecId) > 0;
                docXmlContent = docXmlContent.replace(oldSecId, newSecId);
            }
            zip.file("word/document.xml", docXmlContent);
            getBase64Content(zip, fileName).then(function (result) {
                result.isSectionIdsReplaced = isSectionIdsReplaced;
                resolve(result);
            });
        });
    };

    //Method to convert Zip to Base64
    function getBase64Content(zipFile, outputFileName){
        return new Promise(function(resolve, reject) {
            var doc = new Docxtemplater();
            doc.loadZip(zipFile);
            var outputFileConfig = {
                        'type': 'blob',
                        'mimeType': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                        'compression': 'DEFLATE',
                        'compressionOptions': {
                            'level': 9
                        }
                    };
            var outputContentBlob = doc.getZip().generate(outputFileConfig);
            var dataReader = new FileReader();
            dataReader.addEventListener('load', function() {
                var outputContentBase64 = dataReader.result;
                var base64Mark = 'base64,';
                var dataStart = outputContentBase64.indexOf(base64Mark) + base64Mark.length;
                outputContentBase64 = outputContentBase64.substring(dataStart);

                resolve({'fileName': outputFileName, 'fileContent': outputContentBase64});
            });
            dataReader.readAsDataURL(outputContentBlob);
        });
    }
    
    function convertDocxTemplateSectionToHtmlContent(remoteActions, inputMap) {
        console.log('####Docx Document Sections Begin...');
        return new Promise(function(resolve, reject) {
            var documentXml, styleFileContents, numberingFileContents, wordDocContentsMap;
            var zip = new JSZip(inputMap.fileContentData, {base64: true});
            var file = zip.file('word/document.xml');
            var styleFile = zip.file('word/styles.xml');
            var numberingFile = zip.file('word/numbering.xml');
            if (file != null) {
                documentXml = file.asText();
                let fitleredDocXML = filteredSectionContent(documentXml);
                if(fitleredDocXML !== null) {
                    if(styleFile != null) {
                        styleFileContents = styleFile.asText();
                    }
                    wordDocContentsMap = {
                        wordDocContents: fitleredDocXML,
                        styleContents: styleFileContents,

                    };
                    if( numberingFile != null){
                        numberingFileContents = numberingFile.asText();
                        wordDocContentsMap['numberingContents'] = numberingFileContents;
                    }

                    remoteActions.getDocxTemplateSectionHtmlContent(wordDocContentsMap).then(function(htmlContent){
                        resolve(htmlContent);
                    },function(error) {
                       reject(error);
                    });
                }
                else {
                    resolve('DocHasNoSections');
                }
            }
        });
    }

    //Method to insert the Document Section Id in to the Document and Save the New Content Version
    function replaceClauseIdWithSectionId(fileContentData, inputMap){
        return new Promise(function(resolve, reject) {
            let docSectionData = inputMap.documentSectionData;
            let remoteActions = inputMap.remoteActions;

            let zip = new JSZip(fileContentData, {base64: true});
            var docXmlContent = zip.files["word/document.xml"].asText();
            var contractSectionStartTag = '<w:alias w:val="Contract Section boundary"';
            var contractSectionIdStartTag = '<w:tag w:val="';
            var contractSectionIdEndTag = '/>';
            let startIndex = 0;

            for(var i = 0; i < docSectionData.length; i++){
                var section = docSectionData[i];
                var sectionId = section.sectionId;
                var id = '';
                
                if(section.sectionType === 'Context') {
                    id = 'CS:'+section.sectionName;
                } else {
                    id = section.sectionClauseId;
                }
                var tagPos = docXmlContent.indexOf(contractSectionStartTag, startIndex); //Look for ContractSectionBoundary
                var idTagPos = docXmlContent.indexOf(contractSectionIdStartTag, tagPos) + contractSectionIdStartTag.length; //look for w:tag w:val right after it 
                var idEndTagPos = docXmlContent.indexOf(contractSectionIdEndTag, idTagPos) + contractSectionIdEndTag.length; // get end of tag
                if(idTagPos > -1){
                    let startString = docXmlContent.substring(0, idEndTagPos);
                    let endString = docXmlContent.substring(idEndTagPos);
                    let idPos = startString.lastIndexOf(id);
                    if(idPos > -1){
                        console.log('Found Id for:::'+id);
                        startString = startString.substring(0, idTagPos) + sectionId +'"/>';
                        docXmlContent =  startString + endString;
                        startIndex = startString.length + contractSectionStartTag.length;
                    } else if(docXmlContent.indexOf(sectionId, startIndex) > -1 ) {
                        console.log('Found existing Id for:::'+sectionId);
                        startIndex = docXmlContent.indexOf(sectionId, startIndex);
                    }
                }
            }

            zip.file("word/document.xml", docXmlContent);
            getBase64Content(zip, inputMap.docName).then(function(outputContentBase64){
                resolve(outputContentBase64);
            });
        });
    }


    //Method to replace the Document Section Id in to the Document upon activating after (Importing Document Template)
    function replaceWithNewSectionIds(fileContentData, inputMap){
        return new Promise(function(resolve, reject) {
            let docSectionData = inputMap.documentSectionData;
            let remoteActions = inputMap.remoteActions;

            let zip = new JSZip(fileContentData, {base64: true});
            var docXmlContent = zip.files["word/document.xml"].asText();
            var contractSectionStartTag = '<w:alias w:val="Contract Section boundary"';
            var contractSectionIdStartTag = '<w:tag w:val="';
            var contractSectionIdEndTag = '/>';
            let startIndex = 0;

            for(var i = 0; i < docSectionData.length; i++){
                var section = docSectionData[i];
                var sectionId = section.sectionId;
                var id = '';
                var tagPos = docXmlContent.indexOf(contractSectionStartTag, startIndex); //Look for ContractSectionBoundary
                var idTagPos = docXmlContent.indexOf(contractSectionIdStartTag, tagPos) + contractSectionIdStartTag.length; //look for w:tag w:val right after it 
                var idEndTagPos = docXmlContent.indexOf(contractSectionIdEndTag, idTagPos) + contractSectionIdEndTag.length; // get end of tag
                if(idTagPos > -1){
                    let startString = docXmlContent.substring(0, idEndTagPos);
                    let endString = docXmlContent.substring(idEndTagPos);
                    console.log('Replaced  Id for:::'+id);
                    startString = startString.substring(0, idTagPos) + sectionId +'"/>';
                    docXmlContent =  startString + endString;
                    startIndex = startString.length + contractSectionStartTag.length;
                }
            }

            zip.file("word/document.xml", docXmlContent);
            getBase64Content(zip, inputMap.docName).then(function(outputContentBase64){
                resolve(outputContentBase64);
            });
        });
    }


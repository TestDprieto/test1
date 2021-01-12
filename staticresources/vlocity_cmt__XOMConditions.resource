(function(){  var fileNsPrefix = (function() {
    'use strict';
    var scripts = document.getElementsByTagName('script');
    var lastScript = scripts[scripts.length - 1];
    var scriptName = lastScript.src;
    var parts = scriptName.split('/');
    var thisScript = parts[parts.length - 1];
    if (thisScript === "") {
      thisScript = parts[parts.length - 2];
    }

    // Fix to handle cases where js files are inside zip files
    // https://dev-card.na31.visual.force.com/resource/1509484368000/dev_card__cardframework_core_assets/latest/cardframework.js
    if(scriptName.indexOf('__') != -1 && thisScript.indexOf('__') == -1) {
        thisScript = parts[5] && parts[5].indexOf('__') != -1 ? parts[5] : thisScript;
    }

    var lowerCasePrefix = thisScript.indexOf('__') == -1 ? '' : thisScript.substring(0, thisScript.indexOf('__') + 2);
    //check for the cached namespace first
    lowerCasePrefix = lowerCasePrefix === '' && localStorage.getItem('nsPrefix') ? localStorage.getItem('nsPrefix'): lowerCasePrefix;
    
    if(lowerCasePrefix !== ''){
        lowerCasePrefix = /__$/.test(lowerCasePrefix) ? lowerCasePrefix : lowerCasePrefix + '__';
    }
    if (lowerCasePrefix.length === 0) {
      return function() {
        //then check if the app has put a namespace and take that one as it is newer
        lowerCasePrefix = window.nsPrefix ? window.nsPrefix: lowerCasePrefix;
        //add the underscore if it doesn't have them    
        if(lowerCasePrefix !== ""){
            lowerCasePrefix = /__$/.test(lowerCasePrefix) ? lowerCasePrefix : lowerCasePrefix + '__';
        }  
        return lowerCasePrefix;
      };
    } else {
      var resolvedNs = null;
      return function() {
        if (resolvedNs) {
          return resolvedNs;
        }
        // hack to make scan SF objects for the correct case
        try {
          var tofind = lowerCasePrefix.replace('__', '');
          var name;
          var scanObjectForNs = function(object, alreadySeen) {
            if (object && object !== window && alreadySeen.indexOf(object) == -1) {
                alreadySeen.push(object);
                Object.keys(object).forEach(function(key) {
                  if (key === 'ns') {
                    // do ns test
                    if (typeof object[key] === 'string' && object[key].toLowerCase() === tofind) {
                      name = object[key] + '__';
                      return false;
                    }
                  }
                  if (Object.prototype.toString.call(object[key]) === '[object Array]') {
                    object[key].forEach(function(value) {
                      var result = scanObjectForNs(value, alreadySeen);
                      if (result) {
                          name = result;
                          return false;
                      }
                    });
                  } else if (typeof object[key] == 'object') {
                    var result = scanObjectForNs(object[key], alreadySeen);
                    if (result) {
                        name = result;
                        return false;
                    }
                  }
                  if (name) {
                    return false;
                  }
                });
                if (name) {
                  return name;
                }
            };
          }
          if(typeof Visualforce !== 'undefined') { //inside VF
            scanObjectForNs(Visualforce.remoting.Manager.providers, []);  
          } else {
            return lowerCasePrefix;
          }
          if (name) {
            return resolvedNs = name;
          } else {
            return resolvedNs = lowerCasePrefix;
          }
        } catch (e) {
          return lowerCasePrefix;
        }
      };
    }
  })();

  var fileNsPrefixDot = function() {
    var prefix = fileNsPrefix();
    if (prefix.length > 1) {
      return prefix.replace('__', '.');
    } else {
      return prefix;
    }
  };
(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var module = angular.module('xomconditions', ['vlocity', 'ui.bootstrap', 'fieldLookupUI', 'ngSanitize', 'mgcrea.ngStrap.tooltip']);

require('./modules/xomconditions/factory/ParametersFactory.js');
require('./modules/xomconditions/templates/templates.js');
require('./modules/xomconditions/directive/XOMConditionElement.js');
require('./modules/xomconditions/controller/ConditionsMapperCtrl.js');



},{"./modules/xomconditions/controller/ConditionsMapperCtrl.js":2,"./modules/xomconditions/directive/XOMConditionElement.js":3,"./modules/xomconditions/factory/ParametersFactory.js":4,"./modules/xomconditions/templates/templates.js":5}],2:[function(require,module,exports){
angular.module('xomconditions').controller('conditionsMapperCtrl', function ($scope, remoteActions, $modal, $sce, expressionService, configData) {
    $scope.currRecId = configData.currRecId;
    $scope.nsPrefix = configData.nsPrefix;
    var recordAttributeName = configData.recordAttributeName;
    var objType = configData.objType;
    $scope.isOffPlatformMode = configData.isOffPlatformMode;
    $scope.isExpressionEnabled = configData.isExpressionEnabled;
    $scope.oType = objType;
    $scope.editMode = false;
    $scope.loadedAttrs = true;
    $scope.selectedProduct = [];
    $scope.attrAbsentFlag = false;
    $scope.selProdAttrs = {};
    $scope.operands = [">", "<", ">=", "<=", "!=", "=", "startsWith", "doesNotStartWith", "endsWith", "doesNotEndWith", "contains", "doesNotContain"];
    $scope.expressionOprs = ["+", "-", "*", "/", ">", "<", ">=", "<=", "!=", "==", "(", ")"];
    $scope.deprived = { //key=rowIndex and value = prodName;
        prodsMissingAttrs: []
    };
    $scope.prodMissingAttrFrq = {};//key=prodName, val=frequency of occurrences

    $scope.stOptions = ['attribute', 'field-OrderItem'];
    if ($scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
        $scope.stOptions.push('field-FRLine');
    }
    if ($scope.isOffPlatformMode == true && $scope.isExpressionEnabled == true) {
        $scope.stOptions.push('expression');
    }
    if ($scope.oType == $scope.nsPrefix + 'OrchestrationQueueAssignmentRule__c') {
        if (recordAttributeName == 'OrderItemCondition__c') {
            $scope.stOptions = ['attribute', 'field-OrderItem'];
        }
        else {
            $scope.stOptions = ['field-OrchestrationItem'];
        }
    }
    $scope.conTypeOptions = ['AND', 'OR'];

    // FIXME: Dynamic load
    $scope.avlblAttrsforProd = [];
    $scope.prodName = [];
    // if (productsStr != null && productsStr != '') {
    //     $scope.products = JSON.parse(productsStr);
    // }

    $scope.products = [];

    remoteActions.getProducts($scope.currRecId).then(function(prds)
    {
        $scope.products.concat(prds);
    });

    $scope.prod2attrs = {};

    var errorMessage;
    $scope.loadedMetaData = true;

    // FIXME: dynamic load

    var myAttribList;

    if (myAttribList != null) {
        var codeNamePairs = {};
        if (myAttribList.length == 0) {
            $scope.attrAbsentFlag = true;
            document.getElementById("prodAttrsAbsentMsg").innerHTML = "Warning: Source Product attributes are not found/saved properly. Please add/save them explicitly and retry.";
        }
        for (var a = 0; a < myAttribList.length; a++) {
            codeNamePairs[myAttribList[a].code] = {
                code: myAttribList[a].code,
                name: myAttribList[a].name,
                dataType: myAttribList[a].dataType,
                categoryCode: myAttribList[a].categoryCode
            };

        }
        $scope.attribs = myAttribList;
        $scope.attrMap = codeNamePairs;
        $scope.loadedMetaData = true;
    }

    $scope.sConditions = [];
    $scope.con = {
        name: 'SimpleCondition',
        type: 'AND',
        singleconditions: []
    };
    $scope.replaceHTMLMetaCharsInExpr = function (paramVal) {
        var paramVal = paramVal;
        paramVal = paramVal.replace(/\&\quot\;/g, '"');
        paramVal = paramVal.replace(/&#39;/g, "'");
        paramVal = paramVal.replace(/\&\lt\;/g, "<");
        paramVal = paramVal.replace(/\&\gt\;/g, ">");
        paramVal = paramVal.replace(/\&\lt\=;/g, "<=");
        paramVal = paramVal.replace(/\&\gt\=;/g, ">=");
        paramVal = paramVal.replace(/\&\amp\;/g, "&");
        console.log(" escaped - paramVal: " + paramVal);
        return paramVal;
    };

    $scope.getConditions = function () {
        remoteActions.getConditions($scope.currRecId, recordAttributeName).then(function (response) {
            //prepopulation of dropdown XOM 197-s
            if (response != null && response.singleconditions != null && response.singleconditions.length > 0) {

                console.log('Response', response);
                // var code = '';
                // var isMissingAttrCode = false;
                // for (var i = 0; i < response.singleconditions.length; i++) {
                //     code = response.singleconditions[i]['left-side'];
                //     if (response.singleconditions[i]['left-side-type'] == 'attribute' || response.singleconditions[i]['left-side-type'] == 'expression') {
                //         if ($scope.attrMap != null && (code == '' || code == null || $scope.attrMap[code] == null || $scope.attrMap[code] == '') && response.singleconditions[i]['left-side-type'] == 'attribute') {
                //             response.singleconditions[i]['left-side'] = '';
                //             response.singleconditions[i]['left-side-name'] = '';
                //             isMissingAttrCode = true;
                //         }
                //         if ($scope.attrMap == null && $scope.oType == $scope.nsPrefix + 'OrchestrationQueueAssignmentRule__c') {
                //             response.singleconditions[i]['left-side'] = '';
                //             response.singleconditions[i]['left-side-name'] = '';
                //         }
                //         if ($scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
                //             var x = response.singleconditions[i].product != null ? $scope.prodAttrMap[response.singleconditions[i].product.Id] : null;
                //             updatedProductName = response.singleconditions[i].product.Name;
                //             if ((x === null || x === '' || x === undefined || x.length === 0) && response.singleconditions[i].product.Id != null) {
                //                 $scope.attrAbsentFlag = true;
                //                 $scope.deprived[i] = updatedProductName;
                //                 if ($scope.deprived.prodsMissingAttrs.indexOf(updatedProductName) == -1) {
                //                     $scope.deprived.prodsMissingAttrs.push(updatedProductName);
                //                 }
                //                 $scope.prodMissingAttrFrq[updatedProductName] = $scope.prodMissingAttrFrq[updatedProductName] != null ? $scope.prodMissingAttrFrq[updatedProductName] + 1 : 1;
                //                 response.singleconditions[i]['left-side'] = '';
                //                 response.singleconditions[i]['left-side-name'] = '';
                //             }
                //
                //             response.singleconditions[i].product = response.singleconditions[i].product == null ? {} : response.singleconditions[i].product;
                //             $scope.selProdAttrs[response.singleconditions[i].product.Id] = x;
                //         }
                //         if (response.singleconditions[i]['left-side-type'] == 'expression') {
                //             response.singleconditions[i]['right-side'] = response.singleconditions[i]['right-side'] != null ? $scope.replaceHTMLMetaCharsInExpr(response.singleconditions[i]['right-side']) : null;
                //             $scope.validateExpression(response.singleconditions[i]);
                //         }
                //     }
                //
                //     console.log("response.singleconditions[i]['right-side']: " + response.singleconditions[i]['right-side']);
                //     var rhs = response.singleconditions[i]['right-side'];
                //     if ((rhs != '' && rhs != null) && (rhs.search("&#39;") != -1 || rhs.search("&quot;") != -1 || rhs.search("&amp;") != -1)) {
                //         var resStr = rhs.replace(/\&\quot\;/g, '"');
                //         resStr = resStr.replace(/&#39;/g, "'");
                //         resStr = resStr.replace(/\&\amp\;/g, "&");
                //         response.singleconditions[i]['right-side'] = resStr;
                //         console.log(" escaped - response.singleconditions[i]['right-side']: " + response.singleconditions[i]['right-side']);
                //     }
                //
                //     if (response.singleconditions[i].op == "\&\lt\;") {
                //         response.singleconditions[i].op = "<";
                //     }
                //     if (response.singleconditions[i].op == "\&\gt\;") {
                //         response.singleconditions[i].op = ">";
                //     }
                //     if (response.singleconditions[i].op == "\&\lt\;\=") {
                //         response.singleconditions[i].op = "<=";
                //     }
                //     if (response.singleconditions[i].op == "\&\gt\;\=") {
                //         response.singleconditions[i].op = ">=";
                //     }
                // }//for
                // if (Object.keys($scope.deprived).length == 1 && $scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
                //     $scope.attrAbsentFlag = false;
                // }
                // else if ($scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
                //     $scope.attrAbsentFlag = true;
                //     if ($scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
                //         document.getElementById("prodAttrsAbsentMsg").innerHTML = "Warning:  Attributes missing for the following selected product(s): &nbsp;&nbsp;" + $scope.deprived.prodsMissingAttrs.join(' , &nbsp;') + "<br/> Please add/save them explicitly and retry.";
                //     }
                // }
                // if (isMissingAttrCode) {
                //     $scope.editMode = true;
                //     document.getElementById('errorMsg').innerHTML = 'Please enter the highlighted details in order to save.';
                // }
            }
            $scope.con = response;
        });
    };
    $scope.getConditions();
    $scope.addSingleCon = function () {
        if ($scope.con == null) {
            $scope.con = {
                name: 'SimpleCondition',
                type: 'AND',
                singleconditions: []
            };
        }
        var singleCon = {};
        singleCon['conditionname'] = 'Condition 1';
        singleCon['left-side-type'] = $scope.stOptions[0];
        singleCon['left-side-datatype'] = '';
        singleCon['left-side'] = '';
        singleCon['left-side-name'] = '';
        singleCon['op'] = '';
        singleCon['right-side-type'] = 'value';
        singleCon['right-side'] = '';
        $scope.con.singleconditions.push(singleCon);

        var position = $scope.con.singleconditions.length - 1;
        $scope.selectedProduct[position] = '';
        $scope.editMode = true;
    };

    $scope.deleteSingleCon = function (index, bRefresh) {
        var msg = (bRefresh == true) ? "Are you sure you want to delete this condition permanently? This change cannot be undone." : "Are you sure you want to delete the condition?";
        var resp = confirm(msg);
        var updatedProductName;
        if (resp) {
            if ($scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
                updatedProductName = $scope.con.singleconditions[index].product != null ? $scope.con.singleconditions[index].product.Name : '';
                if ($scope.deprived[index] != null) {//implies the prod has attributes
                    delete $scope.deprived[index];
                    if ($scope.prodMissingAttrFrq[updatedProductName] == 1) {
                        tempIndex = $scope.deprived.prodsMissingAttrs.indexOf(updatedProductName);
                        $scope.deprived.prodsMissingAttrs.splice(tempIndex, 1);
                    }
                    $scope.prodMissingAttrFrq[updatedProductName] = $scope.prodMissingAttrFrq[updatedProductName] - 1;
                }
                document.getElementById("prodAttrsAbsentMsg").innerHTML = "Warning:  Attributes missing for the following selected product(s): &nbsp;&nbsp;" + $scope.deprived.prodsMissingAttrs.join(' , &nbsp;') + "<br/> Please add/save them explicitly and retry.";
                if (Object.keys($scope.deprived).length == 1) {
                    $scope.attrAbsentFlag = false;
                }
                else {
                    $scope.attrAbsentFlag = true;
                    document.getElementById("prodAttrsAbsentMsg").innerHTML = "Warning:  Attributes missing for the following selected product(s): &nbsp;&nbsp;" + $scope.deprived.prodsMissingAttrs.join(' , &nbsp;') + "<br/> Please add/save them explicitly and retry.";
                }
            }
            $scope.con.singleconditions.splice(index, 1);
            if (bRefresh == true)
                $scope.save();
        }

    }

    $scope.myRefresh = function () {
        $scope.editMode = false;
        $scope.getConditions();
    };

    $scope.validateData = function (sCon, i) {
        var objFields = Object.keys(sCon);
        for (var f = 0; f < objFields.length; f++) {
            var fl = objFields[f];
            if (sCon[fl] === null || sCon[fl] === '' || sCon[fl] === undefined) {
                if ((fl !== "right-side" && fl != "product") || (fl == "left-side" && sCon["left-side-type"] != "expression")) {
                    $scope.dataValidFlag = false;
                    $scope.highlightInvalidFields(sCon, i);
                    return;
                }
                else if (fl == "product" && sCon['left-side-type'] == 'attribute'
                    && (sCon["product"].Id == null || sCon["product"].Id == "")
                    && $scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
                    $scope.dataValidFlag = false;
                    $scope.highlightInvalidFields(sCon, i);
                    return;
                }
            }
        }
    };

    $scope.highlightInvalidFields = function (sCon, i) {
        document.getElementById('errorMsg').innerHTML = 'Please enter the highlighted details in order to save. Also rectify all the highlighted expressions for their validity.';
        var elementsValid = document.querySelectorAll(".ng-valid-required");
        for (var e = 0; e < elementsValid.length; e++) {
            elementsValid[e].style.border = "1px solid rgba(0, 0, 0, 0.15)";
            if (elementsValid[e].nodeName.toLowerCase() == "input") {
                var p = elementsValid[e].parentElement.parentElement;
                p.style.border = "1px solid rgba(0, 0, 0, 0.15)";
            }
        }
        var ex;
        var elements = [];
        var elements = document.querySelectorAll(".ng-invalid-required");
        for (var e = 0; e < elements.length; e++) {
            elements[e].style.border = "red 1px solid";
            if (elements[e].nodeName.toLowerCase() == "input" && elements[e].name == "lookupElement") {
                var p = elements[e].parentElement.parentElement;
                p.style.border = "1px solid red";
            }
        }
        for (var j = 0; j < $scope.con.singleconditions.length; j++) {
            if ($scope.con.singleconditions[j]['left-side'] == '' || $scope.con.singleconditions[j]['left-side-type'] == "expression") {
                var p = document.getElementById('prodSelect_' + j);
                if (p != null && p != '') {
                    console.log(p.value);
                    if ($scope.con.singleconditions[j]['left-side-type'] == 'attribute' && ($scope.con.singleconditions[j]['product'] == null || $scope.con.singleconditions[j]['product'].Id == null)) {  //Product details not mandatory
                        p.style.border = "1px solid red";
                    }
                    else {
                        p.style.border = "1px solid rgba(0, 0, 0, 0.15)";
                    }
                }
                if ($scope.con.singleconditions[j]['left-side'] != '' && j >= i) {
                    $scope.validateExpression($scope.con.singleconditions[j]);
                }
            }
        }
        return;
    }


    $scope.save = function () {
        $scope.dataValidFlag = true;
        var conditionStr;
        if ($scope.con != null && $scope.con.singleconditions.length > 0) {
            for (var i = 0; (i < $scope.con.singleconditions.length && $scope.dataValidFlag == true); i++) {
                var sCon = $scope.con.singleconditions[i];
                if (sCon['left-side-type'] == "attribute") {
                    var code = sCon['left-side'];
                    if (code != '' && code != null && $scope.attrMap[code]) { //XOM-671(added $scope.attrMap[code] to the condition)
                        sCon['left-side-name'] = $scope.attrMap[code]['name'];
                        sCon['left-side-datatype'] = $scope.attrMap[code]['dataType'];
                    }
                    else {
                        sCon['left-side'] = '';
                        sCon['left-side-name'] = '';
                        console.log(document.getElementById('leftSide' + i).classList);
                        document.getElementById('leftSide' + i).classList.remove('ng-valid-required');
                        document.getElementById('leftSide' + i).classList.add('ng-invalid-required');
                    }
                }
                else {
                    if (sCon['left-side-name'] != null) {
                        delete sCon['left-side-name'];
                    }
                    if (sCon['left-side-type'] == "expression" && sCon['right-side'] != null) {
                        //delete sCon['left-side'];//delete for the sake of validation and re-add after validate function returns
                        delete sCon['left-side-datatype'];
                        delete sCon['left-side'];
                        if ($scope.validateExpression(sCon) != true) {
                            $scope.dataValidFlag = false;
                            break;
                        }
                    }
                    else {
                        delete sCon['isExprValid'];
                    }

                }
                $scope.con.singleconditions[i] = sCon;

                if ($scope.con.singleconditions[i]['right-side'] === undefined) {
                    $scope.con.singleconditions[i]['right-side'] = '';
                }
                delete selectedProducts;
                console.log($scope.dataValidFlag);
                $scope.validateData(sCon, i);
            }
            for (var i = 0; i < $scope.con.singleconditions.length && $scope.dataValidFlag == true; i++) {
                delete $scope.con.singleconditions[i]['isExprValid'];
            }
            console.log('saving ' + $scope.con);
            conditionStr = JSON.stringify($scope.con);
            for (var i = 0; i < $scope.con.singleconditions.length && $scope.dataValidFlag == true; i++) {
                $scope.con.singleconditions[i]['isExprValid'] = true; //restoring the isExprValid flag on each row to avoid errorneous view
            }
        }
        else {
            conditionStr = null;
        }
        j$('#msgDiv').hide();
        j$('#errorMsg').hide();
        console.log('saving conditionStr ' + conditionStr);
        if ($scope.dataValidFlag === true) {
            var elementsValid = document.querySelectorAll(".ng-valid-required");
            for (var e = 0; e < elementsValid.length; e++) {
                elementsValid[e].style.border = "1px solid rgba(0, 0, 0, 0.15)";
                if (elementsValid[e].nodeName.toLowerCase() == "input") {
                    var p = elementsValid[e].parentElement.parentElement;
                    p.style.border = "1px solid rgba(0, 0, 0, 0.15)";
                }
            }
            remoteActions.saveCondition(conditionStr, $scope.currRecId, recordAttributeName).then(function (response) {
                if (response == 1) {
                    document.getElementById('msgDiv').innerHTML = 'Saved!';
                    j$('#msgDiv').show();
                    setTimeout(function () {
                        j$('#msgDiv').hide();
                    }, 3000);
                    $scope.editMode = false;
                }
                else {
                    document.getElementById('errorMsg').innerHTML = 'Error occurred while saving condition.';
                    j$('#errorMsg').show();
                }
            });
        }//XOM-698
        else {
            j$('#errorMsg').show();
        }
    }//save function end

    $scope.deleteAll = function () {
        j$('#errorMsg').hide();
        j$('#msgDiv').hide();
        var resp = confirm("Are you sure you want to delete all conditions permanently?");
        if (resp) {
            var conditionStr = '';
            remoteActions.saveCondition(conditionStr, $scope.currRecId, recordAttributeName).then(function (response) {
                if (response == 1) {
                    $scope.myRefresh();
                }
                else {
                    document.getElementById('errorMsg').innerHTML = 'Error occurred while saving condition.';
                    j$('#errorMsg').show();
                }
            });
        }
    }
    $scope.resetLHSType = function (conIndex) {
        console.log(conIndex + ':' + JSON.stringify($scope.con.singleconditions));
        $scope.con.singleconditions[conIndex]['left-side'] = '';
        $scope.con.singleconditions[conIndex]['right-side'] = '';
        if ($scope.con.singleconditions[conIndex]['left-side-type'] == "expression") {
            $scope.con.singleconditions[conIndex]['op'] = "=";
            $scope.con.singleconditions[conIndex]['isExprValid'] = 'unchecked';
            $scope.con.singleconditions[conIndex]['product'] = {};
        }

        if ($scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c') {
            updatedProductName = $scope.con.singleconditions[conIndex].product != null ? $scope.con.singleconditions[conIndex].product.Name : '';
            if ($scope.deprived[conIndex] != null) {//implies the prod has no attributes
                delete $scope.deprived[conIndex];
                if ($scope.prodMissingAttrFrq[updatedProductName] == 1) {
                    tempIndex = $scope.deprived.prodsMissingAttrs.indexOf(updatedProductName);
                    $scope.deprived.prodsMissingAttrs.splice(tempIndex, 1);
                }
                $scope.prodMissingAttrFrq[updatedProductName] = $scope.prodMissingAttrFrq[updatedProductName] - 1;
            }
            document.getElementById("prodAttrsAbsentMsg").innerHTML = "Warning:  Attributes missing for the following selected product(s): &nbsp;&nbsp;" + $scope.deprived.prodsMissingAttrs.join(' , &nbsp;') + "<br/> Please add/save them explicitly and retry.";
            if (Object.keys($scope.deprived).length == 1) {
                $scope.attrAbsentFlag = false;
            }
            else {
                $scope.attrAbsentFlag = true;
                document.getElementById("prodAttrsAbsentMsg").innerHTML = "Warning:  Attributes missing for the following selected product(s): &nbsp;&nbsp;" + $scope.deprived.prodsMissingAttrs.join(' , &nbsp;') + "<br/> Please add/save them explicitly and retry.";
            }
            if ($scope.con.singleconditions[conIndex]['left-side-type'] != "attribute") {
                $scope.con.singleconditions[conIndex]['product'] = {};
            }
        }

    };

    ///////////////////////////////////////FieldMapper////////////////////////////////////////
    var FieldModalInstanceCtrl = function ($scope, $modalInstance, fieldLookupService, items) {
        //console.log('items: '+items);
        $scope.selectedItem = items[0];
        $scope.nsPrefix = items[1];
        $scope.objectName = items[2];
        $scope.fieldName = '';
        $scope.selectedFields = [];

        $scope.save = function () {
            $modalInstance.close(fieldLookupService.parseFields($scope.selectedFields));
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');

        };
    };
    var AttrModalInstanceCtrl = function ($scope, $modalInstance, items) {
        $scope.selectedItem = items[0];
        $scope.nsPrefix = items[1];
        $scope.attrs = items[2];
        $scope.selectedAttrs = [];

        $scope.saveAttr = function (selectedAttr) {
            $modalInstance.close(selectedAttr);
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    };
    var ProdModalInstanceCtrl = function ($scope, $modalInstance, items) {
        $scope.selectedItem = items[0];
        $scope.nsPrefix = items[1];
        $scope.prods = items[2];
        $scope.selectedProds = [];
        $scope.saveProd = function (selectedProd) {
            $modalInstance.close(selectedProd);
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    };

    var OprModalInstanceCtrl = function ($scope, $modalInstance, items) {
        $scope.selectedItem = items[0];
        $scope.nsPrefix = items[1];
        $scope.oprs = items[2];
        $scope.selectedProds = [];
        $scope.saveOpr = function (selectedOpr) {
            $modalInstance.close(selectedOpr);
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    };

    $scope.openFieldSelection = function (sc, exprParam) {
        var val = sc['left-side-type'] != "expression" ? sc['left-side-type'] : exprParam;
        switch (val) {
            case    "field-FRLine"          :
                $scope.objectName = $scope.nsPrefix + 'FulfilmentRequestLine__c';
                break;
            case    "field-OrderItem"       :
                $scope.objectName = 'OrderItem';
                break;
            case    "field-OrchestrationItem":
                $scope.objectName = $scope.nsPrefix + 'OrchestrationItem__c';
                break;
        }

        var modalInstance = $modal.open({
            templateUrl: 'fieldSelectionModal.html',
            controller: FieldModalInstanceCtrl,
            resolve: {
                items: function () {
                    return [sc, $scope.nsPrefix, $scope.objectName];
                }
            }
        });
        modalInstance.result.then(function (fieldInfo) {
            console.log('in fieldMapper....' + fieldInfo);
            if (exprParam != null && exprParam != '') {
                sc['right-side'] = sc['right-side'] + " field:\'" + fieldInfo.fullFieldName + "\'";
            }
            else {
                sc['left-side'] = fieldInfo.fullFieldName;
                sc['left-side-datatype'] = fieldInfo.fieldType;
            }
        }, function () {
        });
    };

    $scope.openAttrSelection = function (sc, attribs) {
        $scope = $scope;
        var modalInstance = $modal.open({
            templateUrl: 'attrSelectionModal.html',
            controller: AttrModalInstanceCtrl,
            resolve: {
                items: function () {
                    return [sc, $scope.nsPrefix, attribs];
                }
            }
        });
        modalInstance.result.then(function (selectedAttr) {
            console.log('selectedAttr....' + selectedAttr);
            if (sc['left-side-type'] == 'expression') {
                sc['right-side'] = sc['right-side'] + " attr:\'" + selectedAttr.code + "\'";
            }
            else {
                sc['left-side'] = selectedAttr.code;
                sc['left-side-datatype'] = selectedAttr.dataType;
                sc['left-side-name'] = selectedAttr.name;
            }
        }, function () {
        });
    };

    $scope.openProdSelection = function (sc, prods, parentIndex) {
        var modalInstance = $modal.open({
            templateUrl: 'prodSelectionModal.html',
            controller: ProdModalInstanceCtrl,
            resolve: {
                items: function () {
                    return [sc, $scope.nsPrefix, prods];
                }
            }
        });
        modalInstance.result.then(function (selectedProd) {
            console.log('selectedProd....' + selectedProd);
            var tempIndex;
            if (sc.product != null) {
                if ($scope.prodMissingAttrFrq[sc.product.Name] == 1) {
                    tempIndex = $scope.deprived.prodsMissingAttrs.indexOf(sc.product.Name);
                    $scope.deprived.prodsMissingAttrs.splice(tempIndex, 1);
                }
                $scope.prodMissingAttrFrq[sc.product.Name] = $scope.prodMissingAttrFrq[sc.product.Name] > 0 ? $scope.prodMissingAttrFrq[sc.product.Name] - 1 : 0;
                delete $scope.deprived[parentIndex];
            }
            else {
                sc.product = {};
            }
            sc.product.Name = selectedProd.Name;
            sc.product.Id = selectedProd.Id;
            $scope.fetchProdAttrs(sc.product.Id, parentIndex);
            if (sc['left-side-type'] == "expression") {
                sc['left-side'] = '';
                sc['right-side'] = '';
                sc['left-side-datatype'] = '';
                sc['left-side-name'] = '';
            }
        }, function () {
        });
    };

    $scope.openOprSelection = function (sc, operators) {
        $scope = $scope;
        var modalInstance = $modal.open({
            templateUrl: 'oprSelectionModal.html',
            controller: OprModalInstanceCtrl,
            resolve: {
                items: function () {
                    return [sc, $scope.nsPrefix, operators];
                }
            }
        });
        modalInstance.result.then(function (selectedOpr) {
            console.log('selectedOpr....' + selectedOpr);
            sc['right-side'] = sc['right-side'] + ' ' + selectedOpr;
        }, function () {
        });
    };

    /////////////////////////////////
    $scope.getTooltip = function (message) {
        if (message != "-")
            return {title: message};
        return {title: ""};
    };
    $scope.toggleEditMode = function () {
        $scope.editMode = !($scope.editMode);
    };
    $scope.getMessage = function (sCon) {
        if ((sCon['left-side-type'] == 'attribute' || sCon['left-side-type'] == 'expression')
            && $scope.oType != $scope.nsPrefix + 'DecompositionRelationship__c'
            && sCon.product != null && sCon.product.Id != null
            && ($scope.selProdAttrs[sCon.product.Id] == null
                || $scope.selProdAttrs[sCon.product.Id] == '')) {
            return "Product has no attributes defined";
        }
        return "Select a Product in order to select an attribute";
    };

    $scope.validateExpression = function (sCon) {
        var oldExpr;
        var myStack = [];
        var f = 0;
        var t;
        var expr;
        var skipNextChar = false;
        var appendedOperator;
        var validUnaryOp;
        if (sCon['right-side'] != null && sCon['right-side'] != '') {
            var expr = sCon['right-side'];
            if (expr != null) {
                expressionService.validate(expr)
                    .then(function success(response) {
                        console.log('success response:', response.data);

                        if (response.data.message === 'ok') {
                            sCon['isExprValid'] = true;
                        } else {
                            sCon['isExprValid'] = false;
                            $scope.invalidExprMsg = response.data.message;
                        }
                        return response.data;
                    });
            }
            else {
                console.log('****Unexpected character in expression: ' + expr);
                sCon['isExprValid'] = false;
                return false;
            }
        }
        return sCon['isExprValid'];
    };

});
},{}],3:[function(require,module,exports){
angular.module('xomconditions').directive('conditionElement', ['$compile', 'remoteActions', function($compile, remoteActions) {

    return {

        templateUrl: 'XOMConditionElement.tpl.html',

        scope: {
            conditionElement: '=',
            products: '='
        },
        replace: true,
        restrict: 'E',
        controller:  ['$scope', function($scope) {

        }]

    };

}]);
},{}],4:[function(require,module,exports){
//used for the field Lookup Directive
angular.module('parameters', []).factory('ParametersFactory', function () {
    var factory = {};
    factory.getRemoteInvokeMethod = function () {
        return '{!$RemoteAction.XOMConditionsJSONMapperController.invokeMethod}';

    }

    factory.getClassType = function () {
        return '{!classType}';

    }

    factory.getLoadingImg = function () {
        return '{!$Resource.WAITGIF}';
    }

    factory.getNsPrefix = function () {
        return '{!nsPrefix}';
    }

    return factory;

});
},{}],5:[function(require,module,exports){
angular.module("xomconditions").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("XOMConditionElement.tpl.html",'AAAAA\n\n<div id="conditionContainer_{{$index}}" class="outcome-wrapper"\n     ng-if="con.singleconditions.length>0 && loadedMetaData==true" ng-init="parentIndex = $index;"\n     ng-repeat="sCon in con.singleconditions track by $index" name="{{sCon.conditionname}}">\n    <table class="table table-fix container " id="conMappingtable_{{$index}}" ng-click="expand=!expand"\n           style="border:none">\n        <tr class="step-block slider" expand="expand" id="con_{{$index}}">\n            <form name="conMapperForm" class="form-inline form-group form-short"\n                  ng-click="$event.stopPropagation(); $event.preventDefault();">\n                <td class="col-md-2">\n                          <span class="col-md-2" ng-show="editMode==false" ng-bind-html="sCon[\'conditionname\']"\n                                ng-click="$event.stopPropagation();"\n                                bs-tooltip="getTooltip(sCon.conditionname)" data-container="body" data-placement="top auto">{{sCon[\'conditionname\']}}\n                          </span>\n                    <input ng-show="editMode" class="form-control editBox col-md-2"\n                           ng-model="sCon[\'conditionname\']" value="sCon[\'conditionname\']" type="text"\n                           id="conditionName_{{parentIndex}}" ng-click="$event.stopPropagation();"\n                           bs-tooltip="getTooltip(sCon.conditionname)" data-container="body"\n                           data-placement="top auto"/>\n                </td>\n\n                <td class="col-md-2">\n                    <strong class="icon-warnings"\n                            ng-if="sCon[\'left-side-type\']==null || sCon[\'left-side-type\']==\'\'"><span\n                            class="icon icon-v-warning-circle-line" data-type="danger"\n                            bs-tooltip="getTooltip(\'Select a Value\')" data-container="body"\n                            data-placement="top auto"></span></strong>\n                    <span class="col-md-2" ng-if="editMode==false" ng-bind-html="sCon[\'left-side-type\']"\n                          bs-tooltip="getTooltip(sCon[\'left-side-type\'])" data-container="body"\n                          data-placement="top auto">{{sCon[\'left-side-type\']}} </span>\n                    <select ng-if="editMode" class="form-control editBox col-md-2"\n                            ng-model="sCon[\'left-side-type\']" ng-click="$event.stopPropagation();"\n                            name="{{parentIndex}}" id="selectedSrcTypeOption_{{parentIndex}}"\n                            required="true" ng-options="st for st in stOptions"\n                            ng-change="resetLHSType(parentIndex);"\n                            bs-tooltip="getTooltip(sCon[\'left-side-type\'])" data-container="body"\n                            data-placement="top auto">\n                    </select>\n                </td>\n\n                <td class="col-md-2" ng-if="oType!=nsPrefix+\'DecompositionRelationship__c\'">\n                    <!-- Product selection -->\n                    <span class="col-md-2" ng-show="editMode==false" ng-bind-html="sCon.product.Name"\n                          bs-tooltip="getTooltip(sCon.product.Name)" data-container="body"\n                          data-placement="top auto">{{sCon.product.Name}}</span>\n                    <div ng-if="editMode && (sCon[\'left-side-type\']==\'attribute\'\n                                      && oType!=nsPrefix+\'DecompositionRelationship__c\')"\n                         class="form-control fieldLookup  col-md-3 oiLookup" style="height:28px !important;"\n                         required="true"\n                         id="prodSelect_{{parentIndex}}">\n                        <div class="vloc_lookup_btn">\n                            <button id="prodSelectBtn_{{parentIndex}}" class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openProdSelection(sCon, products, parentIndex);">\n                                <i class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="prodSelectInput_{{parentIndex}}" type=\'text\'\n                                                            name="lookupElement" ng-model="sCon.product.Name"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            bs-tooltip="getTooltip(sCon.product.Name)"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/></div>\n                    </div>\n                    <div ng-if="editMode && (sCon[\'left-side-type\']==\'expression\' && oType!=nsPrefix+\'DecompositionRelationship__c\')"\n                         class="form-control fieldLookup  col-md-3 oiLookup" style="height:28px !important;"\n                         id="prodSelect_{{parentIndex}}">\n                        <div class="vloc_lookup_btn">\n                            <button id="prodSelectBtn_{{parentIndex}}" class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openProdSelection(sCon, products, parentIndex);">\n                                <i class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="prodSelectInput_{{parentIndex}}" type=\'text\'\n                                                            name="lookupElement" ng-model="sCon.product.Name"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            bs-tooltip="getTooltip(sCon.product.Name)"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/></div>\n                    </div>\n                    <select ng-if="editMode && sCon[\'left-side-type\']!=\'attribute\' && sCon[\'left-side-type\']!=\'expression\'"\n                            ng-readOnly="true" class="form-control editBox col-md-2" ng-value="" ng-model=""\n                            id="prodSelect_{{parentIndex}}">\n                    </select>\n                </td>\n\n                <td class="col-md-2">\n                    <!--\n                    <strong class="icon-warnings" ng-if="sCon[\'left-side\']==null || sCon[\'left-side\']==\'\' || (sCon[\'left-side-type\']==\'expression\' && sCon[\'isExprValid\']!=true)"><span class="icon icon-v-warning-circle-line" data-type="danger" bs-tooltip="getTooltip(\'Select a Value\')" data-container="body" data-placement="top auto"></span></strong>\n                    -->\n                    <strong class="icon-warnings"\n                            ng-if="(sCon[\'left-side\']==null || sCon[\'left-side\']==\'\') && sCon[\'left-side-type\']!=\'expression\'"><span\n                            class="icon icon-v-warning-circle-line" data-type="danger"\n                            bs-tooltip="getTooltip(\'Select a Value\')" data-container="body"\n                            data-placement="top auto"></span></strong>\n                    <span class="col-md-2" ng-show="editMode==false && sCon[\'left-side-type\']==\'attribute\'"\n                          ng-bind-html=""\n                          bs-tooltip="getTooltip(attrMap[sCon[\'left-side\']].categoryCode+\'-\'+sCon[\'left-side-name\'])"\n                          data-container="body" data-placement="top auto">{{attrMap[sCon[\'left-side\']].categoryCode}}-{{sCon[\'left-side-name\']}}</span>\n                    <div ng-show="editMode && sCon[\'left-side-type\']==\'attribute\' && oType==nsPrefix+\'DecompositionRelationship__c\' && attrAbsentFlag!=true"\n                         id="leftSide{{parentIndex}}" class="form-control fieldLookup  col-md-3 oiLookup"\n                         style="height:28px !important;"\n                         ng-class="{\'ng-invalid ng-invalid-required\': sCon[\'left-side\']==\'\', \'ng-valid ng-valid-required\':sCon[\'left-side\']!=\'\'}">\n                        <div class="vloc_lookup_btn">\n                            <button id="openAttrSelectionBtn_{{parentIndex}}"\n                                    class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openAttrSelection(sCon, attribs);"><i\n                                    class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="leftSide{{parentIndex}}input" type=\'text\'\n                                                            name="lookupElement"\n                                                            ng-value="(attrMap[sCon[\'left-side\']].categoryCode!=null?(attrMap[sCon[\'left-side\']].categoryCode+\'-\'+sCon[\'left-side-name\']):\'\')"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            ng-class="{\'ng-invalid ng-invalid-required\': sCon[\'left-side\']==\'\', \'ng-valid ng-valid-required\':sCon[\'left-side\']!=\'\'}"\n                                                            bs-tooltip="getTooltip(attrMap[sCon[\'left-side\']].categoryCode+\'-\'+sCon[\'left-side-name\'])"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/>\n\n                        </div>\n                    </div>\n\n                    <div ng-show="editMode && sCon[\'left-side-type\']==\'attribute\' && oType!=nsPrefix+\'DecompositionRelationship__c\' && selProdAttrs[sCon.product.Id]!=null && selProdAttrs[sCon.product.Id]!=\'\'"\n                         id="leftSide-{{parentIndex}}" class="form-control fieldLookup  col-md-3 oiLookup"\n                         style="height:28px !important;">\n                        <div class="vloc_lookup_btn">\n                            <button id="openAttrelectionBtn_{{parentIndex}}"\n                                    class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openAttrSelection(sCon, selProdAttrs[sCon.product.Id]);">\n                                <i class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="leftSide-{{parentIndex}}-input" type=\'text\'\n                                                            name="lookupElement"\n                                                            ng-value="(attrMap[sCon[\'left-side\']].categoryCode!=null?(attrMap[sCon[\'left-side\']].categoryCode+\'-\'+sCon[\'left-side-name\']):\'\')"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            ng-class="{\'ng-invalid ng-invalid-required\': sCon[\'left-side\']==\'\', \'ng-valid ng-valid-required\':sCon[\'left-side\']!=\'\'}"\n                                                            bs-tooltip="getTooltip((attrMap[sCon[\'left-side\']].categoryCode!=null?(attrMap[sCon[\'left-side\']].categoryCode+\'-\'+sCon[\'left-side-name\']):\'\'))"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/>\n                        </div>\n                    </div>\n                    <input ng-readOnly="true" type=\'text\' ng-value="" required="true"\n                           ng-show="editMode && sCon[\'left-side-type\']==\'attribute\' && oType==nsPrefix+\'DecompositionRelationship__c\' && attrAbsentFlag==true"\n                           class="form-control editBox" id="leftSide{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"/>\n\n                    <input ng-readOnly="true" type=\'text\' ng-value="" required="true"\n                           ng-show="editMode && sCon[\'left-side-type\']==\'attribute\' && oType!=nsPrefix+\'DecompositionRelationship__c\' && (selProdAttrs[sCon.product.Id]==null || selProdAttrs[sCon.product.Id]==\'\') && (attrMap[sCon[\'left-side\']].name!=null && attrMap[sCon[\'left-side\']].name!=\'\')"\n                           class="form-control editBox" id="leftSide{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"/>\n                    <input ng-readOnly="true" type=\'text\' ng-value="" required="true"\n                           ng-show="editMode && sCon[\'left-side-type\']==\'attribute\' && oType!=nsPrefix+\'DecompositionRelationship__c\' && (selProdAttrs[sCon.product.Id]==null || selProdAttrs[sCon.product.Id]==\'\') && (attrMap[sCon[\'left-side\']].name==null || attrMap[sCon[\'left-side\']].name==\'\')"\n                           class="form-control editBox ng-invalid-required" id="leftSide{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"/>\n\n\n                    <span ng-show="sCon[\'left-side-type\']==\'attribute\' && attrAbsentFlag==true && (attribs.length==0 || deprived.prodsMissingAttrs.indexOf(sCon.product.Name)!=-1)"\n                          bs-tooltip="getTooltip(\'Product has no attributes defined\')" data-container="body"\n                          data-placement="top auto" class="text-primary errorMsg">\n                                  Product has no attributes defined\n                            </span>\n\n                    <span class="col-md-2 oiLookup"\n                          ng-show="editMode==false && sCon[\'left-side-type\']!=\'attribute\'"\n                          ng-bind-html="sCon[\'left-side\']"\n                          bs-tooltip="getTooltip(sCon[\'left-side\'])" data-container="body"\n                          data-placement="top auto">\n                                  {{sCon[\'left-side\']}}\n                            </span>\n\n                    <!-- For OrderItem -->\n                    <div ng-show="editMode && sCon[\'left-side-type\']==\'field-OrderItem\'"\n                         id="oiLookup_{{parentIndex}}" class="form-control fieldLookup  col-md-3 oiLookup"\n                         style="height:28px !important;" required="true">\n                        <div class="vloc_lookup_btn">\n                            <button id="openFieldSelectionBtn_{{parentIndex}}"\n                                    class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openFieldSelection(sCon, null);"\n                                    style=""><i class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="leftSide{{parentIndex}}" type=\'text\'\n                                                            name="lookupElement" ng-model="sCon[\'left-side\']"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            bs-tooltip="getTooltip(sCon[\'left-side\'])"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/>\n                        </div>\n                    </div>\n\n                    <!-- For FRLine -->\n                    <div ng-show="editMode && sCon[\'left-side-type\']==\'field-FRLine\'"\n                         id="frLookup_{{parentIndex}}" class="form-control fieldLookup  col-md-3 frLookup"\n                         style="height:28px !important;" required="true">\n                        <div class="vloc_lookup_btn">\n                            <button id="openFieldSelectionBtn_{{parentIndex}}"\n                                    class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openFieldSelection(sCon, null);"\n                                    style=""><i class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="leftSide{{parentIndex}}" type=\'text\'\n                                                            name="lookupElement" ng-model="sCon[\'left-side\']"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            bs-tooltip="getTooltip(sCon[\'left-side\'])"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/>\n                        </div>\n                    </div>\n\n                    <!-- For OrchItem -->\n                    <div ng-show="editMode && sCon[\'left-side-type\']==\'field-OrchestrationItem\'"\n                         id="orchLookup_{{parentIndex}}" class="form-control fieldLookup  col-md-3 frLookup"\n                         style="height:28px !important;" required="true">\n                        <div class="vloc_lookup_btn">\n                            <button id="openFieldSelectionBtn_{{parentIndex}}"\n                                    class="btn btn-link col-md-1 vloc_btn"\n                                    ng-click="$event.stopPropagation();openFieldSelection(sCon, null);"\n                                    style=""><i class="icon icon-v-search"></i></button>\n                        </div>\n                        <div class="vloc_lookup_inp"><input id="leftSide{{parentIndex}}" type=\'text\'\n                                                            name="lookupElement" ng-model="sCon[\'left-side\']"\n                                                            ng-readOnly="true" class="fliedLookupVal vloc_inp"\n                                                            required="true"\n                                                            bs-tooltip="getTooltip(sCon[\'left-side\'])"\n                                                            data-container="body" data-placement="top auto"\n                                                            ng-click="$event.stopPropagation();"/>\n                        </div>\n                    </div>\n\n                    <!-- For Expression -->\n                    <input ng-readOnly="true" type=\'text\' ng-value=""\n                           ng-show="editMode && sCon[\'left-side-type\']==\'expression\'"\n                           class="form-control editBox ng-valid-required" id="leftSide{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"/>\n                    <!--\n                    <input ng-show="editMode && sCon[\'left-side-type\']==\'expression\'"  class="form-control editBox col-md-2"\n                           ng-model="sCon[\'left-side\']" ng-click="$event.stopPropagation();"\n                           ng-options="" id="left-side_{{parentIndex}}"\n                           required="true"\n                           bs-tooltip="getTooltip(sCon[\'left-side\'])"  data-container="body" data-placement="top auto">\n                   </input>\n                   <span ng-show="sCon[\'left-side-type\']==\'expression\' && sCon[\'isExprValid\']!=true && sCon[\'isExprValid\']!=\'unchecked\'" bs-tooltip="getTooltip(\'Check validity of the expression\')"  data-container="body" data-placement="top auto" class="text-primary errorMsg exprValidityMsg">\n                           {{sCon.isExprValid==false? \'Check validity of expression\':\'Invalid expression\'}}\n                   </span>\n                   -->\n\n                </td>\n\n                <td class="col-md-1">\n                    <strong class="icon-warnings" ng-if="sCon[\'op\']==null || sCon[\'op\']==\'\'"><span\n                            class="icon icon-v-warning-circle-line" data-type="danger"\n                            bs-tooltip="getTooltip(\'Select a Value\')" data-container="body"\n                            data-placement="top auto"></span></strong>\n                    <span class="col-md-2" ng-show="editMode==false" ng-bind-html="sCon[\'op\']"\n                          bs-tooltip="getTooltip(sCon[\'op\'])" data-container="body"\n                          data-placement="top auto"></span>\n                    <select ng-show="editMode && sCon[\'left-side-type\']!=\'expression\'"\n                            class="form-control editBox col-md-2"\n                            ng-model="sCon[\'op\']" ng-click="$event.stopPropagation();"\n                            ng-options="op for op in operands" required="true" id="operand_{{parentIndex}}"\n                            bs-tooltip="getTooltip(sCon[\'op\'])" data-container="body" data-placement="top auto">\n                    </select>\n                    <select ng-show="editMode && sCon[\'left-side-type\']==\'expression\'"\n                            class="form-control editBox col-md-2"\n                            ng-model="sCon[\'op\']" ng-click="$event.stopPropagation();"\n                            ng-options="op for op in [\'=\', \'!=\']" required="true" id="operand_{{parentIndex}}"\n                            bs-tooltip="getTooltip(sCon[\'op\'])" data-container="body" data-placement="top auto"\n                            ng-disabled="true">\n                    </select>\n                </td>\n\n                <td class="col-md-2">\n                            <span class="col-md-2" ng-show="editMode==false" ng-bind-html="sCon[\'right-side\']"\n                                  bs-tooltip="getTooltip(sCon[\'right-side\'])" data-container="body"\n                                  data-placement="top auto"> {{sCon[\'right-side\']}}</span>\n                    <input ng-show="editMode && sCon[\'left-side-type\']!=\'expression\'"\n                           class="form-control editBox col-md-2" ng-model="sCon[\'right-side\']"\n                           value="sCon[\'right-side\']" type="text" id="rightSideVal_{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"\n                           bs-tooltip="getTooltip(sCon[\'right-side\'])" data-container="body"\n                           data-placement="top auto"/>\n                    <input ng-show="editMode && sCon[\'left-side-type\']==\'expression\'"\n                           class="form-control editBox col-md-2" ng-model="sCon[\'right-side\']"\n                           value="sCon[\'right-side\']" type="text" id="rightSideVal_{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"\n                           bs-tooltip="getTooltip(sCon[\'right-side\'])" data-container="body"\n                           data-placement="top auto"/>\n                    <span ng-show="sCon[\'left-side-type\']==\'expression\' && sCon[\'isExprValid\']!=true && sCon[\'isExprValid\']!=\'unchecked\'"\n                          bs-tooltip="getTooltip(\'Check validity of the expression\')" data-container="body"\n                          data-placement="top auto" class="text-primary errorMsg exprValidityMsg">\n                                {{sCon.isExprValid==false? \'Check validity of expression\':\'Invalid expression\'}}\n                            </span>\n                </td>\n                <td class="col-md-1">\n                    <i id="deleteEditMode_{{$index}}" class="icon-v-trash pull-left" ng-show="editMode==true"\n                       ng-click="$event.stopPropagation();deleteSingleCon($index,false)"\n                       bs-tooltip="getTooltip(\'Delete condition\')" data-container="body"\n                       data-placement="top auto"/>\n                    <i id="deleteReadMode_{{$index}}" class="icon-v-trash pull-left" ng-show="editMode==false"\n                       ng-click="$event.stopPropagation();deleteSingleCon($index,true)"\n                       bs-tooltip="getTooltip(\'Delete condition\')" data-container="body"\n                       data-placement="top auto"/>\n                    <i ng-if="sCon[\'left-side-type\']==\'expression\'"\n                       ng-class="expand ? \'icon-v-down-caret\' : \'icon-v-right-caret\'"\n                       bs-tooltip="getTooltip(\'Toggle expand\')" data-container="body"\n                       data-placement="top auto"/>\n                </td>\n            </form>\n        </tr>\n    </table>\n\n\n    <!-- collapsible Section  -->\n    <div expand="expand" class="step-block slider"\n         ng-if="expand==true && sCon[\'left-side-type\']==\'expression\' ">\n        <p ng-show="sCon[\'left-side-type\']!=\'expression\'"\n           style="color: rgb(124,124,124); font: arial; font-size: 12px">Please select "expression" under\n            source-type to provide an expression</p>\n        <p ng-show="sCon[\'left-side-type\']==\'expression\'"\n           style="color: rgb(124,124,124); font: arial; font-size: 12px">Expression editor</p>\n        <div ng-if="sCon[\'left-side-type\']==\'expression\'">\n            <p ng-show="editMode && (sCon[\'left-side-type\']==\'attribute\'||sCon[\'left-side-type\']==\'expression\')\n                              && oType!=nsPrefix+\'DecompositionRelationship__c\' && (selProdAttrs[sCon.product.Id]==null\n                              || selProdAttrs[sCon.product.Id]==\'\')"\n               bs-tooltip="" data-container="body" data-placement="top auto" class="text-primary errorMsg">\n                {{getMessage(sCon)}}\n            </p>\n            <p ng-show="sCon[\'isExprValid\']==true" bs-tooltip="" data-container="body" data-placement="top auto"\n               class="text-primary" id="invalidExprMsg">Valid Expression.</p>\n            <p ng-show="sCon[\'isExprValid\']==false" bs-tooltip="" data-container="body"\n               data-placement="top auto" class="errorMsg" id="invalidExprMsg">Invalid Expression.\n                {{invalidExprMsg}}</p>\n\n            <form name="expressionForm" class="form-inline form-group form-short expressionForm"\n                  ng-click="$event.stopPropagation(); $event.preventDefault();">\n\n                <!-- For attribute Selection -->\n                <button type="button" class="btn btn-primary pull-left expr_buttons"\n                        ng-show="editMode && (sCon[\'left-side-type\']==\'attribute\'||sCon[\'left-side-type\']==\'expression\')\n                              && oType!=nsPrefix+\'DecompositionRelationship__c\'"\n                        ng-disabled="(selProdAttrs[sCon.product.Id]==null || selProdAttrs[sCon.product.Id]==\'\')"\n                        ng-click="$event.stopPropagation();openAttrSelection(sCon, selProdAttrs[sCon.product.Id]);"\n                        id=""\n                        bs-tooltip="{title:getMessage(sCon)}" data-container="body" data-placement="top auto">\n                    Select Attribute\n                </button>\n\n                <!-- attrib selection for DR -->\n                <button type="button" class="btn btn-primary pull-left expr_buttons"\n                        ng-show="editMode && (sCon[\'left-side-type\']==\'attribute\'||sCon[\'left-side-type\']==\'expression\')\n                              && oType==nsPrefix+\'DecompositionRelationship__c\' && attrAbsentFlag!=true"\n                        ng-disabled="attrAbsentFlag==true"\n                        ng-click="$event.stopPropagation();openAttrSelection(sCon, attribs);" id="">Select\n                    Attribute\n                </button>\n                <!-- For OI -->\n                <button type="button" class="btn btn-primary pull-left expr_buttons" ng-if="editMode==true"\n                        ng-click="$event.stopPropagation();openFieldSelection(sCon, \'field-OrderItem\');" id="">\n                    Select OrderItem Field\n                </button>\n\n                <!-- For FRLine -->\n                <button type="button" class="btn btn-primary pull-left expr_buttons"\n                        ng-if="editMode==true && oType!=nsPrefix+\'DecompositionRelationship__c\'"\n                        ng-click="$event.stopPropagation();openFieldSelection(sCon, \'field-FRLine\');" id="">\n                    Select Fulfilment Request Line Item Field\n                </button>\n\n                <!-- For Operator -->\n                <button type="button" class="btn btn-primary pull-left expr_buttons" ng-if="editMode==true"\n                        ng-click="$event.stopPropagation();openOprSelection(sCon, expressionOprs);" id="">Select\n                    Operator\n                </button>\n\n                <div class="expressionContainer">\n                    <label class="" bs-tooltip="getTooltip(sCon[\'right-side\'])" data-container="body"\n                           data-placement="top auto" ng-show="!editMode">{{sCon[\'right-side\']}}</label>\n                    <input ng-show="editMode" class="form-control editBox" ng-model="sCon[\'right-side\']"\n                           value="sCon[\'right-side\']" type="text" id="expr_{{parentIndex}}"\n                           ng-click="$event.stopPropagation();"\n                           bs-tooltip="getTooltip(sCon[\'right-side\'])" data-container="body"\n                           data-placement="top auto"/>\n                    <strong class="icon-warnings" ng-if="sCon[\'isExprValid\']!=true"><span\n                            class="icon icon-v-warning-circle-line" data-type="danger"\n                            bs-tooltip="getTooltip(\'Invalid expression\')" data-container="body"\n                            data-placement="top auto"></span></strong>\n\n                </div>\n                <button type="button" class="btn btn-primary pull-left expr_buttons" ng-if="editMode==true"\n                        ng-click="$event.stopPropagation();validateExpression(sCon);"\n                        bs-tooltip="getTooltip(\'Validate Expression\')" data-container="body"\n                        data-placement="top auto">Validate Expression\n                </button>\n            </form>\n        </div>\n    </div>\n</div><!-- expand -->')}]);
},{}]},{},[1]);

})();
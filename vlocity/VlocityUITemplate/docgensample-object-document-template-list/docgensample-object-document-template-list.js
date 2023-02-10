baseCtrl.prototype.setDocXDocTempList = function(control,scp) {
    'use strict';
    var afterSlash = '/' + window.location.href.split('.com/')[1].split('/')[0];
    window.VlocOmniSI = scp;
    if (afterSlash === 'apex') {
        afterSlash = '';
    }

    baseCtrl.prototype.$scope.searchFilter = function (name, term) {
        if (term !== '' && term !== undefined) {
            var temp = name.toLowerCase();
            term = term.toLowerCase();
            if (temp.indexOf(term) > -1) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    };

 };
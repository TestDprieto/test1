baseCtrl.prototype.openSubTab = function(control,scp) {

   sforce && sforce.console && sforce.console.getEnclosingPrimaryTabId(function(result) {
            var primaryTabId = result.id;
            sforce.console.openSubtab(primaryTabId , '/' + scp.bpTree.response.SelectedAccountId , false,
                'salesforce', null, function(){}, scp.bpTree.response.Name);
    });

if ('parentIFrame' in window) { 
   window.parentIFrame.sendMessage({
      message: 'actionLauncher:windowopen',
      action : {
          isCustomAction : true,
          url: '/' + scp.bpTree.response.SelectedAccountId,
          openUrlIn : 'New Tab / Window',
          openInPrimaryTab : true
      }
    });
 }
};
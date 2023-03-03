var iframeIntervals = {};

/* create an iframe resize event  */
function bindIframeResize(iframeId, resizeHeight) {
	resizeIframe(iframeId, resizeHeight);

	iframeIntervals[iframeId] = setInterval(function() {
		resizeIframe(iframeId, resizeHeight);
	}, 500);
}

/* resize the given iframe */
function resizeIframe(iframeId, resizeHeight) {
	if ($('#'+iframeId).length > 0) {
        var iframeBodyEl = $('#'+iframeId).contents().find('body');

        // set width
        var prevwidth = $('#'+iframeId).attr('width');
        var newwidth = iframeBodyEl.outerWidth(true);
        if (newwidth !== prevwidth && newwidth > 0) {
            //$('#'+iframeId).attr('width', newwidth);
        }

        if (resizeHeight) {
            // set height
            var prevheight = $('#'+iframeId).attr('height');
            var newheight = iframeBodyEl.outerHeight(true);
            if (newheight !== prevheight && newheight > 0) {
                $('#'+iframeId).attr('height', newheight);
            }
        }
    }
}

/* unbind the iframe resize event */
function unbindIframeResize(iframeId) {
	clearInterval(iframeIntervals[iframeId]);
	delete iframeIntervals[iframeId];
}

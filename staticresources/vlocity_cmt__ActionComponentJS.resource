// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds. If `immediate` is passed, trigger the function on the
// leading edge, instead of the trailing.
function debounce(func, wait, immediate) {
    'use strict';
    var timeout;
    return function() {
        var context = this,
            args = arguments;
        var later = function() {
            timeout = null;
            if (!immediate) {
                func.apply(context, args);
            }
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) {
            func.apply(context, args);
        }
    };
}
 //workaround to call the 'ResponsiveTail' method from lightning component.
(function(w){
    "use strict";

    var respTailMethods = {
        "responsiveTailMethod":responsiveTailMethod
    };

    function responsiveTailMethod(){
        var responsiveTail = new ResponsiveTail();
    }
    w.responsiveTail = respTailMethods;

})(window);

// ResponsiveTail Object
function ResponsiveTail() {
    'use strict';
    var self = this;
    this.createDropdown();
    if (this instanceof ResponsiveTail) {
        this.createDropdown();
        // console.log('Dropdown created 2');
        this.activateMenu();
        // console.log('Menu activated 2');
    } else {
        return new ResponsiveTail();
    }

    $(window).resize(debounce(function() {
        self.createDropdown();
        // console.log('Dropdown created on window resize');
    }, 20));
}

/**
 * This is where the magic happens. Create the dropdown container if it doesn't
 * exist, then one by one add each last action-item to the dropdown container.
 * Additionally, return each action-item to its original position when the browser
 * width is increasing in size. :)
 *
 */
ResponsiveTail.prototype.createDropdown = function() {
    'use strict';
    var vlocityActionsW = $('.vlocity-actions').outerWidth();
    if ($('.actions-dropdown').length < 1) {
        $('.action-container.action-horizontal').addClass('dropdown')
            .append('<div class="actions-dropdown"></div>');
    }
    var addedElementsWidth = 100;
    $('#action-container .actions-dropdown .action-item').remove();
    $('#action-container .action-item').remove();
    var limitReached = false;
    $($('.action-container.action-horizontal.hidden-actions').children('.action-item').get()).each(function() {
        var futureWidth = (addedElementsWidth + this.getBoundingClientRect().width);
        if (futureWidth > vlocityActionsW || limitReached) {
            limitReached = true;
            $(this).clone().appendTo('#action-container .actions-dropdown');
        } else if (!limitReached) {
            addedElementsWidth += this.getBoundingClientRect().width;
            $(this).clone().appendTo('#action-container');
        }
    });
};

ResponsiveTail.prototype.activateMenu = function() {
    'use strict';
    $('html').click(function(e) {
        if ($(e.target).parents('.actions-dropdown').length) {
            return;
        }
        $('.action-container.action-horizonntal, .actions-dropdown').removeClass('active');
        $('.action-container.action-horizontal').removeClass('active');
    });
    $('.action-container.action-horizontal').children('i.icon').click(function(e) {
        e.stopPropagation();
        $(this).siblings('.actions-dropdown').toggleClass('active');
        $('.action-container.action-horizontal').toggleClass('active');
    });
};

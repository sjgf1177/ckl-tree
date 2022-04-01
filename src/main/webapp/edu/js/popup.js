/**
 * Created by ceo on 2017-10-21.
 */

/* popup_wrap 스크롤 컨트롤 */
(function () {

    var popup_wrap = $(".popup_wrap");
    var _clientY = null; // remember Y position on touch start

    popup_wrap.on("touchstart", function( event ){
        if (event.targetTouches.length === 1) {
            // detect single touch
            _clientY = event.targetTouches[0].clientY;
        }
    })

    popup_wrap.on("touchmove", function( event ){
        if (event.targetTouches.length === 1) {
            // detect single touch
            disableRubberBand(event);
        }
    })

    function disableRubberBand(event) {
        var clientY = event.targetTouches[0].clientY - _clientY;

        if (popup_wrap[0].scrollTop === 0 && clientY > 0) {
            // element is at the top of its scroll
            event.preventDefault();
        }

        if (isOverlayTotallyScrolled() && clientY < 0) {
            //element is at the top of its scroll
            event.preventDefault();
        }
    }

    function isOverlayTotallyScrolled() {
        // https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight#Problems_and_solutions
        return popup_wrap[0].scrollHeight - popup_wrap[0].scrollTop <= popup_wrap[0].clientHeight;
    }
}())
/* //popup_wrap 스크롤 컨트롤 */
function layer_open(el) {

    var temp = $('#' + el);		//레이어의 id를 temp변수에 저장
    var bg = temp.prev().hasClass('layer_bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

    if (bg) {
        temp.parent('.archive_layer').fadeIn();
    } else {
        temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
        return false;
    }

    // 화면의 중앙에 레이어를 띄운다.
    if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
    else temp.css('top', '0px');
    if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
    else temp.css('left', '0px');

    temp.find('.btn_layer_close').click(function (e) { 
        if (bg) {
            $('.archive_layer').fadeOut();
        } else {
            temp.fadeOut();		//'닫기'버튼을 클릭하면 레이어가 사라진다.
        }
        e.preventDefault();
    });
}

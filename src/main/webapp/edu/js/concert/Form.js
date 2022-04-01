/**
 * User: kjhbond
 * Date: 13. 7. 4
 * Time: 오후 2:58
 */

bm.httpSend = function(
    url /* url */
    , data /* object 파라미터들 */
    , fn /* complete handler */
)
{
    var timeoutDelay = 30000;
    var dataType = 'json';
    var method = 'post';

    data = data || {};
    Progress.ON();

    $.ajax({
        url : url
        ,dataType : dataType
        ,data : data
        ,type : method
        ,timeout : timeoutDelay
        ,success : function(msg){
            Progress.OFF();
            if( fn ) fn( msg );
        }
        ,error : function( msg, t ){

            if( t === "timeout" ){
                alert( "데이터 전송 시간이 초과되었습니다" );
            }
            Progress.OFF();
        }
    });
}




/**
 * Created with JetBrains PhpStorm.
 * User: kjhnotebook
 * Date: 15. 1. 24
 * Time: 오후 6:15
 * To change this template use File | Settings | File Templates.
 */



bm.string = {

    /*
     * 숫자를 원하는 자릿수로 바꿔줌.
     * @num origin number
     * @unit 자릿수 ( 기본값 2 )
     * */
    numUtitToString : function( num, unit ){
        var s, len;

        s = num.toString(10);
        unit = unit || 2;
        len = unit - s.length;

        if( len > 0 ) while( len-- ) s = "0"+s;

        return s;
    }



    /**
     * 원하는 값에 3자리마다 , 를 찍어서 화폐 단위로 반환
     * @param x
     * @returns {*}
     */
    ,numberWithCommas : function(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }


    /**
     * 문자열 자르기
     * str : 문자열
     * byte : 원하는 문자열 길이
     * moreText : 문자열 뒤에 붙을 문자 : ...
     */
    ,cutByte : function( str, byte, moreText ){
        moreText = moreText || "...";

        var count = 0;
        for(var i = 0; i < str.length; i++) {

            if(escape(str.charAt(i)).length >= 4) count += 2;
            else if (escape(str.charAt(i)) != "%0D") count++;

            if(count >  byte) {
                if(escape(str.charAt(i)) == "%0A")
                    i--;
                break;
            }
        }
        return str.substring(0, i-3) + "...";
    }

    /**
     * 문자열의 길이를 byte 로 반환
     */
    ,getByte : function( str ){
        var length = 0;
        for(var i = 0; i < str.length; i++) {
            if(escape(str.charAt(i)).length >= 4) length += 2;
            else if(escape(str.charAt(i)) == "%A7") length += 2;
            else if (escape(str.charAt(i)) != "%0D") length++;
        }
        return length;
    }

    ,trimLeft : function( str ){ return str ? str.replace(/^\s*/, "") : str; }
    ,trimRight : function( str ){ return str ? str.replace(/\s*$/, "") : str; }
    ,trim : function( str ){
        return str ? str.replace(/(^\s*)|(\s*$)/g, '') : str;
    }
    ,trimList : function( list ){
        var len = list.length;
        while( len-- ){
            list[len] = bm.string.trim( list[len] );
        }
        return list;
    }

}
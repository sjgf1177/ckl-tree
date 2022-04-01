/**
 * Created by kjhmac on 2017-01-15.
 */


bm.number = {


    /**
     * "rgb(255,255,255)" 를 hex 코드로 변경해주는 함수
     * @param rgb
     * @returns {string}
     */
    rgbToHex : function(rgb){
        rgb = rgb.split("(")[1].split(")")[0];
        rgb = rgb.split(",");

        return "#" + this.hex(rgb[0]) + this.hex(rgb[1]) + this.hex(rgb[2]);
    }


    /**
     * 숫자를 hex 코드로 변경해주는 함수
     * @param c
     * @returns {string}
     */
    ,hex : function(c) {
        var hex = parseInt(c).toString(16);
        return hex.length == 1 ? "0" + hex : hex;
    }

}
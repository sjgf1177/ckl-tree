/**
 * Created with JetBrains PhpStorm.
 * User: kjhbond
 * Date: 13. 6. 27
 * Time: 오후 8:09
 * To change this template use File | Settings | File Templates.
 */

bm.__foo = document.createElement('div');

bm.html = function( str ) {
    this.__foo.innerHTML = str;
    var el = this.__foo.children[0].cloneNode(true);
    this.__foo.removeChild( this.__foo.children[0] );
    return el;
}

bm.addChild = function( element, parent ) { parent.insertBefore( element, parent.childNodes[0] ); }
bm.addChildAt = function( element, parent, index ){ parent.insertBefore( element, parent.childNodes[index] ); }



bm.dom = {
    listInterpreter : function( data, template, parentContainer, type ){
        var len = data.length;
        for( var i=0; i<len; i++ ){
            var el = $( this.convertVariables( data[i], template ) );
            if( el.length > 0 ) el.appendTo( parentContainer).show();
            this.checkAutoForm( data[i], el );
        }
    }

    ,singleInterpreter : function( data, template, parentContainer, isEmptyView ){
        var el = $( this.convertVariables( data, template ) ); // 변수변환
        if( el.length && el.length > 0 ) {
            $(el).appendTo( parentContainer).show(); // add child
            this.checkAutoForm( data, el ); // binding
        }
        else if( isEmptyView ){
            el = $( this.convertVariables( {}, template ) ); // 변수제거
            $(el).appendTo( parentContainer ).show(); // add child
        }
    }

    ,checkAutoForm : function( o, el ){
        el.find('[binding]').each(function(){

            var key = $(this).attr( "binding" );
            var name;

            if( o[key] === 0 || o[key] ){
                if( this.type.indexOf( "text") > -1 ){
                    $(this).val( o[key] );
                }
                else if( this.type.indexOf( "radio") > -1 ){
                    name = $(this).attr( 'name' );
                    $(el).find("input[name="+name+"]:radio[value='"+o[key]+"']").attr('checked', 'checked');
                }
                else if( this.type.indexOf( "checkbox") > -1 ){
                    name = $(this).attr( 'name' );
                    $(el).find("input[name='"+name+"']:checkbox").each(function(){
                        if( o[key].indexOf( this.value ) > -1 ){
                            $(this).attr('checked', 'checked');
                        }else{
                            // 체크박스 체크상태 리무브
                            //                            $(this).attr('checked', false);
                        }
                    });
                }
                else if( this.type.indexOf( "select" ) > -1 ){
                    this.value = o[key];
                }
            }
        });
    }

    // remove
    ,removeVariables : function( template ){
        while( template.indexOf("{{") > -1 ){
            var currIdx =  template.indexOf("{{");
            var key = template.slice( currIdx + 2 , template.indexOf("}}") );
            template = template.replace( "{{"+key+"}}", "" );
        }
        return template;
    }

    // auto setting
    , convertVariables: function ( o, template ) {

        // data-wv-print 제거
        while( template.indexOf( "data-wv-print=") > -1 ){
            var currIdx =  template.indexOf("data-wv-print=");
            var lastIdx = template.indexOf("\"", currIdx + 15 )+1;
            var currentPrint = template.slice( currIdx , lastIdx );

            template = template.replace( currentPrint, template.slice( currIdx + 15, lastIdx - 1 ) );
        }


        if( o == null ) return;

        while( template.indexOf("{{") > -1 ){
            var currIdx =  template.indexOf("{{");
            var key = template.slice( currIdx + 2 , template.indexOf("}}") );
            var isRadio, compareValue, value;
            var tempKey = key;

            if( tempKey.indexOf( "::" ) > -1 ){
                tempKey = bm.string.trim( tempKey.slice( 0, tempKey.indexOf("::") ) );
            }

            if( tempKey.indexOf( "textarea:" ) == 0 ){
                // 텍스트 에어리어일 경우 <br/> 넣지 않음
                var tempKey2 = tempKey.slice( 9 , tempKey.length );
                value = this.getWvParseValue( tempKey2, o );
                template = template.replace( "{{"+key+"}}" , value ? value : "" );

            } else if( tempKey.indexOf( "src:" ) == 0 ){

                var tempKey2 = tempKey.slice( 4 , tempKey.length );
                var prefixStr = "", postfixStr="";
                if( tempKey2.indexOf( "+" ) > 0 ){
                    prefixStr = bm.string.trim( tempKey2.slice( 0, tempKey2.indexOf( "+" ) ) );
                    tempKey2 = bm.string.trim( tempKey2.slice( prefixStr.length+1, tempKey2.length ) );

                    if( tempKey2.indexOf("+") > 0 ){
                        postfixStr = bm.string.trim( tempKey2.slice( tempKey2.indexOf("+")+1, tempKey2.length ) );
                        tempKey2 = bm.string.trim( tempKey2.slice( 0, tempKey2.indexOf("+") ) );
                    }
                }

                value = this.getWvParseValue( tempKey2, o );
                template = template.replace( "{{"+key+"}}" , value ? "src='"+prefixStr+value+postfixStr+"'" : "" );

            } else if ( tempKey.indexOf( "-&gt;" ) > -1 || tempKey.indexOf( "->" ) > -1 ){
                // -> 는 속성의 키값 검색으로 처리.
                template = template.replace( "{{"+key+"}}" , this.getWvParseValue( key, o ) );

            } else {
                // 나머지..
                if( o[tempKey] ) {
                    if( Object.prototype.toString.call(o[tempKey]) === "[object String]" ){
//                        o[tempKey] = o[tempKey].replace(/\n|\r/g, "<br/>");
                        o[tempKey] = o[tempKey].replace(/(?:\r\n|\r|\n)/g, "<br/>"); //  개행 정규식 수정 150518
                    }
                }
                var _v = this.getWvParseValue( key, o );

                if( window.version != -1 && window.version <= 8 ){
                    var preTxt = template.slice( currIdx-6, currIdx );
                    if( preTxt == "value=" ){
                        _v = '"'+_v+'"';
                    }
                }
                template = template.replace( "{{"+key+"}}", o[tempKey] == undefined ? "" : _v );


            }
        }
        return template;
    }

    ,getWvParseValue : function( key, o ){

        var val, tempKey = key;


        if( key.indexOf( "::" ) > -1 ){
            // 다항 switch case 처리문
            var compareList, realValList, splitVal;
            key = bm.string.trim( tempKey.slice( 0, tempKey.indexOf("::") ) );
            val = bm.string.trim( tempKey.slice( tempKey.indexOf("::")+2, tempKey.length ) );
            splitVal = val.split("?");

            compareList = splitVal[0].split("|");
            realValList = splitVal[1].split("|");

            compareList = bm.string.trimList( compareList );
            realValList = bm.string.trimList( realValList );

            var len = compareList.length;
            while( len-- ){
                if( !isNaN(parseFloat( compareList[len] )) ){
                    compareList[len] = parseFloat(compareList[len]);
                }
            }

            var oVal;
            if( key.indexOf( "-&gt;" ) > -1 || key.indexOf( "->" ) > -1 ){
                // -> 로 키검색 처리.
                var keyList = key.indexOf( "-&gt;" ) > -1 ? key.split("-&gt;") : key.split("->");
                var len = keyList.length;
                oVal = o;
                for( var i=0; i<len; i++ ){
                    oVal = oVal[ bm.string.trim( keyList[i] ) ];
                    if( !oVal ) break;
                }
            }else{
                oVal = o[key];
            }

            val = realValList[ compareList.indexOf( oVal ) ];
            if( val == undefined && !isNaN(parseFloat( oVal )) ){
                val = realValList[ compareList.indexOf( parseFloat( oVal ) ) ];
            }
            if (val == undefined && compareList.indexOf( "~" ) > -1 ){ // 여전히 val 은 undefined 이고, ~ 아무거나 가 있으면
                val = realValList[ compareList.indexOf( "~" ) ];
            }
            if (val == undefined ){ // 만약 검색에 걸리는 값이 없으면
                val = oVal; // 원래 key 로 값을 찾아 반환
                if( val == undefined ) val = ""; // 그조차 없으면 빈값 반환
            }
        }else if( key.indexOf( "-&gt;" ) > -1 || key.indexOf( "->" ) > -1 ){
            // -> 로 키검색 처리.
            var keyList = key.indexOf( "-&gt;" ) > -1 ? key.split("-&gt;") : key.split("->");
            var len = keyList.length;
            val = o;
            for( var i=0; i<len; i++ ){
                val = val[ bm.string.trim( keyList[i] ) ];
                if( !val ) break;
            }
        }else{
            // 기타
            val = o[key];
        }

        return ( val == undefined || val == null ) ? "" : val;
    }



    ,getValueByFormElement : function( el, searchContainer ){
        var value, name;
        el = el.length && el.context ? el[0] : el;
        if( el.type.indexOf( "text") > -1 ){
            value = $(el).val();
        }else if( el.type.indexOf( "radio") > -1 ){
            name = $(el).attr('name');
            value = $( searchContainer ).find( "input[name='"+name+"']:checked").val();
        }else if( el.type.indexOf( "select") > -1 ){
            value = $(el).val();
        }else if( el.type.indexOf( "checkbox" ) > -1 ) {
            name = $(el).attr('name');
            if( $(el).is( ":checked" ) ){
                value = $(el).val();
            }else{
                // 기본값이 설정되어 있을 경우
                if( $(el).attr( "data-wv-default" ) !== undefined ){
                    value = $(el).attr( "data-wv-default" );
                }
            }
        }
        return value;
    }



    ,__blockSchema : null

    ,getBlockSchema : function(){

        if( this.__blockSchema == null ){
            this.__blockSchema = ( "center dir isindex noframes " +
            "address blockquote div dl fieldset form h1 h2 h3 h4 h5 h6 hr menu ol p pre table ul li dt dd" +
            "article aside details dialog figure header footer hgroup section nav" ).split(" ");
        }

        return this.__blockSchema;
    }

    ,__inlineSchema : null

    ,getInlineSchema : function(){
        if( this.__inlineSchema == null ){
            this.__inlineSchema = ( "a abbr b bdo br button cite code del dfn em embed i iframe img input ins kbd " +
            "label map noscript object q s samp script select small span strong sub sup textarea u var #text #comment " +
            "audio canvas command datalist mark meter output picture progress time wbr video ruby bdi keygen" ).split(" ");
        }

        return this.__inlineSchema;
    }

    ,isBlock : function( tagOrElement ){
        var tag;
        if( bm.type.isString( tagOrElement ) ) tag = tagOrElement;
        else tag = tagOrElement.nodeName;

        tag = tag.toLocaleLowerCase();
        var schema = this.getBlockSchema();
        if( schema.indexOf( tag ) == -1  ){
            return false;
        }else{
            return true;
        }
    }

    ,isInline : function( tagOrElement ){
        var tag;
        if( bm.type.isString( tagOrElement ) ) tag = tagOrElement;
        else tag = tagOrElement.nodeName;

        tag = tag.toLocaleLowerCase();
        var schema = this.getInlineSchema();
        if( schema.indexOf( tag ) == -1  ){
            return false;
        }else{
            return true;
        }
    }

    ,isElement : function( element ){
        if( element.nodeType !== 1 ){
            return false;
        }else{
            return true;
        }
    }

    ,isEmptyNode : function( node ){
        var t = node.nodeType;
        return (node.nodeType == 3 && $.trim( node.data ) == "") || t == 4 || t == 8 ; // Text, CDataSection or Comment
    }

    ,checkEmptyThenRemove : function( nodeOrElement ){
        var node = nodeOrElement.nodeType == 3 ? nodeOrElement : nodeOrElement.firstChild;
        if( this.isEmptyNode( node ) ) $(nodeOrElement).remove();
    }


    ,deleteData : function( node, startIndex, endIndex ){
        var childNode = node.nodeType == 3 ? this : node.firstChild;
        if( !childNode || !childNode.nodeValue ) return;

        var str = childNode.nodeValue;
        str = str.substr( 0, startIndex ) + str.substr( endIndex , str.length );
        childNode.nodeValue = str;
    }

    ,splitNodeAt : function (node, index) {
        var newNode = $(node).clone()[0];
        this.deleteData( newNode, 0, index );

        var childNode = node.nodeType == 3 ? this : node.firstChild;
        if( childNode && childNode.nodeValue ){
            this.deleteData( node, index, childNode.nodeValue.length );
        }

        $(node).after( newNode );

        return [node,newNode];
    }


    ,getParent : function( node ){
        if( node.parentNode ) return node.parentNode;
        else{
            return node.ownerDocument.activeElement;
        }
    }

    ,findParentUntilElement : function(node){
        return this.findParentUntil( "element", node );
    }

    ,findParentUntilInline: function(node){
        return this.findParentUntil( "inline", node );
    }

    ,findParentUntilBlock : function(node){
        return this.findParentUntil( "block", node );
    }


    /**
     * 최초의 type 요소가 나올때까지 parent 탐색
     * @param node
     * @returns {*}
     */
    ,findParentUntil : function( type, node ){

        var body = document.body;
        var currentNode = node;

        var compareFn;
        switch( type ){
            case "block" : compareFn = this.isBlock; break;
            case "inline" : compareFn = this.isInline; break;
            case "element" : compareFn = this.isElement; break;
        }

        while( compareFn.call( this, currentNode) == false ){
            currentNode = currentNode.parentNode;

            if( currentNode === body ) {
                currentNode = body;
                break;
            }
        }

        return currentNode;
    }

    /**
     * 태그 변경.
     * @param element
     * @param tagName
     * @param attributeCopy 속성 변경 , 기본값 true
     */
    ,replaceTag : function( element, tagName, attributeCopy ){

        if( attributeCopy === undefined ) attributeCopy = true;

        var to = bm.html( "<"+tagName+"></"+tagName+">" );
        $(element).contents().each( function(){
            to.append( this );
        });

        if( attributeCopy === undefined || attributeCopy ){
            this.copyAttribute( element, to );
        }

        $(element).before( to );
        $(element).remove();

        return to;
    }

    ,wrapOuter : function( element, tag ){
        var wrapper = $(tag).insertBefore( element );
        wrapper.prepend( element );
        return wrapper[0];
    }

    ,removeTagOnChild : function( element, tag ){
        var list = $(element).find(tag);

        list.each( function(){
            var children = this.children;
            var len = children.length;
            for( var i=0; i<len; i++ ){
                $(this).before( children[0] );
            }

            $(this).remove();
        })
    }

    ,removeTagOnParent : function( element, tag ){
        var el = $(element).closest(tag)[0];
        var children, len;
        if( el ){
            children = el.children;
            len = children.length;
            for( var i=0; i<len; i++ ){
                $(el).before( children[0] );
            }
        }

        $(el).remove();
    }

    ,copyAttribute : function( from, to ){

        $.each(from.attributes, function() {
            $(to).attr(this.name, this.value);
        } );
    }
}
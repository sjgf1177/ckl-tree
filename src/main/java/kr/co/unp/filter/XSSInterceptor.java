package kr.co.unp.filter;

import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.util.WebFactory;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class XSSInterceptor extends HandlerInterceptorAdapter {

@Resource(name = "webFactory")
private WebFactory webFactory;

private String accessIp;

 // 필터링 정책을 블랙리스트

 // XSS_Filter_Rules.txt
String[] pattern= {
       "<script>(.*?)</script>",
       //"src[\r\n]*=[\r\n]*\\\'(.*?)\\\'",
       //"src[\r\n]*=[\r\n]*\\\"(.*?)\\\"",
       "</script>",
       "<script(.*?)>",
       "eval\\((.*?)\\)",
       "expression\\((.*?)\\)",
       "javascript:",
       "vbscript:",
       "alert(.*?)=",
       "onabort(.*?)=",
       "onactivate(.*?)=",
       "onafterprint(.*?)=",
       "onafterupdate(.*?)=",
       "onbeforeactivate(.*?)=",
       "onbeforecopy(.*?)=",
       "onbeforecut(.*?)=",
       "onbeforedeactivate(.*?)=",
       "onbeforeeditfocus(.*?)=",
       "onbeforepaste(.*?)=",
       "onbeforeprint(.*?)=",
       "onbeforeunload(.*?)=",
       "onbeforeupdate(.*?)=",
       "onbegin(.*?)=",
       "onblur(.*?)=",
       "onbounce(.*?)=",
       "oncellchange(.*?)=",
       "onchange(.*?)=",
       "onchange(.*?)=",
       "onclick(.*?)=",
       "oncontentready(.*?)=",
       "oncontentsave(.*?)=",
       "oncontextmenu(.*?)=",
       "oncontrolselect(.*?)=",
       "oncopy(.*?)=",
       "oncut(.*?)=",
       "ondataavailable(.*?)=",
       "ondatasetchanged(.*?)=",
       "ondatasetcomplete(.*?)=",
       "ondatasetcomplete(.*?)=",
       "ondblclick(.*?)=",
       "ondeactivate(.*?)=",
       "ondetach(.*?)=",
       "ondocumentready(.*?)=",
       "ondrag(.*?)=",
       "ondragdrop(.*?)=",
       "ondragend(.*?)=",
       "ondragenter(.*?)=",
       "ondragleave(.*?)=",
       "ondragover(.*?)=",
       "ondragstart(.*?)=",
       "ondrop(.*?)=",
       "onend(.*?)=",
       "onerror(.*?)=",
       "onerror(.*?)=",
       "onerror(.*?)=",
       "onerror(.*?)=",
       "onerrorupdate(.*?)=",
       "onfilterchange(.*?)=",
       "onfinish(.*?)=",
       "onfocus(.*?)=",
       "onfocusin(.*?)=",
       "onfocusout(.*?)=",
       "onhelp(.*?)=",
       "onhide(.*?)=",
       "onkeydown(.*?)=",
       "onkeypress(.*?)=",
       "onkeyup(.*?)=",
       "onlayoutcomplete(.*?)=",
       "onload(.*?)=",
       "onload(.*?)=",
       "onlosecapture(.*?)=",
       "onmediacomplete(.*?)=",
       "onmediaerror(.*?)=",
       "onmedialoadfailed(.*?)=",
       "onmousedown(.*?)=",
       "onmouseenter(.*?)=",
       "onmouseleave(.*?)=",
       "onmousemove(.*?)=",
       "onmouseout(.*?)=",
       "onmouseover(.*?)=",
       "onmouseup(.*?)=",
       "onmousewheel(.*?)=",
       "onmove(.*?)=",
       "onmoveend(.*?)=",
       "onmovestart(.*?)=",
       "onopenstatechange(.*?)=",
       "onoutofsync(.*?)=",
       "onpaste(.*?)=",
       "onpause(.*?)=",
       "onplaystatechange(.*?)=",
       "onpropertychange(.*?)=",
       "onreadystatechange(.*?)=",
       "onrepeat(.*?)=",
       "onreset(.*?)=",
       "onreset(.*?)=",
       "onresize(.*?)=",
       "onresizeend(.*?)=",
       "onresizestart(.*?)=",
       "onresume(.*?)=",
       "onreverse(.*?)=",
       "onrowclick(.*?)=",
       "onrowenter(.*?)=",
       "onrowexit(.*?)=",
       "onrowout(.*?)=",
       "onrowover(.*?)=",
       "onrowsdelete(.*?)=",
       "onrowsinserted(.*?)=",
       "onsave(.*?)=",
       "onscroll(.*?)=",
       "onseek(.*?)=",
       "onselect(.*?)=",
       "onselectionchange(.*?)=",
       "onselectstart(.*?)=",
       "onshow(.*?)=",
       "onstart(.*?)=",
       "onstop(.*?)=",
       "onsubmit(.*?)=",
       "onsyncrestored(.*?)=",
       "ontimeerror(.*?)=",
       "ontrackchange(.*?)=",
       "onunload(.*?)=",
       "onurlflip(.*?)=",
       "/\\w*((\\%27)|(\\'))((\\%6F)|o|(\\%4F))((\\%72)|r|(\\%52))/ix", //1'or'1'='1 패턴
       "/((\\%27)|(\'))union/ix", //UNION 키워드를 SQL 주입을 검출 * 정규식
       "insert|update|delete|having|drop|(\'|%27).(and|or).(\'|%27)|(\'|%27).%7C{0,2}|%7C{2}"  //이중 파이프 (||)와 접속사 따옴표 따옴표의 조합
  };




@Override
public boolean preHandle(HttpServletRequest request,
   HttpServletResponse response, Object handler) throws Exception {

  if ( request instanceof MultipartHttpServletRequest) {
      // ParameterMap  을 사용하는것이 더 권장사항임.
      Enumeration<String> names=request.getParameterNames();
      while ( names.hasMoreElements()) {
         String a=names.nextElement();
            String value=request.getParameter(a);
               if ( ! isValidInput(value)) {
	             //response.sendRedirect("/common/detect.jsp");
            	 webFactory.printHtmlBack(response, "잘못된 접근입니다.");
	             return false;
	           }
      }
  }
     return true;
 }


private boolean isValidInput(String value) {
    if (value != null) {
        value = value.replaceAll("", "");
        for ( String ptn : pattern ) {
              Pattern scriptPattern = Pattern.compile(ptn,
                                            Pattern.CASE_INSENSITIVE);
              if ( scriptPattern.matcher(value).find() ) return false;
        }
        return true;
    } else {
     return false;
    }
}
}



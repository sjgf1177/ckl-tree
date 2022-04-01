package kr.co.unp.util;

public class StringCnt {
    private int cnt;
    private String src = "";
    
    
    public StringCnt(String src) {
        super();
        this.src = src;
    }
    public int stringCnt(String s) {
        return stringCnt(s, 0);
    }
    public int stringCnt(String s, int pos){ //pos는 찾기 시작하는 위치
        int idx = 0; //존재위치
        if (s == null || s.length() == 0) {
            return  0;
        }
        if ((idx = src.indexOf(s, pos))!=-1) {
            // src
            cnt++;
            stringCnt(s, idx +s.length());
            // 하나를 찾으면 다음을 찾기 시작하는 위치를 pos=0 에서
            // idx 다음부터 문자열 길이까지로 수정해서 계속 찾아라.
            // 실제로 이 stringCnt(s, idx+s.length());를 생략하면
            //1개밖에 찾지 않고 스톱된다.
        }return cnt;
    }
    public static void main(String[] args) {
        String str = "100-hansanghun,118-heunggie,135-hilys,111-test";
        System.out.println(str);
        StringCnt sc = new StringCnt(str);
        System.out.println(",를"+sc.stringCnt(",")+"개 찾았습니다.");
    }
    
}

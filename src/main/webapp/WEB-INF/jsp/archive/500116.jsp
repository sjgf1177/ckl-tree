<%@page contentType="text/html;charset=utf-8" %>

<style>
    /* 준비중 이미지 pc */
    .img-soon {width: 100%;height: auto;padding-bottom: 20px;}
    .img-soon-m {width: 100%;height: auto;padding-bottom: 20px;display: none;}

    /* 준비중 이미지 모바일 */
    @media (max-width: 992px){
        .img-soon {display: none;}
        .img-soon-m {display: block;}
    }
</style>

<body>
    <!-- content_sub_wrap 찾아서 붙여넣기 -->
    <div id="content_sub_wrap" class="col-12 sub_contents_wrap">
        <div class="col-12 col-center mw-1200 over-visible">
            <div class="col-12 pr15 pl15">
                <div class="col-12 col-md-0 fn-md over-hidden" style="padding-bottom: 50px;">
                    <img class="img-soon" src="/archive/images/img_soon.jpg" alt="홈페이지 준비중입니다." /><!-- pc -->
                    <img class="img-soon-m" src="/archive/images/img_soon_m.jpg" alt="홈페이지 준비중입니다." /><!-- 모바일 -->
                </div>
            </div>
        </div>
    </div>
</body>



<!-- 
<style>
.edu_youtube_subtitle_view_btn_con{text-align: right; margin-bottom: 40px;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn{font-size:14px; font-size:1.4rem; line-height:20px; line-height:2.0rem; color:#fff; display:inline-block; border-radius:1px; cursor: pointer;
    text-align: left; padding-right:41px; padding-left:12px; padding-top:9px; padding-bottom:8px; background-image:url('/edu/images/bm/edu_yotubue_subtitle_view.png'); background-repeat: no-repeat; background-position: right 12px center; background-color: #1da28d; box-sizing: border-box;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_default{display:inline-block;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_active{display:none;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_close_btn{display:none; float:right; width:17px; height:17px; background-image: url('/edu/images/bm/edu_yotubue_subtitle_close.png');}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn{overflow:hidden; display:block; width:100%; padding-left:25px; background-image:none; padding-right:25px;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_default{display:none;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_active{display:inline-block;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_close_btn{display:inline-block; }
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_text{font-size: 14.5px; font-size: 1.45rem; line-height: 26px; line-height: 2.6rem; color: #999999; letter-spacing: -0.025em;
    padding-top:20px; padding-left:25px; padding-right:25px; padding-bottom:20px; border:2px solid #5ac9b7; text-align: left; display:none; max-height:300px; overflow-y: auto;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_text{display:block;}
</style> 
-->
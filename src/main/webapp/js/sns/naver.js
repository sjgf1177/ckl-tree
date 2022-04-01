
var naver = null;


(function($) {

	$.sNaver = {
		image_url : null,
		photo_id : null,
		me_uid : null,
		me_name : null,
		nb_redirect_uri : null,
		appId : null,
		secret : null,
		redirect_uri : null,


		initialize : function(settings) {

			var obj = this;
			settings = jQuery.extend(true, {
				clickBtn : 'naverBtn',
				appId : '',
				secret :  '',
				redirect_uri : 'http://edu.kocca..dev.kr/edu/sns_test_login.jsp',
				image_url : '',
				me_photo_target : '#profile_photo',
				me_name_target : '#profile_name',
				me_id_target : '#naverBlogSnsId',
				me_naver_login_target : '#naverBlogLoginImg',
				me_image_url : '#me_image_url',
				me_sns_name : '#snsName',
				authResponse : false,
				fnData : function() {}

			}, settings);

			this.appId = settings.appId;
			this.secret = settings.secret;
			this.redirect_uri = settings.redirect_uri;
			this.image_url = settings.image_url;
			this.me_photo_target = settings.me_photo_target;
			this.me_name_target = settings.me_name_target;
			this.me_id_target = settings.me_id_target;
			this.me_naver_login_target = settings.me_naver_login_target;
			this.me_image_url = settings.me_image_url;
			this.me_sns_name = settings.me_sns_name;
			this.authResponse = settings.authResponse;

			naver = NaverAuthorize({
				client_id : settings.appId,
				client_secret : settings.secret,
				redirect_uri : settings.redirect_uri
			});

			$("#" + settings.clickBtn).click(function() {
				//obj.loginPop(settings.appId, settings.redirect_uri);
				obj.login();
				return false;
			});

			//obj.checkLoginState(settings.fnData);
		},

		generateState : function() {
			// CSRF 방지를 위한 state token 생성 코드
			// state token은 추후 검증을 위해 세션에 저장 되어야 합니다.
			var oDate = new Date();
			return oDate.getTime();
		},

		saveState : function(state) {
			$.removeCookie("state_token");
			$.cookie("state_token", state);
		},

		checkLoginState : function(fnData) {
			var obj = this;
			var tokenInfo = { access_token:"" , refresh_token:"" };

			var state = $.cookie("state_token");
			if(naver.checkAuthorizeState(state) === "connected") {
				//정상적으로 Callback정보가 전달되었을 경우 Access Token발급 요청 수행
				naver.getAccessToken(function(data) {
					var response = data._response.responseJSON;
					if(response.error === "fail") {
						//access token 생성 요청이 실패하였을 경우에 대한 처리
					    return ;
					}
					tokenInfo.access_token = response.access_token;
					tokenInfo.refresh_token = response.refresh_token;

					$.cookie("naver_access_token",tokenInfo.access_token);
					fnData(response.access_token);
					//obj.me_profile(fnData);
				});
			}
		},

		login : function() {
			var obj = this;
			var state = obj.generateState();
			obj.saveState(state);
			naver.login(state);
		},

		//로그인 팝업띄우기
		loginPop : function(nv_client_id,nv_redirect_uri) {
			var obj = this;
			var state = obj.generateState();
			obj.saveState(state);
			url = "https://nid.naver.com/oauth2.0/authorize?client_id="+nv_client_id+"&response_type=code&redirect_uri="+nv_redirect_uri+"&state="+ state;
			window.open(url, "winNaverPop", "width=500, height=500, scrollbars=no");
		},

		me_profile : function(fnData) {

			var obj = this;


			var access_token = $.cookie("naver_access_token");
			var URL = "https://apis.naver.com/nidlogin/nid/getUserProfile.json?response_type=json";

			if(access_token != null || access_token != undefined){

				naver.api(URL, access_token, function(data) {

    			    var userInfo = data._response.responseJSON;

    			    console.log("success to get user info", userInfo);

    			    if (userInfo.resultcode == "00") {

    					//jQuery(obj.me_photo_target).attr("src", userInfo.response.profile_image);
    					//jQuery(obj.me_image_url).val(userInfo.response.profile_image);
    					//jQuery(obj.me_name_target).text(userInfo.response.nickname);
    					//jQuery(obj.me_sns_name).val("naverBlog");
    					//alert("id : " + userInfo.response.id);
    					//alert("email : " + userInfo.response.email);

    					fnData(userInfo.response.id, userInfo.response.nickname, userInfo.response.email);

						//var loginTargetImg = jQuery(obj.me_naverBlog_login_target).attr("src");
						//loginTargetImg = loginTargetImg.replace('naver_blog.png', 'naver_blog_on.png');
						//jQuery(obj.me_naverBlog_login_target).attr("src", loginTargetImg);
    				}
    				else {
    					//jQuery(obj.me_photo_target).attr("src", '');
    					//jQuery(obj.me_name_target).empty();
    					//alert("twitter정보 가져오기가 실패했습니다.");
    					return false;
    				}


    			    //userInfo.resultcode : 응답 결과 코드
    			    //userInfo.message : 응답 결과 메시지
    			    //userInfo.response : API조회 결과
    			    //userInfo.response.email (이메일)
    			    //userInfo.response.nickname (닉네임)


    			    // API응답결과 처리
    			});

			}

		}

	};

})(jQuery);

(function($) {

	$.sTistory = {
		image_url : null,
		photo_id : null,
		me_uid : null,
		me_name : null,


		initialize : function(settings) {

			obj = this;
			settings = jQuery.extend(true, {
				image_url : '',
				me_photo_target : '#profile_photo',
				me_name_target : '#profile_name',
				me_id_target : '#tiStorySnsId',
				me_tistory_login_target : '#tistoryLoginImg',
				me_image_url : '#me_image_url',
				me_sns_name : '#snsName',
				authResponse : false

			}, settings);

			this.image_url = settings.image_url;
			this.me_photo_target = settings.me_photo_target;
			this.me_name_target = settings.me_name_target;
			this.me_id_target = settings.me_id_target;
			this.me_tistory_login_target = settings.me_tistory_login_target;
			this.me_image_url = settings.me_image_url;
			this.me_sns_name = settings.me_sns_name;
			this.authResponse = settings.authResponse;

			this.me_profile();
		},



		me_profile : function() {


			var obj = this;

			if (obj.authResponse == true) {
				jQuery.post("/ckl/sns/tiStory/profile.json",{},function(data) {


					if (data.resultCode == "success") {

						$.each(data.tiStory.item, function(key, val) {

							jQuery(obj.me_photo_target).attr("src", val.profileThumbnailImageUrl);
							jQuery(obj.me_image_url).val(val.profileThumbnailImageUrl);


							jQuery(obj.me_id_target).val(val.url);

						});


						//jQuery(obj.me_name_target).text(data.name);
						jQuery(obj.me_sns_name).val("tiStory");


						if (jQuery("#gubun") && jQuery("#gubun").val() != "H") {
							jQuery("#gubun").val("S");
						};


						var loginTargetImg = jQuery(obj.me_tistory_login_target).attr("src");
						loginTargetImg = loginTargetImg.replace('tistory.png', 'tistory_on.png');

						jQuery(obj.me_tistory_login_target).attr("src", loginTargetImg);
					}
					else {
						//jQuery(obj.me_photo_target).attr("src", '');
						//jQuery(obj.me_name_target).empty();
						//alert("twitter정보 가져오기가 실패했습니다.");
						return false;
					}
				},"json");
			}
			else {
				alert("fail");
			}

		},

		login : function() {
			//window.open("https://www.tistory.com/oauth/authorize?client_id=f3055f5940e7a22aac48eb4e2548ad32&redirect_uri=http://pms.ccbrain.co.kr:9999/ckl/sns/tiStory/callbackUrl.do&response_type=code", "tistoryPop",'width=600, height=400');
			window.open("/ckl/sns/tiStory/token.do", "tistoryPop",'width=600, height=400');
		},


		post_feed : function(tiStorySnsId, target, shortUrl) {

			var text = jQuery(target).val();
			var text_count = new String(text);
			if (text_count.length == 0) {
				alert("내용을 입력하세요.");
				jQuery(target).focus();
				return;
			}

			text = shortUrl +"\n"+ text;

			if (text.length > 140) {
				text = text.substring(0,130)+ "...";
			}
			var params = {
				message : text,
				id : jQuery(tiStorySnsId).val()
			};

			$.post("/ckl/sns/tiStory/snsPost.do",params, function(data) {
				if (data.resultCode == "success") {

				}
				else {
					alert("twitter 글쓰기가 실패했습니다.");
				}
			},"json");
			return false;
		}
	};

})(jQuery);







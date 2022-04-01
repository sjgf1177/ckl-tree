
(function($) {

	$.sGooglePlus = {
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
				me_id_target : '#googlePlusSnsId',
				me_googlePlus_login_target : '#googlePlusLoginImg',
				me_image_url : '#me_image_url',
				me_sns_name : '#snsName',
				authResponse : false

			}, settings);

			this.image_url = settings.image_url;
			this.me_photo_target = settings.me_photo_target;
			this.me_name_target = settings.me_name_target;
			this.me_id_target = settings.me_id_target;
			this.me_googlePlus_login_target = settings.me_googlePlus_login_target;
			this.me_image_url = settings.me_image_url;
			this.me_sns_name = settings.me_sns_name;
			this.authResponse = settings.authResponse;



			//this.render();


		},

		me_profile : function() {

			alert("11");
			var obj = this;

			if (obj.authResponse == true) {


				jQuery.post("/ckl/sns/googlePlus/profile.json",{},function(data) {

					if (data.resultCode == "success") {
						jQuery(obj.me_photo_target).attr("src", data.image);
						jQuery(obj.me_image_url).val(data.image);
						//jQuery(obj.me_name_target).text(data.name);
						jQuery(obj.me_sns_name).val(data.name);
						jQuery(obj.me_id_target).val(data.id);

						if (jQuery("#gubun") && jQuery("#gubun").val() != "H") {
							jQuery("#gubun").val("T");
						};

						var loginTargetImg = jQuery(
								obj.me_twt_login_target).attr("src");
						loginTargetImg = loginTargetImg.replace(
								'google_plus.png', 'google_plus_on.png');

						jQuery(obj.me_twt_login_target).attr("src", loginTargetImg);
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
			window.open("/ckl/sns/googlePlus/token.do","googlePlusPop",'width=600, height=400');
		},

		logout : function() {
			$.post("/ckl/sns/googlePlus/logout.do",{}, function(data) {
				if (data.resultCode == "success") {
					alert("googlePlus계정이 로그아웃 되었습니다.");
					window.location.reload();
				}
			},"json");
		},

		post_feed : function(target, shortUrl) {
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
				message : text
			};

			$.post("/ckl/sns/googlePlus/snsPost.do",params, function(data) {
				if (data.resultCode == "success") {

				}
				else {
					alert("googlePlus 글쓰기가 실패했습니다.");
				}
			},"json");
			return false;
		}
	};

})(jQuery);
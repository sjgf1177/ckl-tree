
(function($) {

	$.sLinkedIn = {
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
				me_id_target : '#linkedInSnsId',
				me_linkedIn_login_target : '#linkedInLoginImg',
				me_image_url : '#me_image_url',
				me_sns_name : '#snsName'

			}, settings);

			this.image_url = settings.image_url;
			this.me_photo_target = settings.me_photo_target;
			this.me_name_target = settings.me_name_target;
			this.me_id_target = settings.me_id_target;
			this.me_linkedIn_login_target = settings.me_linkedIn_login_target;
			this.me_image_url = settings.me_image_url;
			this.me_sns_name = settings.me_sns_name;

			onLinkedInLoad();
		},


		login : function() {


			if(IN.User.isAuthorized() == false){

				 IN.User.authorize(getLinkedInProfile);
			 }
			 else{
				 getLinkedInProfile();
			 }

		},

		logout : function() {

			IN.User.logout(function(){

				alert("로그아웃 되었습니다.");

				window.location.reload();
			});
		},

		// 원글작성용
		post_feed : function(title, target, URL, shortUrl) {

			var subject = jQuery(title).val();
			var text = jQuery(target).val();
			var text_count = new String(text);
			if (text_count.length == 0) {
				alert("내용을 입력하세요.");
				jQuery(target).focus();
				return;
			}


			IN.API.Raw("/people/~/shares").method("POST").body( JSON.stringify( {
				"content": {
					"title": subject ,
					//"description": snsTitle,
					"submitted-url": URL
					//"submitted-image-url": "https://media.licdn.com/mpr/mpr/shrink_100_100/AAEAAQAAAAAAAAKJAAAAJDk4ZWVlNWFjLTQ2ZmEtNDFjYy04MDllLWU3MWE0YTUwZjc5YQ.jpg"
				},
				"visibility": {
					"code": "anyone"
				},
				"comment": text
			})
			).result(function(data) {

				$.cookie("linkedIn_id", data.updateKey);

	    		alert("글 등록이 완료되었습니다.");

			}).error(function(error) {
				console.log(error);
				alert(error.message);

			});

		},

		// 댓글작성용
		comment_feed : function(target, shortUrl) {

			var text = jQuery(target).val();
			var text_count = new String(text);
			if (text_count.length == 0) {
				alert("내용을 입력하세요.");
				jQuery(target).focus();
				return;
			}


			var snsTitle = "";
			if ($(".snsTitle")) snsTitle = $(".snsTitle").text();
			else snsTitle = document.title;

			IN.API.Raw("/people/~/shares").method("POST").body( JSON.stringify( {
				"content": {
					"title": snsTitle ,
					"submitted-url": document.URL
					//"submitted-image-url": "https://media.licdn.com/mpr/mpr/shrink_100_100/AAEAAQAAAAAAAAKJAAAAJDk4ZWVlNWFjLTQ2ZmEtNDFjYy04MDllLWU3MWE0YTUwZjc5YQ.jpg"
				},
				"visibility": {
					"code": "anyone"
				},
				"comment": text
			})
			).result(function(data) {

				$.cookie("linkedIn_id", data.updateKey);

				//alert("등록 되었습니다.");

			}).error(function(error) {
				console.log(error);
				alert(error.message);

			});

		},



		delete_feed: function() {

			alert($.cookie("linkedIn_id"));
		}

	};

})(jQuery);

	function onLinkedInLoad() {

	    IN.Event.on(IN, "auth", getLinkedInProfile);
	}

	// Handle the successful return from the API call
	function me_profile(data) {

		var obj = $.sLinkedIn;

		jQuery(obj.me_photo_target).attr("src", data.pictureUrl);
		jQuery(obj.me_image_url).val(data.pictureUrl);
		//jQuery(obj.me_name_target).text(obj.me_name);
		//jQuery(obj.me_sns_name).val(user.name);
		jQuery(obj.me_id_target).val(data.id);

		if (jQuery("#gubun") && jQuery("#gubun").val() != "H") {
			jQuery("#gubun").val("L");
		};


		var loginTargetImg = jQuery(
				obj.me_linkedIn_login_target).attr("src");
		loginTargetImg = loginTargetImg.replace(
				'linkedIn.png', 'linkedIn_on.png');

		jQuery(obj.me_linkedIn_login_target).attr("src", loginTargetImg);

		jQuery(obj.me_sns_name).val("linkedIn");

	}

	// Handle an error response from the API call
	function onError(error) {
	    alert(error);
	}

	// Use the API call wrapper to request the member's basic profile data
	function getLinkedInProfile() {

	    IN.API.Raw("/people/~:(id,firstName,lastName,num-connections,picture-url)?format=json").result(me_profile).error(onError);
	}




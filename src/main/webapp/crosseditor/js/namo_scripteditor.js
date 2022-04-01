var agentInfo = (function() {
/*	var uat = navigator.userAgent.toLowerCase();
	return {
		IsIE :
		 @cc_on!@ false,
		IsIE6 :
		 @cc_on!@ false && (parseInt(uat.match(/msie (\d+)/)[1], 10) >= 6),
		IsIE7 :
		 @cc_on!@ false && (parseInt(uat.match(/msie (\d+)/)[1], 10) >= 7),
		IsIE8 :
		 @cc_on!@ false && (parseInt(uat.match(/msie (\d+)/)[1], 10) >= 8),
		IsIE9 :
		 @cc_on!@ false && (parseInt(uat.match(/msie (\d+)/)[1], 10) >= 9),
		IsIE10 :
		 @cc_on!@ false && (parseInt(uat.match(/msie (\d+)/)[1], 10) >= 10),
		IsGecko : /gecko\//.test(uat),
		IsOpera : !!window.opera,
		IsSafari : /applewebkit\//.test(uat) && !/chrome\//.test(uat),
		IsChrome : /applewebkit\//.test(uat) && /chrome\//.test(uat),
		pe_Nf : /applewebkit\//.test(uat) && /chrome\//.test(uat)
				&& /edge\//.test(uat),
		IsMac : /macintosh/.test(uat),
		IsIOS5 : /(ipad|iphone)/.test(uat)
				&& uat.match(/applewebkit\/(\d*)/)[1] >= 534
				&& uat.match(/applewebkit\/(\d*)/)[1] < 536,
		IsIOS6 : /(ipad|iphone)/.test(uat)
				&& uat.match(/applewebkit\/(\d*)/)[1] >= 536
	};*/
	var uat=navigator.userAgent.toLowerCase();
	var re=new RegExp("\x74\x72\x69\x64\x65\x6e\x74\x2f\x2e\x2a\x72\x76\x3a\x28\x5b\x30\x2d\x39\x5d\x7b\x31\x2c\x7d\x5b\.\x30\x2d\x39\x5d\x7b\x30\x2c\x7d\x29");
	if(re.exec(uat)!=null)
		var rv=parseFloat(RegExp.$1);
		return{
			IsIE:/* @cc_on!@ */false,
			IsIE6:/* @cc_on!@ */false&&(parseInt(uat.match(/msie (\d+)/)[1],10)>=6),
			IsIE7:/* @cc_on!@ */false&&(parseInt(uat.match(/msie (\d+)/)[1],10)>=7),
			IsIE8:/* @cc_on!@ */false&&(parseInt(uat.match(/msie (\d+)/)[1],10)>=8),
			IsIE9:/* @cc_on!@ */false&&(parseInt(uat.match(/msie (\d+)/)[1],10)>=9),
			IsIE10:/* @cc_on!@ */false&&(parseInt(uat.match(/msie (\d+)/)[1],10)>=10),
			IsIE11:(!uat.match(/msie (\d+)/)&&((uat.indexOf('\x74\x72\x69\x64\x65\x6e\x74')>0)&&(parseInt(uat.match(/trident\/(\d+)/)[1],10)>=7)))||rv==11,
			IsGecko:/gecko\//.test(uat),
			IsOpera: ! !window.opera,
			IsSafari:/applewebkit\//.test(uat)&& !/chrome\//.test(uat),
			IsChrome:/applewebkit\//.test(uat)&&/chrome\//.test(uat),
			pe_Nf:/applewebkit\//.test(uat)&&/chrome\//.test(uat)&&/edge\//.test(uat),
			IsMac:/macintosh/.test(uat),
			IsIOS5:/(ipad|iphone)/.test(uat)&&uat.match(/applewebkit\/(\d*)/)[1]>=534&&uat.match(/applewebkit\/(\d*)/)[1]<536,
			IsIOS6:/(ipad|iphone)/.test(uat)&&uat.match(/applewebkit\/(\d*)/)[1]>=536
		};
})();
var NamoSE = function(pe_ahj) {
	this.editorName = pe_ahj;
	this.params = {};
	this.pe_rB = null;
	this.pe_aqX = null;
	this.pe_KG = "\x6b\x72", this.ceEngine = null;
	this.pe_kv = false;
	this.pe_oK ="";
	this.toolbar = null, this.ceIfrEditor = null, this.pe_ahq = true,
			this.pe_Tm = {
				'\x73\x43\x6f\x64\x65' : [ '\x6b\x6f', '\x65\x6e', '\x6a\x61',
						'\x7a\x68\x2d\x63\x6e', '\x7a\x68\x2d\x74\x77' ],
				'\x6c\x43\x6f\x64\x65' : [ '\x6b\x6f\x72', '\x65\x6e\x75',
						'\x6a\x70\x6e', '\x63\x68\x73', '\x63\x68\x74' ]
			}, this.pe_auI = [], this.pe_auP();
};
var NamoCrossEditorAjaxCacheControlSetup = true;
NamoSE.prototype = {
	pe_auP : function() {
		var pe_mg = null;
		var pe_hD = document.getElementsByTagName("\x68\x65\x61\x64")[0]
				.getElementsByTagName("\x73\x63\x72\x69\x70\x74");
		var pe_sg = "\x6a\x73\x2f\x6e\x61\x6d\x6f\x5f\x73\x63\x72\x69\x70\x74\x65\x64\x69\x74\x6f\x72\x2e\x6a\x73";
		for (i = 0; i < pe_hD.length; i++) {
			if (pe_hD[i].src.indexOf(pe_sg) != -1) {
				pe_mg = pe_hD[i].src.substring(0, pe_hD[i].src.indexOf(pe_sg));
				break;
			}
		}
		if (!pe_mg) {
			pe_hD = document.getElementsByTagName("\x62\x6f\x64\x79")[0]
					.getElementsByTagName("\x73\x63\x72\x69\x70\x74");
			for (i = 0; i < pe_hD.length; i++) {
				if (pe_hD[i].src.indexOf(pe_sg) != -1) {
					pe_mg = pe_hD[i].src.substring(0, pe_hD[i].src
							.indexOf(pe_sg));
					break;
				}
			}
		}
		if (pe_mg) {
			var pe_sE = pe_bh(pe_mg);
			if (pe_sE) {
				if (pe_sE.substring(pe_sE.length - 1) != "\x2f")
					pe_sE = pe_sE + "\x2f";
			}
			pe_mg = pe_sE
		}
		this.pe_rB = pe_mg;
		this.pe_aqX = document.location.protocol + '\x2f\x2f'
				+ document.location.host;
		this.pe_oK = "\x43\x61\x6e\x27\x74\x20\x72\x75\x6e\x20\x41\x50\x49\x20\x75\x6e\x74\x69\x6c\x20\x4e\x61\x6d\x6f\x20\x43\x72\x6f\x73\x73\x45\x64\x69\x74\x6f\x72\x20\x73\x74\x61\x72\x74\x73\x2e";
		var pe_alm = document.getElementById(this.editorName);
		if (pe_alm)
			pe_alm.style.display = "\x6e\x6f\x6e\x65";
	},
	pe_yB : function(idoc) {
		var d = (!idoc) ? document : idoc;
		var head = d.getElementsByTagName("\x68\x65\x61\x64")[0];
		if (head) {
			var pe_jd = head.getElementsByTagName("\x6c\x69\x6e\x6b");
			var pe_yI = false;
			for (var i = 0; i < pe_jd.length; i++) {
				if (pe_jd[i].id == "\x4e\x61\x6d\x6f\x53\x45\x50\x6c\x75\x67\x69\x6e\x44\x72\x61\x67\x43\x53\x53")
					pe_yI = true;
			}
			if (pe_yI)
				return;
			var pe_gR = d.createElement('\x4c\x49\x4e\x4b');
			pe_gR.type = "\x74\x65\x78\x74\x2f\x63\x73\x73";
			pe_gR.rel = "\x73\x74\x79\x6c\x65\x73\x68\x65\x65\x74";
			pe_gR.id = "\x4e\x61\x6d\x6f\x53\x45\x50\x6c\x75\x67\x69\x6e\x44\x72\x61\x67\x43\x53\x53";
			if (this.params.Webtree) {
				pe_gR.href = this.pe_rB
						+ '\x63\x73\x73\x2f\x6e\x61\x6d\x6f\x73\x65\x5f\x70\x6c\x75\x67\x69\x6e\x64\x72\x61\x67\x5f\x77\x65\x62\x74\x72\x65\x65\x2e\x63\x73\x73';
			} else {
				pe_gR.href = this.pe_rB
						+ '\x63\x73\x73\x2f\x6e\x61\x6d\x6f\x73\x65\x5f\x70\x6c\x75\x67\x69\x6e\x64\x72\x61\x67\x2e\x63\x73\x73';
			}
			head.appendChild(pe_gR);
		}
	},
	pe_amA : function() {
		var pe_mE = this.pe_KG;
		if (this.params.UserLang && this.params.UserLang != "") {
			pe_RZ = this.params.UserLang.toLowerCase();
			if (pe_RZ == "\x61\x75\x74\x6f") {
				var pe_aHv = "\x65\x6e";
				var pe_Ym = pe_aV("\x6b\x6f");
				if (this.pe_DH(this.pe_Tm.sCode, pe_Ym.pe_Mf)) {
					pe_mE = pe_Ym.pe_Mf;
				} else if (this.pe_DH(this.pe_Tm.sCode, pe_Ym.pe_LZ)) {
					pe_mE = pe_Ym.pe_LZ;
				} else {
					pe_mE = pe_aHv;
				}
			} else {
				pe_mE = pe_RZ;
				var pe_ajX = this.pe_aFc(this.pe_Tm.lCode, pe_mE);
				if (pe_ajX == -1) {
					pe_mE = this.pe_KG;
				} else {
					pe_mE = this.pe_Tm.sCode[pe_ajX];
				}
			}
			if (pe_mE == "\x6b\x6f")
				pe_mE = "\x6b\x72";
			if (pe_mE != this.pe_KG) {
				if (this.params.ParentEditor) {
					var idoc = this.params.ParentEditor.ownerDocument;
					var pe_hD = idoc.createElement("\x73\x63\x72\x69\x70\x74");
					pe_hD.id = "\x4e\x61\x6d\x6f\x53\x45\x5f\x49\x66\x72\x5f\x5f\x54\x65\x6d\x70\x4c\x61\x6e\x43\x6f\x64\x65";
					pe_hD.name = pe_RZ;
					pe_hD.setAttribute("\x70\x65\x5f\x76\x79", pe_mE);
					pe_hD
							.setAttribute("\x74\x79\x70\x65",
									"\x74\x65\x78\x74\x2f\x6a\x61\x76\x61\x73\x63\x72\x69\x70\x74");
					pe_hD.setAttribute("\x73\x72\x63", this.pe_rB
							+ '\x6a\x73\x2f\x6c\x61\x6e\x67\x2f' + pe_mE
							+ '\x2e\x6a\x73');
					idoc.body.appendChild(pe_hD);
				} else {
					document
							.write('<\x73\x63\x72'
									+ '\x69\x70\x74\x20\x69\x64\x3d\x22\x4e\x61\x6d\x6f\x53\x45\x5f\x49\x66\x72\x5f\x5f\x54\x65\x6d\x70\x4c\x61\x6e\x43\x6f\x64\x65\x22\x20\x6e\x61\x6d\x65\x3d'
									+ pe_RZ
									+ '\x20\x70\x65\x5f\x76\x79\x3d'
									+ pe_mE
									+ '\x20\x74\x79\x70\x65\x3d\x22\x74\x65\x78\x74\x2f\x6a\x61\x76\x61\x73\x63\x72\x69\x70\x74\x22\x20\x73\x72\x63\x3d\x22'
									+ this.pe_rB
									+ '\x6a\x73\x2f\x6c\x61\x6e\x67\x2f'
									+ pe_mE
									+ '\x2e\x6a\x73\x22\x3e\x3c\x2f\x73\x63\x72'
									+ '\x69\x70\x74\x3e');
				}
			}
		}
		this.pe_KG = pe_mE;
	},
	ShowEditor : function(bshow) {
		var t = this;
		if (t.ceEngine.pe_ei) {
			t.ceEngine.pe_ei.style.display = (bshow == true) ? ""
					: "\x6e\x6f\x6e\x65";
		}
	},
	GetEditor : function() {
		var t = this;
		return t.ceEngine.pe_ei;
	},
	pe_aAX : function() {
		var t = this;
		var pe_Gu = "\x4e\x61\x6d\x6f\x53\x45\x5f\x49\x66\x72\x5f\x5f"
				+ this.editorName;
		var pe_TO = "\x4e\x61\x6d\x6f\x53\x45\x5f\x49\x66\x72\x5f\x50\x6c\x75\x67\x69\x6e\x5f\x5f"
				+ this.editorName;
		var pe_Uh = "\x4e\x61\x6d\x6f\x53\x45\x5f\x49\x66\x72\x5f\x53\x75\x62\x50\x6c\x75\x67\x69\x6e\x5f\x5f"
				+ this.editorName;
		var pe_Uf = "\x4e\x61\x6d\x6f\x53\x45\x5f\x49\x66\x72\x5f\x53\x74\x65\x70\x50\x6c\x75\x67\x69\x6e\x5f\x5f"
				+ this.editorName;
		var pe_ans = this.pe_rB
				+ "\x63\x6f\x6e\x66\x69\x67\x2f\x68\x74\x6d\x6c\x73\x2f\x63\x72\x6f\x73\x73\x65\x64\x69\x74\x6f\x72\x2e\x68\x74\x6d\x6c";
		var pe_aao = this.pe_rB
				+ "\x63\x6f\x6e\x66\x69\x67\x2f\x68\x74\x6d\x6c\x73\x2f\x62\x6c\x61\x6e\x6b\x2e\x68\x74\x6d\x6c";
		var pe_Uc = pe_aao;
		var pe_Hc = null;
		var pe_KC = null;
		var pe_Kh = null;
		var pe_KB = null;
		if (t.params.ParentEditor) {
			var pe_zf = t.params.ParentEditor;
			var pe_axA = (t.params.ShowFrame == false) ? "\x6e\x6f\x6e\x65"
					: "";
			t.ceIfrEditor = pe_Hc = t.pe_Vz(pe_zf, pe_Gu, pe_ans,
					"\x36\x30\x30\x70\x78", "\x33\x30\x30\x70\x78", 20000,
					pe_axA);
			if (t.params.IsSpliteToolbar && t.params.SpliteToolbarEle) {
				pe_zf = t.params.SpliteToolbarEle.ownerDocument.body;
			}
			if (t.params.TargetPluginFrame) {
				pe_zf = t.params.TargetPluginFrame.ownerDocument.body;
			}
			pe_zf = pe_zf.ownerDocument.body;
			pe_KC = t.pe_Vz(pe_zf, pe_TO, pe_aao, "\x31\x70\x78",
					"\x31\x70\x78", 20001, "\x6e\x6f\x6e\x65",
					"\x61\x62\x73\x6f\x6c\x75\x74\x65");
			pe_Kh = t.pe_Vz(pe_zf, pe_Uf, pe_Uc, "\x31\x70\x78",
					"\x31\x70\x78", 20002, "\x6e\x6f\x6e\x65",
					"\x61\x62\x73\x6f\x6c\x75\x74\x65");
			pe_KB = t.pe_Vz(pe_zf, pe_Uh, pe_Uc, "\x31\x70\x78",
					"\x31\x70\x78", 20003, "\x6e\x6f\x6e\x65",
					"\x61\x62\x73\x6f\x6c\x75\x74\x65");
			this.pe_amA();
		} else {
			document
					.write("\x3c\x69\x66\x72\x61\x6d\x65\x20\x69\x64\x3d\x27"
							+ pe_Gu
							+ "\x27\x20\x74\x69\x74\x6c\x65\x3d\x27"
							+ pe_Gu
							+ "\x27\x20\x73\x72\x63\x3d\x27\x27\x20\x66\x72\x61\x6d\x65\x62\x6f\x72\x64\x65\x72\x3d\x27\x30\x27\x20\x73\x63\x72\x6f\x6c\x6c\x69\x6e\x67\x3d\x27\x6e\x6f\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x62\x6f\x72\x64\x65\x72\x3a\x20\x30\x70\x74\x20\x6e\x6f\x6e\x65\x20\x3b\x20\x6d\x61\x72\x67\x69\x6e\x3a\x20\x30\x70\x74\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x20\x30\x70\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x20\x74\x72\x61\x6e\x73\x70\x61\x72\x65\x6e\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x69\x6d\x61\x67\x65\x3a\x20\x6e\x6f\x6e\x65\x3b\x20\x77\x69\x64\x74\x68\x3a\x20\x36\x30\x30\x70\x78\x3b\x20\x68\x65\x69\x67\x68\x74\x3a\x20\x33\x30\x30\x70\x78\x3b\x20\x7a\x2d\x69\x6e\x64\x65\x78\x3a\x32\x30\x30\x30\x30\x3b\x27\x3e\x3c\x2f\x69\x66\x72\x61\x6d\x65\x3e");
			document
					.write("\x3c\x69\x66\x72\x61\x6d\x65\x20\x69\x64\x3d\x27"
							+ pe_TO
							+ "\x27\x20\x74\x69\x74\x6c\x65\x3d\x27"
							+ pe_TO
							+ "\x27\x20\x73\x72\x63\x3d\x27\x27\x20\x66\x72\x61\x6d\x65\x62\x6f\x72\x64\x65\x72\x3d\x27\x30\x27\x20\x73\x63\x72\x6f\x6c\x6c\x69\x6e\x67\x3d\x27\x6e\x6f\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x62\x6f\x72\x64\x65\x72\x3a\x20\x30\x70\x74\x20\x6e\x6f\x6e\x65\x20\x3b\x20\x6d\x61\x72\x67\x69\x6e\x3a\x20\x30\x70\x74\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x20\x30\x70\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x20\x74\x72\x61\x6e\x73\x70\x61\x72\x65\x6e\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x69\x6d\x61\x67\x65\x3a\x20\x6e\x6f\x6e\x65\x3b\x20\x77\x69\x64\x74\x68\x3a\x20\x31\x70\x78\x3b\x20\x68\x65\x69\x67\x68\x74\x3a\x20\x31\x70\x78\x3b\x20\x64\x69\x73\x70\x6c\x61\x79\x3a\x6e\x6f\x6e\x65\x3b\x20\x7a\x2d\x69\x6e\x64\x65\x78\x3a\x32\x30\x30\x30\x31\x3b\x20\x70\x6f\x73\x69\x74\x69\x6f\x6e\x3a\x61\x62\x73\x6f\x6c\x75\x74\x65\x3b\x27\x3e\x3c\x2f\x69\x66\x72\x61\x6d\x65\x3e");
			document
					.write("\x3c\x69\x66\x72\x61\x6d\x65\x20\x69\x64\x3d\x27"
							+ pe_Uf
							+ "\x27\x20\x74\x69\x74\x6c\x65\x3d\x27"
							+ pe_Uf
							+ "\x27\x20\x73\x72\x63\x3d\x27\x27\x20\x66\x72\x61\x6d\x65\x62\x6f\x72\x64\x65\x72\x3d\x27\x30\x27\x20\x73\x63\x72\x6f\x6c\x6c\x69\x6e\x67\x3d\x27\x6e\x6f\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x62\x6f\x72\x64\x65\x72\x3a\x20\x30\x70\x74\x20\x6e\x6f\x6e\x65\x20\x3b\x20\x6d\x61\x72\x67\x69\x6e\x3a\x20\x30\x70\x74\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x20\x30\x70\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x20\x74\x72\x61\x6e\x73\x70\x61\x72\x65\x6e\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x69\x6d\x61\x67\x65\x3a\x20\x6e\x6f\x6e\x65\x3b\x20\x77\x69\x64\x74\x68\x3a\x20\x31\x70\x78\x3b\x20\x68\x65\x69\x67\x68\x74\x3a\x20\x31\x70\x78\x3b\x20\x64\x69\x73\x70\x6c\x61\x79\x3a\x6e\x6f\x6e\x65\x3b\x20\x7a\x2d\x69\x6e\x64\x65\x78\x3a\x32\x30\x30\x30\x32\x3b\x20\x70\x6f\x73\x69\x74\x69\x6f\x6e\x3a\x61\x62\x73\x6f\x6c\x75\x74\x65\x3b\x27\x3e\x3c\x2f\x69\x66\x72\x61\x6d\x65\x3e");
			document
					.write("\x3c\x69\x66\x72\x61\x6d\x65\x20\x69\x64\x3d\x27"
							+ pe_Uh
							+ "\x27\x20\x74\x69\x74\x6c\x65\x3d\x27"
							+ pe_Uh
							+ "\x27\x20\x73\x72\x63\x3d\x27\x27\x20\x66\x72\x61\x6d\x65\x62\x6f\x72\x64\x65\x72\x3d\x27\x30\x27\x20\x73\x63\x72\x6f\x6c\x6c\x69\x6e\x67\x3d\x27\x6e\x6f\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x62\x6f\x72\x64\x65\x72\x3a\x20\x30\x70\x74\x20\x6e\x6f\x6e\x65\x20\x3b\x20\x6d\x61\x72\x67\x69\x6e\x3a\x20\x30\x70\x74\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x20\x30\x70\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x20\x74\x72\x61\x6e\x73\x70\x61\x72\x65\x6e\x74\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x69\x6d\x61\x67\x65\x3a\x20\x6e\x6f\x6e\x65\x3b\x20\x77\x69\x64\x74\x68\x3a\x20\x31\x70\x78\x3b\x20\x68\x65\x69\x67\x68\x74\x3a\x20\x31\x70\x78\x3b\x20\x64\x69\x73\x70\x6c\x61\x79\x3a\x6e\x6f\x6e\x65\x3b\x20\x7a\x2d\x69\x6e\x64\x65\x78\x3a\x32\x30\x30\x30\x33\x3b\x20\x70\x6f\x73\x69\x74\x69\x6f\x6e\x3a\x61\x62\x73\x6f\x6c\x75\x74\x65\x3b\x27\x3e\x3c\x2f\x69\x66\x72\x61\x6d\x65\x3e");
			this.pe_amA();
			pe_Hc = t.ceIfrEditor = document.getElementById(pe_Gu);
			pe_KC = document.getElementById(pe_TO);
			pe_Kh = document.getElementById(pe_Uh);
			pe_KB = document.getElementById(pe_Uf);
			if (document.body.lastChild) {
				document.body.insertBefore(pe_KC, document.body.lastChild);
				document.body.insertBefore(pe_KB, document.body.lastChild);
				document.body.insertBefore(pe_Kh, document.body.lastChild);
			}
			pe_Hc.src = pe_ans;
			pe_KC.src = pe_aao;
			pe_Kh.src = pe_Uc;
			pe_KB.src = pe_Uc;
		}
		var pe_bJ = function(elm, pe_kb, fn) {
			if (elm.addEventListener) {
				elm.addEventListener(pe_kb, fn, false);
			} else if (elm.attachEvent) {
				elm.attachEvent('\x6f\x6e' + pe_kb, fn);
			} else {
				elm['\x6f\x6e' + pe_kb] = fn;
			}
		};
		pe_bJ(
				pe_Hc,
				"\x6c\x6f\x61\x64",
				function() {
					t.ceEngine = new pe_Hc.contentWindow.NamoSE(t.editorName,
							t.pe_rB, t.pe_aqX, t.params.Webtree,
							t.params.WebsourcePath, t.params.ConfigXmlURL);
					t.pe_kv = true;
					if (t.params.IsSpliteToolbar && t.params.SpliteToolbarEle) {
						var idoc = t.params.SpliteToolbarEle.ownerDocument;
						t.ceEngine.pe_yB(idoc);
					}
					var pe_PD = t.params;
					for ( var key in pe_PD) {
						if (String(pe_PD[key]) != ""
								&& typeof (pe_PD[key]) != "\x66\x75\x6e\x63\x74\x69\x6f\x6e") {
							if (key == "\x41\x64\x64\x4d\x65\x6e\x75") {
								var pe_mQ = pe_PD[key].split("\x7c");
								for (var i = 0; i < pe_mQ.length; i++) {
									if (pe_mQ[i] && pe_mQ[i] != "") {
										var pe_RY = pe_mQ[i].replace(
												/(^\s*)|(\s*$)/g, '');
										if (!t.ceEngine.params[key]) {
											t.ceEngine.params[key] = [ pe_RY ];
										} else {
											var pe_aug = false;
											var pe_adC = pe_RY.split("\x2c");
											for (var j = 0; j < t.ceEngine.params[key].length; j++) {
												var pe_mZ = t.ceEngine.params[key][j]
														.split("\x2c");
												if (pe_mZ[0]
														&& pe_mZ[0]
																.replace(
																		/(^\s*)|(\s*$)/g,
																		'') == pe_adC[0]
																.replace(
																		/(^\s*)|(\s*$)/g,
																		'')) {
													pe_aug = true;
													t.ceEngine.params[key][j] = pe_RY;
													break;
												}
											}
											if (!pe_aug)
												t.ceEngine.params[key]
														.push(pe_RY);
										}
									}
								}
							} else {
								t.ceEngine.params[key] = pe_PD[key];
							}
						}
					}
					t.ceEngine.pe_ahu = t;
					t.ceEngine.pe_ei = pe_Hc;
					t.ceEngine.pe_cl = pe_KC;
					t.ceEngine.pe_gQ = pe_KB;
					t.ceEngine.pe_fY = pe_Kh;
					t.ceEngine.pe_vK = t.pe_auI;
					t.ceEngine.editorStart();
					t.params = t.ceEngine.params;
					t.toolbar = t.ceEngine.pe_eR;
					if (t.params.UnloadWarning) {
						window.onbeforeunload = function(e) {
							if (t.ceEngine.IsDirty() && t.pe_ahq) {
								return t.ceEngine.pe_awB;
							}
						}
					} else {
						window.onbeforeunload = null;
					}
				});
	},
	EditorStart : function() {
		this.editorStart();
	},
	editorStart : function() {
		if (typeof this.params.EditorBaseURL != "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64") {
			var pe_Ck = this.params.EditorBaseURL;
			if (!(pe_Ck.substr(0, 7) == "\x68\x74\x74\x70\x3a\x2f\x2f" || pe_Ck
					.substr(0, 8) == "\x68\x74\x74\x70\x73\x3a\x2f\x2f")) {
				alert("\x46\x6f\x72\x20\x74\x68\x65\x20\x62\x61\x73\x65\x20\x55\x52\x4c\x2c\x20\x79\x6f\x75\x20\x6d\x75\x73\x74\x20\x65\x6e\x74\x65\x72\x20\x74\x68\x65\x20\x66\x75\x6c\x6c\x20\x55\x52\x4c\x20\x70\x61\x74\x68\x20\x69\x6e\x63\x6c\x75\x64\x69\x6e\x67\x20\x74\x68\x65\x20\x68\x6f\x73\x74\x20\x69\x6e\x66\x6f\x72\x6d\x61\x74\x69\x6f\x6e\x2e");
				return;
			}
			if (pe_Ck.substring(pe_Ck.length - 1) != "\x2f")
				pe_Ck = pe_Ck + "\x2f";
			this.pe_rB = pe_Ck;
		}
		if (!this.pe_rB) {
			alert("\x43\x72\x6f\x73\x73\x45\x64\x69\x74\x6f\x72\x20\x69\x73\x20\x46\x61\x69\x6c\x21\x28\x75\x6e\x64\x65\x66\x69\x6e\x65\x64\x20\x70\x61\x74\x68\x29");
			return;
		}
		if (typeof this.params.AjaxCacheSetup != "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64") {
			if (this.params.AjaxCacheSetup === false)
				NamoCrossEditorAjaxCacheControlSetup = false;
		}
		for ( var key in this) {
			if (key != "")
				this.pe_auI.push(key);
		}
		this.pe_yB();
		this.pe_aAX();
	},
	GetEditorDocument : function(pe_aEZ) {
		var t = this;
		try {
			if (pe_aEZ == "\x64\x6f\x63") {
				return t.ceEngine.getDocument();
			} else {
				return t.ceEngine.getDocument().body;
			}
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x56\x61\x6c\x75\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	GetValue : function(pe_iF) {
		var t = this;
		try {
			return t.ceEngine.GetValue(pe_iF);
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x56\x61\x6c\x75\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	GetValueLength : function() {
		var t = this;
		try {
			return t.ceEngine.GetValueLength();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x56\x61\x6c\x75\x65\x4c\x65\x6e\x67\x74\x68\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	GetBodyValueLength : function() {
		var t = this;
		try {
			return t.ceEngine.GetBodyValueLength();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x42\x6f\x64\x79\x56\x61\x6c\x75\x65\x4c\x65\x6e\x67\x74\x68\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	SetValue : function(source) {
		var t = this;
		try {
			if (agentInfo.IsIE && t.params.UserDomain
					&& t.params.UserDomain != "") {
				setTimeout(function() {
					t.ceEngine.SetValue(source);
				}, 150);
			} else {
				t.ceEngine.SetValue(source);
			}
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetValue(source)
			}, 500);
		}
	},
	SetMimeValue : function(source) {
		var t = this;
		try {
			t.ceEngine.SetMimeValue(source);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetMimeValue(source)
			}, 500);
		}
	},
	GetBodyValue : function(pe_iF) {
		var t = this;
		try {
			return t.ceEngine.GetBodyValue(pe_iF);
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x42\x6f\x64\x79\x56\x61\x6c\x75\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	SetBodyValue : function(source) {
		var t = this;
		try {
			if (agentInfo.IsIE && t.params.UserDomain
					&& t.params.UserDomain != "") {
				setTimeout(function() {
					t.ceEngine.SetBodyValue(source)
				}, 150);
			} else {
				t.ceEngine.SetBodyValue(source);
			}
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetBodyValue(source)
			}, 500);
		}
	},
	GetHeadValue : function() {
		var t = this;
		try {
			return t.ceEngine.GetHeadValue();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x48\x65\x61\x64\x56\x61\x6c\x75\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	SetHeadValue : function(source) {
		var t = this;
		try {
			if (agentInfo.IsIE && t.params.UserDomain
					&& t.params.UserDomain != "") {
				setTimeout(function() {
					t.ceEngine.SetHeadValue(source)
				}, 150);
			} else {
				t.ceEngine.SetHeadValue(source);
			}
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetHeadValue(source)
			}, 500);
		}
	},
	IsDirty : function() {
		var t = this;
		try {
			return t.ceEngine.IsDirty();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x49\x73\x44\x69\x72\x74\x79\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	SetDirty : function() {
		var t = this;
		try {
			t.ceEngine.SetDirty();
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetDirty()
			}, 500);
		}
	},
	ShowTab : function(pe_vz) {
		var t = this;
		try {
			t.ceEngine.ShowTab(pe_vz);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.ShowTab(pe_vz)
			}, 500);
		}
	},
	ShowToolbar : function(index, flag) {
		var t = this;
		try {
			t.ceEngine.ShowToolbar(index, flag);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.ShowToolbar(index, flag)
			}, 500);
		}
	},
	InsertImage : function(src, title) {
		var t = this;
		try {
			t.ceEngine.InsertImage(src, title);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.InsertImage(src, title)
			}, 500);
		}
	},
	InsertHyperlink : function(str, src, target) {
		var t = this;
		try {
			t.ceEngine.InsertHyperlink(str, src, target);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.InsertHyperlink(str, src)
			}, 500);
		}
	},
	InsertValue : function(position, source) {
		var t = this;
		try {
			t.ceEngine.InsertValue(position, source);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.InsertValue(position, source)
			}, 500);
		}
	},
	SetCharSet : function(enc) {
		var t = this;
		try {
			t.ceEngine.SetCharSet(enc);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetCharSet(enc)
			}, 500);
		}
	},
	SetBodyStyle : function(pe_is, pe_dw) {
		var t = this;
		try {
			t.ceEngine.SetBodyStyle(pe_is, pe_dw);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetBodyStyle(pe_is, pe_dw)
			}, 500);
		}
	},
	GetTextValue : function() {
		var t = this;
		try {
			return t.ceEngine.GetTextValue();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x54\x65\x78\x74\x56\x61\x6c\x75\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	GetDocumentSize : function() {
		var t = this;
		try {
			return t.ceEngine.GetDocumentSize();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x44\x6f\x63\x75\x6d\x65\x6e\x74\x53\x69\x7a\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	GetBodyElementsByTagName : function(pe_wY) {
		var t = this;
		try {
			return t.ceEngine.GetBodyElementsByTagName(pe_wY);
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x42\x6f\x64\x79\x45\x6c\x65\x6d\x65\x6e\x74\x73\x42\x79\x54\x61\x67\x4e\x61\x6d\x65\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	SetUISize : function(pe_iZ, pe_jp) {
		var t = this;
		try {
			t.ceEngine.SetUISize(pe_iZ, pe_jp);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetUISize(pe_iZ, pe_jp)
			}, 400);
		}
	},
	GetActiveTab : function() {
		var t = this;
		try {
			return t.ceEngine.GetActiveTab();
		} catch (e) {
			alert(t.pe_oK
					+ "\x20\x28\x47\x65\x74\x41\x63\x74\x69\x76\x65\x54\x61\x62\x20\x4d\x65\x74\x68\x6f\x64\x29");
		}
	},
	SetActiveTab : function(pe_sw) {
		var t = this;
		try {
			t.ceEngine.SetActiveTab(pe_sw);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetActiveTab(pe_sw)
			}, 500);
		}
	},
	SetFocusOut : function(type) {
		var t = this;
		try {
			t.ceEngine.SetFocusOut(type);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetFocusOut(type)
			}, 500);
		}
	},
	SetFocusEditor : function(pe_AA) {
		var t = this;
		try {
			t.ceEngine.SetFocusEditor(pe_AA);
		} catch (e) {
			if (t.pe_kv)
				return;
			setTimeout(function() {
				t.SetFocusEditor(pe_AA)
			}, 500);
		}
	},
	doCommand : function(cmd, ele, arg) {
		var t = this;
		if (t.ceEngine.pe_hj != '\x77\x79\x73\x69\x77\x79\x67') {
			return;
		}
		if (cmd.toLowerCase() == '\x68\x65\x6c\x70') {
			window.open(t.ceEngine.config.pe_apA, '\x5f\x62\x6c\x61\x6e\x6b');
			return;
		}
		var pe_aCh = [ '\x66\x6f\x6e\x74\x6e\x61\x6d\x65',
				'\x66\x6f\x6e\x74\x73\x69\x7a\x65',
				'\x6c\x69\x6e\x65\x68\x65\x69\x67\x68\x74',
				'\x74\x65\x6d\x70\x6c\x61\x74\x65',
				'\x66\x6f\x72\x6d\x61\x74\x62\x6c\x6f\x63\x6b' ];
		var t = this;
		var btn = null;
		if (ele) {
			btn = ele;
		}
		if (t.ceEngine) {
			t.ceEngine.pe_aBQ();
			if (this
					.pe_DH(
							[
									'\x69\x6d\x61\x67\x65',
									'\x69\x6e\x73\x65\x72\x74\x66\x69\x6c\x65',
									'\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x69\x6d\x61\x67\x65',
									'\x66\x6c\x61\x73\x68' ], cmd)
					|| this.pe_DH(t.ceEngine.config.pe_Gi, cmd)
					|| this.pe_DH(t.ceEngine.config.pe_Db, cmd)
					|| this.pe_DH(t.ceEngine.config.pe_Ot, cmd)) {
				if (agentInfo.IsIE
						&& (cmd.toLowerCase() == '\x70\x61\x73\x74\x65' || cmd
								.toLowerCase() == '\x6f\x6e\x70\x61\x73\x74\x65')) {
					cmd = '\x70\x61\x73\x74\x65';
					t.ceEngine.pe_dT(cmd, arg);
				} else {
					if (cmd.toLowerCase() == '\x70\x61\x73\x74\x65'
							|| cmd.toLowerCase() == '\x6f\x6e\x70\x61\x73\x74\x65') {
						cmd = '\x6f\x6e\x70\x61\x73\x74\x65';
					}
					t.ceEngine.pe_akN(cmd, ele);
				}
			} else {
				if (this.pe_DH(pe_aCh, cmd) && arg) {
					t.ceEngine.pe_dT(cmd, arg);
				} else {
					t.ceEngine.pe_akQ(cmd, ele);
				}
			}
			t.ceEngine.pe_hv = cmd;
		}
	},
	destroyEditor : function() {
		var t = this;
		var e = null;
		var pe_Lk = document.createElement("\x69\x6e\x70\x75\x74");
		pe_Lk.setAttribute("\x74\x79\x70\x65", "\x69\x6e\x70\x75\x74");
		document.body.appendChild(pe_Lk);
		pe_Lk.focus();
		pe_Lk.parentNode.removeChild(pe_Lk);
		if (t.ceEngine.pe_ei) {
			e = t.ceEngine.pe_ei.parentElement;
			if (!(agentInfo.IsIE6 && !agentInfo.IsIE9)) {
				t.ceEngine.pe_ei.innerHTML = '';
			}
			if (e) {
				e.removeChild(t.ceEngine.pe_ei);
			}
		}
		if (t.ceEngine.pe_cl) {
			e = t.ceEngine.pe_cl.parentElement;
			if (!(agentInfo.IsIE6 && !agentInfo.IsIE9)) {
				t.ceEngine.pe_cl.innerHTML = '';
			}
			if (e) {
				e.removeChild(t.ceEngine.pe_cl);
			}
		}
		if (t.ceEngine.pe_gQ) {
			e = t.ceEngine.pe_gQ.parentElement;
			if (!(agentInfo.IsIE6 && !agentInfo.IsIE9)) {
				t.ceEngine.pe_gQ.innerHTML = '';
			}
			if (e) {
				e.removeChild(t.ceEngine.pe_gQ);
			}
		}
		if (t.ceEngine.pe_fY) {
			e = t.ceEngine.pe_fY.parentElement;
			if (!(agentInfo.IsIE6 && !agentInfo.IsIE9)) {
				t.ceEngine.pe_fY.innerHTML = '';
			}
			if (e) {
				e.removeChild(t.ceEngine.pe_fY);
			}
		}
		t.params = {};
		t.pe_KG = "\x6b\x72";
		try {
			var funx = t.ceEngine.onMouseClosePlugin;
			t.ceEngine.util.pe_GV(t.ceEngine.pe_hn(),
					'\x6d\x6f\x75\x73\x65\x64\x6f\x77\x6e', funx);
			t.ceEngine.util.pe_GV(document,
					'\x6d\x6f\x75\x73\x65\x64\x6f\x77\x6e', funx);
		} catch (e) {
		}
	},
	pe_Vz : function(pe_abM, pe_aAm, pe_aAn, pe_ayR, pe_aAl, pe_ayT, pe_aqT,
			pe_aqK) {
		var iframe = null;
		if (pe_abM) {
			var idoc = pe_abM.ownerDocument;
			if (idoc) {
				iframe = idoc.createElement("\x49\x46\x52\x41\x4d\x45");
				iframe.id = pe_aAm;
				iframe.frameBorder = "\x30";
				iframe.scrolling = "\x6e\x6f";
				iframe.style.border = "\x30\x70\x74\x20\x6e\x6f\x6e\x65";
				iframe.style.margin = "\x30\x70\x74";
				iframe.style.padding = "\x30\x70\x74";
				iframe.style.backgroundColor = "\x74\x72\x61\x6e\x73\x70\x61\x72\x65\x6e\x74";
				iframe.style.backgroundImage = "\x6e\x6f\x6e\x65";
				iframe.style.width = pe_ayR;
				iframe.style.height = pe_aAl;
				iframe.style.zIndex = pe_ayT;
				iframe.title = "\x6e\x61\x6d\x6f\x5f\x66\x72\x61\x6d\x65";
				if (pe_aqK) {
					iframe.style.position = pe_aqK;
				}
				if (pe_aqT) {
					iframe.style.display = pe_aqT;
				}
				pe_abM.appendChild(iframe);
				iframe.src = pe_aAn;
			}
		}
		return iframe;
	},
	pe_aJR : function() {
		return this.editorName;
	},
	pe_DH : function(pe_KX, val) {
		var i;
		for (i = 0; i < pe_KX.length; i++) {
			if (pe_KX[i] === val) {
				return true;
			}
		}
		return false;
	},
	pe_aFc : function(pe_KX, val) {
		var i;
		for (i = 0; i < pe_KX.length; i++) {
			if (pe_KX[i] === val) {
				return i;
			}
		}
		return -1;
	}
};
function pe_av() {
	var pe_aHz = (document.location.protocol != '\x66\x69\x6c\x65\x3a') ? document.location.host
			: ((agentInfo.IsOpera) ? "\x6c\x6f\x63\x61\x6c\x68\x6f\x73\x74"
					: "");
	var pe_anx = (document.location.protocol != '\x66\x69\x6c\x65\x3a') ? document.location.pathname
			: decodeURIComponent(document.location.pathname);
	var pe_aHg = document.location.protocol + '\x2f\x2f' + pe_aHz
			+ pe_anx.substring(0, pe_anx.lastIndexOf('\x2f') + 1);
	return pe_aHg;
};
function pe_bh(path) {
	var pe_Uz = "";
	var pe_Lr = pe_av();
	var bURL = (document.location.protocol != '\x66\x69\x6c\x65\x3a') ? path
			: decodeURIComponent(path);
	if (bURL.substring(0, 1) == "\x2e") {
		bURL = bURL.replace(/\/\//g, '\x2f');
		if (bURL.substring(0, 2) == "\x2e\x2f") {
			pe_Uz = pe_Lr + bURL.substring(2);
		} else {
			var pe_ajN = "";
			var pe_jS = pe_Lr;
			if (pe_jS.substring(pe_jS.length - 1) == "\x2f")
				pe_jS = pe_jS.substring(0, pe_jS.length - 1);
			var sp = bURL.split('\x2e\x2e\x2f');
			var pe_anu = sp.length;
			for (var i = 0; i < pe_anu; i++) {
				if (sp[i] == "" && i != pe_anu - 1) {
					pe_jS = pe_jS.substring(0, pe_jS.lastIndexOf('\x2f'));
				} else {
					pe_ajN = sp[i];
					break;
				}
			}
			pe_Uz = pe_jS + "\x2f" + pe_ajN;
		}
	} else {
		pe_Lr = document.location.protocol + '\x2f\x2f'
				+ document.location.host;
		var pe_acG = bURL.toLowerCase();
		if (pe_acG.substr(0, 7) == "\x68\x74\x74\x70\x3a\x2f\x2f"
				|| pe_acG.substr(0, 8) == "\x68\x74\x74\x70\x73\x3a\x2f\x2f") {
			var pe_akc = (bURL.substr(0, 8) == "\x68\x74\x74\x70\x73\x3a\x2f\x2f") ? bURL
					.substr(8)
					: bURL.substr(7);
			bURL = pe_Lr + pe_akc.substring(pe_akc.indexOf("\x2f"));
		} else if (pe_acG.substr(0, 5) == "\x66\x69\x6c\x65\x3a") {
			if (agentInfo.IsOpera) {
				bURL = "\x66\x69\x6c\x65\x3a\x2f\x2f"
						+ ((bURL.substr(7).substring(0, 9) == "\x6c\x6f\x63\x61\x6c\x68\x6f\x73\x74") ? bURL
								.substr(7).replace(/\/\//g, '\x2f')
								: "\x6c\x6f\x63\x61\x6c\x68\x6f\x73\x74"
										+ bURL.substr(5).replace(/\/\//g,
												'\x2f'));
			} else {
				bURL = bURL.substr(0, 7)
						+ bURL.substr(7).replace(/\/\//g, '\x2f');
			}
		} else {
			if (bURL.substring(0, 1) == "\x2f")
				bURL = pe_Lr + bURL.replace(/\/\//g, '\x2f');
			else {
				if (bURL == "")
					bURL = pe_av();
				else
					bURL = null;
			}
		}
		pe_Uz = bURL;
	}
	return pe_Uz;
};
function pe_aV(pe_Ol) {
	var pe_on = "";
	var pe_ty = "";
	if (navigator.userLanguage) {
		pe_on = navigator.userLanguage.toLowerCase();
	} else if (navigator.language) {
		pe_on = navigator.language.toLowerCase();
	} else {
		pe_on = pe_Ol;
	}
	if (pe_on.length >= 2)
		pe_ty = pe_on.substring(0, 2);
	if (pe_ty == "")
		pe_ty = pe_Ol;
	return {
		'\x70\x65\x5f\x4d\x66' : pe_ty,
		'\x70\x65\x5f\x4c\x5a' : pe_on
	};
}
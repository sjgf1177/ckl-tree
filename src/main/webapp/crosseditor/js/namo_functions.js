var pe_awh = {
	_oThis : null,
	pe_tw : null,
	pe_alb : null,
	pe_Pz : 0,
	pe_akR : 0,
	pe_Ir : 0,
	pe_Iu : 0,
	pe_ayx : function(pe_ca, pe_eN) {
		var pe_aoP = null;
		var pe_aoS = null;
		var pe_QI = null;
		if (this._oThis.config.pe_rD.InArray(pe_ca.tagName.toLowerCase())
				|| (agentInfo.IsOpera && pe_ca.tagName.toLowerCase() == "\x70")) {
			if (this.pe_tw.nodeType == 3) {
				if (pe_eN) {
					var pe_ft = this._oThis.getDocument().createElement("\x50");
					var pe_ry = this._oThis.getDocument().createElement("\x50");
					var pe_agB = null;
					pe_QI = false;
					if (pe_eN == this.pe_tw) {
						if (pe_eN.nodeType == 3) {
							if (this.pe_Pz < pe_eN.nodeValue.length)
								pe_QI = true;
						}
					} else {
						pe_QI = true;
					}
					if (pe_QI) {
						(pe_ca.tagName.toLowerCase() == "\x62\x6f\x64\x79") ? pe_agB = pe_eN
								: pe_agB = pe_ca.firstChild;
						this.pe_asb(pe_agB, pe_ft, pe_ry);
						if (this.pe_Ir == this.pe_Iu
								&& this._oThis.util.pe_Wt(pe_ry, true) == null) {
							if (pe_ry.firstChild) {
								var pe_jO = this._oThis.util.pe_qz(pe_ry,
										'\x6c\x61\x73\x74', 1);
								if (pe_jO
										&& pe_jO.nodeType == 1
										&& pe_jO.tagName.toLowerCase() == "\x61") {
									pe_jO.parentNode.removeChild(pe_jO);
									pe_jO = this._oThis.util.pe_qz(pe_ry,
											'\x6c\x61\x73\x74', 1);
								}
								if (pe_jO
										&& pe_jO.nodeType == 1
										&& this._oThis.config.pe_pp
												.InArray(pe_jO.tagName
														.toLowerCase())) {
									this.pe_Br(pe_jO);
								}
							} else {
								pe_ry.innerHTML = "";
							}
						}
					} else {
						pe_ft.appendChild(this.pe_tw.cloneNode(false));
					}
					pe_aoP = pe_ft;
					pe_aoS = pe_ry;
				}
			}
		}
		return {
			'\x70\x65\x5f\x43\x79' : pe_aoP,
			'\x70\x65\x5f\x43\x7a' : pe_aoS,
			'\x70\x65\x5f\x61\x47\x49' : pe_QI
		};
	},
	pe_asb : function(pe_aBr, pe_aFJ, pe_HD) {
		function pe_at(pe_cY, pe_RI) {
			if (pe_cY.length > 0) {
				for (var i = 0; i < pe_cY.length; i++) {
					var pe_hT = null;
					el = pe_cY[i];
					t.pe_Ir++;
					pe_hT = el.cloneNode(false);
					if (agentInfo.IsOpera) {
						if (pe_hT && pe_hT.nodeType == 3
								&& pe_hT.nodeValue == "" && el
								&& el.nodeType == 3 && el.nodeValue != "") {
							pe_hT = t._oThis.getDocument().createTextNode(
									el.nodeValue);
						}
					}
					if (el == t.pe_tw) {
						if (t.pe_Iu == 0)
							t.pe_Iu = t.pe_Ir;
						else
							t.pe_Ir = t.pe_Iu;
						if (el.nodeType == 3) {
							pe_RI
									.appendChild(t._oThis.getDocument()
											.createTextNode(
													el.nodeValue.substring(0,
															t.pe_Pz)));
							if (pe_qL == null)
								pe_qL = pe_HD;
							pe_qL.appendChild(t._oThis.getDocument()
									.createTextNode(
											el.nodeValue.substring(t.pe_Pz)));
							if (!el.nextSibling) {
								if (!(pe_qL && t._oThis.util
										.pe_up(pe_HD, pe_qL))) {
									pe_qL = pe_HD;
								}
							}
						}
					} else {
						if (t.pe_Iu == 0) {
							pe_RI.appendChild(pe_hT);
							if (pe_hT.nodeType == 1) {
								if (t._oThis.config.pe_pp.InArray(pe_hT.tagName
										.toLowerCase())
										&& t._oThis.util.pe_up(el, t.pe_tw)) {
									var pe_adN = pe_hT.cloneNode(false);
									(pe_qL == null) ? pe_HD.appendChild(pe_adN)
											: pe_qL.appendChild(pe_adN);
									pe_qL = pe_adN;
								}
							}
						} else {
							if (pe_hT.nodeType != 3
									|| (pe_hT.nodeType == 3 && pe_hT.nodeValue
											.Trim() != "")) {
								if (t._oThis.util.pe_up(pe_HD, pe_RI)) {
									pe_RI.appendChild(pe_hT);
								} else {
									pe_qL.appendChild(pe_hT);
									if (pe_hT.nodeType == 1
											&& pe_hT.nodeName == "\x42\x52"
											&& el.parentNode
											&& el.parentNode.nodeType == 1
											&& t._oThis.config.pe_rD
													.InArray(el.parentNode.nodeName
															.toLowerCase())) {
										pe_arv = true;
									}
									if (pe_arv)
										pe_qL = pe_HD;
								}
							} else {
								t.pe_Ir--;
							}
						}
					}
					if (el.childNodes.length > 0)
						pe_at(el.childNodes, pe_hT);
				}
			}
		}
		;
		var t = this;
		var pe_gV = false;
		var pe_ed = pe_aBr;
		var nextNode = pe_aFJ;
		var pe_qL = null;
		var pe_arv = false;
		this.pe_Ir = 0;
		this.pe_Iu = 0;
		while (!pe_gV) {
			pe_at([ pe_ed ], nextNode);
			pe_ed = pe_ed.nextSibling;
			if (!pe_ed || (pe_ed.nodeType == 1 && this.pe_rk(pe_ed))) {
				pe_gV = true;
			}
		}
	},
	pe_km : function(pe_nC) {
		if (typeof pe_nC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		var pe_gV = false;
		var pe_ca = pe_nC;
		var pe_eN = null;
		while (!pe_gV) {
			if (!pe_ca.parentNode) {
				pe_ca = null;
				break;
			}
			pe_eN = pe_ca;
			pe_ca = pe_ca.parentNode;
			if (this.pe_rk(pe_ca)) {
				pe_gV = true;
			}
		}
		return {
			'\x70\x65\x5f\x64\x67' : pe_ca,
			'\x70\x65\x5f\x6c\x53' : pe_eN
		};
	},
	pe_asG : function(pe_eD, pe_fl) {
		var pe_lW = this.pe_ayx(pe_eD, pe_fl);
		if (pe_lW.pe_Cy != null && pe_lW.pe_Cz != null) {
			this.pe_amB(pe_lW.pe_Cy);
			this.pe_Br(pe_lW.pe_Cy);
			this.pe_abK(pe_lW.pe_Cy, pe_eD, pe_fl, pe_lW.pe_aGI);
		} else {
			pe_lW.pe_Cz = this._oThis.getDocument().createElement("\x50");
		}
		this.pe_Br(pe_lW.pe_Cz);
		if (pe_lW.pe_Cy != null) {
			pe_lW.pe_Cy.parentNode.insertBefore(pe_lW.pe_Cz,
					pe_lW.pe_Cy.nextSibling);
		} else {
			var pe_bC = this._oThis.getSelection();
			pe_bC.sel = pe_bC.getSelection();
			pe_bC.range = pe_bC.pe_bY();
			pe_bC.range.insertNode(pe_lW.pe_Cz);
		}
		this.pe_amC(pe_lW.pe_Cz);
		this.pe_ki(pe_lW.pe_Cz);
	},
	pe_aGp : function(pe_eD, pe_fl) {
		if (pe_fl.nodeType == 1
				&& this._oThis.config.pe_pp
						.InArray(pe_fl.tagName.toLowerCase())) {
			var pe_oW = this._oThis.getDocument().createElement("\x50");
			this.pe_Br(pe_oW);
			this.pe_abK(pe_oW, pe_eD, pe_fl);
			this.pe_amC(pe_oW);
			this.pe_ki(pe_oW);
		}
	},
	pe_Nx : function(pe_eD) {
		var pe_ZX;
		var pe_oW = this._oThis.getDocument().createElement("\x50");
		this.pe_Br(pe_oW);
		(pe_eD.nodeName == "\x4c\x49") ? pe_ZX = pe_eD.parentNode
				: pe_ZX = pe_eD;
		pe_ZX.parentNode.insertBefore(pe_oW, pe_ZX.nextSibling);
		if (pe_eD.nodeName == "\x4c\x49" && pe_eD.textContent.Trim() == "") {
			pe_eD.parentNode.removeChild(pe_eD);
		}
		this.pe_ki(pe_oW);
	},
	pe_abK : function(pe_ft, pe_ca, pe_eN, pe_GE) {
		if (typeof pe_GE == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_GE = null;
		var pe_cv;
		(pe_ca.tagName == "\x50") ? pe_cv = pe_ca : pe_cv = pe_eN;
		pe_cv.parentNode.insertBefore(pe_ft, pe_cv);
		this.pe_aDb(pe_cv, pe_GE);
	},
	pe_ki : function(pe_fe, pe_Cn) {
		if (typeof pe_Cn == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64")
			pe_Cn = true;
		var focusNode;
		if (pe_fe.firstChild && pe_fe.firstChild.tagName == "\x42\x52") {
			focusNode = pe_fe.firstChild;
		} else {
			var pe_asP = "";
			if (!agentInfo.IsIE) {
				if (!(agentInfo.IsOpera && parseInt(pe_cm) < 10)) {
					pe_asP = "\x62\x72";
				}
			}
			focusNode = this._oThis.util.pe_Wt(pe_fe, pe_Cn, pe_asP);
			if (focusNode == null) {
				if (pe_fe.firstChild) {
					var pe_jO = this._oThis.util.pe_qz(pe_fe,
							'\x6c\x61\x73\x74', 1);
					if (pe_jO && pe_jO.firstChild
							&& pe_jO.firstChild.tagName == "\x42\x52")
						focusNode = pe_jO.firstChild;
					else {
						if (pe_jO) {
							focusNode = pe_jO;
						} else {
							if (pe_fe.firstChild
									&& pe_fe.firstChild.nodeType == 3
									&& /\s/.test(pe_fe.firstChild.nodeValue)) {
								focusNode = pe_fe.firstChild;
							} else {
								focusNode = pe_fe;
							}
						}
					}
				} else {
					focusNode = pe_fe;
				}
			}
		}
		if (agentInfo.IsIE)
			focusNode = pe_fe;
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.pe_iq(focusNode);
		pe_bC.range = pe_bC.pe_bY();
		pe_bC.range.collapse(true);
		pe_bC.pe_bM();
	},
	pe_amC : function(pe_fe) {
		if (typeof pe_fe == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		if (pe_fe.previousSibling
				&& pe_fe.previousSibling.tagName == "\x42\x52")
			pe_fe.parentNode.removeChild(pe_fe.previousSibling);
		if (pe_fe.nextSibling && pe_fe.nextSibling.tagName == "\x42\x52")
			pe_fe.parentNode.removeChild(pe_fe.nextSibling);
	},
	pe_Br : function(pe_fe) {
		if (typeof pe_fe == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		if (pe_fe.innerHTML == "") {
			if (agentInfo.IsOpera)
				pe_fe.innerHTML = ((parseInt(pe_cm) < 10) ? "\x26\x6e\x62\x73\x70\x3b"
						: "\x3c\x62\x72\x20\x2f\x3e");
			else if (agentInfo.IsIE)
				pe_fe.innerHTML = "\x26\x6e\x62\x73\x70\x3b";
			else
				pe_fe.innerHTML = "\x3c\x62\x72\x20\x2f\x3e";
		}
	},
	pe_amB : function(pe_fe) {
		if (typeof pe_fe == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		if (this._oThis.util.pe_Wt(pe_fe, true) == null
				&& !this._oThis.util.pe_up(pe_fe,
						'\x43\x6f\x6e\x74\x72\x6f\x6c', [ '\x6f\x6c',
								'\x75\x6c', '\x6c\x69' ])
				&& !this._oThis.util.pe_up(pe_fe,
						'\x45\x6c\x65\x41\x72\x72\x61\x79',
						this._oThis.config.pe_zj)) {
			pe_fe.innerHTML = "";
		}
	},
	pe_aDb : function(pe_nC, pe_GE) {
		if (typeof pe_nC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_gV = false;
		var pe_ed = pe_nC;
		if ((pe_ed.nodeType == 1 && pe_ed.tagName == "\x50")
				|| (pe_GE != null && pe_GE == false)) {
			pe_ed.parentNode.removeChild(pe_ed);
		} else {
			while (!pe_gV) {
				if (!pe_ed || (pe_ed.nodeType == 1 && this.pe_rk(pe_ed))) {
					pe_gV = true;
					break;
				}
				var pe_fx = pe_ed.nextSibling;
				pe_ed.parentNode.removeChild(pe_ed);
				pe_ed = pe_fx;
			}
		}
	},
	pe_EB : function(node) {
		if (typeof node == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		var pe_gV = false;
		var pe_ed = node;
		while (!pe_gV) {
			if (!pe_ed.previousSibling
					|| (pe_ed.previousSibling.nodeType == 1 && (this
							.pe_rk(pe_ed.previousSibling) || pe_ed.previousSibling.nodeName == "\x48\x52"))) {
				pe_gV = true;
				break;
			}
			pe_ed = pe_ed.previousSibling;
		}
		return pe_ed;
	},
	pe_aDP : function(node, pe_amS) {
		try {
			var pe_aAz = [ '\x49\x4d\x47', '\x41' ];
			if (node.previousSibling
					&& node.previousSibling.nodeType == 1
					&& pe_aAz
							.InArray(this._oThis.getDocument().body.childNodes[pe_amS - 1].nodeName))
				return this._oThis.getDocument().body.childNodes[pe_amS - 1];
			else
				return null;
		} catch (e) {
			return null;
		}
	},
	pe_aBm : function(pe_pO) {
		var pe_kQ, focusNode;
		focusNode = this._oThis.getDocument().createTextNode('\x20');
		pe_pO.parentNode.insertBefore(focusNode, pe_pO.nextSibling);
		pe_kQ = this._oThis.getDocument().createRange();
		pe_kQ.selectNode(focusNode);
		pe_kQ.collapse(true);
		pe_kQ.setStart(focusNode, 1);
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.sel.removeAllRanges();
		pe_bC.sel.addRange(pe_kQ);
	},
	pe_aDE : function(pe_pO) {
		if (typeof pe_pO == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_ca;
		var pe_akx = null;
		var pe_ago = null;
		var pe_akv = null;
		pe_ca = pe_pO;
		if (!this.pe_rk(pe_pO)) {
			var pe_fn = this.pe_km(pe_pO);
			pe_ca = pe_fn.pe_dg;
		}
		var x = this._oThis.util.pe_bP(pe_ca, "\x73\x70\x61\x6e");
		if (x.length > 0) {
			for (i = 0; i < x.length; i++) {
				if (x[i].style.backgroundColor) {
					pe_akv = x[i];
					pe_ago = pe_b(x[i].style.backgroundColor);
					break;
				}
			}
		}
		if (pe_ago) {
			if (this._oThis.util.pe_up(pe_akv, this.pe_tw)
					|| pe_pO == this.pe_tw)
				pe_akx = pe_ago;
		}
		return pe_akx;
	},
	pe_aBn : function(pe_LF) {
		if (typeof pe_LF == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_ca;
		var pe_oG = false;
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.range = pe_bC.pe_bY();
		pe_ca = pe_bC.range.startContainer;
		if (!this.pe_rk(pe_ca)) {
			var pe_fn = this.pe_km(pe_ca);
			pe_ca = pe_fn.pe_dg;
		}
		if (pe_ca == null)
			return;
		var x = this._oThis.util.pe_bP(pe_ca, "\x73\x70\x61\x6e");
		var pe_arJ = function(pe_mM) {
			if (pe_mM.className
					&& pe_mM.className.toLowerCase() == "\x61\x70\x70\x6c\x65\x2d\x73\x74\x79\x6c\x65\x2d\x73\x70\x61\x6e"
					&& pe_mM.style.lineHeight && pe_mM.style.lineHeight != "") {
				pe_mM.style.lineHeight = "";
			}
		};
		if (pe_LF == "\x58") {
			for (var i = 0; i < x.length; i++) {
				pe_arJ(x[i]);
			}
		} else {
			if (x.length == 0) {
				var pe_wo = this._oThis.getDocument().createElement(
						"\x53\x50\x41\x4e");
				pe_wo.style.backgroundColor = pe_LF;
				pe_wo.innerHTML = pe_ca.innerHTML;
				pe_ca.innerHTML = "";
				pe_ca.appendChild(pe_wo);
				this.pe_ki(pe_wo);
			} else {
				if (pe_ca.tagName.toLowerCase() == "\x70") {
					for (var i = 0; i < x.length; i++) {
						if (x[i].style.backgroundColor) {
							pe_oG = true;
							break;
						}
					}
				}
				if (!pe_oG) {
					if (x[0])
						x[0].style.backgroundColor = pe_LF;
				}
				for (var i = 0; i < x.length; i++) {
					if (!pe_oG && x[i].style.fontSize
							&& x[i].style.fontSize != "")
						x[i].style.backgroundColor = pe_LF;
					pe_arJ(x[i]);
				}
			}
		}
	},
	pe_rk : function(node) {
		try {
			return (this._oThis.config.pe_fP
					.InArray(node.tagName.toLowerCase()) || this._oThis.config.pe_rD
					.InArray(node.tagName.toLowerCase()));
		} catch (e) {
			return false;
		}
	},
	pe_aIV : function() {
		var pe_cD = null;
		var pe_ca = null;
		var pe_fn = null;
		var pe_oG = false;
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.range = pe_bC.pe_bY();
		pe_cD = pe_bC.range.startContainer;
		pe_ca = pe_bC.range.startContainer;
		if (pe_ca.nodeType == 3) {
			pe_fn = this.pe_km(pe_ca);
			pe_ca = pe_fn.pe_dg;
		}
		if (pe_ca == null)
			return;
		if (pe_cD.parentNode && pe_cD.parentNode.nodeType == 1
				&& pe_cD.parentNode.nodeName == "\x41") {
			var pe_jO = this._oThis.util.pe_qz(pe_ca, '\x6c\x61\x73\x74', 1);
			if (pe_jO.nodeName == "\x41") {
				var pe_kQ, focusNode;
				focusNode = this._oThis.getDocument().createTextNode('\x20');
				pe_cD.parentNode.parentNode.insertBefore(focusNode,
						pe_cD.parentNode.nextSibling);
				pe_kQ = this._oThis.getDocument().createRange();
				pe_kQ.selectNode(focusNode);
				pe_kQ.collapse(true);
				pe_kQ.setStart(focusNode, 1);
				pe_bC.sel = pe_bC.getSelection();
				pe_bC.sel.removeAllRanges();
				pe_bC.sel.addRange(pe_kQ);
				if (!agentInfo.IsOpera)
					pe_cD.parentNode.parentNode.removeChild(focusNode);
			}
		}
	},
	pe_arK : function() {
		var pe_ca = null;
		var pe_eN = null;
		var pe_fn = null;
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.range = pe_bC.pe_bY();
		pe_ca = pe_bC.range.startContainer;
		if (pe_ca.nodeType == 3) {
			pe_fn = this.pe_km(pe_ca);
			pe_ca = pe_fn.pe_dg;
			pe_eN = this.pe_EB(pe_fn.pe_lS);
		}
		if (pe_ca == null)
			return;
		if (!this._oThis.config.pe_fP.InArray(pe_ca.tagName.toLowerCase())
				&& this._oThis.config.pe_rD
						.InArray(pe_ca.tagName.toLowerCase())) {
			if (pe_bC.isCollapsed()) {
				this.pe_tw = pe_bC.range.startContainer;
				this.pe_alb = pe_bC.range.endContainer;
				this.pe_Pz = pe_bC.range.startOffset;
				this.pe_akR = pe_bC.range.endOffset;
				this.pe_asG(pe_ca, pe_eN);
			}
		} else if (pe_ca.nodeType == 1
				&& this._oThis.config.pe_pp
						.InArray(pe_ca.tagName.toLowerCase())) {
			pe_fn = this.pe_km(pe_ca);
			pe_ca = pe_fn.pe_dg;
			pe_eN = this.pe_EB(pe_fn.pe_lS);
			this.pe_aGp(pe_ca, pe_eN);
		}
	},
	pe_amO : function(pe_cD, pe_hL, pe_zX) {
		if (![ 8, 46 ].InArray(pe_zX))
			return;
		if (!pe_cD)
			return;
		var pe_arf = [ '\x74\x61\x62\x6c\x65', '\x68\x72',
				'\x69\x6e\x70\x75\x74' ];
		var pe_jT = null;
		var pe_DQ = false;
		if (pe_zX == 8) {
			try {
				if (pe_cD.nodeType == 1 && pe_cD.nodeName == "\x42\x4f\x44\x59") {
					if (pe_cD.childNodes[pe_hL - 1]
							&& pe_cD.childNodes[pe_hL - 1].nodeName == "\x54\x41\x42\x4c\x45")
						pe_jT = pe_cD.childNodes[pe_hL - 1];
					else
						pe_jT = pe_cD.childNodes[pe_hL];
				} else if (pe_cD.nodeType == 3 && pe_cD.nextSibling
						&& pe_cD.nextSibling.nodeType == 1) {
					pe_jT = pe_cD.nextSibling;
				}
				if (pe_jT) {
					if (pe_arf.InArray(pe_jT.nodeName.toLowerCase())) {
						pe_jT.parentNode.removeChild(pe_jT);
						pe_DQ = true;
					}
				}
			} catch (e) {
				return false;
			}
		} else if (pe_zX == 46) {
			try {
				var pe_ca = this.pe_km(pe_cD);
				if (pe_cD.nodeType == 3) {
					if (NamoSE.Util.pe_qz(pe_ca.pe_dg, '\x6c\x61\x73\x74', 3) == pe_cD
							&& pe_hL >= pe_cD.nodeValue.length) {
					}
				} else {
					if (pe_cD.nodeType == 1
							&& pe_cD.nodeName == "\x42\x4f\x44\x59") {
						pe_jT = pe_cD.childNodes[pe_hL];
					} else if (NamoSE.Util.pe_qz(pe_ca.pe_dg,
							'\x6c\x61\x73\x74', 1) == pe_cD) {
						pe_jT = pe_ca.pe_dg.nextSibling;
					}
				}
				if (pe_jT) {
					if (pe_jT && pe_jT.nodeType == 1
							&& pe_arf.InArray(pe_jT.nodeName.toLowerCase())) {
						pe_jT.parentNode.removeChild(pe_jT);
						pe_DQ = true;
					}
				}
			} catch (e) {
				return false;
			}
		}
		return pe_DQ;
	},
	pe_aiX : function(pe_zX, pe_aHE) {
		var pe_SM = false;
		var pe_DQ = false;
		var eDoc = this._oThis.getDocument();
		var eWin = this._oThis.pe_dy();
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.range = pe_bC.pe_bY();
		if (eDoc.body.innerHTML.Trim() == ""
				|| eDoc.body.innerHTML.Trim().toLowerCase() == "\x3c\x62\x72\x3e") {
			eDoc.body.innerHTML = "";
			pe_SM = true;
		} else {
			var pe_iy;
			var pe_afM = "";
			var pe_Su = null;
			var pe_Sj = null;
			try {
				if (agentInfo.IsIE && parseInt(pe_cm) < 9) {
					pe_Su = null;
					pe_Sj = 0;
					pe_iy = pe_bC.range.duplicate();
					pe_iy.moveToElementText(eDoc.body);
					pe_afM = pe_iy.text;
				} else {
					if (agentInfo.IsIE) {
						pe_bC.sel = pe_bC.pe_Fh();
						pe_bC.range = pe_bC.pe_Fj(pe_bC.sel);
					}
					pe_Su = pe_bC.range.startContainer;
					pe_Sj = pe_bC.range.startOffset;
					pe_iy = pe_bC.range.cloneRange();
					pe_iy.selectNode(eDoc.body);
					pe_afM = pe_iy.toString();
				}
			} catch (exp) {
				return;
			}
			if (pe_afM.Trim() == "") {
				if (!this._oThis.util.pe_up(eDoc.body,
						'\x43\x6f\x6e\x74\x72\x6f\x6c', [ '\x6f\x6c',
								'\x75\x6c', '\x6c\x69' ])
						&& !this._oThis.util.pe_up(eDoc.body,
								'\x45\x6c\x65\x41\x72\x72\x61\x79',
								this._oThis.config.pe_zj)) {
					eDoc.body.innerHTML = "";
					if (eDoc.body.style.textAlign == "\x63\x65\x6e\x74\x65\x72")
						eDoc.body.style.textAlign = "\x6c\x65\x66\x74";
					if (!eDoc.body.style.fontFamily
							|| eDoc.body.style.fontFamily == "")
						eDoc.body.style.fontFamily = pe_bE.pe_uT;
					if (!eDoc.body.style.fontSize
							|| eDoc.body.style.fontSize == "")
						eDoc.body.style.fontSize = pe_bE.pe_ql + "\x70\x74";
					pe_SM = true;
				}
				if (!pe_SM && agentInfo.IsGecko && pe_bC.isCollapsed()) {
					pe_DQ = this.pe_amO(pe_Su, pe_Sj, pe_zX);
				}
			} else {
				if (!agentInfo.IsIE) {
					if (agentInfo.IsGecko && pe_bC.isCollapsed()) {
						pe_DQ = this.pe_amO(pe_Su, pe_Sj, pe_zX);
					}
					if (!pe_bC.isCollapsed())
						this.pe_arK();
				}
			}
		}
		if (pe_SM) {
			this._oThis.pe_acc();
			if (this._oThis.util.pe_bP(eDoc.body, "\x70").length > 0) {
				var pe_axV = this._oThis.util.pe_bP(eDoc.body, "\x70")[0];
				this.pe_ki(pe_axV);
			} else {
				if (!agentInfo.IsIE) {
					if (agentInfo.IsOpera && parseInt(pe_cm) >= 10) {
						NamoSE.Util.pe_bO(function() {
							eWin.focus()
						}, 100);
					} else {
						var pe_kQ = eDoc.createRange();
						pe_kQ.collapse(true);
						pe_bC.sel.removeAllRanges();
						pe_bC.sel.addRange(pe_kQ);
					}
				}
			}
		} else {
			if (pe_DQ && agentInfo.IsGecko) {
				if (eDoc.body.innerHTML.Trim() == ""
						|| eDoc.body.innerHTML.Trim().toLowerCase() == "\x3c\x62\x72\x3e")
					this.pe_aiX(pe_zX, pe_aHE);
			}
		}
	}
};
var pe_avS = {
	_oThis : null,
	pe_nP : null,
	pe_ahU : null,
	pe_vY : null,
	pe_rI : false,
	pe_ahR : false,
	pe_bU : null,
	marginLeft : null,
	marginRight : null,
	init : function() {
		this.pe_bU = this._oThis
				.getFunctionals("\x65\x6e\x74\x65\x72\x6b\x65\x79");
		this.pe_vY = [ "\x42\x4f\x44\x59", "\x54\x44", "\x54\x48" ];
		this.pe_atG = [ "\x54\x41\x42\x4c\x45", "\x4f\x4c", "\x55\x4c" ];
	},
	start : function() {
		if (!this.pe_ahU)
			return;
		var pe_eN = null;
		var pe_ur = null;
		var pe_fn = null;
		var startContainer = null;
		var endContainer = null;
		this.pe_ahR = false;
		this.pe_ahT = false;
		this.pe_MJ = [];
		this.pe_aef = null;
		this.pe_ael = null;
		this.init();
		this._oThis.pe_dy().focus();
		var pe_bC = this._oThis.getSelection();
		var sel = pe_bC.sel = pe_bC.getSelection();
		var range = pe_bC.range = pe_bC.pe_bY();
		if (pe_bC.range.startContainer)
			startContainer = this.pe_aef = pe_bC.range.startContainer;
		if (pe_bC.range.endContainer)
			endContainer = this.pe_ael = pe_bC.range.endContainer;
		if (agentInfo.IsIE) {
			var pe_aFE = pe_bC.pe_Fh();
			var pe_aqJ = pe_bC.pe_Fj(pe_aFE);
			this.pe_aef = pe_aqJ.startContainer;
			this.pe_ael = pe_aqJ.endContainer;
		}
		if (pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c") {
			if ([ "\x6a\x75\x73\x74\x69\x66\x79\x6c\x65\x66\x74",
					"\x6a\x75\x73\x74\x69\x66\x79\x63\x65\x6e\x74\x65\x72",
					"\x6a\x75\x73\x74\x69\x66\x79\x72\x69\x67\x68\x74",
					"\x6a\x75\x73\x74\x69\x66\x79\x66\x75\x6c\x6c" ]
					.InArray(this.pe_nP)) {
				var pe_bG = pe_bC.pe_fJ();
				if (pe_bG == null)
					return;
				if (pe_bG.nodeName == "\x54\x41\x42\x4c\x45") {
					var pe_akp = this.pe_nP.substring(7).toLowerCase();
					if (pe_akp == "\x66\x75\x6c\x6c") {
						var pe_atA = document.getElementById(this.pe_nP);
						if (pe_atA)
							NamoSE.Util.pe_bO(function() {
								NamoSE.pe_dn.pe_uo(pe_atA)
							}, 50);
					} else
						pe_bG.align = pe_akp;
					return;
				} else {
					if (agentInfo.IsIE) {
						pe_bC.pe_it(pe_bG);
						range = pe_bC.range = pe_bC.pe_bY();
					}
				}
			} else {
				return;
			}
		}
		if (pe_bC.isCollapsed()) {
			if (startContainer && startContainer.nodeType == 1
					&& startContainer.nodeName == "\x42\x4f\x44\x59") {
				if (!agentInfo.IsIE) {
					if (agentInfo.IsOpera
							&& startContainer.firstChild
							&& startContainer.firstChild.nodeType == 1
							&& startContainer.firstChild.nodeName == "\x42\x52"
							&& startContainer.firstChild == startContainer.lastChild)
						startContainer = startContainer.firstChild;
					else if (this.pe_vY.InArray(startContainer.nodeName))
						startContainer = startContainer.childNodes[pe_bC.range.startOffset];
				}
			}
			pe_fn = this.pe_aej(pe_bC, true, startContainer);
			pe_eN = pe_fn.pe_dg;
		} else {
			if (!agentInfo.IsIE) {
				if (startContainer
						&& this.pe_vY.InArray(startContainer.nodeName))
					startContainer = startContainer.childNodes[pe_bC.range.startOffset];
				if (endContainer && this.pe_vY.InArray(endContainer.nodeName))
					endContainer = endContainer.childNodes[pe_bC.range.endOffset - 1];
			}
			pe_fn = this.pe_aej(pe_bC, true, startContainer);
			pe_eN = pe_fn.pe_dg;
			pe_fn = this.pe_aej(pe_bC, false, endContainer);
			pe_ur = pe_fn.pe_dg;
		}
		if (pe_eN || pe_ur)
			this.pe_cq(pe_eN, pe_ur, pe_bC);
	},
	pe_cq : function(pe_cD, pe_gN, pe_bC) {
		if (typeof pe_cD == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64")
			return;
		var t = this;
		var val = this.pe_ahU;
		if (pe_cD && pe_gN && pe_cD != pe_gN)
			t.pe_aBE(pe_cD, pe_gN, val);
		else {
			if (!t.pe_zx(pe_cD, val))
				if (t.pe_nP == "\x6f\x75\x74\x64\x65\x6e\x74" && pe_cD
						&& pe_cD.nodeName == "\x4c\x49" && t.pe_aeX(pe_cD))
					t.pe_MJ.push(pe_cD);
		}
		if (this.pe_MJ.length > 0)
			this.pe_aCM();
		if (this.pe_ahR) {
			if (pe_cD && pe_gN && pe_cD != pe_gN)
				pe_bC.pe_it(pe_cD, pe_gN);
			else {
				pe_bC.pe_iq(pe_cD);
				if (agentInfo.IsOpera
						&& (pe_cD.innerHTML.Trim() == "" || (pe_cD.firstChild
								&& pe_cD.firstChild.nodeType == 1
								&& pe_cD.firstChild.nodeName == "\x42\x52" && pe_cD.firstChild == pe_cD.lastChild))) {
					pe_bC.range = pe_bC.pe_bY();
					pe_bC.range.collapse(true);
					pe_bC.pe_bM();
				}
			}
		} else {
			try {
				pe_bC.pe_bM();
				if (this.pe_ahT) {
					var pe_abX = pe_bC.pe_Fh();
					var pe_ti = pe_bC.pe_Fj(pe_abX);
					if (!(pe_ti.startContainer == this.pe_aef && pe_ti.endContainer == this.pe_ael)) {
						if (pe_cD && pe_gN && pe_cD != pe_gN) {
							var pe_hL = 0, pe_mn = 0;
							pe_ti.selectNodeContents(pe_gN);
							pe_gN = pe_ti.endContainer;
							pe_mn = pe_ti.endOffset;
							pe_ti.setStart(pe_cD, pe_hL);
							pe_ti.setEnd(pe_gN, pe_mn);
							if (!pe_ti.pe_aoT)
								pe_abX.removeAllRanges();
							pe_abX.addRange(pe_ti);
						} else
							pe_bC.pe_zN(pe_cD);
					}
				}
			} catch (exp) {
			}
		}
	},
	pe_zx : function(node, pe_jg) {
		if (typeof node == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64")
			return false;
		var pe_qo = false;
		var pe_adL = this.pe_atG.InArray(node.nodeName);
		if (this._oThis.config.pe_fP.InArray(node.nodeName.toLowerCase())
				|| pe_adL || node.nodeName == "\x53\x50\x41\x4e") {
			switch (this.pe_nP) {
			case "\x6c\x69\x6e\x65\x68\x65\x69\x67\x68\x74":
				node.style.lineHeight = pe_jg;
				pe_qo = true;
				break;
			case "\x6a\x75\x73\x74\x69\x66\x79\x6c\x65\x66\x74":
			case "\x6a\x75\x73\x74\x69\x66\x79\x63\x65\x6e\x74\x65\x72":
			case "\x6a\x75\x73\x74\x69\x66\x79\x72\x69\x67\x68\x74":
			case "\x6a\x75\x73\x74\x69\x66\x79\x66\x75\x6c\x6c":
				if (node.nodeName != "\x53\x50\x41\x4e") {
					if (node.getAttribute("\x61\x6c\x69\x67\x6e"))
						node.removeAttribute("\x61\x6c\x69\x67\x6e");
					pe_jg = pe_jg.substring(7).toLowerCase();
					node.style["\x74\x65\x78\x74\x41\x6c\x69\x67\x6e"] = (pe_jg == "\x66\x75\x6c\x6c") ? "\x6a\x75\x73\x74\x69\x66\x79"
							: pe_jg;
					pe_qo = true;
				}
				break;
			case "\x6f\x75\x74\x64\x65\x6e\x74":
			case "\x69\x6e\x64\x65\x6e\x74":
				if (node.nodeName != "\x53\x50\x41\x4e") {
					var pe_Zb = "";
					var pe_HS = "";
					var pe_abq = "";
					var pe_RL = "";
					if (pe_adL || node.nodeName == "\x4c\x49") {
						pe_Zb = "\x6d\x61\x72\x67\x69\x6e\x2d\x6c\x65\x66\x74";
						pe_HS = "\x6d\x61\x72\x67\x69\x6e\x4c\x65\x66\x74";
						pe_abq = "\x70\x61\x64\x64\x69\x6e\x67\x2d\x6c\x65\x66\x74";
						pe_RL = "\x70\x61\x64\x64\x69\x6e\x67\x4c\x65\x66\x74";
						if (pe_adL) {
							if (node.parentNode
									&& node.parentNode.nodeType == 1
									&& this._oThis.config.pe_fP
											.InArray(node.parentNode.nodeName
													.toLowerCase()))
								if (!(this.pe_nP == "\x6f\x75\x74\x64\x65\x6e\x74" && [
										"\x4f\x4c", "\x55\x4c" ]
										.InArray(node.nodeName)))
									return false;
						}
					} else {
						pe_Zb = "\x70\x61\x64\x64\x69\x6e\x67\x2d\x6c\x65\x66\x74";
						pe_HS = "\x70\x61\x64\x64\x69\x6e\x67\x4c\x65\x66\x74";
						pe_abq = "\x6d\x61\x72\x67\x69\x6e\x2d\x6c\x65\x66\x74";
						pe_RL = "\x6d\x61\x72\x67\x69\x6e\x4c\x65\x66\x74";
					}
					var pe_HF = node.style[pe_HS];
					if (!pe_HF) {
						var pe_arp = node.style[pe_RL];
						if (pe_arp) {
							pe_HF = pe_arp;
							pe_Zb = pe_abq;
							pe_HS = pe_RL;
						}
					}
					pe_jg = (this.pe_nP == "\x69\x6e\x64\x65\x6e\x74") ? parseInt(pe_HF || 0)
							+ pe_jg
							: Math.max(0, parseInt(pe_HF || 0) - pe_jg);
					if (this.pe_nP == "\x6f\x75\x74\x64\x65\x6e\x74"
							&& pe_jg == 0) {
						pe_qo = (parseInt(pe_HF || 0) > 0);
						if (pe_HF != "")
							NamoSE.Util.pe_AX(node, pe_Zb, pe_HS);
						if (node.style.cssText == "")
							node.removeAttribute("\x73\x74\x79\x6c\x65");
						return pe_qo;
					}
					node.style[pe_HS] = pe_jg + "\x70\x78";
					pe_qo = true;
				}
				break;
			case "\x64\x69\x72\x6c\x74\x72":
			case "\x64\x69\x72\x72\x74\x6c":
				var pe_RT = pe_jg.substring(3).toLowerCase();
				if (!node.dir) {
					node.dir = pe_RT;
				} else if (node.dir == pe_RT) {
					node.removeAttribute("\x64\x69\x72");
				} else if (node.dir != pe_RT) {
					node.dir = pe_RT;
				}
				pe_qo = true;
				break;
			case "\x74\x78\x74\x4d\x61\x72\x67\x69\x6e":
				var pe_aGO = this.marginLeft;
				var pe_aGK = this.marginRight;
				if (node.nodeName != "\x53\x50\x41\x4e") {
					var pe_aCF = "\x6d\x61\x72\x67\x69\x6e\x2d\x6c\x65\x66\x74";
					var pe_aCK = "\x6d\x61\x72\x67\x69\x6e\x4c\x65\x66\x74";
					var pe_aCH = "\x6d\x61\x72\x67\x69\x6e\x2d\x72\x69\x67\x68\x74";
					var pe_aCI = "\x6d\x61\x72\x67\x69\x6e\x52\x69\x67\x68\x74";
					var pe_aio = pe_aCF;
					if (!node.style[pe_aio]) {
						pe_aio = pe_aCK;
					}
					var pe_aip = pe_aCH;
					if (!node.style[pe_aip]) {
						pe_aip = pe_aCI;
					}
					node.style[pe_aio] = pe_aGO;
					node.style[pe_aip] = pe_aGK;
					if (!node.style.cssText) {
						node.removeAttribute("\x73\x74\x79\x6c\x65");
					}
				}
				pe_qo = true;
				break;
			}
		}
		return pe_qo;
	},
	pe_aBE : function(pe_cD, pe_gN, pe_jg) {
		function pe_u(pe_cY) {
			if (pe_cY.length > 0) {
				for (var i = 0; i < pe_cY.length; i++) {
					if (t.pe_rI)
						return;
					var el = pe_cY[i];
					if (pe_LT == null) {
						if ([ "\x69\x6e\x64\x65\x6e\x74",
								"\x6f\x75\x74\x64\x65\x6e\x74" ]
								.InArray(t.pe_nP)
								&& el.nodeType == 1
								&& t.pe_atG.InArray(el.nodeName)) {
							pe_LT = el;
							if ([ "\x4f\x4c", "\x55\x4c" ].InArray(el.nodeName)) {
								var pe_uc = false;
								if (!(el.parentNode
										&& el.parentNode.nodeType == 1 && t._oThis.config.pe_fP
										.InArray(el.parentNode.nodeName
												.toLowerCase()))) {
									var pe_so = NamoSE.Util.pe_bP(el,
											"\x6c\x69");
									if (pe_so.length > 0) {
										for (var x = 0; x < pe_so.length; x++) {
											if (pe_so[x]) {
												var pe_avh = t.pe_zx(pe_so[x],
														pe_jg);
												if (pe_avh)
													pe_uc = true;
											}
										}
										if (!pe_uc
												&& t.pe_nP == "\x6f\x75\x74\x64\x65\x6e\x74")
											pe_uc = t.pe_zx(el, pe_jg);
										if (!pe_uc && t.pe_ajw(el))
											pe_uj.push(el);
									}
								} else if (el.parentNode
										&& t._oThis.config.pe_fP
												.InArray(el.parentNode.nodeName
														.toLowerCase())) {
									if (t.pe_nP == "\x6f\x75\x74\x64\x65\x6e\x74"
											&& pe_KV.length > 0) {
										pe_uc = true;
										for (var x = 0; x < pe_KV.length; x++) {
											if (pe_KV[x]
													&& pe_KV[x] == el.parentNode) {
												pe_uc = false;
												break;
											}
										}
										if (!pe_uc)
											pe_uc = t.pe_zx(el, pe_jg);
										if (!pe_uc && t.pe_ajw(el))
											pe_uj.push(el);
									}
								}
							} else {
								t.pe_zx(el, pe_jg);
							}
						}
						if (el.nodeType == 1
								&& t._oThis.config.pe_fP.InArray(el.nodeName
										.toLowerCase())) {
							var pe_aBw = t.pe_zx(el, pe_jg);
							if (!pe_aBw
									&& t.pe_nP == "\x6f\x75\x74\x64\x65\x6e\x74") {
								if (el.nodeName == "\x4c\x49")
									if (t.pe_aeX(el))
										t.pe_MJ.push(el);
									else if (NamoSE.Util.pe_bP(el, "\x55\x4c").length > 0
											|| NamoSE.Util
													.pe_bP(el, "\x4f\x4c").length > 0)
										pe_KV.push(el);
							}
						}
						if (el.nodeType == 1
								&& el.nodeName == "\x53\x50\x41\x4e"
								&& el.style.lineHeight != "")
							t.pe_zx(el, pe_jg);
						if (el.nodeType == 3
								|| (el.nodeType == 1 && el.nodeName == "\x49\x4d\x47")) {
							var pe_ajZ = true;
							if (el.nodeType == 3) {
								var pe_rf = NamoSE.Util.pe_wd(el.nodeValue);
								if (pe_rf == "")
									pe_ajZ = false;
							}
							if (pe_ajZ) {
								var pe_aaG = t.pe_bU.pe_km(el);
								if (pe_aaG
										&& t.pe_vY
												.InArray(pe_aaG.pe_dg.nodeName))
									pe_nq.push(pe_aaG);
							}
						}
					}
					if (el == pe_OK)
						t.pe_rI = true;
					if (el.childNodes.length > 0)
						pe_u(el.childNodes);
					if (pe_LT && pe_LT == el)
						pe_LT = null;
				}
			}
		}
		;
		var t = this;
		var pe_gV = false;
		var pe_LT = null;
		var pe_fx = null;
		var pe_ed = pe_cD;
		var pe_OK = this._oThis.util.pe_qz(pe_gN, "\x6c\x61\x73\x74", 0);
		var pe_nq = [];
		var pe_uj = [];
		var pe_KV = [];
		t.pe_rI = false;
		while (!pe_gV) {
			pe_u([ pe_ed ]);
			pe_fx = pe_ed;
			pe_ed = pe_ed.nextSibling;
			if (!pe_ed) {
				if (pe_fx.parentNode
						&& pe_fx.parentNode.nodeType == 1
						&& t._oThis.config.pe_rD
								.InArray(pe_fx.parentNode.nodeName
										.toLowerCase())
						&& pe_fx.parentNode.nodeName != "\x42\x4f\x44\x59") {
					var pe_cr = pe_fx.parentNode;
					while (pe_cr.nodeName != "\x42\x4f\x44\x59") {
						if (pe_cr.nextSibling) {
							pe_ed = pe_cr.nextSibling;
							break;
						}
						pe_cr = pe_cr.parentNode;
					}
				}
			}
			if (!pe_ed || t.pe_rI) {
				pe_gV = true;
			}
		}
		if (pe_nq.length > 0) {
			for (var i = 0; i < pe_nq.length; i++) {
				var pe_ca = t.pe_asU(pe_nq[i].pe_dg, pe_nq[i].pe_lS);
				if (pe_ca
						&& pe_ca.nodeType == 1
						&& t._oThis.config.pe_fP.InArray(pe_ca.nodeName
								.toLowerCase()))
					t.pe_zx(pe_ca, pe_jg);
			}
		}
		if (pe_uj.length > 0) {
			for (var i = 0; i < pe_uj.length; i++) {
				if (pe_uj[i]) {
					var pe_ee = NamoSE.Util.pe_ff(pe_uj[i].firstChild);
					if (pe_ee
							&& pe_ee.nodeType == 1
							&& [ "\x4f\x4c", "\x55\x4c" ]
									.InArray(pe_ee.nodeName)) {
						if (pe_uj[i].parentNode) {
							t.pe_ahT = true;
							pe_uj[i].parentNode.replaceChild(pe_ee, pe_uj[i]);
						}
					}
				}
			}
		}
	},
	pe_aej : function(pe_bC, pe_acf, selectNode) {
		var pe_gM = null;
		if (agentInfo.IsIE)
			pe_gM = this.pe_aeI(pe_bC, pe_acf);
		else
			pe_gM = this.pe_adX(pe_bC, selectNode);
		if (this.pe_vY.InArray(pe_gM.pe_dg.nodeName)) {
			if (pe_gM.pe_lS
					&& pe_gM.pe_lS.nodeName == "\x53\x50\x41\x4e"
					&& pe_gM.pe_lS.id == "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65\x5f\x5f\x45\x6e\x64") {
				if (pe_gM.pe_dg.nodeName != "\x42\x4f\x44\x59") {
					pe_gM.pe_lS.innerHTML = "";
					pe_gM.pe_lS = pe_gM.pe_dg;
				}
			}
			pe_gM.pe_dg = this.pe_asU(pe_gM.pe_dg, pe_gM.pe_lS, pe_gM.pe_cp);
			if (!pe_gM.pe_dg)
				return {
					"\x70\x65\x5f\x64\x67" : null,
					"\x70\x65\x5f\x6c\x53" : null
				};
		}
		return {
			"\x70\x65\x5f\x64\x67" : pe_gM.pe_dg,
			"\x70\x65\x5f\x6c\x53" : pe_gM.pe_lS
		};
	},
	pe_aeI : function(pe_bC, pe_acf) {
		var pe_cp = pe_bC.range.duplicate();
		pe_cp.collapse(pe_acf);
		var pe_cr = pe_cp.parentElement();
		var pe_gV = false;
		var pe_ca = pe_cr;
		var pe_aIn = null;
		if (this.pe_bU.pe_rk(pe_ca))
			pe_eN = pe_ca;
		else {
			while (!pe_gV) {
				if (!pe_ca.parentNode)
					break;
				pe_eN = pe_ca;
				pe_ca = pe_ca.parentNode;
				if (this.pe_bU.pe_rk(pe_ca))
					pe_gV = true;
			}
		}
		return {
			"\x70\x65\x5f\x64\x67" : pe_ca,
			"\x70\x65\x5f\x6c\x53" : pe_eN,
			"\x70\x65\x5f\x63\x70" : pe_cp
		};
	},
	pe_adX : function(pe_bC, selectNode) {
		var pe_ca = null;
		var pe_eN = null;
		var pe_ca = selectNode;
		if (this.pe_bU.pe_rk(pe_ca))
			pe_eN = pe_ca;
		else {
			var pe_fn = this.pe_bU.pe_km(pe_ca);
			pe_ca = pe_fn.pe_dg;
			pe_eN = this.pe_bU.pe_EB(pe_fn.pe_lS);
		}
		return {
			"\x70\x65\x5f\x64\x67" : pe_ca,
			"\x70\x65\x5f\x6c\x53" : pe_eN,
			"\x70\x65\x5f\x63\x70" : null
		};
	},
	pe_asU : function(pe_eD, pe_fl, pe_cp) {
		var pe_TR = pe_eD;
		if (this.pe_vY.InArray(pe_eD.nodeName)) {
			if (agentInfo.IsIE) {
				if (this.pe_vY.InArray(pe_fl.nodeName)) {
					var pe_AH = "\x3c\x53\x50\x41\x4e\x20\x69\x64\x3d\"\x73\x70\x61\x6e\x5f\x65\x6e\x64\x63\x61\x72\x65\x74\"\x3e"
							+ this._oThis.getSelection().pe_Ix
							+ "\x3c\x2f\x53\x50\x41\x4e\x3e";
					pe_cp.pasteHTML(pe_AH);
					var pe_db = this._oThis
							.getDocument()
							.getElementById(
									"\x73\x70\x61\x6e\x5f\x65\x6e\x64\x63\x61\x72\x65\x74");
					if (pe_db.previousSibling)
						pe_fl = this.pe_bU.pe_EB(pe_db.previousSibling);
					else
						pe_fl = pe_db.nextSibling;
					pe_db.parentNode.removeChild(pe_db);
				} else
					pe_fl = this.pe_bU.pe_EB(pe_fl);
			}
			if (!pe_fl)
				return null;
			if (pe_fl.nodeType == 1
					&& this._oThis.config.pe_iD.InArray(pe_fl.nodeName
							.toLowerCase()) && pe_fl.nodeName != "\x49\x4d\x47")
				pe_TR = pe_fl;
			else if (pe_fl.nodeType == 3 && pe_fl.nodeValue == "\n")
				pe_TR = pe_fl;
			else {
				var pe_ft = this._oThis.getDocument().createElement("\x50");
				var pe_ry = this._oThis.getDocument().createElement("\x50");
				this.pe_bU.pe_asb(pe_fl, pe_ft, pe_ry);
				if (pe_ft.innerHTML != null) {
					this.pe_bU.pe_amB(pe_ft);
					this.pe_bU.pe_Br(pe_ft);
					this.pe_bU.pe_abK(pe_ft, pe_eD, pe_fl);
					pe_TR = pe_ft;
					this.pe_ahR = true;
				}
				delete pe_ry;
			}
		}
		return pe_TR;
	},
	pe_aCM : function() {
		var t = this;
		var pe_Yx = function(pe_aCg, pe_dQ, pe_iQ) {
			if (!pe_dQ)
				return;
			try {
				pe_aCg.insertBefore(pe_dQ, pe_iQ);
				t.pe_ahT = true;
			} catch (exp) {
			}
		};
		for (var i = 0; i < this.pe_MJ.length; i++) {
			var pe_ci = this.pe_MJ[i];
			if (pe_ci && pe_ci.nodeType == 1 && pe_ci.nodeName == "\x4c\x49") {
				if (this.pe_aeX(pe_ci)) {
					var pe_cr = pe_ci.parentNode;
					if (NamoSE.Util.pe_ff(pe_cr.firstChild) == pe_ci)
						pe_Yx(pe_cr.parentNode, pe_ci, pe_cr);
					else if (NamoSE.Util.pe_ff(pe_cr.lastChild,
							"\x70\x65\x5f\x70\x5a") == pe_ci)
						pe_Yx(pe_cr.parentNode, pe_ci, pe_cr.nextSibling);
					else {
						var pe_Ec, pe_agb;
						pe_agb = this._oThis.getDocument().createElement(
								pe_cr.nodeName);
						while ((pe_Ec = pe_ci.nextSibling))
							pe_agb.appendChild(pe_cr.removeChild(pe_Ec));
						pe_Yx(pe_cr.parentNode, pe_ci, pe_cr.nextSibling);
						pe_Yx(pe_cr.parentNode, pe_agb, pe_ci.nextSibling);
					}
					if (!NamoSE.Util.pe_ff(pe_cr.firstChild))
						pe_cr.parentNode.removeChild(pe_cr);
				}
			}
		}
	},
	pe_aeX : function(liObj) {
		var pe_da = false;
		if (!liObj)
			return pe_da;
		var pe_asv = [ "\x4f\x4c", "\x55\x4c" ];
		var pe_cr = liObj.parentNode;
		if (pe_cr && pe_cr.nodeType == 1 && pe_asv.InArray(pe_cr.nodeName))
			if (pe_cr.parentNode && pe_cr.parentNode.nodeType == 1
					&& pe_asv.InArray(pe_cr.parentNode.nodeName))
				pe_da = true;
		return pe_da;
	},
	pe_ajw : function(pe_ZU) {
		var pe_da = false;
		if (!pe_ZU)
			return pe_da;
		if (pe_ZU.firstChild) {
			var pe_ee = NamoSE.Util.pe_ff(pe_ZU.firstChild);
			if (pe_ee.nodeType == 1
					&& [ "\x4f\x4c", "\x55\x4c" ].InArray(pe_ee.nodeName)
					&& pe_ee == NamoSE.Util.pe_ff(pe_ZU.lastChild,
							"\x70\x65\x5f\x70\x5a"))
				pe_da = true;
		}
		return pe_da;
	}
};
var pe_aFG = {
	_oThis : null,
	pe_bU : null,
	pe_afH : null,
	pe_MP : false,
	pe_eU : [],
	pe_iM : {},
	pe_lQ : [],
	pe_Tt : [],
	pe_Jk : [],
	pe_aks : [ '\x73\x61\x76\x65\x61\x73', '\x69\x6d\x61\x67\x65',
			'\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x69\x6d\x61\x67\x65',
			'\x66\x6c\x61\x73\x68' ],
	pe_aGx : {
		'\x74\x64' : [
				'\x74\x61\x62\x6c\x65\x72\x6f\x77\x69\x6e\x73\x65\x72\x74',
				'\x74\x61\x62\x6c\x65\x72\x6f\x77\x64\x65\x6c\x65\x74\x65',
				'\x74\x61\x62\x6c\x65\x63\x6f\x6c\x75\x6d\x6e\x69\x6e\x73\x65\x72\x74',
				'\x74\x61\x62\x6c\x65\x63\x6f\x6c\x75\x6d\x6e\x64\x65\x6c\x65\x74\x65',
				'\x74\x61\x62\x6c\x65\x63\x65\x6c\x6c\x6d\x65\x72\x67\x65',
				'\x74\x61\x62\x6c\x65\x63\x65\x6c\x6c\x73\x70\x6c\x69\x74',
				'\x74\x61\x62\x6c\x65\x63\x65\x6c\x6c\x61\x74\x74\x72\x69\x62\x75\x74\x65',
				'\x74\x61\x62\x6c\x65\x6c\x6f\x63\x6b',
				'\x63\x65\x6c\x6c\x6c\x6f\x63\x6b' ],
		'\x68\x69\x73\x74\x6f\x72\x79' : [ '\x75\x6e\x64\x6f',
				'\x72\x65\x64\x6f' ],
		'\x64\x69\x76' : [ '\x6d\x6f\x76\x65\x66\x6f\x72\x77\x61\x72\x64',
				'\x6d\x6f\x76\x65\x62\x61\x63\x6b\x77\x61\x72\x64' ]
	},
	pe_wj : [],
	pe_akt : {
		'\x74\x61\x62\x6c\x65' : [
				'\x74\x61\x62\x6c\x65\x69\x6e\x73\x65\x72\x74',
				'\x74\x61\x62\x6c\x65\x64\x72\x61\x67\x69\x6e\x73\x65\x72\x74' ],
		'\x69\x6d\x67' : [ '\x69\x6d\x61\x67\x65',
				'\x68\x79\x70\x65\x72\x6c\x69\x6e\x6b',
				'\x70\x68\x6f\x74\x6f\x65\x64\x69\x74\x6f\x72' ],
		'\x68\x72' : [],
		'\x65\x6d\x62\x65\x64' : [ '\x66\x6c\x61\x73\x68' ],
		'\x6f\x62\x6a\x65\x63\x74' : [ '\x66\x6c\x61\x73\x68' ],
		'\x69\x6e\x70\x75\x74' : [],
		'\x73\x65\x6c\x65\x63\x74' : [],
		'\x74\x65\x78\x74\x61\x72\x65\x61' : [],
		'\x64\x69\x76' : [ '\x6d\x6f\x76\x65\x66\x6f\x72\x77\x61\x72\x64',
				'\x6d\x6f\x76\x65\x62\x61\x63\x6b\x77\x61\x72\x64',
				'\x69\x6e\x73\x65\x72\x74\x6c\x61\x79\x65\x72' ]
	},
	pe_Ts : {
		'\x62' : '\x62\x6f\x6c\x64',
		'\x73\x74\x72\x6f\x6e\x67' : '\x62\x6f\x6c\x64',
		'\x65\x6d' : '\x69\x74\x61\x6c\x69\x63',
		'\x69' : '\x69\x74\x61\x6c\x69\x63',
		'\x75' : '\x75\x6e\x64\x65\x72\x6c\x69\x6e\x65',
		'\x73\x74\x72\x69\x6b\x65' : '\x73\x74\x72\x69\x6b\x65\x74\x68\x72\x6f\x75\x67\x68',
		'\x73' : '\x73\x74\x72\x69\x6b\x65\x74\x68\x72\x6f\x75\x67\x68',
		'\x73\x75\x62' : '\x73\x75\x62\x73\x63\x72\x69\x70\x74',
		'\x73\x75\x70' : '\x73\x75\x70\x65\x72\x73\x63\x72\x69\x70\x74'
	},
	pe_CG : [ '\x66\x6f\x6e\x74\x46\x61\x6d\x69\x6c\x79',
			'\x66\x6f\x6e\x74\x53\x69\x7a\x65',
			'\x66\x6f\x6e\x74\x57\x65\x69\x67\x68\x74',
			'\x66\x6f\x6e\x74\x53\x74\x79\x6c\x65',
			'\x74\x65\x78\x74\x44\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e' ],
	pe_Ep : {
		'\x62\x6f\x6c\x64' : '\x62\x6f\x6c\x64',
		'\x69\x74\x61\x6c\x69\x63' : '\x69\x74\x61\x6c\x69\x63',
		'\x75\x6e\x64\x65\x72\x6c\x69\x6e\x65' : '\x75\x6e\x64\x65\x72\x6c\x69\x6e\x65',
		'\x6c\x69\x6e\x65\x2d\x74\x68\x72\x6f\x75\x67\x68' : '\x73\x74\x72\x69\x6b\x65\x74\x68\x72\x6f\x75\x67\x68'
	},
	pe_SX : {
		'\x6c\x65\x66\x74' : '\x6a\x75\x73\x74\x69\x66\x79\x6c\x65\x66\x74',
		'\x63\x65\x6e\x74\x65\x72' : '\x6a\x75\x73\x74\x69\x66\x79\x63\x65\x6e\x74\x65\x72',
		'\x72\x69\x67\x68\x74' : '\x6a\x75\x73\x74\x69\x66\x79\x72\x69\x67\x68\x74',
		'\x6a\x75\x73\x74\x69\x66\x79' : '\x6a\x75\x73\x74\x69\x66\x79\x66\x75\x6c\x6c'
	},
	pe_aGR : {
		'\x75\x6c' : '\x6d\x61\x72\x6b\x73\x65\x74',
		'\x6f\x6c' : '\x6e\x75\x6d\x62\x65\x72\x73\x65\x74'
	},
	pe_anj : {
		'\x6c\x74\x72' : '\x64\x69\x72\x6c\x74\x72',
		'\x72\x74\x6c' : '\x64\x69\x72\x72\x74\x6c'
	},
	init : function() {
		this.pe_MP = false;
		this.pe_lQ = [];
		this.pe_Tt = [];
		this.pe_Jk = [];
		this.pe_eU = [];
		this.pe_iM = {
			'\x66\x6f\x6e\x74\x6e\x61\x6d\x65' : null,
			'\x70\x65\x5f\x61\x68\x65' : null,
			'\x66\x6f\x6e\x74\x73\x69\x7a\x65' : null,
			'\x6c\x69\x6e\x65\x68\x65\x69\x67\x68\x74' : null
		};
		this.pe_kr = {
			'\x62\x6f\x6c\x64' : null,
			'\x69\x74\x61\x6c\x69\x63' : null,
			'\x75\x6e\x64\x65\x72\x6c\x69\x6e\x65' : null,
			'\x73\x74\x72\x69\x6b\x65\x74\x68\x72\x6f\x75\x67\x68' : null
		};
		this.pe_wj = [ '\x6e\x65\x77\x64\x6f\x63', '\x73\x61\x76\x65\x61\x73',
				'\x70\x72\x69\x6e\x74', '\x75\x6e\x64\x6f', '\x72\x65\x64\x6f',
				'\x63\x75\x74', '\x63\x6f\x70\x79', '\x70\x61\x73\x74\x65',
				'\x70\x61\x73\x74\x65\x74\x65\x78\x74',
				'\x73\x65\x61\x72\x63\x68', '\x72\x65\x70\x6c\x61\x63\x65',
				'\x73\x65\x6c\x65\x63\x74\x61\x6c\x6c',
				'\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e',
				'\x6a\x75\x73\x74\x69\x66\x79\x6c\x65\x66\x74',
				'\x6a\x75\x73\x74\x69\x66\x79\x63\x65\x6e\x74\x65\x72',
				'\x6a\x75\x73\x74\x69\x66\x79\x72\x69\x67\x68\x74',
				'\x6a\x75\x73\x74\x69\x66\x79\x66\x75\x6c\x6c',
				'\x66\x6f\x72\x6d\x61\x74\x62\x6c\x6f\x63\x6b' ];
		this.pe_bU = this._oThis
				.getFunctionals('\x6c\x69\x6e\x65\x73\x74\x79\x6c\x65');
		this.pe_bU.init();
		this.pe_afH = this._oThis
				.getFunctionals('\x66\x6f\x72\x6d\x61\x74\x62\x6c\x6f\x63\x6b');
	},
	start : function(pe_TV) {
		var pe_bC;
		var startContainer = null;
		var endContainer = null;
		this.init();
		if (pe_TV) {
			pe_bC = pe_TV;
		} else {
			if (agentInfo.IsIE) {
				if (this._oThis.pe_hv != ""
						&& (this._oThis.config.pe_uL.InArray(this._oThis.pe_hv) || this._oThis.config.pe_Db
								.InArray(this._oThis.pe_hv))) {
					this._oThis.pe_dy().focus();
				}
			} else {
				if (!agentInfo.IsIE11) {
					this._oThis.pe_dy().focus();
				}
			}
			pe_bC = this._oThis.getSelection();
			var sel, range;
			try {
				sel = pe_bC.sel = pe_bC.getSelection();
				range = pe_bC.range = pe_bC.pe_bY();
			} catch (e) {
				try {
					pe_bC.pe_jX(true);
					sel = pe_bC.sel = pe_bC.getSelection();
					range = pe_bC.range = pe_bC.pe_bY();
				} catch (exp) {
					return;
				}
			}
		}
		var pe_VW = false;
		if (agentInfo.IsGecko
				&& pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c") {
			var pe_VA = range.startContainer;
			if (pe_VA && [ '\x54\x44', '\x54\x48' ].InArray(pe_VA.nodeName)
					&& this._oThis.pe_bV && this._oThis.pe_bV.length > 0)
				pe_VW = true;
			else if (pe_VA
					&& !this._oThis.config.pe_iD.InArray(pe_VA.nodeName
							.toLowerCase()))
				pe_VW = true;
		}
		if (range && range.startContainer
				&& range.startContainer.nodeName == "\x44\x49\x56") {
			pe_VW = true;
		}
		if (pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c" && !pe_VW) {
			var pe_bG = pe_bC.pe_fJ();
			if (pe_bG == null)
				return;
			this.pe_atv();
			this.pe_ajv("\x43\x4f\x4e\x54\x52\x4f\x4c");
			var pe_RF = null;
			var pe_azQ = [ '\x68\x72' ];
			if (eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x61\x6b\x74\x2e'
					+ pe_bG.nodeName.toLowerCase())) {
				var pe_TH = "";
				if (pe_bG.nodeName == "\x49\x4d\x47"
						&& pe_bG
								.getAttribute("\x6e\x61\x6d\x6f\x73\x65\x5f\x72\x65\x61\x6c\x74\x79\x70\x65"))
					pe_RF = this._oThis
							.pe_ayb(this._oThis.getDocument(), pe_bG);
				if (pe_RF) {
					pe_TH = pe_RF.pe_aCO;
				} else if (pe_bG.nodeName == "\x49\x4d\x47"
						&& pe_bG
								.getAttribute("\x6e\x61\x6d\x6f\x5f\x6f\x72\x67\x68\x74\x6d\x6c")) {
					pe_TH = "\x65\x6d\x62\x65\x64";
				} else {
					pe_TH = pe_bG.nodeName.toLowerCase();
				}
				var pe_qg = eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x61\x6b\x74\x2e'
						+ pe_TH);
				if (pe_bG.nodeName == "\x54\x41\x42\x4c\x45")
					this.pe_asp(pe_bG, "\x43\x4f\x4e\x54\x52\x4f\x4c", pe_bC);
				if (this.pe_MP) {
					pe_qg = [];
				} else {
					if (pe_azQ.InArray(pe_bG.nodeName.toLowerCase()))
						this.pe_wj.splice(this.pe_wj.length - 4, 4);
					if (pe_bG.nodeName == "\x54\x41\x42\x4c\x45"
							&& pe_bG.getAttribute('\x61\x6c\x69\x67\x6e')) {
						var pe_ako = pe_bG.getAttribute('\x61\x6c\x69\x67\x6e');
						if (pe_ako != "") {
							for ( var key in this.pe_SX) {
								if (key == pe_ako.toLowerCase()) {
									this.pe_eU.push(this.pe_SX[key]);
									break;
								}
							}
						}
					}
				}
				var pe_nT = NamoSE.Util.pe_WX(this._oThis.getDocument(), pe_bG);
				var pe_akq = "";
				if (pe_bG.attributes
						&& pe_bG
								.getAttribute('\x69\x6d\x61\x67\x65\x4b\x69\x6e\x64')) {
					if (pe_bG
							.getAttribute('\x69\x6d\x61\x67\x65\x4b\x69\x6e\x64') == "\x66\x6c\x61\x73\x68") {
						pe_akq = "\x66\x6c\x61\x73\x68";
					}
				}
				var pe_asX = false;
				var pe_asZ = false;
				if (pe_qg && pe_qg.length) {
					for (var i = 0; i < pe_qg.length; i++) {
						if (pe_qg[i] && pe_qg[i] == "\x66\x6c\x61\x73\x68") {
							pe_asZ = true;
						}
					}
				}
				if (pe_akq == "\x66\x6c\x61\x73\x68") {
					if (pe_asZ == false) {
						pe_qg.push("\x66\x6c\x61\x73\x68");
					}
					pe_asX = true;
				}
				for (var k = 0; k < pe_qg.length; k++) {
					if (pe_qg[k] == "\x66\x6c\x61\x73\x68") {
						if (!pe_asX) {
							if (!((pe_nT && pe_nT == "\x73\x77\x66")
									|| (pe_RF && pe_RF.pe_aCN == "\x66\x6c\x61\x73\x68") || (pe_bG.nodeName == "\x49\x4d\x47" && pe_bG
									.getAttribute("\x6e\x61\x6d\x6f\x5f\x6f\x72\x67\x68\x74\x6d\x6c"))))
								continue;
						}
					} else if (pe_qg[k] == "\x70\x68\x6f\x74\x6f\x65\x64\x69\x74\x6f\x72") {
						var pe_Ju = this._oThis.pe_ard(pe_bG.src);
						if (!pe_Ju)
							continue;
					}
					this.pe_wj.push(pe_qg[k])
				}
				this.pe_ame(this.pe_wj);
				if ((agentInfo.IsIE || agentInfo.IsIE11)
						&& pe_bG.nodeName == "\x44\x49\x56") {
					NamoSE.Util
							.pe_bO(
									function() {
										var pe_Yo;
										if (t && t._oThis
												&& t._oThis.getSelection) {
											pe_Yo = t._oThis;
										} else if (this && t
												&& this.t.getSelection) {
											pe_Yo = this.t;
										} else {
											return;
										}
										pe_bC = pe_Yo.getSelection();
										var sel, range;
										try {
											sel = pe_bC.sel = pe_bC
													.getSelection();
											range = pe_bC.range = pe_bC.pe_bY();
										} catch (e) {
											try {
												pe_bC.pe_jX(true);
												sel = pe_bC.sel = pe_bC
														.getSelection();
												range = pe_bC.range = pe_bC
														.pe_bY();
											} catch (exp) {
												return;
											}
										}
										if (pe_bC.pe_dV() != "\x43\x6f\x6e\x74\x72\x6f\x6c") {
											var pe_bU = pe_Yo
													.getFunctionals('\x73\x74\x61\x74\x75\x73\x68\x69\x67\x68\x6c\x69\x67\x68\x74');
											pe_bU.start();
										}
									}, 1000);
				}
			}
		} else {
			var pe_azJ = this.pe_aDp(pe_bC);
			this.pe_ajv("\x54\x45\x58\x54");
			this.pe_atv();
			if (this.pe_MP) {
				this.pe_ame(this.pe_wj);
				return;
			}
			var pe_ca = pe_bC.pe_nn();
			if (!agentInfo.IsIE) {
				if (range.startContainer && range.startContainer.nodeType == 1)
					pe_ca = range.startContainer;
			}
			if (!pe_azJ) {
				while (pe_ca) {
					var pe_aiT = this.pe_afH.pe_adR(pe_ca);
					if (pe_aiT && this.pe_afH.pe_adu(pe_aiT))
						this.pe_iM["\x66\x6f\x72\x6d\x61\x74\x62\x6c\x6f\x63\x6b"] = pe_aiT.nodeName
								.toLowerCase();
					if (this._oThis.config.pe_pp.InArray(pe_ca.nodeName
							.toLowerCase())) {
						if (pe_ca.getAttribute('\x73\x74\x79\x6c\x65') != null) {
							this.pe_asy(pe_ca);
						}
						for ( var key in this.pe_Ts) {
							if (key == pe_ca.nodeName.toLowerCase()) {
								try {
									if (!this.pe_kr[this.pe_Ts[key]]) {
										this.pe_eU.push(this.pe_Ts[key]);
										this.pe_kr[this.pe_Ts[key]] = key;
									}
								} catch (exp) {
								}
								break;
							}
						}
						if (pe_ca.nodeName == "\x46\x4f\x4e\x54") {
							var pe_tn = "";
							if (pe_ca.getAttribute('\x66\x61\x63\x65')) {
								pe_tn = pe_ca.face;
								if (pe_tn && pe_tn != ""
										&& !this.pe_iM.fontname)
									this.pe_iM.pe_ahe = pe_tn;
								this.pe_iM.fontname = pe_N(pe_tn);
							}
							if (pe_ca.getAttribute('\x73\x69\x7a\x65')) {
								pe_tn = pe_ca.size;
								if (pe_tn && pe_tn != ""
										&& !this.pe_iM.fontsize)
									this.pe_iM.fontsize = pe_be(pe_tn);
							}
						}
					}
					if (this._oThis.config.pe_fP.InArray(pe_ca.nodeName
							.toLowerCase())
							|| [ '\x75\x6c', '\x6f\x6c' ]
									.InArray(pe_ca.nodeName.toLowerCase())) {
						var pe_OE = "";
						if (pe_ca.style.textAlign) {
							pe_OE = pe_ca.style.textAlign;
						} else if (pe_ca.getAttribute('\x61\x6c\x69\x67\x6e')) {
							pe_OE = pe_ca.align;
						}
						if (pe_OE && pe_OE != "") {
							for ( var key in this.pe_SX) {
								if (key == pe_OE.toLowerCase()) {
									this.pe_eU.push(this.pe_SX[key]);
									break;
								}
							}
						}
						var pe_SV = "";
						if (pe_ca.dir) {
							pe_SV = pe_ca.dir;
						}
						if (pe_SV && pe_SV != "") {
							for ( var key in this.pe_anj) {
								if (key == pe_SV.toLowerCase()) {
									this.pe_eU.push(this.pe_anj[key]);
									break;
								}
							}
						}
						if (pe_ca.getAttribute('\x73\x74\x79\x6c\x65') != null) {
							this.pe_asy(pe_ca);
						}
						if ([ '\x75\x6c', '\x6f\x6c' ].InArray(pe_ca.nodeName
								.toLowerCase())) {
							this.pe_eU.push(this.pe_aGR[pe_ca.nodeName
									.toLowerCase()]);
						}
					}
					if (this.pe_bU.pe_bU.pe_rk(pe_ca)) {
						if (!(pe_ca.nodeName == "\x44\x49\x56"
								&& pe_ca.parentNode
								&& [ '\x50', '\x4c\x49' ]
										.InArray(pe_ca.parentNode.nodeName) || pe_ca.nodeName == "\x4c\x49")) {
							break;
						}
					}
					pe_ca = pe_ca.parentNode;
				}
			}
			this.pe_aCc();
			var pe_pt = parent.window.CE_OnTxtFormatChangeEvent;
			if (pe_pt) {
				var e = {
					'\x66\x6f\x6e\x74\x66\x61\x6d\x69\x6c\x79' : '',
					'\x66\x6f\x6e\x74\x73\x69\x7a\x65' : '',
					'\x6c\x69\x6e\x65\x68\x65\x69\x67\x68\x74' : '',
					'\x62\x6f\x6c\x64' : '',
					'\x69\x74\x61\x6c\x69\x63' : '',
					'\x75\x6e\x64\x65\x72\x6c\x69\x6e\x65' : '',
					'\x73\x74\x72\x69\x6b\x65\x74\x68\x72\x6f\x75\x67\x68' : '',
					'\x61\x6c\x69\x67\x6e\x6d\x65\x6e\x74' : '',
					'\x6c\x69\x73\x74' : '',
					'\x66\x6f\x72\x6d\x61\x74\x62\x6c\x6f\x63\x6b' : ''
				};
				e.fontfamily = this.pe_iM.pe_ahe;
				e.fontsize = this.pe_iM.fontsize;
				e.lineheight = this.pe_iM.lineheight;
				e.formatblock = this.pe_iM.formatblock;
				e.bold = this.pe_kr.bold;
				e.italic = this.pe_kr.italic;
				e.underline = this.pe_kr.underline;
				e.strikethrough = this.pe_kr.strikethrough;
				for (var i = 0; i < this.pe_eU.length; i++) {
					if ([ '\x6d\x61\x72\x6b\x73\x65\x74',
							'\x6e\x75\x6d\x62\x65\x72\x73\x65\x74' ]
							.InArray(this.pe_eU[i])) {
						e.list = this.pe_eU[i];
					} else if ([
							'\x6a\x75\x73\x74\x69\x66\x79\x6c\x65\x66\x74',
							'\x6a\x75\x73\x74\x69\x66\x79\x63\x65\x6e\x74\x65\x72',
							'\x6a\x75\x73\x74\x69\x66\x79\x72\x69\x67\x68\x74',
							'\x6a\x75\x73\x74\x69\x66\x79',
							'\x6a\x75\x73\x74\x69\x66\x79\x66\x75\x6c\x6c' ]
							.InArray(this.pe_eU[i])) {
						e.alignment = this.pe_eU[i];
					}
				}
				pe_pt(e);
			}
		}
	},
	pe_aDp : function(pe_bC) {
		var pe_afj = false;
		var pe_pP = [];
		var pe_Ma = pe_bC.pe_dG(pe_bC.range.commonAncestorContainer
				|| pe_bC.range.parentElement(), '\x54\x41\x42\x4c\x45');
		if (pe_Ma && pe_Ma.nodeType == 1
				&& pe_Ma.nodeName == "\x54\x41\x42\x4c\x45") {
			this.pe_asp(pe_Ma, "\x54\x45\x58\x54", pe_bC);
			if (!this.pe_MP) {
				this.pe_Tt.push("\x74\x64");
				var pe_aaA = false;
				if (this._oThis.pe_bV && this._oThis.pe_bV.length > 1) {
					pe_pP = [
							'\x63\x75\x74',
							'\x63\x6f\x70\x79',
							'\x70\x61\x73\x74\x65',
							'\x68\x79\x70\x65\x72\x6c\x69\x6e\x6b',
							'\x69\x6e\x73\x65\x72\x74\x68\x6f\x72\x69\x7a\x6f\x6e\x74\x61\x6c\x72\x75\x6c\x65',
							'\x69\x6d\x61\x67\x65',
							'\x70\x68\x6f\x74\x6f\x65\x64\x69\x74\x6f\x72',
							'\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x69\x6d\x61\x67\x65',
							'\x66\x6c\x61\x73\x68',
							'\x73\x70\x65\x63\x69\x61\x6c\x63\x68\x61\x72\x73',
							'\x65\x6d\x6f\x74\x69\x63\x6f\x6e',
							'\x74\x61\x62\x6c\x65\x72\x6f\x77\x69\x6e\x73\x65\x72\x74',
							'\x74\x61\x62\x6c\x65\x63\x6f\x6c\x75\x6d\x6e\x69\x6e\x73\x65\x72\x74',
							'\x74\x61\x62\x6c\x65\x72\x6f\x77\x64\x65\x6c\x65\x74\x65',
							'\x74\x61\x62\x6c\x65\x63\x6f\x6c\x75\x6d\x6e\x64\x65\x6c\x65\x74\x65',
							'\x74\x61\x62\x6c\x65\x63\x65\x6c\x6c\x73\x70\x6c\x69\x74' ];
					pe_afj = true;
					pe_aaA = true;
				} else if (this._oThis.pe_bV && this._oThis.pe_bV.length == 1) {
					pe_pP = [
							'\x63\x75\x74',
							'\x63\x6f\x70\x79',
							'\x70\x61\x73\x74\x65',
							'\x68\x79\x70\x65\x72\x6c\x69\x6e\x6b',
							'\x69\x6e\x73\x65\x72\x74\x68\x6f\x72\x69\x7a\x6f\x6e\x74\x61\x6c\x72\x75\x6c\x65',
							'\x69\x6d\x61\x67\x65',
							'\x70\x68\x6f\x74\x6f\x65\x64\x69\x74\x6f\x72',
							'\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x69\x6d\x61\x67\x65',
							'\x66\x6c\x61\x73\x68',
							'\x73\x70\x65\x63\x69\x61\x6c\x63\x68\x61\x72\x73',
							'\x65\x6d\x6f\x74\x69\x63\x6f\x6e',
							'\x74\x61\x62\x6c\x65\x63\x65\x6c\x6c\x6d\x65\x72\x67\x65' ];
					pe_afj = true;
					pe_aaA = true;
				} else {
					pe_pP = [ '\x74\x61\x62\x6c\x65\x63\x65\x6c\x6c\x6d\x65\x72\x67\x65' ];
				}
				if (pe_pP.length > 0)
					this.pe_lQ = this.pe_lQ.concat(pe_pP);
				if (pe_aaA && this._oThis.pe_Wk && this._oThis.pe_Wk.length > 0) {
					var pe_mQ = [];
					var pe_LS = this._oThis.pe_Wk;
					for (var i = 0; i < pe_LS.length; i++) {
						if (pe_LS[i]
								&& pe_LS[i] != ""
								&& pe_LS[i].substring(0, 9) == "\x75\x73\x65\x72\x6d\x65\x6e\x75\x5f") {
							pe_mQ.push(pe_LS[i]);
						}
					}
					if (pe_mQ.length > 0)
						this.pe_lQ = this.pe_lQ.concat(pe_mQ);
				}
				if ((this._oThis.pe_rK("\x6d\x61\x6e\x61\x67\x65\x72") || this._oThis
						.pe_rK("\x74\x65\x73\x74\x5f\x6d\x61\x6e\x61\x67\x65\x72"))) {
					if (this._oThis
							.pe_hO(
									pe_Ma,
									"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b\x5f\x6e\x6f\x4c\x69\x63\x65\x6e\x73\x65")) {
						this.pe_lQ.push('\x63\x65\x6c\x6c\x6c\x6f\x63\x6b');
						this.pe_eU.push('\x74\x61\x62\x6c\x65\x6c\x6f\x63\x6b');
					} else {
						var pe_lK = pe_bC.pe_dG(
								pe_bC.range.commonAncestorContainer
										|| pe_bC.range.parentElement(), [
										'\x54\x44', '\x54\x48' ]);
						if (pe_lK
								&& [ '\x54\x44', '\x54\x48' ]
										.InArray(pe_lK.nodeName)
								&& this._oThis
										.pe_hO(
												pe_lK,
												"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b\x5f\x6e\x6f\x4c\x69\x63\x65\x6e\x73\x65")) {
							if (!(this._oThis.pe_bV && this._oThis.pe_bV.length > 1))
								this.pe_eU
										.push('\x63\x65\x6c\x6c\x6c\x6f\x63\x6b');
						}
					}
				}
			}
		}
		if (document.location.protocol == '\x66\x69\x6c\x65\x3a') {
			pe_pP = this.pe_aks;
			for (var j = 0; j < pe_pP.length; j++) {
				if (!this.pe_lQ.InArray(pe_pP[j])) {
					this.pe_lQ.push(pe_pP[j]);
				}
			}
		}
		return pe_afj;
	},
	pe_asp : function(pe_ci, pe_kP, pe_bC) {
		if (typeof pe_kP == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_kP = "\x54\x45\x58\x54";
		var pe_pP = [ '\x63\x75\x74', '\x63\x6f\x70\x79',
				'\x70\x61\x73\x74\x65' ];
		var pe_fg = this._oThis.pe_hO(pe_ci,
				"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b");
		if (!pe_fg && pe_kP == "\x54\x45\x58\x54") {
			var pe_Oo = (pe_bC.range.commonAncestorContainer || pe_bC.range
					.parentElement());
			if (agentInfo.IsIE
					&& parseInt(pe_cm) < 9
					&& !(this._oThis.pe_rK("\x6d\x61\x6e\x61\x67\x65\x72") || this._oThis
							.pe_rK("\x74\x65\x73\x74\x5f\x6d\x61\x6e\x61\x67\x65\x72"))) {
				if (pe_Oo && pe_Oo.nodeType == 1
						&& pe_Oo.nodeName == "\x54\x52") {
					var pe_LQ = NamoSE.Util
							.pe_Oa(
									pe_Oo,
									'\x74\x64',
									[ '\x6e\x61\x6d\x6f\x5f\x6c\x6f\x63\x6b',
											'\x6d\x61\x6e\x61\x67\x65\x72\x5f\x6d\x6f\x64\x65' ],
									'\x41\x74\x74\x72\x68\x61\x73');
					if (pe_LQ && pe_LQ.length > 0)
						pe_fg = true;
					if (!pe_fg) {
						var pe_LM = NamoSE.Util
								.pe_Oa(
										pe_Oo,
										'\x74\x68',
										[
												'\x6e\x61\x6d\x6f\x5f\x6c\x6f\x63\x6b',
												'\x6d\x61\x6e\x61\x67\x65\x72\x5f\x6d\x6f\x64\x65' ],
										'\x41\x74\x74\x72\x68\x61\x73');
						if (pe_LM && pe_LM.length > 0)
							pe_fg = true;
					}
				}
			} else {
				pe_fg = this._oThis.pe_Ne(pe_ci, pe_bC);
			}
		}
		if (pe_fg) {
			this.pe_wj.splice(this.pe_wj.length - 4, 4);
			this.pe_lQ = this.pe_lQ.concat(pe_pP);
		}
		this.pe_MP = pe_fg;
	},
	pe_atv : function() {
		if (this._oThis.pe_rR) {
			if (this._oThis._historyStackIdx <= 0) {
				var pe_NI = false;
				if (this._oThis._historyStackIdx == 0) {
					var pe_bU = this._oThis
							.getFunctionals('\x68\x69\x73\x74\x6f\x72\x79\x69\x6e\x76\x65\x6e\x74\x6f\x72\x79');
					if (pe_bU.pe_ash())
						pe_NI = true;
				} else {
					pe_NI = true;
				}
				if (pe_NI)
					this.pe_lQ.push('\x75\x6e\x64\x6f');
			}
			if (this._oThis._historyStackIdx >= this._oThis.pe_iB.length - 1)
				this.pe_lQ.push('\x72\x65\x64\x6f');
		}
	},
	pe_ajv : function(pe_kP) {
		if (this._oThis.pe_fU) {
			var pe_ahk = this._oThis.pe_fU;
			for ( var key in pe_ahk) {
				if (pe_ahk[key] && pe_ahk[key].length > 0) {
					this.pe_Jk.push(key);
				}
			}
			if (pe_kP == "\x54\x45\x58\x54" && this.pe_Jk.length > 0)
				this.pe_eU = this.pe_eU.concat(this.pe_Jk);
		}
	},
	pe_asy : function(node) {
		if (typeof node == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		if (node.getAttribute('\x73\x74\x79\x6c\x65') != null) {
			var pe_ga = "";
			var pe_GF;
			for (var i = 0; i < this.pe_CG.length; i++) {
				pe_ga = "";
				switch (this.pe_CG[i]) {
				case '\x66\x6f\x6e\x74\x46\x61\x6d\x69\x6c\x79':
					pe_ga = node.style.fontFamily;
					if (agentInfo.IsOpera && node.currentStyle)
						node.currentStyle['\x66\x6f\x6e\x74\x46\x61\x6d\x69\x6c\x79'];
					break;
				case '\x66\x6f\x6e\x74\x53\x69\x7a\x65':
					pe_ga = node.style.fontSize;
					if (agentInfo.IsOpera && node.currentStyle)
						node.currentStyle['\x66\x6f\x6e\x74\x53\x69\x7a\x65'];
					break;
				case '\x66\x6f\x6e\x74\x57\x65\x69\x67\x68\x74':
					if (this.pe_kr.bold && this.pe_kr.bold != "")
						continue;
					pe_ga = node.style.fontWeight;
					if ([ '\x36\x30\x30', '\x37\x30\x30', '\x38\x30\x30',
							'\x39\x30\x30' ].InArray(pe_ga)
							|| pe_ga == "\x62\x6f\x6c\x64\x65\x72")
						pe_ga = "\x62\x6f\x6c\x64";
					break;
				case '\x66\x6f\x6e\x74\x53\x74\x79\x6c\x65':
					if (this.pe_kr.italic && this.pe_kr.italic != "")
						continue;
					pe_ga = node.style.fontStyle;
					if (pe_ga == "\x6f\x62\x6c\x69\x71\x75\x65")
						pe_ga = "\x69\x74\x61\x6c\x69\x63";
					break;
				case '\x74\x65\x78\x74\x44\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e':
					if (this.pe_kr.underline && this.pe_kr.underline != ""
							&& this.pe_kr.strikethrough
							&& this.pe_kr.strikethrough != "")
						continue;
					pe_ga = node.style.textDecoration;
					break;
				}
				if (pe_ga && pe_ga != "") {
					if (this.pe_CG[i] == "\x66\x6f\x6e\x74\x46\x61\x6d\x69\x6c\x79") {
						if (pe_ga && pe_ga != "" && !this.pe_iM.fontname)
							this.pe_iM.pe_ahe = pe_ga;
						this.pe_iM.fontname = pe_N(pe_ga);
					} else if (this.pe_CG[i] == "\x66\x6f\x6e\x74\x53\x69\x7a\x65") {
						if (pe_ga && pe_ga != "" && !this.pe_iM.fontsize)
							this.pe_iM.fontsize = pe_ak(pe_ga);
					} else if (this.pe_CG[i] == "\x74\x65\x78\x74\x44\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e") {
						pe_GF = pe_ga.split("\x20");
						for (var z = 0; z < pe_GF.length; z++) {
							if (pe_GF[z] != "") {
								pe_GF[z] = pe_GF[z].replace("\x2c", "");
								for ( var key in this.pe_Ep) {
									if (key == pe_GF[z].toLowerCase()) {
										try {
											if (!this.pe_kr[this.pe_Ep[key]]) {
												this.pe_eU
														.push(this.pe_Ep[key]);
												this.pe_kr[this.pe_Ep[key]] = key;
											}
										} catch (exp) {
										}
										break;
									}
								}
							}
						}
					} else {
						if (this.pe_CG[i] == "\x66\x6f\x6e\x74\x57\x65\x69\x67\x68\x74") {
							this.pe_kr.bold = pe_ga.toLowerCase();
						} else if (this.pe_CG[i] == "\x66\x6f\x6e\x74\x53\x74\x79\x6c\x65") {
							this.pe_kr.italic = pe_ga.toLowerCase();
						}
						for ( var key in this.pe_Ep) {
							if (key == pe_ga.toLowerCase()) {
								this.pe_eU.push(this.pe_Ep[key]);
								break;
							}
						}
					}
				}
			}
			if (this._oThis.config.pe_fP.InArray(node.nodeName.toLowerCase())) {
				pe_ga = node.style.lineHeight;
				if (pe_ga && pe_ga != "") {
					if (String(pe_ga).indexOf("\x25") != -1) {
						this.pe_iM.lineheight = pe_ga.Trim();
					} else {
						this.pe_iM.lineheight = pe_ga;
					}
				}
			}
		}
	},
	pe_aCc : function() {
		var pe_acr = [];
		var pe_IF = [];
		var pe_apK = [];
		var pe_Ii;
		if (!agentInfo.IsIE && !agentInfo.IsIE11) {
			var pe_bC = this._oThis.getSelection();
			var sel, range;
			try {
				sel = pe_bC.sel = pe_bC.getSelection();
				range = pe_bC.range = pe_bC.pe_bY();
			} catch (e) {
				try {
					pe_bC.pe_jX(true);
					sel = pe_bC.sel = pe_bC.getSelection();
					range = pe_bC.range = pe_bC.pe_bY();
				} catch (exp) {
					return;
				}
			}
			var pe_bK = pe_bC.sel.anchorNode;
			while (pe_bK && pe_bK.nodeName != "\x44\x49\x56") {
				pe_bK = pe_bK.parentNode;
				if (pe_bK && pe_bK.nodeName == "\x42\x4f\x44\x59") {
					break;
				}
			}
			if (pe_bK && pe_bK.nodeName == '\x44\x49\x56') {
				pe_Ii = [ '\x74\x64' ];
			} else {
				pe_Ii = [ '\x74\x64', '\x64\x69\x76' ];
			}
		} else {
			pe_Ii = [ '\x74\x64', '\x64\x69\x76' ];
		}
		for (var k = 0; k < pe_Ii.length; k++) {
			pe_acr = eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x61\x47\x78\x2e'
					+ pe_Ii[k]);
			if (pe_acr) {
				if (this.pe_Tt.length > 0 && this.pe_Tt.InArray(pe_Ii[k])) {
					continue;
				} else {
					pe_IF = pe_IF.concat(pe_acr);
				}
			}
		}
		if (this._oThis.pe_hj == "\x77\x79\x73\x69\x77\x79\x67"
				&& (this._oThis.pe_Op == "\x68\x74\x6d\x6c" || this._oThis.pe_Op == "\x70\x72\x65\x76\x69\x65\x77")) {
			this.pe_lQ.push('\x75\x6e\x64\x6f');
		}
		if (this.pe_lQ.length > 0)
			pe_IF = pe_IF.concat(this.pe_lQ);
		var pe_ck = this._oThis.util.pe_bP(this._oThis.pe_eR, "\x69\x6d\x67");
		if (this._oThis.params.DisableToolbarButtons) {
			pe_apK = this._oThis.params.DisableToolbarButtons;
		}
		for (var i = 0; i < pe_ck.length; i++) {
			if (pe_ck[i].id == "\x73\x70\x61\x63\x65\x62\x61\x72"
					|| pe_ck[i].id == "\x73\x70\x61\x63\x65")
				continue;
			var pe_age = false;
			var pe_gb = pe_ck[i].parentNode.parentNode;
			if (!agentInfo.IsIE
					&& !agentInfo.IsIE11
					&& pe_ck[i].id == "\x73\x70\x65\x6c\x6c\x63\x68\x65\x63\x6b\x65\x72") {
				pe_ck[i].setAttribute('\x73\x74\x61\x74\x75\x73',
						'\x64\x69\x73\x61\x62\x6c\x65');
				pe_gb.className = '\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e\x5f\x6f\x66\x66';
				continue;
			}
			if (this._oThis.pe_pz() != '\x64\x69\x73\x61\x62\x6c\x65') {
				if (pe_ck[i].id == '\x74\x61\x62\x6c\x65\x64\x72\x61\x67\x69\x6e\x73\x65\x72\x74') {
					pe_ck[i].setAttribute('\x73\x74\x61\x74\x75\x73',
							'\x64\x69\x73\x61\x62\x6c\x65');
					pe_gb.className = '\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e\x5f\x6f\x66\x66';
					continue;
				}
			}
			if (pe_IF.length > 0) {
				if (pe_IF.InArray(pe_ck[i].id) || pe_apK.InArray(pe_ck[i].id)) {
					pe_age = true;
				} else {
					pe_age = false;
				}
			}
			if (pe_age) {
				if (pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x64\x69\x73\x61\x62\x6c\x65'
						&& pe_gb.className == "\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e\x5f\x6f\x66\x66")
					continue;
				if (pe_gb.tagName.toLowerCase() == "\x73\x70\x61\x6e")
					pe_gb.className = "\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e\x5f\x6f\x66\x66";
				pe_ck[i].setAttribute("\x73\x74\x61\x74\x75\x73",
						"\x64\x69\x73\x61\x62\x6c\x65");
				NamoSE.pe_dn.pe_uo(pe_ck[i]);
				this._oThis.util.pe_Qr(pe_ck[i]);
				continue;
			} else if (agentInfo.IsChrome || agentInfo.IsSafari) {
				pe_ck[i]
						.setAttribute("\x74\x61\x62\x69\x6e\x64\x65\x78", i + 1);
			}
			if (pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == "\x64\x69\x73\x61\x62\x6c\x65")
				pe_ck[i].setAttribute("\x73\x74\x61\x74\x75\x73",
						"\x64\x65\x66\x61\x75\x6c\x74");
			if (this.pe_eU.InArray(pe_ck[i].id)) {
				if (pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x61\x63\x74\x69\x76\x65')
					continue;
				var doc = null;
				if (this._oThis.params.IsSpliteToolbar) {
					try {
						doc = this._oThis.params.SpliteToolbarEle.ownerDocument;
					} catch (e) {
						doc = document;
					}
				} else {
					doc = document;
				}
				NamoSE.pe_dn.pe_acY(pe_ck[i], doc);
			} else {
				if (this._oThis.pe_hv == pe_ck[i].id
						&& pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x61\x63\x74\x69\x76\x65'
						&& NamoSE.pe_cy.pe_uL.InArray(pe_ck[i].id))
					continue;
				if (pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x64\x65\x66\x61\x75\x6c\x74'
						&& pe_gb.className == "\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e")
					continue;
				NamoSE.pe_dn.pe_uo(pe_ck[i]);
			}
			if (pe_gb.tagName.toLowerCase() == "\x73\x70\x61\x6e")
				pe_gb.className = "\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e";
			this._oThis.util.pe_ep(pe_ck[i]);
		}
		var pe_dS = this._oThis.util.pe_bP(this._oThis.pe_eR,
				"\x73\x65\x6c\x65\x63\x74");
		for (var i = 0; i < pe_dS.length; i++) {
			var pe_nx = pe_dS[i].parentNode;
			if (pe_dS[i].id != "") {
				if (!(pe_dS[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x64\x65\x66\x61\x75\x6c\x74'
						&& pe_nx.className == "\x70\x65\x5f\x72\x51" && pe_dS[i].disabled == false)) {
					if (pe_nx.tagName.toLowerCase() == "\x73\x70\x61\x6e")
						pe_nx.className = "\x70\x65\x5f\x72\x51";
					pe_dS[i].disabled = false;
					if (!agentInfo.IsIE)
						pe_dS[i].style.opacity = "";
					pe_dS[i].setAttribute("\x73\x74\x61\x74\x75\x73",
							"\x64\x65\x66\x61\x75\x6c\x74");
				}
				if (eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x69\x4d\x2e'
						+ pe_dS[i].id)) {
					var pe_da = false;
					for (var k = (pe_dS[i].options.length - 1); k >= 0; k--) {
						var pe_acu = (pe_dS[i].id == "\x66\x6f\x6e\x74\x6e\x61\x6d\x65") ? pe_N(pe_dS[i].options[k].value)
								: pe_dS[i].options[k].value;
						pe_acu = pe_acu.replace(/\s/g, '');
						var pe_aav = String(
								eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x69\x4d\x2e'
										+ pe_dS[i].id)).replace(/\'/g, "");
						pe_aav = pe_aav.replace(/\s/g, '');
						if (pe_aav == pe_acu) {
							pe_da = true;
							break;
						}
					}
					if (pe_da)
						pe_dS[i].selectedIndex = k;
					else
						pe_dS[i].selectedIndex = -1;
				} else {
					pe_dS[i].selectedIndex = 0;
				}
			}
		}
	},
	pe_ame : function(pe_awf) {
		var pe_ck = this._oThis.util.pe_bP(this._oThis.pe_eR, "\x69\x6d\x67");
		for (var i = 0; i < pe_ck.length; i++) {
			if (pe_ck[i].id == "\x73\x70\x61\x63\x65\x62\x61\x72"
					|| pe_ck[i].id == "\x73\x70\x61\x63\x65")
				continue;
			if (this._oThis.pe_hv == pe_ck[i].id
					&& pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x61\x63\x74\x69\x76\x65'
					&& NamoSE.pe_cy.pe_uL.InArray(pe_ck[i].id))
				continue;
			if (this.pe_Jk.InArray(pe_ck[i].id)
					&& pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x61\x63\x74\x69\x76\x65')
				continue;
			if (document.location.protocol == '\x66\x69\x6c\x65\x3a') {
				if (this.pe_aks.InArray(pe_ck[i].id))
					continue;
			}
			var pe_gb = pe_ck[i].parentNode.parentNode;
			NamoSE.pe_dn.pe_uo(pe_ck[i]);
			if (pe_awf.InArray(pe_ck[i].id) && !this.pe_lQ.InArray(pe_ck[i].id)) {
				if (pe_gb.tagName.toLowerCase() == "\x73\x70\x61\x6e")
					pe_gb.className = "\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e";
				pe_ck[i].setAttribute("\x73\x74\x61\x74\x75\x73",
						"\x64\x65\x66\x61\x75\x6c\x74");
				this._oThis.util.pe_ep(pe_ck[i]);
				if (this.pe_eU.InArray(pe_ck[i].id)) {
					if (pe_ck[i].getAttribute('\x73\x74\x61\x74\x75\x73') == '\x61\x63\x74\x69\x76\x65')
						continue;
					NamoSE.pe_dn.pe_acY(pe_ck[i]);
				}
			} else {
				if (pe_gb.tagName.toLowerCase() == "\x73\x70\x61\x6e")
					pe_gb.className = "\x70\x61\x6e\x65\x6c\x62\x75\x74\x74\x6f\x6e\x5f\x73\x70\x61\x6e\x5f\x6f\x66\x66";
				pe_ck[i].setAttribute("\x73\x74\x61\x74\x75\x73",
						"\x64\x69\x73\x61\x62\x6c\x65");
				this._oThis.util.pe_Qr(pe_ck[i]);
			}
		}
		var pe_dS = this._oThis.util.pe_bP(this._oThis.pe_eR,
				"\x73\x65\x6c\x65\x63\x74");
		for (var i = 0; i < pe_dS.length; i++) {
			var pe_nx = pe_dS[i].parentNode;
			if (pe_dS[i].id != "") {
				if (pe_nx.tagName.toLowerCase() == "\x73\x70\x61\x6e")
					pe_nx.className = "\x70\x65\x5f\x61\x62\x46";
				pe_dS[i].disabled = true;
				if (!agentInfo.IsIE)
					pe_dS[i].style.opacity = "\x30\x2e\x33\x30";
				pe_dS[i].setAttribute("\x73\x74\x61\x74\x75\x73",
						"\x64\x69\x73\x61\x62\x6c\x65");
			}
		}
	}
};
var pe_aGz = {
	_oThis : null,
	pe_bU : null,
	pe_CA : null,
	pe_aGJ : null,
	pe_CL : null,
	pe_aGC : null,
	pe_sj : null,
	pe_Ua : null,
	pe_KF : null,
	pe_eU : {
		'\x66\x6f\x6e\x74\x6e\x61\x6d\x65' : [
				'\x66\x6f\x6e\x74\x46\x61\x6d\x69\x6c\x79',
				'\x66\x6f\x6e\x74\x2d\x66\x61\x6d\x69\x6c\x79',
				'\x66\x61\x63\x65' ],
		'\x66\x6f\x6e\x74\x73\x69\x7a\x65' : [
				'\x66\x6f\x6e\x74\x53\x69\x7a\x65',
				'\x66\x6f\x6e\x74\x2d\x73\x69\x7a\x65', '\x73\x69\x7a\x65' ],
		'\x62\x6f\x6c\x64' : [ '\x66\x6f\x6e\x74\x57\x65\x69\x67\x68\x74',
				'\x66\x6f\x6e\x74\x2d\x77\x65\x69\x67\x68\x74', '' ],
		'\x69\x74\x61\x6c\x69\x63' : [ '\x66\x6f\x6e\x74\x53\x74\x79\x6c\x65',
				'\x66\x6f\x6e\x74\x2d\x73\x74\x79\x6c\x65', '' ],
		'\x75\x6e\x64\x65\x72\x6c\x69\x6e\x65' : [
				'\x74\x65\x78\x74\x44\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e',
				'\x74\x65\x78\x74\x2d\x64\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e',
				'' ],
		'\x73\x74\x72\x69\x6b\x65\x74\x68\x72\x6f\x75\x67\x68' : [
				'\x74\x65\x78\x74\x44\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e',
				'\x74\x65\x78\x74\x2d\x64\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e',
				'' ],
		'\x66\x6f\x6e\x74\x63\x6f\x6c\x6f\x72' : [ '\x63\x6f\x6c\x6f\x72',
				'\x63\x6f\x6c\x6f\x72', '\x63\x6f\x6c\x6f\x72' ],
		'\x66\x6f\x6e\x74\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x63\x6f\x6c\x6f\x72' : [
				'\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x43\x6f\x6c\x6f\x72',
				'\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72',
				'' ]
	},
	init : function() {
		this.pe_bU = this._oThis
				.getFunctionals('\x6c\x69\x6e\x65\x73\x74\x79\x6c\x65');
		this.pe_bU.init();
		this.pe_KF = [];
	},
	pe_aFL : function() {
		if (!this.pe_sj)
			return;
		this.init();
		this._oThis.pe_dy().focus();
		var pe_bC = this._oThis.getSelection();
		var sel = pe_bC.sel = pe_bC.getSelection();
		var range = pe_bC.range = pe_bC.pe_bY();
		if (pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c") {
			return;
		} else {
			var pe_kB = eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x65\x55\x2e'
					+ this.pe_sj);
			var pe_nd = this.pe_Ua;
			if (pe_bC.isCollapsed()) {
				this.pe_avx(pe_kB, pe_nd, pe_bC);
			} else {
				if (agentInfo.IsIE11
						&& (this._oThis.pe_bV && this._oThis.pe_bV.length > 0)) {
					this.pe_aiD(pe_kB, pe_nd, pe_bC);
				} else if (agentInfo.IsIE11) {
					var t = this;
					NamoSE.Util.pe_bO(function() {
						t.pe_aiD(pe_kB, pe_nd, pe_bC);
					}, 30);
				} else {
					this.pe_aiD(pe_kB, pe_nd, pe_bC);
				}
			}
		}
	},
	pe_avx : function(pe_kB, pe_nd, pe_bC) {
		var sdoc = this._oThis.getDocument();
		var pe_cr = pe_bC.pe_nn();
		var pe_df = pe_bC.range.startContainer;
		var pe_gm = null;
		var pe_asC = function(ele) {
			if (!ele)
				return;
			var source = ele.innerHTML.Trim();
			return source == "" || escape(source) == "\x25\x75\x46\x45\x46\x46";
		};
		var pe_arN = function(ele) {
			if (!ele)
				return;
			var source = ele.innerHTML.Trim();
			return agentInfo.IsIE ? source == "\x26\x6e\x62\x73\x70\x3b"
					: (source == "\x3c\x62\x72\x3e"
							|| source == "\x3c\x62\x72\x2f\x3e"
							|| source == "\x3c\x62\x72\x20\x2f\x3e" || source == "")
		};
		var pe_qV = function(val) {
			var pe_Om = sdoc.createElement("\x73\x70\x61\x6e");
			pe_Om.innerHTML = val;
			return pe_Om;
		};
		var pe_YN = function(pe_gm, pe_aFy) {
			pe_bC.pe_amI(pe_gm);
			pe_bC.pe_zN(pe_gm);
			pe_bC.range = pe_bC.pe_bY();
			if ((pe_aFy && agentInfo.IsIE11) || agentInfo.IsGecko) {
				pe_bC.range.collapse(true);
			} else {
				pe_bC.range.collapse(false);
			}
			pe_bC.pe_bM();
		};
		if (pe_df && pe_df.nodeType == 1
				&& pe_df.nodeName == "\x53\x50\x41\x4e"
				&& (pe_asC(pe_df) || pe_arN(pe_df))) {
			this.pe_wN(pe_df, pe_kB, pe_nd);
			if (agentInfo.IsIE || agentInfo.IsGecko) {
				pe_gm = pe_qV();
				pe_YN(pe_gm, true);
				pe_gm.parentNode.removeChild(pe_gm);
			}
		} else if (pe_df && pe_df.nodeType == 1 && pe_df.nodeName == "\x50"
				&& pe_arN(pe_df)) {
			pe_df.innerHTML = "";
			pe_gm = pe_qV(agentInfo.IsIE ? "\x26\x6e\x62\x73\x70\x3b"
					: "\x3c\x62\x72\x20\x2f\x3e");
			this.pe_wN(pe_gm, pe_kB, pe_nd);
			pe_YN(pe_gm, true);
		} else if (pe_cr && pe_cr.nodeType == 1
				&& pe_cr.nodeName == "\x53\x50\x41\x4e" && pe_asC(pe_cr)) {
			this.pe_wN(pe_cr, pe_kB, pe_nd);
			if (agentInfo.IsIE || agentInfo.IsGecko) {
				pe_gm = pe_qV();
				pe_YN(pe_gm);
				pe_gm.parentNode.removeChild(pe_gm);
			}
		} else {
			pe_gm = pe_qV(agentInfo.IsGecko ? ""
					: unescape("\x25\x75\x46\x45\x46\x46"));
			this.pe_wN(pe_gm, pe_kB, pe_nd);
			pe_YN(pe_gm);
		}
	},
	pe_aiD : function(pe_kB, pe_nd, pe_bC) {
		var t = this;
		var sdoc = this._oThis.getDocument();
		var pe_ajp = pe_bC.pe_hU();
		var pe_gW = pe_ajp[0];
		var pe_fy = pe_ajp[1];
		var pe_acX = null;
		var pe_acO = null;
		if (!(pe_gW && pe_fy))
			return;
		var pe_qV = function(pe_ci, pe_alz) {
			if (!pe_ci)
				return;
			var pe_hT = pe_ci.cloneNode(false);
			if (agentInfo.IsOpera) {
				if (pe_hT && pe_hT.nodeType == 3 && pe_hT.nodeValue == ""
						&& pe_ci && pe_ci.nodeType == 3
						&& pe_ci.nodeValue != "") {
					pe_hT = sdoc.createTextNode(pe_ci.nodeValue);
				}
			}
			var pe_gm = sdoc.createElement("\x73\x70\x61\x6e");
			t.pe_wN(pe_gm, pe_kB, pe_nd);
			pe_gm.appendChild(pe_hT);
			pe_ci.parentNode.replaceChild(pe_gm, pe_ci);
			if (pe_alz == 0) {
				pe_acX = pe_gm;
			} else if (pe_alz == pe_Js.length - 1) {
				pe_acO = pe_gm;
			}
		};
		try {
			if (this.pe_aDI(pe_fy))
				this.pe_afY(pe_fy, pe_fy.parentNode, "\x65\x6e\x64");
			this.pe_aCX(sdoc, pe_bC);
			var pe_Js = this.pe_Qb(pe_gW, pe_fy, "\x74\x65\x78\x74", pe_bC);
			if (pe_Js.length > 0) {
				for (var i = 0; i < pe_Js.length; i++) {
					var pe_oJ = pe_Js[i][0];
					var pe_aji = pe_Js[i][1];
					if (pe_oJ) {
						if (pe_oJ.nodeType == 1) {
							if (NamoSE.pe_cy.pe_fP.InArray(pe_oJ.nodeName
									.toLowerCase())) {
								pe_oJ.innerHTML = (agentInfo.IsIE) ? "\x26\x6e\x62\x73\x70\x3b"
										: "\x3c\x62\x72\x20\x2f\x3e";
								pe_qV(pe_oJ.firstChild, i);
							} else if (pe_oJ.nodeName == "\x42\x52") {
								if (pe_aji) {
									this.pe_wN(pe_oJ.parentNode, pe_kB, pe_nd);
								} else {
									pe_qV(pe_oJ, i);
								}
							}
						} else {
							var pe_AR = pe_oJ.parentNode;
							if (pe_AR && pe_AR.nodeType == 1
									&& pe_AR.nodeName == "\x53\x50\x41\x4e") {
								var pe_abL = this.pe_Ve(pe_AR.firstChild,
										"\x66\x69\x72\x73\x74", pe_gW, pe_fy);
								var pe_ajo = this.pe_Ve(pe_AR.lastChild,
										"\x6c\x61\x73\x74", pe_gW, pe_fy);
								if (pe_abL && pe_ajo && pe_abL == pe_oJ
										&& pe_abL == pe_ajo) {
									this.pe_wN(pe_AR, pe_kB, pe_nd);
								} else {
									if (pe_aji) {
										this.pe_wN(pe_AR, pe_kB, pe_nd);
									} else {
										pe_qV(pe_oJ, i);
									}
								}
							} else {
								pe_qV(pe_oJ, i);
							}
						}
					}
				}
			}
			if (pe_acX)
				this.pe_afY(pe_gW, pe_acX, "\x73\x74\x61\x72\x74");
			if (pe_acO)
				this.pe_afY(pe_fy, pe_acO, "\x65\x6e\x64");
			var pe_jy = pe_bC.pe_iX();
			var pe_iJ = this.pe_aua(pe_jy[0]);
			var pe_iC = this.pe_aua(pe_jy[1]);
			var pe_amY = this.pe_aEs(pe_iJ, pe_iC, pe_jy[0], pe_jy[1], pe_bC);
			var pe_aHV = pe_amY.start;
			var pe_avG = pe_amY.end;
			if (pe_aHV)
				this.pe_acH(pe_iJ, pe_kB, pe_jy[0], pe_jy[1]);
			if (this.pe_KF.length > 0) {
				for (var i = 0; i < this.pe_KF.length; i++) {
					var pe_UK = this.pe_KF[i];
					if (pe_UK && pe_UK != pe_iJ && pe_UK != pe_iC) {
						this.pe_acH(pe_UK, pe_kB, pe_jy[0], pe_jy[1]);
					}
				}
			}
			if (pe_avG)
				this.pe_acH(pe_iC, pe_kB, pe_jy[0], pe_jy[1]);
			pe_bC.pe_hW(pe_jy[0], pe_jy[1]);
		} catch (exp) {
			pe_bC.pe_hI(pe_gW, pe_fy);
		}
	},
	pe_wN : function(pe_bW, pe_sM, sVal) {
		if (!pe_bW)
			return;
		if (sVal)
			pe_bW.style[pe_sM[0]] = sVal;
		else {
			NamoSE.Util.pe_AX(pe_bW, pe_sM[1], pe_sM[0]);
			if (pe_bW.style.cssText == "")
				pe_bW.removeAttribute("\x73\x74\x79\x6c\x65");
		}
	},
	pe_Ve : function(pe_bW, pe_Gw, pe_gW, pe_fy) {
		if (!pe_bW)
			return null;
		if (!pe_Gw || pe_Gw == "")
			pe_Gw = "\x66\x69\x72\x73\x74";
		var pe_agT = pe_bW;
		if (pe_Gw == "\x6c\x61\x73\x74") {
			if (pe_bW && pe_bW.nodeType == 3 && pe_bW.nodeValue == ""
					&& pe_bW.previousSibling && pe_bW.previousSibling == pe_fy)
				pe_bW = pe_bW.previousSibling;
			if (pe_bW == pe_fy)
				pe_agT = pe_bW.previousSibling;
		} else {
			if (pe_bW && pe_bW.nodeType == 3 && pe_bW.nodeValue == ""
					&& pe_bW.nextSibling && pe_bW.nextSibling == pe_gW)
				pe_bW = pe_bW.nextSibling;
			if (pe_bW == pe_gW)
				pe_agT = pe_bW.nextSibling;
		}
		return pe_agT;
	},
	pe_afY : function(pe_Ti, pe_dQ, pe_asf) {
		if (!pe_Ti)
			return;
		if (!pe_dQ)
			return;
		try {
			if (pe_asf == "\x73\x74\x61\x72\x74") {
				if (!pe_dQ.firstChild) {
					pe_dQ.appendChild(pe_Ti);
				} else {
					pe_dQ.insertBefore(pe_Ti, pe_dQ.firstChild);
				}
			} else if (pe_asf == "\x65\x6e\x64") {
				pe_dQ.appendChild(pe_Ti);
			}
		} catch (exp) {
		}
	},
	pe_aCX : function(sdoc, pe_bC) {
		var pe_GK = null;
		var pe_jy = pe_bC.pe_iX();
		if (pe_jy[0] && pe_jy[1]) {
			if (agentInfo.IsIE) {
				var pe_cp = sdoc.body.createTextRange();
				pe_cp.moveToElementText(pe_jy[0]);
				pe_bC.range.setEndPoint(
						"\x53\x74\x61\x72\x74\x54\x6f\x45\x6e\x64", pe_cp);
				var pe_fm = sdoc.body.createTextRange();
				pe_fm.moveToElementText(pe_jy[1]);
				pe_bC.range.setEndPoint(
						"\x45\x6e\x64\x54\x6f\x53\x74\x61\x72\x74", pe_fm);
			} else {
				pe_GK = sdoc.createRange();
				pe_GK.setStart(pe_jy[0], 0);
				pe_GK.setEnd(pe_jy[1], 0);
				pe_bC.range = pe_GK;
			}
			pe_bC.pe_bM();
			pe_bC.sel = pe_bC.getSelection();
			pe_bC.range = pe_bC.pe_bY();
		}
	},
	pe_asi : function(pe_bW, pe_cv, pe_gW, pe_fy, pe_bC) {
		var pe_da = true;
		var pe_cY = pe_bW.childNodes;
		for (var i = 0; i < pe_cY.length; i++) {
			if (pe_cY[i]) {
				var pe_bG = pe_cY[i];
				if (pe_bG.nodeType == 1) {
					if (!(NamoSE.pe_cy.pe_zj.InArray(pe_bG.nodeName
							.toLowerCase())
							|| [ '\x42\x52', '\x2f\x45\x4d\x42\x45\x44' ]
									.InArray(pe_bG.nodeName)
							|| pe_bG == pe_cv
							|| pe_bG == pe_gW || pe_bG == pe_fy)) {
						if (!([ '\x53\x50\x41\x4e', '\x46\x4f\x4e\x54' ]
								.InArray(pe_bG.nodeName) && pe_bC.pe_FV(pe_bG,
								true))) {
							pe_da = false;
							break;
						}
					}
				} else if (pe_bG.nodeType == 3) {
					var pe_rf = NamoSE.Util.pe_wd(pe_bG.nodeValue);
					if (!(pe_bG == pe_cv || pe_rf == "")) {
						if (!pe_bC.pe_FV(pe_bG, false)) {
							pe_da = false;
							break;
						}
					}
				}
			}
		}
		return pe_da;
	},
	pe_aJP : function(pe_bW, pe_gW, pe_fy, pe_bC) {
		if (typeof pe_bW == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		var pe_TS = eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x65\x55\x2e'
				+ this.pe_sj);
		var pe_amV = null;
		var pe_gV = false;
		var pe_fl = pe_bW;
		var pe_amX = pe_bW;
		while (!pe_gV) {
			if (pe_fl.nodeName == "\x53\x50\x41\x4e") {
				if (this.pe_asi(pe_fl, pe_amX, pe_gW, pe_fy, pe_bC)) {
					pe_amV = pe_fl;
					break;
				}
			}
			var pe_Sy = true;
			var pe_GM = pe_fl.style[pe_TS[0]];
			if (pe_GM && pe_GM != "")
				pe_Sy = false;
			if (pe_Sy && pe_fl.nodeName == "\x46\x4f\x4e\x54") {
				pe_GM = "";
				if (pe_TS[2] && pe_TS[2] != "")
					pe_GM = pe_fl.getAttribute(pe_TS[2]);
				if (pe_GM && pe_GM != "")
					pe_Sy = false;
			}
			pe_amX = pe_fl;
			pe_fl = pe_fl.parentNode;
			if (!pe_fl
					|| !pe_Sy
					|| !NamoSE.pe_cy.pe_pp
							.InArray(pe_fl.nodeName.toLowerCase())) {
				pe_gV = true;
			}
		}
		return pe_amV;
	},
	pe_aDI : function(pe_fy) {
		var pe_da = false;
		var pe_Zf = pe_fy.nextSibling;
		if (pe_Zf && pe_Zf.nodeType == 3) {
			if (NamoSE.Util.pe_wd(pe_Zf.nodeValue) == "\x20"
					&& !pe_Zf.nextSibling) {
				pe_da = true;
			}
		}
		return pe_da;
	},
	pe_aEs : function(pe_cD, pe_gN, pe_gW, pe_fy, pe_bC) {
		var pe_ok = true;
		var pe_qQ = true;
		if (!pe_cD || pe_cD.nodeName == "\x42\x4f\x44\x59")
			pe_ok = false;
		if (!pe_gN || pe_gN.nodeName == "\x42\x4f\x44\x59")
			pe_qQ = false;
		if (pe_qQ) {
			var pe_yK = NamoSE.Util.pe_ff(pe_gN.firstChild);
			if (pe_yK && pe_yK.nodeType == 3 && pe_yK.nodeValue == ""
					&& pe_yK.nextSibling && pe_yK.nextSibling == pe_fy)
				pe_yK = pe_yK.nextSibling;
			if (pe_yK == pe_fy)
				pe_qQ = false;
		}
		if (pe_ok) {
			var pe_afu = this.pe_afo(pe_cD, pe_gW, pe_fy);
			if (pe_afu == null)
				pe_ok = false;
		}
		if (pe_cD == pe_gN) {
			pe_qQ = pe_ok;
		} else {
			if (pe_qQ) {
				pe_afu = this.pe_afo(pe_gN, pe_gW, pe_fy);
				if (pe_afu == null)
					pe_qQ = false;
			}
		}
		if (pe_ok)
			pe_ok = this.pe_aju(pe_cD, "\x73\x74\x61\x72\x74", pe_gW, pe_fy,
					pe_bC);
		if (pe_qQ)
			pe_qQ = this.pe_aju(pe_gN, "\x65\x6e\x64", pe_gW, pe_fy, pe_bC);
		if (pe_cD == pe_gN) {
			if (!(pe_ok && pe_qQ)) {
				pe_ok = false;
				pe_qQ = false;
			}
		}
		return {
			"\x73\x74\x61\x72\x74" : pe_ok,
			"\x65\x6e\x64" : pe_qQ
		};
	},
	pe_aju : function(pe_bW, pe_gk, pe_gW, pe_fy, pe_bC) {
		if (!pe_bW)
			return false;
		if (!pe_gk || pe_gk == "")
			return false;
		var sdoc = this._oThis.getDocument();
		var pe_da = false;
		var pe_aJk = (agentInfo.IsIE) ? "\x26\x6e\x62\x73\x70\x3b"
				: "\x3c\x62\x72\x20\x2f\x3e";
		var pe_fu = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65\x5f\x5f\x4d\x61\x72\x6b";
		var pe_CI = sdoc.createElement("\x73\x70\x61\x6e");
		pe_CI.id = pe_fu;
		if (pe_bW && pe_bW.firstChild) {
			var pe_ee = NamoSE.Util.pe_ff(pe_bW.firstChild);
			if (pe_ee) {
				try {
					var pe_ZT;
					if (pe_gk == "\x73\x74\x61\x72\x74") {
						pe_bW.insertBefore(pe_CI, pe_ee);
						pe_ZT = this.pe_Qb(pe_CI, pe_gW,
								"\x69\x6e\x72\x61\x6e\x67\x65", pe_bC, pe_bW);
					} else {
						pe_bW.appendChild(pe_CI);
						pe_ZT = this.pe_Qb(pe_fy, pe_CI,
								"\x69\x6e\x72\x61\x6e\x67\x65", pe_bC, pe_bW);
					}
					if (pe_ZT && pe_ZT.length == 0)
						pe_da = true;
					if (pe_CI)
						pe_bW.removeChild(pe_CI);
				} catch (exp) {
					if (sdoc.getElementById(pe_fu))
						pe_bW.removeChild(sdoc.getElementById(pe_fu));
				}
			}
		}
		return pe_da;
	},
	pe_afo : function(pe_bW, pe_gW, pe_fy) {
		if (!pe_bW)
			return null;
		var t = this;
		var pe_aoX = function(pe_kw, pe_aDj) {
			while (pe_kw
					&& (pe_kw.nodeType == 3 && NamoSE.Util
							.pe_wd(pe_kw.nodeValue) == "")
					|| (pe_kw.nodeType == 1 && (pe_kw.nodeName == "\x42\x52"
							|| pe_kw == pe_gW || pe_kw == pe_fy))) {
				if (pe_aDj == "\x70\x65\x5f\x70\x5a") {
					pe_kw = pe_kw.previousSibling;
				} else {
					pe_kw = pe_kw.nextSibling;
				}
			}
			return pe_kw;
		};
		var pe_atb = null;
		var pe_gs = pe_aoX(pe_bW.firstChild, "\x70\x65\x5f\x4b\x52");
		var pe_aiZ = pe_aoX(pe_bW.lastChild, "\x70\x65\x5f\x70\x5a");
		if (pe_gs
				&& pe_aiZ
				&& pe_gs == pe_aiZ
				&& pe_gs.nodeType == 1
				&& [ '\x53\x50\x41\x4e', '\x46\x4f\x4e\x54' ]
						.InArray(pe_gs.nodeName)) {
			pe_atb = pe_gs;
		}
		return pe_atb;
	},
	pe_aua : function(pe_nC) {
		if (typeof pe_nC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		var pe_gV = false;
		var pe_ca = pe_nC;
		while (!pe_gV) {
			if (!pe_ca.parentNode) {
				pe_ca = null;
				break;
			}
			pe_ca = pe_ca.parentNode;
			if (this._oThis.config.pe_fP.InArray(pe_ca.nodeName.toLowerCase())
					|| [ '\x42\x4f\x44\x59', '\x54\x44', '\x54\x48' ]
							.InArray(pe_ca.nodeName)) {
				pe_gV = true;
			}
		}
		return pe_ca;
	},
	pe_awN : function(pe_gs) {
		if (typeof pe_gs == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		var pe_BH = [];
		var pe_RD, pe_RA, pe_Rn, pe_SP;
		var pe_eY = pe_gs.cloneNode(false);
		if (pe_gs.nodeName == "\x46\x4f\x4e\x54") {
			pe_RD = (pe_eY.style.fontFamily) ? pe_eY.style.fontFamily
					: pe_eY.face;
			pe_RA = (pe_eY.style.fontSize) ? pe_eY.style.fontSize : pe_eY.size;
			pe_Rn = (pe_eY.style.color) ? pe_eY.style.color : pe_eY.color;
		} else {
			pe_RD = pe_eY.style.fontFamily;
			pe_RA = pe_eY.style.fontSize;
			pe_Rn = pe_eY.style.color;
		}
		pe_SP = pe_eY.style.backgroundColor;
		if (pe_RD && pe_RD != "") {
			NamoSE.Util.pe_AX(pe_eY, this.pe_eU.fontname[1],
					this.pe_eU.fontname[0]);
			if (pe_eY.face)
				pe_eY.removeAttribute("\x66\x61\x63\x65");
			pe_BH.push([ this.pe_eU.fontname[0], pe_RD ]);
		}
		if (pe_RA && pe_RA != "") {
			NamoSE.Util.pe_AX(pe_eY, this.pe_eU.fontsize[1],
					this.pe_eU.fontsize[0]);
			if (pe_eY.size)
				pe_eY.removeAttribute("\x73\x69\x7a\x65");
			pe_BH.push([ this.pe_eU.fontsize[0], pe_RA ]);
		}
		if (pe_Rn && pe_Rn != "") {
			NamoSE.Util.pe_AX(pe_eY, this.pe_eU.fontcolor[1],
					this.pe_eU.fontcolor[0]);
			if (pe_eY.color)
				pe_eY.removeAttribute("\x63\x6f\x6c\x6f\x72");
			pe_BH.push([ this.pe_eU.fontcolor[0], pe_Rn ]);
		}
		if (pe_SP && pe_SP != "") {
			NamoSE.Util.pe_AX(pe_eY, this.pe_eU.fontbackgroundcolor[1],
					this.pe_eU.fontbackgroundcolor[0]);
			pe_BH.push([ this.pe_eU.fontbackgroundcolor[0], pe_SP ]);
		}
		if (pe_gs.nodeName == "\x46\x4f\x4e\x54") {
			if (pe_eY.className
					&& pe_eY.className == "\x41\x70\x70\x6c\x65\x2d\x73\x74\x79\x6c\x65\x2d\x73\x70\x61\x6e") {
				if (agentInfo.IsIE && parseInt(pe_cm) < 8) {
					pe_eY
							.removeAttribute("\x63\x6c\x61\x73\x73\x4e\x61\x6d\x65");
				} else {
					pe_eY.removeAttribute("\x63\x6c\x61\x73\x73");
				}
			}
			if (pe_eY.getAttribute("\x5f\x6d\x6f\x7a\x5f\x64\x69\x72\x74\x79"))
				pe_eY
						.removeAttribute("\x5f\x6d\x6f\x7a\x5f\x64\x69\x72\x74\x79");
			if (pe_eY
					.getAttribute("\x5f\x6d\x6f\x7a\x2d\x75\x73\x65\x72\x64\x65\x66\x69\x6e\x65\x64"))
				pe_eY
						.removeAttribute("\x5f\x6d\x6f\x7a\x2d\x75\x73\x65\x72\x64\x65\x66\x69\x6e\x65\x64");
			var pe_azf = NamoSE.Util.pe_Fe(pe_eY);
			if (!(pe_eY.style.cssText == "" && pe_azf.length == 0))
				pe_BH = null;
		} else {
			if (pe_eY.style.cssText != "")
				pe_BH = null;
		}
		pe_eY = null;
		return pe_BH;
	},
	pe_acH : function(pe_bW, pe_sM, pe_gW, pe_fy) {
		var pe_gs = this.pe_afo(pe_bW, pe_gW, pe_fy);
		if (pe_gs != null) {
			var pe_da = true;
			var pe_PO = [];
			var pe_cY = pe_gs.childNodes;
			for (var i = 0; i < pe_cY.length; i++) {
				if (pe_cY[i]) {
					var pe_bG = pe_cY[i];
					pe_PO.push(pe_bG);
					if (pe_bG.nodeType == 3) {
						var pe_rf = NamoSE.Util.pe_wd(pe_bG.nodeValue);
						if (pe_rf != "") {
							pe_da = false;
							break;
						}
					}
				}
			}
			if (pe_da) {
				var pe_anA = false;
				var pe_te = NamoSE.Util.pe_bP(pe_gs, "\x73\x70\x61\x6e");
				for (var i = 0; i < pe_te.length; i++) {
					if (!pe_te[i] || pe_te[i] == pe_gW || pe_te[i] == pe_fy) {
						continue;
					} else {
						pe_anA = true;
						break;
					}
				}
				if (pe_anA) {
					var pe_mU = null;
					NamoSE.Util.pe_AX(pe_gs, pe_sM[1], pe_sM[0]);
					if (pe_sM[2] && pe_sM[2] != ""
							&& pe_gs.getAttribute(pe_sM[2]))
						pe_gs.removeAttribute(pe_sM[2]);
					if (pe_gs.nodeName == "\x53\x50\x41\x4e"
							&& pe_gs.style.cssText == "") {
						pe_gs.removeAttribute("\x73\x74\x79\x6c\x65");
					} else {
						pe_mU = this.pe_awN(pe_gs);
					}
					var pe_lj = true;
					var pe_mT = NamoSE.Util.pe_Fe(pe_gs);
					if (pe_mT.length > 0) {
						for (var i = 0; i < pe_mT.length; i++) {
							var pe_dq = pe_mT[i].nodeName.toLowerCase();
							if (!pe_mT[i]
									|| [
											'\x5f\x6d\x6f\x7a\x5f\x64\x69\x72\x74\x79',
											'\x5f\x6d\x6f\x7a\x2d\x75\x73\x65\x72\x64\x65\x66\x69\x6e\x65\x64' ]
											.InArray(pe_dq)
									|| (pe_dq == "\x63\x6c\x61\x73\x73" && pe_gs.className == "\x41\x70\x70\x6c\x65\x2d\x73\x74\x79\x6c\x65\x2d\x73\x70\x61\x6e")) {
								continue;
							} else {
								if (pe_mU
										&& typeof (pe_mU) == "\x6f\x62\x6a\x65\x63\x74"
										&& pe_mU.length > 0) {
									if (pe_dq == "\x73\x74\x79\x6c\x65")
										continue;
									if (pe_gs.nodeName == "\x46\x4f\x4e\x54"
											&& [ '\x66\x61\x63\x65',
													'\x73\x69\x7a\x65',
													'\x63\x6f\x6c\x6f\x72' ]
													.InArray(pe_dq))
										continue;
								}
								pe_lj = false;
								break;
							}
						}
					}
					if (pe_lj) {
						if (pe_mU
								&& typeof (pe_mU) == "\x6f\x62\x6a\x65\x63\x74"
								&& pe_mU.length > 0) {
							for (var i = 0; i < pe_te.length; i++) {
								if (!pe_te[i] || pe_te[i] == pe_gW
										|| pe_te[i] == pe_fy) {
									continue;
								} else {
									for (var y = 0; y < pe_mU.length; y++) {
										if (pe_mU[y] && pe_mU[y][0]
												&& pe_mU[y][1]) {
											var pe_asQ = pe_te[i].style[pe_mU[y][0]];
											if (!(pe_asQ && pe_asQ != ""))
												pe_te[i].style[pe_mU[y][0]] = pe_mU[y][1];
										}
									}
								}
							}
						}
						for (var i = 0; i < pe_PO.length; i++) {
							if (pe_PO[i]) {
								pe_gs.parentNode.insertBefore(pe_PO[i], pe_gs);
							}
						}
						pe_gs.parentNode.removeChild(pe_gs);
					}
				}
			}
			pe_PO = null;
		}
	},
	pe_asI : function() {
		var pe_eN = null;
		var pe_ur = null;
		var pe_gM = null;
		var pe_oG = false;
		this.init();
		this._oThis.pe_dy().focus();
		var pe_bC = this._oThis.getSelection();
		var sel = pe_bC.sel = pe_bC.getSelection();
		var range = pe_bC.range = pe_bC.pe_bY();
		if (pe_bC.range.startContainer)
			this.pe_CA = pe_bC.range.startContainer;
		if (pe_bC.range.endContainer)
			this.pe_CL = pe_bC.range.endContainer;
		if (!this.pe_CA || !this.pe_CL)
			return;
		this.pe_aGJ = pe_bC.range.startOffset;
		this.pe_aGC = pe_bC.range.endOffset;
		if (pe_bC.isCollapsed()) {
			return;
		} else {
			if (pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c") {
				return;
			} else {
				var pe_gM = null;
				if (agentInfo.IsIE) {
					pe_gM = this.pe_bU.pe_aeI(pe_bC, true);
					pe_eN = pe_gM.pe_dg;
					pe_gM = this.pe_bU.pe_aeI(pe_bC, false);
					pe_ur = pe_gM.pe_dg;
				} else {
					if (agentInfo.IsGecko) {
						if (this.pe_CA
								&& this.pe_CA.nodeName == "\x42\x4f\x44\x59")
							this.pe_CA = this.pe_CA.childNodes[pe_bC.range.startOffset];
						if (this.pe_CL
								&& this.pe_CL.nodeName == "\x42\x4f\x44\x59")
							this.pe_CL = this.pe_CL.childNodes[pe_bC.range.endOffset - 1];
					}
					pe_gM = this.pe_bU.pe_adX(pe_bC, this.pe_CA);
					pe_eN = pe_gM.pe_dg;
					pe_gM = this.pe_bU.pe_adX(pe_bC, this.pe_CL);
					pe_ur = pe_gM.pe_dg;
				}
			}
		}
		if (pe_eN && pe_ur && pe_eN != pe_ur) {
			var pe_aFk = this.pe_Qb(pe_eN, pe_ur);
			pe_oG = this.pe_asu(pe_aFk, this.pe_sj);
		} else {
			pe_oG = this.pe_asu([ pe_eN ], this.pe_sj);
		}
		return pe_oG;
	},
	pe_Qb : function(pe_cD, pe_gN, pe_kP, pe_bC, pe_Ze) {
		function pe_u(pe_cY) {
			if (pe_cY.length > 0) {
				for (var i = 0; i < pe_cY.length; i++) {
					if (t.pe_rI) {
						return;
						break;
					}
					var el = pe_cY[i];
					if (pe_kP == "\x74\x65\x78\x74") {
						var pe_Ww = null;
						if (el.nodeType == 3) {
							var pe_rf = NamoSE.Util.pe_wd(el.nodeValue);
							if (pe_rf != "") {
								if (pe_bC && el.parentNode
										&& el.parentNode.nodeType == 1) {
									if (el.parentNode.nodeName == "\x53\x50\x41\x4e") {
										pe_Ww = t.pe_asi(el.parentNode, el,
												pe_cD, pe_gN, pe_bC);
									}
								}
								pe_nq.push([ el, pe_Ww ]);
							} else {
								if (el.nodeValue == "")
									pe_vE.push(el);
							}
						} else if (el.nodeType == 1) {
							if (agentInfo.IsIE) {
								if (NamoSE.pe_cy.pe_fP.InArray(el.nodeName
										.toLowerCase())) {
									if (el.childNodes.length == 0
											&& el.innerHTML == "")
										pe_nq.push([ el, null ]);
								}
							}
							if (el.nodeName == "\x42\x52") {
								if (el.parentNode
										&& el.parentNode.nodeType == 1
										&& (NamoSE.pe_cy.pe_fP
												.InArray(el.parentNode.nodeName
														.toLowerCase()) || [
												'\x53\x50\x41\x4e',
												'\x46\x4f\x4e\x54' ]
												.InArray(el.parentNode.nodeName))) {
									var pe_agW = t.pe_Ve(NamoSE.Util.pe_ff(
											el.parentNode.firstChild,
											"\x70\x65\x5f\x4b\x52",
											"\x4e\x6f\x44\x61\x74\x61"),
											"\x66\x69\x72\x73\x74", pe_cD,
											pe_gN);
									var pe_anm = t.pe_Ve(NamoSE.Util.pe_ff(
											el.parentNode.lastChild,
											"\x70\x65\x5f\x70\x5a",
											"\x4e\x6f\x44\x61\x74\x61"),
											"\x6c\x61\x73\x74", pe_cD, pe_gN);
									if (pe_agW && pe_anm && pe_agW == el
											&& pe_agW == pe_anm) {
										if (el.parentNode.nodeName == "\x53\x50\x41\x4e")
											pe_Ww = true;
										pe_nq.push([ el, pe_Ww ]);
									}
								}
							}
						}
					} else if (pe_kP == "\x69\x6e\x72\x61\x6e\x67\x65") {
						if (el.nodeType == 3) {
							var pe_aCQ = NamoSE.Util.pe_wd(el.nodeValue);
							if (pe_aCQ != "") {
								pe_nq.push(el);
								t.pe_rI = true;
							} else {
								if (el.nodeValue == "")
									pe_vE.push(el);
							}
						}
					} else if (pe_kP == "\x66\x6f\x72\x6d\x61\x74") {
						if (el.nodeType == 1
								&& t._oThis.config.pe_pp.InArray(el.nodeName
										.toLowerCase())) {
							pe_nq.push(el);
						}
					} else {
						if (el.nodeType == 1
								&& (t._oThis.config.pe_fP.InArray(el.nodeName
										.toLowerCase()) || t._oThis.config.pe_rD
										.InArray(el.nodeName.toLowerCase()))) {
							pe_nq.push(el);
						}
					}
					if (el == pe_OK)
						t.pe_rI = true;
					if (el.childNodes.length > 0)
						pe_u(el.childNodes);
				}
			}
		}
		;
		if (!pe_kP || pe_kP == "")
			pe_kP = "\x62\x6c\x6f\x63\x6b";
		if (!pe_Ze)
			pe_Ze = null;
		var t = this;
		var pe_gV = false;
		var pe_fx = null;
		var pe_ed = pe_cD;
		var pe_OK = this._oThis.util.pe_qz(pe_gN, '\x6c\x61\x73\x74', 0);
		if (pe_OK == null)
			pe_OK = pe_gN;
		var pe_nq = [];
		var pe_vE = [];
		t.pe_rI = false;
		while (!pe_gV) {
			if (pe_kP == "\x74\x65\x78\x74"
					&& (t._oThis.config.pe_fP.InArray(pe_ed.nodeName
							.toLowerCase()) || [ '\x54\x44', '\x54\x48' ]
							.InArray(pe_ed.nodeName)))
				t.pe_KF.push(pe_ed);
			pe_u([ pe_ed ]);
			pe_fx = pe_ed;
			pe_ed = pe_ed.nextSibling;
			if (!pe_ed) {
				if (pe_fx.parentNode && pe_fx.parentNode.nodeType == 1
						&& pe_fx.parentNode.nodeName != "\x42\x4f\x44\x59") {
					var pe_ZR = false;
					var pe_cr = pe_fx.parentNode;
					if (pe_kP == "\x74\x65\x78\x74"
							|| pe_kP == "\x66\x6f\x72\x6d\x61\x74") {
						pe_ZR = true;
					} else if (pe_kP == "\x69\x6e\x72\x61\x6e\x67\x65" && pe_Ze) {
						if (pe_cr != pe_Ze)
							pe_ZR = true;
					} else {
						if (t._oThis.config.pe_rD.InArray(pe_cr.nodeName
								.toLowerCase()))
							pe_ZR = true;
					}
					if (pe_ZR) {
						while (pe_cr.nodeName != "\x42\x4f\x44\x59") {
							if (pe_cr.nextSibling) {
								pe_ed = pe_cr.nextSibling;
								break;
							}
							pe_cr = pe_cr.parentNode;
						}
					}
				}
			}
			if (!pe_ed || t.pe_rI) {
				pe_gV = true;
			}
		}
		if (pe_vE.length > 0) {
			for (var i = 0; i < pe_vE.length; i++) {
				if (pe_vE[i] && pe_vE[i].parentNode) {
					pe_vE[i].parentNode.removeChild(pe_vE[i]);
				}
			}
		}
		if (pe_kP == "\x66\x6f\x72\x6d\x61\x74" && !t.pe_rI)
			pe_nq = [];
		return pe_nq;
	},
	pe_asu : function(pe_gU, pe_aFD) {
		var t = this;
		if (typeof pe_gU == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_agV = eval('\x74\x68\x69\x73\x2e\x70\x65\x5f\x65\x55\x2e'
				+ pe_aFD);
		if (!pe_agV)
			return;
		var pe_OQ = pe_agV[1];
		var pe_agv = pe_agV[0];
		var pe_Yq = false;
		function pe_A(pe_gD, pe_ib, pe_vI) {
			if (pe_gD.firstChild && pe_gD.firstChild.nodeType == 1
					&& pe_gD.firstChild.nodeName == "\x53\x50\x41\x4e"
					&& !pe_gD.firstChild.nextSibling) {
				pe_ar(pe_gD, pe_gD.firstChild, pe_ib, pe_vI);
			} else {
				pe_M(pe_gD, pe_ib, pe_vI);
				pe_Yq = true;
			}
		}
		;
		function pe_ao(pe_gD, pe_ib) {
			var pe_vP = t._oThis.util.pe_bP(pe_gD, "\x6c\x69");
			for (var j = 0; j < pe_vP.length; j++) {
				if (pe_vP[j].firstChild && pe_vP[j].firstChild.nodeType == 1
						&& pe_vP[j].firstChild.nodeName == "\x53\x50\x41\x4e"
						&& !pe_vP[j].firstChild.nextSibling) {
					pe_ar(pe_vP[j], pe_vP[j].firstChild, pe_ib, false);
				} else {
					pe_M(pe_vP[j], pe_ib, false);
					pe_Yq = true;
				}
			}
			pe_s(pe_gD, pe_ib);
		}
		;
		function pe_O(pe_gD, pe_ib, pe_vI) {
			var pe_CJ = t._oThis.util.pe_ff(pe_gD.firstChild);
			if (pe_CJ
					&& pe_CJ.nodeType == 1
					&& t._oThis.config.pe_fP.InArray(pe_CJ.nodeName
							.toLowerCase())) {
				if (!pe_CJ.nextSibling) {
					pe_A(pe_CJ, pe_ib, false);
				} else {
					var pe_OO = t._oThis.util.pe_bP(pe_gD, pe_CJ.nodeName
							.toLowerCase());
					for (var j = 0; j < pe_OO.length; j++) {
						pe_A(pe_OO[j], pe_ib, false);
					}
					if (pe_CJ.nodeName != "\x50") {
						pe_OO = t._oThis.util.pe_bP(pe_gD, "\x70");
						for (var j = 0; j < pe_OO.length; j++) {
							pe_A(pe_OO[j], pe_ib, false);
						}
					}
				}
			} else {
				pe_M(pe_gD, pe_lN, true);
				pe_Yq = true;
			}
			if (pe_vI)
				pe_s(pe_gD, pe_ib);
		}
		;
		function pe_ar(pe_gD, pe_cv, pe_ib, pe_vI) {
			if (pe_OQ == "\x74\x65\x78\x74\x2d\x64\x65\x63\x6f\x72\x61\x74\x69\x6f\x6e") {
				if (pe_cv.style.textDecoration != "") {
					if (pe_cv.style.textDecoration.indexOf(pe_ib) == -1)
						pe_cv.style.textDecoration += "\x20" + pe_ib;
				} else {
					pe_cv.style.cssText += pe_OQ + "\x3a" + pe_ib + "\x3b";
				}
			} else {
				pe_cv.style.cssText += pe_OQ + "\x3a" + pe_ib + "\x3b";
			}
			if (pe_vI)
				pe_s(pe_gD, pe_ib);
		}
		;
		function pe_M(pe_gD, pe_ib, pe_vI) {
			var pe_wo = t._oThis.getDocument()
					.createElement("\x53\x50\x41\x4e");
			pe_wo.style.cssText = pe_OQ + "\x3a" + pe_ib;
			pe_wo.innerHTML = pe_gD.innerHTML;
			pe_gD.innerHTML = "";
			pe_gD.appendChild(pe_wo);
			if (pe_vI)
				pe_s(pe_gD, pe_ib);
		}
		;
		function pe_s(pe_gD, pe_ib) {
			var pe_aHT = pe_gD.style.cssText;
			var pe_aax = pe_aHT.split("\x3b");
			var pe_we = "";
			for (var i = 0; i < pe_aax.length; i++) {
				var pe_qX = pe_aax[i].split("\x3a");
				if (pe_qX[0].Trim() == pe_OQ && pe_qX[1].Trim() == pe_ib)
					continue;
				pe_we += pe_aax[i].Trim() + "\x3b";
			}
			if (pe_we == "" || pe_we == "\x3b") {
				pe_gD.removeAttribute("\x73\x74\x79\x6c\x65");
			} else {
				pe_gD.style.cssText = pe_we;
			}
		}
		;
		if (pe_gU.length > 0) {
			for (var i = 0; i < pe_gU.length; i++) {
				if (pe_gU[i].nodeType == 1
						&& ![ '\x62\x6f\x64\x79', '\x74\x62\x6f\x64\x79',
								'\x66\x6f\x72\x6d' ].InArray(pe_gU[i].nodeName
								.toLowerCase())) {
					var pe_lN = eval('\x70\x65\x5f\x67\x55\x5b\x69\x5d\x2e\x73\x74\x79\x6c\x65\x2e'
							+ pe_agv);
					if (pe_lN && pe_lN != "") {
						if (t._oThis.config.pe_fP.InArray(pe_gU[i].nodeName
								.toLowerCase())) {
							pe_A(pe_gU[i], pe_lN, true);
						} else if (t._oThis.config.pe_rD
								.InArray(pe_gU[i].nodeName.toLowerCase())) {
							var pe_HV = pe_gU[i].nodeName.toLowerCase();
							if (pe_HV == "\x6f\x6c" || pe_HV == "\x75\x6c") {
								pe_ao(pe_gU[i], pe_lN);
							} else if (pe_HV == "\x74\x64"
									|| pe_HV == "\x74\x68") {
								pe_O(pe_gU[i], pe_lN, true);
							} else if (pe_HV == "\x74\x61\x62\x6c\x65"
									|| pe_HV == "\x74\x72") {
								var pe_CQ = t._oThis.util.pe_bP(pe_gU[i],
										"\x74\x64");
								for (var z = 0; z < pe_CQ.length; z++) {
									pe_O(pe_CQ[z], pe_lN, false);
								}
								pe_s(pe_gU[i], pe_lN);
							}
						}
					} else {
						if (pe_gU[i].nodeName == "\x4c\x49"
								&& pe_gU[i].parentNode
								&& pe_gU[i].parentNode.nodeType == 1
								&& [ '\x4f\x4c', '\x55\x4c' ]
										.InArray(pe_gU[i].parentNode.nodeName)) {
							pe_lN = eval('\x70\x65\x5f\x67\x55\x5b\x69\x5d\x2e\x70\x61\x72\x65\x6e\x74\x4e\x6f\x64\x65\x2e\x73\x74\x79\x6c\x65\x2e'
									+ pe_agv);
							if (pe_lN && pe_lN != "") {
								pe_ao(pe_gU[i].parentNode, pe_lN);
							}
						} else if (t._oThis.config.pe_fP
								.InArray(pe_gU[i].nodeName.toLowerCase())
								&& pe_gU[i].parentNode
								&& pe_gU[i].parentNode.nodeType == 1
								&& pe_gU[i].parentNode.nodeName == "\x54\x44") {
							pe_lN = eval('\x70\x65\x5f\x67\x55\x5b\x69\x5d\x2e\x70\x61\x72\x65\x6e\x74\x4e\x6f\x64\x65\x2e\x73\x74\x79\x6c\x65\x2e'
									+ pe_agv);
							if (pe_lN && pe_lN != "") {
								pe_O(pe_gU[i].parentNode, pe_lN, true);
							}
						}
					}
				}
			}
		}
		return pe_Yq;
	}
};
var pe_aDd = {
	_oThis : null,
	pe_bU : null,
	pe_sj : null,
	pe_Ua : null,
	init : function() {
		this.pe_bU = this._oThis
				.getFunctionals('\x73\x74\x79\x6c\x65\x67\x65\x74\x74\x65\x72');
	},
	pe_aFs : function() {
		var sdoc = this._oThis.getDocument();
		this.init();
		this._oThis.pe_dy().focus();
		var pe_bC = this._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.range = pe_bC.pe_bY();
		if (pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c")
			return;
		var sel = pe_bC.pe_Fh();
		var range = pe_bC.pe_Fj(sel);
		var pe_KA = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x53\x74\x79\x6c\x65\x45\x6e\x64\x50\x6f\x69\x6e\x74";
		var pe_df = pe_bC.pe_atI(range, true);
		var pe_fX = pe_bC.pe_atI(range, false);
		var pe_hL = range.startOffset;
		var pe_mn = range.endOffset;
		var pe_iJ, pe_iC, pe_nw;
		if (!(pe_df && pe_fX))
			return;
		if (agentInfo.IsOpera) {
			if (pe_df.nodeType == 3 && pe_df.parentNode
					&& pe_df.parentNode.nodeType == 3)
				pe_df = pe_df.parentNode;
			if (pe_fX.nodeType == 3 && pe_fX.parentNode
					&& pe_fX.parentNode.nodeType == 3)
				pe_fX = pe_fX.parentNode;
		}
		if (pe_df == pe_fX
				&& (pe_df.nodeType == 3 || (pe_df.nodeType == 1 && pe_hL == pe_mn))) {
			if (pe_df.nodeType == 1 && pe_df.nodeName != "\x42\x4f\x44\x59") {
				pe_nw = this.pe_Sw(sdoc, pe_df);
				pe_df = pe_fX = pe_nw;
				pe_hL = pe_mn = 0;
			}
			pe_iJ = NamoSE.Util.pe_Wq(pe_df);
			if (pe_iJ && pe_iJ.nodeType == 1) {
				var pe_mM = pe_df.splitText(pe_hL);
				if (!pe_mM
						|| (pe_mM.nodeType == 3 && !pe_mM.parentNode && pe_mM.nodeValue == "")) {
					if (pe_df
							&& (!pe_df.nextSibling || pe_df.nextSibling.nodeType == 1)) {
						pe_mM = this.pe_Sw(sdoc, pe_df);
					} else {
						return;
					}
				}
				try {
					pe_mM.splitText(pe_mn - pe_hL);
				} catch (exp) {
				}
				NamoSE.Util.pe_UW(sdoc, pe_iJ, pe_mM);
				this.pe_asH(sdoc, pe_mM, null, sel, range);
			} else if (agentInfo.IsOpera && pe_nw)
				pe_df.parentNode.removeChild(pe_nw);
		} else {
			var pe_lL = null;
			var pe_aka = pe_Jh = -1;
			if (pe_df.nodeType == 1
					&& NamoSE.pe_cy.pe_pp.InArray(pe_df.nodeName.toLowerCase())) {
				pe_nw = this.pe_Sw(sdoc, pe_df, "\x70\x72\x65\x76");
				pe_df = pe_nw;
				pe_hL = 0;
			}
			if (pe_fX.nodeType == 1
					&& NamoSE.pe_cy.pe_pp.InArray(pe_fX.nodeName.toLowerCase())) {
				pe_nw = this.pe_Sw(sdoc, pe_fX);
				pe_fX = pe_nw;
				pe_mn = 0;
			}
			pe_iJ = NamoSE.Util.pe_Wq(pe_df);
			pe_iC = NamoSE.Util.pe_Wq(pe_fX);
			if (pe_iJ) {
				if (pe_df.nodeType == 3) {
					if (pe_hL == pe_df.nodeValue.length)
						pe_df.nodeValue += '\uFEFF';
					pe_df = pe_df.splitText(pe_hL)
				} else {
					if (pe_iJ.nodeType == 1 && pe_iJ == pe_df)
						pe_iJ = null;
				}
			}
			if (pe_iC) {
				if (pe_fX.nodeType == 3) {
					pe_fX.splitText(pe_mn)
				} else {
					if (pe_iC.nodeType == 1 && pe_iC == pe_fX)
						pe_iC = null;
				}
			}
			if (pe_iJ && pe_iJ == pe_iC) {
				pe_lL = sdoc.createElement("\x73\x70\x61\x6e");
				pe_lL.id = pe_KA;
				pe_lL.appendChild(pe_fX.cloneNode(true));
				pe_fX.parentNode.replaceChild(pe_lL, pe_fX);
			}
			if (pe_iJ)
				pe_iJ = NamoSE.Util.pe_UW(sdoc, pe_iJ, pe_df);
			else {
				pe_iJ = pe_df;
				pe_aka = pe_hL;
			}
			if (pe_lL = sdoc.getElementById(pe_KA)) {
				pe_fX = pe_lL;
				pe_iC = NamoSE.Util.pe_Wq(pe_fX);
			}
			if (pe_iC)
				pe_iC = NamoSE.Util.pe_UW(sdoc, pe_iC, pe_fX);
			else {
				pe_iC = pe_fX;
				pe_Jh = pe_mn;
			}
			if (pe_lL = sdoc.getElementById(pe_KA)) {
				if (pe_lL == pe_iC) {
					if (pe_iC.lastChild) {
						pe_iC = pe_iC.lastChild;
						NamoSE.Util.pe_ahz(pe_lL);
					}
				} else {
					if (pe_lL.parentNode)
						pe_lL.parentNode.removeChild(pe_lL);
				}
			}
			var pe_Un = this.pe_bU.pe_Qb(pe_iJ, pe_iC,
					"\x66\x6f\x72\x6d\x61\x74");
			if (pe_Un.length > 0) {
				pe_Un.reverse();
				for (var i = 0; i < pe_Un.length; i++) {
					var pe_nE = pe_Un[i];
					if (pe_nE) {
						if ([ '\x41', '\x4c\x41\x42\x45\x4c' ]
								.InArray(pe_nE.nodeName)) {
							if (pe_nE.innerHTML == "") {
								NamoSE.Util.pe_ahz(pe_nE);
							} else {
								if (pe_nE.getAttribute("\x73\x74\x79\x6c\x65"))
									pe_nE
											.removeAttribute("\x73\x74\x79\x6c\x65");
								if (pe_nE.className && pe_nE.className != "") {
									if (agentInfo.IsIE && parseInt(pe_cm) < 8) {
										pe_nE
												.removeAttribute("\x63\x6c\x61\x73\x73\x4e\x61\x6d\x65");
									} else {
										pe_nE
												.removeAttribute("\x63\x6c\x61\x73\x73");
									}
								}
							}
						} else {
							if (pe_nE.parentNode && pe_nE.id != pe_KA)
								NamoSE.Util.pe_ahz(pe_nE);
						}
					}
				}
			}
			this.pe_asH(sdoc, pe_iJ, pe_iC, sel, range, [ pe_aka, pe_Jh ]);
			if (pe_df.nodeValue == '\uFEFF')
				pe_df.nodeValue = '';
			if (pe_lL = sdoc.getElementById(pe_KA))
				if (pe_lL.parentNode)
					pe_lL.parentNode.removeChild(pe_lL);
		}
	},
	pe_Sw : function(sdoc, pe_cv, pe_Zp) {
		if (!pe_cv)
			return null;
		if (!pe_Zp || pe_Zp == "")
			pe_Zp = "\x6e\x65\x78\x74";
		var pe_nw = sdoc.createTextNode('');
		if (pe_Zp == "\x70\x72\x65\x76") {
			pe_cv.parentNode.insertBefore(pe_nw, pe_cv);
		} else {
			(pe_cv.nextSibling) ? pe_cv.parentNode.insertBefore(pe_nw,
					pe_cv.nextSibling) : pe_cv.parentNode.appendChild(pe_nw);
		}
		return pe_nw;
	},
	pe_asH : function(sdoc, pe_sT, pe_zJ, sel, range, pe_Sh) {
		var pe_qV = function() {
			var pe_Om = sdoc.createElement("\x73\x70\x61\x6e");
			pe_Om.innerHTML = unescape("\x25\x75\x46\x45\x46\x46");
			return pe_Om;
		};
		var pe_gm = null;
		if (pe_sT) {
			if (!pe_zJ) {
				if (pe_sT && pe_sT.nodeType == 3) {
					if (pe_sT.nodeValue.length > 0) {
						range.selectNode(pe_sT);
					} else {
						pe_gm = pe_qV();
						pe_sT.parentNode.replaceChild(pe_gm, pe_sT);
						range.selectNodeContents(pe_gm);
						range.collapse(false);
					}
				}
			} else {
				var pe_aoG = false;
				if (pe_zJ.nodeType == 1
						&& pe_zJ.nodeName == "\x53\x50\x41\x4e"
						&& pe_zJ.id == "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x53\x74\x79\x6c\x65\x45\x6e\x64\x50\x6f\x69\x6e\x74")
					pe_aoG = true;
				(pe_sT.nodeType == 3) ? range.setStart(pe_sT,
						(pe_Sh[0] > -1 ? pe_Sh[0] : 0)) : range
						.setStartBefore(pe_sT);
				(pe_zJ.nodeType == 3 || pe_aoG) ? range.setEnd(pe_zJ,
						(pe_Sh[1] > -1 ? pe_Sh[1] : pe_zJ.length)) : range
						.setEndAfter(pe_zJ);
			}
			if (!range.pe_aoT)
				sel.removeAllRanges();
			sel.addRange(range);
			if (agentInfo.IsGecko && pe_gm)
				pe_gm.innerHTML = "";
		}
	}
};
var pe_akK = {
	_oThis : null,
	pe_aii : 0,
	pe_ahv : null,
	pe_ath : "\x66\x6f\x6e\x74",
	pe_atf : "\x73\x70\x61\x6e",
	pe_atg : "\x73\x63\x72\x69\x70\x74",
	pe_Ow : function(node, lang, encoding, pe_iF, pe_aho, inpre, pe_aDZ, saveas) {
		if (!pe_aDZ) {
			this.pe_aii = 0;
			this.pe_ahv = null;
			if (agentInfo.IsIE)
				this.pe_ahv = NamoSE.Util.pe_bP(this._oThis.getDocument().body,
						"\x6f\x62\x6a\x65\x63\x74");
		}
		var pe_agp = '\x7c\x64\x69\x76\x7c\x70\x7c\x70\x61\x72\x61\x6d\x7c\x6f\x62\x6a\x65\x63\x74\x7c\x65\x6d\x62\x65\x64\x7c\x74\x61\x62\x6c\x65\x7c\x63\x61\x70\x74\x69\x6f\x6e\x7c\x63\x6f\x6c\x67\x72\x6f\x75\x70\x7c\x74\x62\x6f\x64\x79\x7c\x74\x68\x65\x61\x64\x7c\x74\x72\x7c\x74\x64\x7c\x74\x68\x7c\x63\x6f\x6c\x7c\x74\x69\x74\x6c\x65\x7c\x68\x65\x61\x64\x7c\x62\x6f\x64\x79\x7c\x73\x63\x72\x69\x70\x74\x7c\x63\x6f\x6d\x6d\x65\x6e\x74\x7c\x6c\x69\x7c\x6d\x65\x74\x61\x7c\x68\x31\x7c\x68\x32\x7c\x68\x33\x7c\x68\x34\x7c\x68\x35\x7c\x68\x36\x7c\x68\x72\x7c\x75\x6c\x7c\x6f\x6c\x7c\x66\x6f\x72\x6d\x7c\x73\x65\x6c\x65\x63\x74\x7c\x6f\x70\x74\x69\x6f\x6e\x7c\x6d\x61\x70\x7c\x61\x72\x65\x61\x7c\x73\x74\x79\x6c\x65\x7c';
		var pe_aia = '\x7c\x68\x74\x6d\x6c\x7c\x68\x65\x61\x64\x7c\x62\x6f\x64\x79\x7c\x74\x61\x62\x6c\x65\x7c\x63\x6f\x6c\x67\x72\x6f\x75\x70\x7c\x74\x62\x6f\x64\x79\x7c\x74\x68\x65\x61\x64\x7c\x74\x72\x7c\x75\x6c\x7c\x6f\x6c\x7c\x66\x6f\x72\x6d\x7c\x73\x65\x6c\x65\x63\x74\x7c\x6d\x61\x70\x7c\x73\x74\x79\x6c\x65\x7c';
		var pe_ape = new RegExp();
		pe_ape.compile("\x5e\x3c\x21\x2d\x2d\x28\x2e\x2a\x29\x2d\x2d\x3e\x24");
		var i;
		var text = '';
		var children = node.childNodes;
		var pe_abT = children.length;
		var pe_dD;
		var pe_aop = pe_aho ? true : false;
		var pe_arr = true;
		var brTag = (pe_iF == "\x48\x54\x4d\x4c") ? "\x3c\x62\x72\x3e"
				: "\x3c\x62\x72\x20\x2f\x3e";
		for (i = 0; i < pe_abT; i++) {
			var pe_cK = children[i];
			var pe_fr = pe_cK;
			if (pe_cK.parentNode
					&& String(node.tagName).toLowerCase() != String(
							pe_cK.parentNode.tagName).toLowerCase())
				continue;
			if (agentInfo.IsIE
					&& [ '\x74\x68', '\x74\x64', '\x2f\x74\x68',
							'\x2f\x74\x64', '\x6f\x70\x74\x69\x6f\x6e',
							'\x6f\x70\x74\x67\x72\x6f\x75\x70',
							'\x2f\x6f\x70\x74\x69\x6f\x6e',
							'\x2f\x6f\x70\x74\x67\x72\x6f\x75\x70',
							'\x63\x61\x70\x74\x69\x6f\x6e',
							'\x63\x6f\x6c\x67\x72\x6f\x75\x70',
							'\x74\x68\x65\x61\x64', '\x74\x66\x6f\x6f\x74',
							'\x74\x62\x6f\x64\x79',
							'\x2f\x63\x61\x70\x74\x69\x6f\x6e',
							'\x2f\x63\x6f\x6c\x67\x72\x6f\x75\x70',
							'\x2f\x74\x68\x65\x61\x64',
							'\x2f\x74\x66\x6f\x6f\x74',
							'\x2f\x74\x62\x6f\x64\x79', '\x74\x72',
							'\x2f\x74\x72', '\x63\x6f\x6c', '\x2f\x63\x6f\x6c' ]
							.InArray(String(pe_fr.tagName).toLowerCase())) {
				if (!pe_fr.parentNode) {
					continue;
				} else {
					if ([ '\x74\x68', '\x74\x64', '\x2f\x74\x68',
							'\x2f\x74\x64' ].InArray(String(pe_fr.tagName)
							.toLowerCase())
							&& [ '\x74\x72', '\x2f\x74\x72' ].InArray(String(
									pe_fr.parentNode.tagName).toLowerCase())
							&& pe_fr.parentNode.parentNode) {
						pe_fr = pe_cK.parentNode;
					} else if ([ '\x74\x68', '\x74\x64', '\x2f\x74\x68',
							'\x2f\x74\x64' ].InArray(String(pe_fr.tagName)
							.toLowerCase())
							&& [ '\x74\x72', '\x2f\x74\x72' ].InArray(String(
									pe_fr.parentNode.tagName).toLowerCase())
							&& !pe_fr.parentNode.parentNode) {
						continue;
					} else if ([ '\x74\x68', '\x74\x64', '\x2f\x74\x68',
							'\x2f\x74\x64' ].InArray(String(pe_fr.tagName)
							.toLowerCase())
							&& pe_fr.parentNode.parentNode
							&& ![ '\x74\x72', '\x2f\x74\x72' ].InArray(String(
									pe_fr.parentNode.tagName).toLowerCase())) {
						continue;
					}
					if ([ '\x63\x61\x70\x74\x69\x6f\x6e',
							'\x63\x6f\x6c\x67\x72\x6f\x75\x70',
							'\x74\x68\x65\x61\x64', '\x74\x66\x6f\x6f\x74',
							'\x74\x62\x6f\x64\x79',
							'\x2f\x63\x61\x70\x74\x69\x6f\x6e',
							'\x2f\x63\x6f\x6c\x67\x72\x6f\x75\x70',
							'\x2f\x74\x68\x65\x61\x64',
							'\x2f\x74\x66\x6f\x6f\x74',
							'\x2f\x74\x62\x6f\x64\x79' ].InArray(String(
							pe_fr.tagName).toLowerCase())
							&& String(pe_fr.parentNode.tagName).toLowerCase() != '\x74\x61\x62\x6c\x65') {
						continue;
					} else if ([ '\x6f\x70\x74\x67\x72\x6f\x75\x70',
							'\x2f\x6f\x70\x74\x67\x72\x6f\x75\x70' ]
							.InArray(String(pe_fr.tagName).toLowerCase())
							&& String(pe_fr.parentNode.tagName).toLowerCase() != '\x73\x65\x6c\x65\x63\x74') {
						continue;
					} else if ([ '\x6f\x70\x74\x69\x6f\x6e',
							'\x2f\x6f\x70\x74\x69\x6f\x6e' ].InArray(String(
							pe_fr.tagName).toLowerCase())
							&& (String(pe_fr.parentNode.tagName).toLowerCase() != '\x73\x65\x6c\x65\x63\x74' && String(
									pe_fr.parentNode.tagName).toLowerCase() != '\x6f\x70\x74\x67\x72\x6f\x75\x70')) {
						continue;
					} else if ([ '\x74\x72', '\x2f\x74\x72' ].InArray(String(
							pe_fr.tagName).toLowerCase())
							&& ![ '\x74\x61\x62\x6c\x65',
									'\x74\x66\x6f\x6f\x74',
									'\x74\x62\x6f\x64\x79',
									'\x74\x68\x65\x61\x64',
									'\x2f\x74\x68\x65\x61\x64',
									'\x2f\x74\x62\x6f\x64\x79',
									'\x2f\x74\x66\x6f\x6f\x74',
									'\x2f\x74\x61\x62\x6c\x65' ]
									.InArray(String(pe_fr.parentNode.tagName)
											.toLowerCase())) {
						continue;
					} else if ([ '\x63\x6f\x6c', '\x2f\x63\x6f\x6c' ]
							.InArray(String(pe_fr.tagName).toLowerCase())
							&& ![ '\x63\x6f\x6c\x67\x72\x6f\x75\x70',
									'\x2f\x63\x6f\x6c\x67\x72\x6f\x75\x70' ]
									.InArray(String(pe_fr.parentNode.tagName)
											.toLowerCase())) {
						continue;
					} else if (pe_fr.parentNode.parentNode) {
						if ([ '\x6f\x70\x74\x69\x6f\x6e',
								'\x2f\x6f\x70\x74\x69\x6f\x6e' ]
								.InArray(String(pe_fr.tagName).toLowerCase())
								&& [ '\x6f\x70\x74\x67\x72\x6f\x75\x70',
										'\x2f\x6f\x70\x74\x67\x72\x6f\x75\x70' ]
										.InArray(String(
												pe_fr.parentNode.tagName)
												.toLowerCase())) {
							if (String(pe_fr.parentNode.parentNode.tagName)
									.toLowerCase() != '\x73\x65\x6c\x65\x63\x74') {
								continue;
							}
						} else if ([ '\x74\x72', '\x2f\x74\x72' ]
								.InArray(String(pe_fr.tagName).toLowerCase())
								&& [ '\x74\x66\x6f\x6f\x74',
										'\x74\x62\x6f\x64\x79',
										'\x74\x68\x65\x61\x64',
										'\x2f\x74\x68\x65\x61\x64',
										'\x2f\x74\x62\x6f\x64\x79',
										'\x2f\x74\x66\x6f\x6f\x74' ]
										.InArray(String(
												pe_fr.parentNode.tagName)
												.toLowerCase())) {
							if (String(pe_fr.parentNode.parentNode.tagName)
									.toLowerCase() != '\x74\x61\x62\x6c\x65') {
								continue;
							}
						} else if ([ '\x63\x6f\x6c', '\x2f\x63\x6f\x6c' ]
								.InArray(String(pe_fr.tagName).toLowerCase())
								&& [ '\x63\x6f\x6c\x67\x72\x6f\x75\x70',
										'\x2f\x63\x6f\x6c\x67\x72\x6f\x75\x70' ]
										.InArray(String(
												pe_fr.parentNode.tagName)
												.toLowerCase())) {
							if (String(pe_fr.parentNode.parentNode.tagName)
									.toLowerCase() != '\x74\x61\x62\x6c\x65') {
								continue;
							}
						}
					}
				}
			}
			switch (pe_cK.nodeType) {
			case 1: {
				var pe_dD = String(pe_cK.tagName).toLowerCase();
				if (agentInfo.IsIE6 && !agentInfo.IsIE9) {
					var ieTag = pe_dD;
					var pe_ce = "";
					var source = pe_cK.outerHTML;
					source.replace(/<\s*\w*\s*:\s*\w*/g, function(pe_fo) {
						if (pe_fo.indexOf(ieTag) > -1) {
							pe_ce = pe_fo.substring(pe_fo.indexOf("\x3c") + 1,
									pe_fo.indexOf("\x3a")).Trim();
						}
						return;
					});
					if (pe_ce) {
						pe_dD = pe_ce.toLowerCase() + "\x3a" + pe_dD;
					}
				}
				var pe_akB = pe_dD;
				if (pe_dD == '')
					break;
				if (pe_dD == '\x6e\x61\x6d\x6f\x73\x65\x2d\x66\x6f\x6e\x74')
					pe_dD = this.pe_ath;
				if (pe_dD == '\x2f\x6e\x61\x6d\x6f\x73\x65\x2d\x66\x6f\x6e\x74')
					pe_dD = "\x2f" + this.pe_ath;
				if (pe_dD == '\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x70\x61\x6e')
					pe_dD = this.pe_atf;
				if (pe_dD == '\x2f\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x70\x61\x6e')
					pe_dD = "\x2f" + this.pe_atf;
				if (pe_dD == '\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x63\x72\x69\x70\x74')
					pe_dD = this.pe_atg;
				if (pe_dD == '\x2f\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x63\x72\x69\x70\x74')
					pe_dD = "\x2f" + this.pe_atg;
				if (pe_dD == '\x6d\x65\x74\x61') {
					var pe_aGP = String(pe_cK.name).toLowerCase();
					if (pe_aGP == '\x67\x65\x6e\x65\x72\x61\x74\x6f\x72')
						break;
				}
				if (agentInfo.IsIE && pe_dD == '\x6f\x62\x6a\x65\x63\x74') {
					var pe_SK = this.pe_asD(this._oThis.pe_GZ(pe_cK.outerHTML));
					var pe_qa = "";
					if (!(/<param/i.test(pe_SK)))
						pe_qa = this.pe_asD(NamoSE.Util
								.pe_adZ(this.pe_ahv[this.pe_aii]));
					if (pe_qa != "") {
						pe_SK = pe_SK.replace(/(<object\s?[^>]*>)/i, "\x24\x31"
								+ pe_qa);
					}
					this.pe_aii++;
					text += pe_SK;
					continue;
				}
				if (saveas == true) {
					if (agentInfo.IsIE
							&& (pe_dD == '\x74\x69\x74\x6c\x65' || pe_dD == '\x73\x74\x79\x6c\x65')) {
						continue;
					}
				}
				if (pe_dD == '\x73\x63\x72\x69\x70\x74') {
					if (typeof (this._oThis.params.AllowContentScript) != '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
							&& this._oThis.params.AllowContentScript == false) {
						continue;
					}
				}
				if (pe_dD == '\x69\x66\x72\x61\x6d\x65') {
					if (typeof (this._oThis.params.AllowContentIframe) != '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
							&& this._oThis.params.AllowContentIframe == false) {
						continue;
					}
				}
				if (this._oThis.params.TagBlockList.InArray(pe_dD))
					continue;
				if (pe_dD == '\x73\x70\x61\x6e' && pe_akB == '\x73\x70\x61\x6e') {
					if (pe_cK.innerHTML == "") {
						if (!pe_cK.id || pe_cK.id == "") {
						} else {
							if ([
									'\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x45\x64\x69\x74\x6f\x72\x43\x61\x72\x65\x74\x53\x74\x61\x72\x74',
									'\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x45\x64\x69\x74\x6f\x72\x43\x61\x72\x65\x74\x45\x6e\x64',
									'\x73\x70\x61\x6e\x5f\x73\x74\x74\x63\x61\x72\x65\x74',
									'\x73\x70\x61\x6e\x5f\x65\x6e\x64\x63\x61\x72\x65\x74' ]
									.InArray(pe_cK.id))
								continue;
						}
					} else {
						if (escape(pe_cK.innerHTML) == "\x25\x75\x46\x45\x46\x46")
							continue;
					}
				}
				if (!pe_aho && pe_dD == '\x62\x6f\x64\x79') {
					pe_arr = false;
				}
				if (pe_dD == '\x21') {
					var pe_gZ = pe_ape.exec(pe_cK.text);
					if (pe_gZ) {
						var pe_pd = pe_gZ[1];
						text += this.pe_atn(pe_pd);
					}
				} else {
					if (pe_dD == '\x68\x74\x6d\x6c'
							&& pe_iF == '\x70\x65\x5f\x57\x41') {
						text = '\x3c\x21\x44\x4f\x43\x54\x59\x50\x45\x20\x68\x74\x6d\x6c\x20\x50\x55\x42\x4c\x49\x43\x20\x22\x2d\x2f\x2f\x57\x33\x43\x2f\x2f\x44\x54\x44\x20\x58\x48\x54\x4d\x4c\x20\x31\x2e\x30\x20\x54\x72\x61\x6e\x73\x69\x74\x69\x6f\x6e\x61\x6c\x2f\x2f\x45\x4e\x22\x20\x22\x68\x74\x74\x70\x3a\x2f\x2f\x77\x77\x77\x2e\x77\x33\x2e\x6f\x72\x67\x2f\x54\x52\x2f\x78\x68\x74\x6d\x6c\x31\x2f\x44\x54\x44\x2f\x78\x68\x74\x6d\x6c\x31\x2d\x74\x72\x61\x6e\x73\x69\x74\x69\x6f\x6e\x61\x6c\x2e\x64\x74\x64\x22\x3e\n';
					}
					if (pe_agp.indexOf('\x7c' + pe_dD + '\x7c') != -1) {
						if ((pe_aop || text != '') && !inpre)
							text += '\n';
						else
							pe_aop = true;
					}
					text += '\x3c' + pe_dD;
					var attr = NamoSE.Util.pe_Fe(pe_cK);
					var pe_aFV = attr.length;
					var pe_em;
					var pe_aiK = "";
					var pe_akr = false;
					var pe_akl = false;
					var pe_akm = false;
					var pe_aqO = false;
					for (var j = 0; j < pe_aFV; j++) {
						var pe_dq = attr[j].nodeName.toLowerCase();
						if (this._oThis.params.AttributeBlockList
								.InArray(pe_dq))
							continue;
						if (!attr[j].specified
								&& ![ '\x73\x65\x6c\x65\x63\x74\x65\x64',
										'\x73\x74\x79\x6c\x65',
										'\x76\x61\x6c\x75\x65',
										'\x63\x6f\x6f\x72\x64\x73',
										'\x73\x68\x61\x70\x65' ].InArray(pe_dq)) {
							if (agentInfo.IsIE && parseInt(pe_cm) >= 8) {
								if (!(pe_cK.nodeName == "\x49\x4e\x50\x55\x54"
										&& pe_dq == "\x74\x79\x70\x65" && pe_cK
										.getAttribute(pe_dq) == "\x74\x65\x78\x74"))
									continue;
							} else {
								continue;
							}
						}
						if (/[\"\'?]/.test(pe_dq))
							continue;
						if (agentInfo.IsIE
								&& parseInt(pe_cm) < 8
								&& [ '\x42\x4f\x44\x59', '\x49\x4d\x47' ]
										.InArray(pe_cK.nodeName)
								&& ![ '\x63\x6c\x61\x73\x73', '\x66\x6f\x72' ]
										.InArray(pe_dq)
								&& pe_cK.getAttribute(pe_dq) == null)
							continue;
						if (pe_dq == '\x73\x74\x79\x6c\x65'
								&& pe_cK.style.cssText == "")
							continue;
						if (agentInfo.IsIE
								&& (pe_dq == "\x63\x6f\x6e\x74\x65\x6e\x74\x65\x64\x69\x74\x61\x62\x6c\x65"
										|| pe_dq == "\x64\x61\x74\x61\x2d\x6e\x61\x6d\x6f\x73\x65\x2d\x6f\x72\x67\x61\x68\x72\x65\x66" || pe_dq == "\x6e\x61\x6d\x6f\x73\x65\x5f\x74\x65\x6d\x70\x73\x61\x76\x65\x73\x74\x79\x6c\x65"))
							continue;
						if (agentInfo.IsIE && pe_cK.nodeName == "\x49\x4d\x47"
								&& pe_dq == "\x63\x6f\x6d\x70\x6c\x65\x74\x65")
							continue;
						if (agentInfo.IsIE && pe_cK.nodeName == "\x41"
								&& pe_dq == "\x73\x68\x61\x70\x65"
								&& pe_cK.getAttribute(pe_dq) == "")
							continue;
						if (pe_dq == '\x73\x65\x6c\x65\x63\x74\x65\x64'
								&& (!pe_cK.selected || pe_dq == '\x73\x74\x79\x6c\x65')
								&& pe_cK.style.cssText == '')
							continue;
						if (pe_dq == '\x5f\x6d\x6f\x7a\x5f\x64\x69\x72\x74\x79'
								|| pe_dq == '\x5f\x6d\x6f\x7a\x5f\x72\x65\x73\x69\x7a\x69\x6e\x67'
								|| pe_dq == '\x5f\x6d\x6f\x7a\x2d\x75\x73\x65\x72\x64\x65\x66\x69\x6e\x65\x64'
								|| (pe_dD == '\x62\x72'
										&& pe_dq == '\x74\x79\x70\x65' && pe_cK
										.getAttribute('\x74\x79\x70\x65') == '\x5f\x6d\x6f\x7a'))
							continue;
						if (pe_dq == '\x73\x74\x79\x6c\x65'
								&& pe_cK.nodeName == "\x54\x44"
								&& pe_cK.style.backgroundImage != ""
								&& (pe_cK.style.backgroundImage
										.indexOf("\x63\x65\x6c\x6c\x5f\x72\x65\x73\x69\x7a\x65\x5f\x68\x65\x69\x67\x68\x74\x2e\x67\x69\x66") != -1 || pe_cK.style.backgroundImage
										.indexOf("\x63\x65\x6c\x6c\x5f\x72\x65\x73\x69\x7a\x65\x5f\x77\x69\x64\x74\x68\x2e\x67\x69\x66") != -1))
							pe_cK.style.backgroundImage = "";
						var pe_aln = true;
						switch (pe_dq) {
						case "\x73\x74\x79\x6c\x65":
							if (pe_cK.style.fontSize
									&& pe_am(pe_cK.style.fontSize) != "\x58")
								pe_cK.style.fontSize = pe_am(pe_cK.style.fontSize);
							pe_em = pe_cK.style.cssText;
							if (pe_cK.style.backgroundImage != ""
									&& pe_cK.style.backgroundImage
											.indexOf("\"") != -1)
								pe_em = pe_em.replace(/\"/g, "");
							break;
						case "\x63\x6c\x61\x73\x73":
							pe_em = pe_cK.className;
							break;
						case "\x66\x6f\x72":
							var pe_afT = (agentInfo.IsIE && parseInt(pe_cm) < 8 && pe_cK.nodeName == "\x4c\x41\x42\x45\x4c") ? "\x68\x74\x6d\x6c\x46\x6f\x72"
									: "\x66\x6f\x72";
							pe_em = pe_cK.getAttribute(pe_afT);
							break;
						case "\x68\x74\x74\x70\x2d\x65\x71\x75\x69\x76":
							pe_em = pe_cK.httpEquiv;
							break;
						case "\x63\x6f\x6d\x70\x61\x63\x74":
						case "\x63\x68\x65\x63\x6b\x65\x64":
						case "\x64\x65\x63\x6c\x61\x72\x65":
						case "\x72\x65\x61\x64\x6f\x6e\x6c\x79":
						case "\x64\x69\x73\x61\x62\x6c\x65\x64":
						case "\x73\x65\x6c\x65\x63\x74\x65\x64":
						case "\x64\x65\x66\x65\x72":
						case "\x69\x73\x6d\x61\x70":
						case "\x6e\x6f\x68\x72\x65\x66":
						case "\x6e\x6f\x73\x68\x61\x64\x65":
						case "\x6e\x6f\x77\x72\x61\x70":
						case "\x6d\x75\x6c\x74\x69\x70\x6c\x65":
						case "\x6e\x6f\x72\x65\x73\x69\x7a\x65":
						case "\x6e\x61\x6d\x6f\x5f\x6c\x6f\x63\x6b":
						case "\x6d\x61\x6e\x61\x67\x65\x72\x5f\x6d\x6f\x64\x65":
							pe_em = pe_dq;
							break;
						default:
							try {
								if (agentInfo.IsIE6
										&& !agentInfo.IsIE9
										&& pe_dq == '\x62\x67\x63\x6f\x6c\x6f\x72') {
									if (agentInfo.IsIE6 && !agentInfo.IsIE8) {
										var pe_Mr = "";
										pe_aiK = pe_cK.outerHTML;
										pe_aiK = pe_aiK
												.replace(
														t.pe_et.attr,
														function(content,
																pe_hw, val1, b,
																val2) {
															if (pe_hw
																	.toLowerCase() == '\x62\x67\x63\x6f\x6c\x6f\x72'
																	&& !pe_Mr) {
																pe_Mr = val1;
																if (!pe_Mr) {
																	pe_Mr = val2;
																}
															}
														});
										pe_em = pe_Mr;
									} else {
										pe_em = pe_cK.getAttribute(pe_dq, 2);
									}
								} else {
									pe_em = pe_cK.getAttribute(pe_dq, 2);
								}
								if (agentInfo.IsIE
										&& parseInt(pe_cm) < 8
										&& pe_cK.nodeName == "\x45\x4d\x42\x45\x44") {
									if (pe_dq == "\x74\x79\x70\x65") {
										pe_em = this.pe_afx(pe_cK,
												'\x74\x79\x70\x65');
									} else if (pe_dq == "\x61\x6c\x69\x67\x6e") {
										pe_em = this.pe_afx(pe_cK,
												'\x61\x6c\x69\x67\x6e');
									} else {
										if (!pe_em)
											pe_em = pe_cK.getAttribute(pe_dq);
									}
								}
								if (pe_em == null) {
									continue;
								}
								if (typeof (pe_em) == "\x66\x75\x6e\x63\x74\x69\x6f\x6e"
										&& agentInfo.IsIE
										&& parseInt(pe_cm) < 9) {
									var pe_Qt = pe_em.toString();
									if (pe_Qt
											.indexOf("\x61\x6e\x6f\x6e\x79\x6d\x6f\x75\x73\x28\x29") != -1
											|| (pe_Qt.indexOf("\x7b") != -1 && pe_Qt
													.indexOf("\x7d") != -1)) {
										var pe_QZ = "";
										pe_QZ = pe_Qt.substring(pe_Qt
												.indexOf("\x7b") + 1);
										pe_QZ = pe_QZ.substring(0,
												pe_QZ.lastIndexOf("\x7d"))
												.Trim();
										pe_em = pe_QZ;
									}
								}
								if (agentInfo.IsGecko
										&& pe_dq == "\x66\x69\x6c\x65\x6d\x69\x6d\x65\x69\x6e\x66\x6f"
										&& pe_cK.nodeName != "\x42\x4f\x44\x59") {
									var pe_afI = NamoSE.Util.pe_ru(pe_cK);
									if (pe_afI
											&& pe_afI != ""
											&& pe_em
											&& pe_em != ""
											&& pe_cK.src
													.indexOf("\x25\x35\x45") != -1) {
										var pe_atR = pe_em.split("\x7c");
										var pe_WT = "";
										var pe_pA = document
												.createElement("\x64\x69\x76");
										pe_pA.innerHTML = pe_afI;
										if (pe_pA.firstChild)
											pe_WT = pe_pA.firstChild.src;
										if (pe_WT && pe_WT != "") {
											pe_em = pe_atR[0] + "\x7c"
													+ pe_atR[1] + "\x7c"
													+ pe_WT;
										}
										delete pe_pA;
									}
								}
							} catch (e) {
								pe_aln = false;
							}
						}
						if (pe_dq == '\x6c\x61\x6e\x67') {
							pe_akr = true;
						}
						if (pe_dq == '\x78\x6d\x6c\x3a\x6c\x61\x6e\x67') {
							pe_akl = true;
						}
						if (pe_dq == '\x78\x6d\x6c\x6e\x73')
							pe_akm = true;
						if (pe_aln) {
							if (!(pe_dD == '\x6c\x69' && pe_dq == '\x76\x61\x6c\x75\x65')) {
								pe_em = this.pe_aCW(pe_em);
								if (/\&quot;/.test(pe_em)
										&& (NamoSE.pe_cy.pe_aod.InArray(pe_dq)
												|| pe_dq == "\x68\x72\x65\x66" || (pe_dq == "\x73\x74\x79\x6c\x65" && (agentInfo.IsIE
												|| agentInfo.IsIE11 || agentInfo.IsGecko))))
									pe_em = pe_em.replace(/\&quot;/gi, "\x27");
								if (pe_em
										|| pe_dq != "\x63\x6f\x6f\x72\x64\x73") {
									text += '\x20' + pe_dq + '\x3d\x22' + pe_em
											+ '\x22';
								}
							}
						}
						if (pe_dq == '\x61\x6c\x74')
							pe_aqO = true;
					}
					if (pe_dD == '\x69\x6d\x67' && !pe_aqO) {
						text += '\x20\x61\x6c\x74\x3d\x22\x22';
					}
					if (pe_dD == '\x68\x74\x6d\x6c'
							&& pe_iF == '\x70\x65\x5f\x57\x41') {
						if (!pe_akr)
							text += '\x20\x6c\x61\x6e\x67\x3d\x22' + lang
									+ '\x22';
						if (!pe_akl)
							text += '\x20\x78\x6d\x6c\x3a\x6c\x61\x6e\x67\x3d\x22'
									+ lang + '\x22';
						if (!pe_akm)
							text += '\x20\x78\x6d\x6c\x6e\x73\x3d\x22\x68\x74\x74\x70\x3a\x2f\x2f\x77\x77\x77\x2e\x77\x33\x2e\x6f\x72\x67\x2f\x31\x39\x39\x39\x2f\x78\x68\x74\x6d\x6c\x22';
					}
					if ((agentInfo.IsIE && parseInt(pe_cm) < 9
							&& pe_cK.canHaveChildren && pe_dD != "\x62\x61\x73\x65")
							|| pe_cK.hasChildNodes()) {
						text += '\x3e';
						var pe_hX;
						if (pe_dD.toLowerCase() == "\x73\x63\x72\x69\x70\x74") {
							pe_hX = pe_cK.innerHTML;
							text += pe_hX;
						} else {
							text += this.pe_Ow(pe_cK, lang, encoding, pe_iF,
									true,
									inpre || pe_dD == '\x70\x72\x65' ? true
											: false, true, saveas);
						}
						if (pe_cK.nodeName == "\x50"
								&& (pe_cK.innerHTML == "" || pe_cK.innerHTML
										.replace(/\n/, "") == ""))
							text += ((agentInfo.IsIE) ? '\x26\x6e\x62\x73\x70\x3b'
									: brTag);
						if (pe_aia.indexOf('\x7c' + pe_dD + '\x7c') != -1) {
							text += '\n';
						}
						if (pe_dD != "\x62\x72") {
							text += '\x3c\x2f' + pe_dD + '\x3e';
						}
					} else {
						if (NamoSE.pe_cy.pe_zj.InArray(pe_dD)
								|| pe_dD == "\x62\x72") {
							if (pe_iF == "\x48\x54\x4d\x4c")
								text += '\x3e';
							else
								text += '\x20\x2f\x3e';
							if (pe_dD == '\x62\x72'
									&& NamoSE.Util.pe_ff(pe_cK.nextSibling))
								text += '\n';
						} else {
							if ([
									'\x6e\x61\x6d\x6f\x73\x65\x2d\x66\x6f\x6e\x74',
									'\x2f\x6e\x61\x6d\x6f\x73\x65\x2d\x66\x6f\x6e\x74',
									'\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x70\x61\x6e',
									'\x2f\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x70\x61\x6e',
									'\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x63\x72\x69\x70\x74',
									'\x2f\x6e\x61\x6d\x6f\x73\x65\x2d\x73\x63\x72\x69\x70\x74' ]
									.InArray(pe_akB)) {
								text += '\x3e';
							} else {
								text += '\x3e';
								var pe_pd;
								if (pe_dD == '\x73\x63\x72\x69\x70\x74') {
									pe_pd = pe_cK.text;
									if (typeof (pe_pd) == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64")
										pe_pd = "";
								} else
									pe_pd = pe_cK.innerHTML;
								if (pe_dD == '\x73\x74\x79\x6c\x65') {
									pe_pd = String(pe_pd).replace(/[\n]+/g,
											'\n');
								}
								if (pe_dD == '\x70') {
									pe_pd = ((agentInfo.IsIE) ? '\x26\x6e\x62\x73\x70\x3b'
											: brTag);
								}
								if (agentInfo.IsIE) {
									if (agentInfo.IsIE6 && !agentInfo.IsIE9) {
										if ([
												'\x6e\x6f\x65\x6d\x62\x65\x64',
												'\x61',
												'\x61\x62\x62\x72',
												'\x61\x63\x72\x6f\x6e\x79\x6d',
												'\x61\x64\x64\x72\x65\x73\x73',
												'\x61\x70\x70\x6c\x65\x74',
												'\x61\x72\x65\x61',
												'\x62',
												'\x62\x61\x73\x65',
												'\x62\x61\x73\x65\x66\x6f\x6e\x74',
												'\x62\x64\x6f',
												'\x62\x69\x67',
												'\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65',
												'\x62\x6f\x64\x79',
												'\x62\x72',
												'\x62\x75\x74\x74\x6f\x6e',
												'\x63\x61\x70\x74\x69\x6f\x6e',
												'\x63\x65\x6e\x74\x65\x72',
												'\x63\x69\x74\x65',
												'\x63\x6f\x64\x65',
												'\x63\x6f\x6c',
												'\x63\x6f\x6c\x67\x72\x6f\x75\x70',
												'\x64\x64',
												'\x64\x65\x6c',
												'\x64\x66\x6e',
												'\x64\x69\x72',
												'\x64\x69\x76',
												'\x64\x6c',
												'\x64\x74',
												'\x65\x6d',
												'\x66\x69\x65\x6c\x64\x73\x65\x74',
												'\x66\x6f\x6e\x74',
												'\x66\x6f\x72\x6d',
												'\x66\x72\x61\x6d\x65',
												'\x66\x72\x61\x6d\x65\x73\x65\x74',
												'\x68\x65\x61\x64',
												'\x68\x65\x61\x64\x65\x72',
												'\x68\x31',
												'\x68\x32',
												'\x68\x33',
												'\x68\x34',
												'\x68\x35',
												'\x68\x36',
												'\x68\x72',
												'\x68\x74\x6d\x6c',
												'\x69',
												'\x69\x66\x72\x61\x6d\x65',
												'\x69\x6d\x67',
												'\x69\x6e\x70\x75\x74',
												'\x69\x6e\x73',
												'\x6b\x62\x64',
												'\x6c\x61\x62\x65\x6c',
												'\x6c\x65\x67\x65\x6e\x64',
												'\x6c\x69',
												'\x6c\x69\x6e\x6b',
												'\x6d\x61\x70',
												'\x6d\x61\x6e\x75',
												'\x6d\x65\x74\x61',
												'\x6e\x6f\x66\x72\x61\x6d\x65\x73',
												'\x6e\x6f\x73\x63\x72\x69\x70\x74',
												'\x6f\x62\x6a\x65\x63\x74',
												'\x6f\x6c',
												'\x6f\x70\x74\x67\x72\x6f\x75\x70',
												'\x6f\x70\x74\x69\x6f\x6e',
												'\x70',
												'\x70\x61\x72\x61\x6d',
												'\x70\x72\x65',
												'\x71',
												'\x73',
												'\x73\x61\x6d\x70',
												'\x73\x63\x72\x69\x70\x74',
												'\x73\x65\x6c\x65\x63\x74',
												'\x73\x6d\x61\x6c\x6c',
												'\x73\x70\x61\x6e',
												'\x73\x74\x72\x69\x6b\x65',
												'\x73\x74\x72\x6f\x6e\x67',
												'\x73\x74\x79\x6c\x65',
												'\x73\x75\x62',
												'\x73\x75\x70',
												'\x74\x61\x62\x6c\x65',
												'\x74\x62\x6f\x64\x79',
												'\x74\x64',
												'\x74\x65\x78\x74\x61\x72\x65\x61',
												'\x74\x66\x6f\x6f\x74',
												'\x74\x68',
												'\x74\x68\x65\x61\x64',
												'\x74\x69\x74\x6c\x65',
												'\x74\x72', '\x74\x74', '\x75',
												'\x75\x6c', '\x76\x61\x72' ]
												.InArray(pe_dD)) {
											text += pe_pd + '\x3c\x2f' + pe_dD
													+ '\x3e';
										}
									} else if ([
											'\x6e\x6f\x65\x6d\x62\x65\x64',
											'\x61',
											'\x61\x62\x62\x72',
											'\x61\x63\x72\x6f\x6e\x79\x6d',
											'\x61\x64\x64\x72\x65\x73\x73',
											'\x61\x70\x70\x6c\x65\x74',
											'\x61\x72\x65\x61',
											'\x61\x72\x74\x69\x63\x6c\x65',
											'\x61\x73\x69\x64\x65',
											'\x61\x75\x64\x69\x6f',
											'\x62',
											'\x62\x61\x73\x65',
											'\x62\x61\x73\x65\x66\x6f\x6e\x74',
											'\x62\x64\x69',
											'\x62\x64\x6f',
											'\x62\x69\x67',
											'\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65',
											'\x62\x6f\x64\x79',
											'\x62\x72',
											'\x62\x75\x74\x74\x6f\x6e',
											'\x63\x61\x6e\x76\x61\x73',
											'\x63\x61\x70\x74\x69\x6f\x6e',
											'\x63\x65\x6e\x74\x65\x72',
											'\x63\x69\x74\x65',
											'\x63\x6f\x64\x65',
											'\x63\x6f\x6c',
											'\x63\x6f\x6c\x67\x72\x6f\x75\x70',
											'\x63\x6f\x6d\x6d\x61\x6e\x64',
											'\x64\x61\x74\x61\x6c\x69\x73\x74',
											'\x64\x64',
											'\x64\x65\x6c',
											'\x64\x65\x74\x61\x69\x6c\x73',
											'\x64\x66\x6e',
											'\x64\x69\x72',
											'\x64\x69\x76',
											'\x64\x6c',
											'\x64\x74',
											'\x65\x6d',
											'\x65\x6d\x62\x65\x64',
											'\x66\x69\x65\x6c\x64\x73\x65\x74',
											'\x66\x69\x67\x63\x61\x70\x74\x69\x6f\x6e',
											'\x66\x69\x67\x75\x72\x65',
											'\x66\x6f\x6e\x74',
											'\x66\x6f\x6f\x74\x65\x72',
											'\x66\x6f\x72\x6d',
											'\x66\x72\x61\x6d\x65',
											'\x66\x72\x61\x6d\x65\x73\x65\x74',
											'\x68\x65\x61\x64',
											'\x68\x65\x61\x64\x65\x72',
											'\x68\x67\x72\x6f\x75\x70',
											'\x68\x31', '\x68\x32', '\x68\x33',
											'\x68\x34', '\x68\x35', '\x68\x36',
											'\x68\x72', '\x68\x74\x6d\x6c',
											'\x69', '\x69\x66\x72\x61\x6d\x65',
											'\x69\x6d\x67',
											'\x69\x6e\x70\x75\x74',
											'\x69\x6e\x73', '\x6b\x62\x64',
											'\x6b\x65\x79\x67\x65\x6e',
											'\x6c\x61\x62\x65\x6c',
											'\x6c\x65\x67\x65\x6e\x64',
											'\x6c\x69', '\x6c\x69\x6e\x6b',
											'\x6d\x61\x70', '\x6d\x61\x72\x6b',
											'\x6d\x61\x6e\x75',
											'\x6d\x65\x74\x61',
											'\x6d\x65\x74\x65\x72',
											'\x6e\x61\x76',
											'\x6e\x6f\x66\x72\x61\x6d\x65\x73',
											'\x6e\x6f\x73\x63\x72\x69\x70\x74',
											'\x6f\x62\x6a\x65\x63\x74',
											'\x6f\x6c',
											'\x6f\x70\x74\x67\x72\x6f\x75\x70',
											'\x6f\x70\x74\x69\x6f\x6e',
											'\x6f\x75\x74\x70\x75\x74', '\x70',
											'\x70\x61\x72\x61\x6d',
											'\x70\x72\x65',
											'\x70\x72\x6f\x67\x72\x65\x73\x73',
											'\x71', '\x72\x70', '\x72\x74',
											'\x72\x75\x62\x79', '\x73',
											'\x73\x61\x6d\x70',
											'\x73\x63\x72\x69\x70\x74',
											'\x73\x65\x63\x74\x69\x6f\x6e',
											'\x73\x65\x6c\x65\x63\x74',
											'\x73\x6d\x61\x6c\x6c',
											'\x73\x6f\x75\x72\x63\x65',
											'\x73\x70\x61\x6e',
											'\x73\x74\x72\x69\x6b\x65',
											'\x73\x74\x72\x6f\x6e\x67',
											'\x73\x74\x79\x6c\x65',
											'\x73\x75\x62',
											'\x73\x75\x6d\x6d\x61\x72\x79',
											'\x73\x75\x70',
											'\x74\x61\x62\x6c\x65',
											'\x74\x62\x6f\x64\x79', '\x74\x64',
											'\x74\x65\x78\x74\x61\x72\x65\x61',
											'\x74\x66\x6f\x6f\x74', '\x74\x68',
											'\x74\x68\x65\x61\x64',
											'\x74\x69\x6d\x65',
											'\x74\x69\x74\x6c\x65', '\x74\x72',
											'\x74\x72\x61\x63\x6b', '\x74\x74',
											'\x75', '\x75\x6c', '\x76\x61\x72',
											'\x76\x69\x64\x65\x6f',
											'\x77\x62\x72' ].InArray(pe_dD)) {
										text += pe_pd + '\x3c\x2f' + pe_dD
												+ '\x3e';
									}
								} else {
									text += pe_pd + '\x3c\x2f' + pe_dD + '\x3e';
								}
							}
						}
					}
				}
				break;
			}
			case 3: {
				if (!inpre) {
					if (pe_cK.nodeValue != '\n') {
						if (pe_cK.parentNode
								&& pe_cK.parentNode.nodeType == 1
								&& [ '\x53\x43\x52\x49\x50\x54',
										'\x4e\x4f\x53\x43\x52\x49\x50\x54',
										'\x53\x54\x59\x4c\x45',
										'\x4e\x41\x4d\x4f\x53\x45\x2d\x53\x43\x52\x49\x50\x54' ]
										.InArray(pe_cK.parentNode.nodeName)) {
							text += pe_cK.nodeValue;
						} else {
							text += this.pe_amc(this.pe_asV(pe_cK.nodeValue));
						}
					}
				} else
					text += this.pe_amc(this.pe_asV(pe_cK.nodeValue));
				break;
			}
			case 8: {// -->
				try {
					var pe_azw = (agentInfo.IsIE) ? this._oThis
							.pe_GZ(pe_cK.nodeValue) : pe_cK.nodeValue;
					text += this.pe_atn(pe_azw);
				} catch (e) {
					if (pe_cK.outerHTML) {
						text += pe_cK.outerHTML;
					} else {
						text += pe_cK.text;
					}
				}
				break;
			}
			default:
				break;
			}
		}
		if (!pe_aho && !pe_arr) {
			text = text.replace(/<\/?head>[\n]*/gi, "");
			text = text.replace(/<head \/>[\n]*/gi, "");
			text = text.replace(/<\/?body>[\n]*/gi, "");
		}
		return text;
	},
	pe_atn : function(text) {
		var pe_aoC = new RegExp();
		pe_aoC.compile("\x2d\x24");// -->
		if (pe_aoC.exec(text)) {
			text += "\x20";
		}
		return "\x3c\x21\x2d\x2d" + text + "\x2d\x2d\x3e";
	},
	pe_amc : function(text) {
		var pe_aze = "";
		var pe_azm = "";
		var pe_nu = String(text).replace(/(^(?:\s+))/g, function(a) {
			pe_aze = "\x20";
			if (/[ ]/.test(a)) {
				return "\x20";
			} else if (/[　]/.test(a)) {
				return a;
			} else {
				return "";
			}
		});
		pe_nu = String(pe_nu).replace(/((?:\s+)$)/g, function(a) {
			pe_azm = "\x20";
			if (/[ ]/.test(a)) {
				return "\x20";
			} else if (/[　]/.test(a)) {
				return a;
			} else {
				return "";
			}
		});
		return pe_nu;
	},
	pe_aDr : function(text) {
		var pe_HI = escape(text);
		if (/^(?:\%uFEFF)/.test(pe_HI))
			text = unescape(pe_HI.replace("\x25\x75\x46\x45\x46\x46", ""));
		return text;
	},
	pe_asV : function(text) {
		var pe_nu = String(text).replace(/\&lt;/g,
				"\x23\x68\x32\x78\x5f\x6c\x74").replace(/\&gt;/g,
				"\x23\x68\x32\x78\x5f\x67\x74");
		pe_nu = pe_nu.replace(/\n{2,}/g, "\n").replace(/\&/g,
				"\x26\x61\x6d\x70\x3b").replace(/</g, "\x26\x6c\x74\x3b")
				.replace(/>/g, "\x26\x67\x74\x3b");
		pe_nu = this._oThis.pe_atd(pe_nu);
		return this.pe_aDr(pe_nu.replace(/#h2x_lt/g, "\x26\x6c\x74\x3b")
				.replace(/#h2x_gt/g, "\x26\x67\x74\x3b"));
	},
	pe_aCW : function(text) {
		var pe_nu = String(text).replace(/\&lt;/g,
				"\x23\x68\x32\x78\x5f\x6c\x74").replace(/\&gt;/g,
				"\x23\x68\x32\x78\x5f\x67\x74");
		pe_nu = pe_nu.replace(/\&/g, "\x26\x61\x6d\x70\x3b").replace(/</g,
				"\x26\x6c\x74\x3b").replace(/>/g, "\x26\x67\x74\x3b").replace(
				/\"/g, "\x26\x71\x75\x6f\x74\x3b");
		return pe_nu.replace(/#h2x_lt/g, "\x26\x6c\x74\x3b").replace(
				/#h2x_gt/g, "\x26\x67\x74\x3b");
	},
	pe_asD : function(text) {
		var temp = String(text).Trim();
		var pe_gX = this._oThis;
		temp = temp.replace(this._oThis.pe_et.attr, function(pe_pE, name, val1,
				val2, val3) {
			if (pe_pE.indexOf("\x3d") != -1) {
				if (name && val1) {
					return name.toLowerCase() + "\x3d\"" + val1 + "\"";
				} else if (name && val2) {
					return name.toLowerCase() + "\x3d\"" + val2 + "\"";
				} else if (name && val3) {
					return name.toLowerCase() + "\x3d\"" + val3 + "\"";
				} else {
					return name.toLowerCase() + "\x3d\"\"";
				}
			} else {
				return pe_pE;
			}
		});
		temp = temp.replace(/(?:[A-Za-z0-9\-_]+)=[ >]/gi, function(a) {
			return a.toLowerCase().replace(/=/, '\x3d\x22\x22');
		});
		temp = temp.replace(/<OBJECT[ >]/gi, function(a) {
			return "\n" + a.toLowerCase()
		});
		temp = temp.replace(/<\/OBJECT>/gi,
				'\x3c\x2f\x6f\x62\x6a\x65\x63\x74\x3e');
		temp = temp.replace(/<PARAM[ >]/gi, function(a) {
			return "\n" + a.toLowerCase()
		});
		temp = temp.replace(/<\/PARAM>/gi, '\x3c\x2f\x70\x61\x72\x61\x6d\x3e');
		temp = temp.replace(/<EMBED[ >]/gi, function(a) {
			return a.toLowerCase()
		});
		temp = temp.replace(/<\/EMBED>/gi, '');
		temp = temp.replace(/<param\s?[^>]*>(?!<\/param>)/gi, function(a) {
			return a.replace(/>/, "\x20\x2f\x3e")
		});
		temp = temp.replace(/[\s]+(<embed)/gi, "\n\x24\x31");
		temp = temp.replace(/(<embed\s?[^>]*>)[\s]+/gi, "\x24\x31");
		temp = temp.replace(/<embed\s?[^>]*>/gi, function(a) {
			if (!/\s?\/\s?>$/.test(a)) {
				return a.replace(/>/, "\x20\x2f\x3e");
			} else {
				return a;
			}
		});
		return temp;
	},
	pe_afx : function(pe_bG, cType) {
		var pe_aek = "";
		var eDiv = document.createElement('\x64\x69\x76');
		eDiv.innerHTML = pe_bG.outerHTML.replace(/embed/gi, "\x73\x70\x61\x6e");
		if (cType == "\x74\x79\x70\x65") {
			if (eDiv.firstChild && eDiv.firstChild.type) {
				pe_aek = eDiv.firstChild.type;
			}
		} else if (cType == "\x61\x6c\x69\x67\x6e") {
			if (eDiv.firstChild && eDiv.firstChild.align) {
				pe_aek = eDiv.firstChild.align;
			}
		}
		delete eDiv;
		return pe_aek;
	},
	pe_T : function(toolbar, index, flag) {
		if (typeof toolbar == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_BZ = [];
		var display;
		var pe_Qs = this._oThis.util.pe_bP(toolbar, "\x74\x72");
		for (var i = 0; i < pe_Qs.length; i++) {
			var pe_alq = NamoSE.Util.pe_ff(pe_Qs[i].firstChild);
			if (pe_alq && pe_alq.className == "\x70\x65\x5f\x76\x5a")
				pe_BZ.push(pe_Qs[i]);
		}
		var pe_ahV = function(node) {
			var pe_YU = NamoSE.Util.pe_ff(node.nextSibling);
			if (pe_YU) {
				var pe_akE = NamoSE.Util.pe_ff(pe_YU.firstChild);
				if (pe_akE && pe_akE.className == "\x70\x65\x5f\x44\x6b") {
					pe_YU.style.display = display;
					var pe_agR = NamoSE.Util.pe_ff(pe_YU.nextSibling);
					if (pe_agR) {
						var pe_ary = NamoSE.Util.pe_ff(pe_agR.firstChild);
						if (pe_ary
								&& pe_ary.className == "\x70\x65\x5f\x46\x64") {
							pe_agR.style.display = display;
						}
					}
				}
			}
		};
		if (pe_BZ[index]) {
			display = (flag) ? '' : '\x6e\x6f\x6e\x65';
			pe_BZ[index].style.display = display;
			pe_ahV(pe_BZ[index]);
		}
		var pe_Py = [];
		for (var k = 0; k < pe_BZ.length; k++) {
			if (pe_BZ[k].style.display != "\x6e\x6f\x6e\x65")
				pe_Py.push(pe_BZ[k]);
		}
		var pe_zE = toolbar.parentNode.parentNode;
		if (pe_Py.length > 0) {
			for (var j = 0; j < pe_Py.length; j++) {
				display = ((pe_Py.length - 1) == j) ? '\x6e\x6f\x6e\x65' : '';
				pe_ahV(pe_Py[j]);
			}
			if (pe_zE && pe_zE.nodeType == 1 && pe_zE.nodeName == "\x54\x52")
				pe_zE.style.display = "";
		} else {
			for (var j = 0; j < pe_Qs.length; j++) {
				display = '\x6e\x6f\x6e\x65';
				pe_ahV(pe_Qs[j]);
			}
			if (pe_zE && pe_zE.nodeType == 1 && pe_zE.nodeName == "\x54\x52")
				pe_zE.style.display = "\x6e\x6f\x6e\x65";
		}
	},
	pe_aCb : function(pe_iZ, pe_jp) {
		var t = this._oThis;
		if (typeof pe_iZ == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
				&& typeof pe_jp == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_Qa = 0;
		var pe_pu = 0;
		var pe_aHo = t.params.Height;
		var pe_sa = String(pe_iZ).Trim();
		var pe_sc = String(pe_jp).Trim();
		var pe_auj = pe_bE.pe_Hm;
		if (pe_sa == "" && pe_sc == "")
			return;
		if (pe_sa == "" || pe_sa == String(t.params.Width))
			pe_sa = "";
		if (pe_sa != "") {
			var pe_Mz = t.pe_Wp('\x77\x69\x64\x74\x68', pe_sa);
			if (pe_Mz.err) {
				alert(pe_auj);
				return;
			}
			pe_sa = pe_Mz.val;
			if (String(pe_sa) != String(t.params.Width)) {
				t.params.Width = pe_sa;
				t.pe_ei.style.width = (String(t.params.Width).indexOf("\x25") != -1) ? t.params.Width
						: t.params.Width + "\x70\x78";
				t.pe_kp.style.width = t.pe_ei.style.width;
				t.pe_hx["\x70\x65\x5f\x74\x6a"] = (t.util.pe_jH(document
						.getElementById("\x70\x65\x5f\x76\x57")) - t.util
						.pe_jH(document.getElementById("\x70\x65\x5f\x55\x6a")))
						+ document.getElementById("\x70\x65\x5f\x76\x57").offsetWidth;
			} else {
				pe_sa = "";
			}
		}
		if (pe_sc == "" || pe_sc == String(t.params.Height))
			pe_sc = "";
		if (pe_sc != "") {
			var pe_MU = t.pe_Wp('\x68\x65\x69\x67\x68\x74', pe_sc);
			if (pe_MU.err) {
				alert(pe_auj);
				return;
			}
			pe_sc = pe_MU.val;
			if (String(pe_sc) != String(t.params.Height)) {
				t.params.Height = pe_sc;
				if (t.pe_hx["\x70\x65\x5f\x6f\x49"]) {
					pe_Qa = t.pe_hx["\x70\x65\x5f\x6f\x49"]
							- t.pe_kp.scrollHeight;
				}
				pe_pu = parseInt(t.params.Height) - pe_aHo + pe_Qa;
				if (agentInfo.IsIE && parseInt(pe_cm) >= 8)
					t.pe_wb = false;
				t.pe_gn.style.height = (parseInt(t.pe_gn.style.height
						.replace("\x70\x78")) + pe_pu)
						+ "\x70\x78";
				t.editorTextarea.style.height = (parseInt(t.editorTextarea.style.height
						.replace("\x70\x78")) + pe_pu)
						+ "\x70\x78";
				t.pe_hx["\x70\x65\x5f\x6f\x49"] = t.pe_kp.scrollHeight;
				if (agentInfo.IsIE && parseInt(pe_cm) >= 8)
					t.pe_wb = true;
				var pe_Ik = (pe_ev == "\x4d\x61\x63\x69\x6e\x74\x6f\x73\x68" && (agentInfo.IsGecko || agentInfo.IsChrome)) ? 2
						: 0;
				t.pe_ei.style.height = (parseInt(t.params.Height) + ((agentInfo.IsIE && parseInt(pe_cm) < 8) ? 0
						: (5 + pe_Ik)))
						+ "\x70\x78";
			} else {
				pe_sc = ""
			}
		}
	},
	pe_aBl : function(pe_sw) {
		this._oThis.pe_amk(pe_sw, '\x41\x50\x49\x43\x68\x61\x6e\x67\x65');
	}
};
var pe_avW = {
	_oThis : null,
	pe_nY : null,
	pe_RO : null,
	pe_ahx : null,
	pe_rY : null,
	start : function() {
		var t = this;
		var table = t.pe_nY;
		var idoc = t._oThis.getDocument();
		if (!(table && table.tagName == '\x54\x41\x42\x4c\x45'))
			return;
		if (t._oThis.pe_bV && t._oThis.pe_bV.length > 0) {
			var pe_pR = null;
			var pe_bC = t._oThis.getSelection();
			pe_bC.sel = pe_bC.getSelection();
			pe_bC.range = pe_bC.pe_bY();
			var pe_amq = function(pe_bW) {
				var pe_pe = null;
				var pe_IH = idoc.createElement("\x73\x70\x61\x6e");
				pe_IH.id = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65\x5f\x5f\x53\x74\x61\x72\x74";
				pe_IH.innerHTML = (agentInfo.IsOpera && parseInt(pe_cm) > 10) ? ""
						: "\x26\x6e\x62\x73\x70\x3b";
				var pe_IQ = idoc.createElement("\x73\x70\x61\x6e");
				pe_IQ.id = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65\x5f\x5f\x45\x6e\x64";
				pe_IQ.innerHTML = (agentInfo.IsOpera && parseInt(pe_cm) > 10) ? ""
						: "\x26\x6e\x62\x73\x70\x3b";
				if (pe_bW && pe_bW.firstChild) {
					var pe_ee = NamoSE.Util.pe_ff(pe_bW.firstChild);
					if (pe_ee) {
						pe_bW.insertBefore(pe_IH, pe_ee);
						pe_bW.appendChild(pe_IQ);
						if (pe_IH && pe_IQ) {
							pe_bC.range.setEndBefore(pe_IQ);
							pe_bC.range.setStartAfter(pe_IH);
							pe_bC.pe_bM();
							pe_pe = [ pe_IH, pe_IQ ];
						}
					}
				}
				return pe_pe;
			};
			var pe_aeT = false;
			if (agentInfo.IsGecko || agentInfo.IsOpera) {
				if (agentInfo.IsOpera) {
					if (!NamoSE.pe_cy.pe_oU.word_style.InArray(t.pe_rY)
							&& !NamoSE.pe_cy.pe_oU.word_listset
									.InArray(t.pe_rY)
							&& t.pe_rY != "\x63\x61\x6e\x63\x65\x6c\x61\x74\x74\x72\x69\x62\x75\x74\x65")
						pe_aeT = true;
				}
			}
			for (var i = 0; i < t._oThis.pe_bV.length; i++) {
				var pe_fD = t._oThis.pe_bV[i];
				var pe_zF = null;
				var pe_gy = null;
				if (pe_fD
						&& !t._oThis
								.pe_hO(pe_fD,
										"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b")) {
					var pe_azL = pe_fD.firstChild;
					if (pe_azL == null
							|| !pe_fD.getElementsByTagName("\x70")[0]) {
						var pe_afS = pe_fD.innerHTML;
						pe_afS = '\x3c\x70\x3e' + pe_afS + '\x3c\x2f\x70\x3e';
						pe_fD.innerHTML = pe_afS;
					}
					t.pe_aGl(pe_fD);
					if (agentInfo.IsIE || agentInfo.IsOpera) {
						if (agentInfo.IsOpera
								&& NamoSE.pe_cy.pe_oU.word_listset
										.InArray(t.pe_rY)) {
							if (!pe_fD.firstChild
									|| (pe_fD.lastChild == pe_fD.firstChild && pe_fD.lastChild.innerHTML
											.Trim().toLowerCase() == "\x3c\x62\x72\x3e"))
								continue;
							var pe_kQ = idoc.createRange();
							pe_kQ.selectNode(pe_fD);
							if (pe_kQ.toString().Trim() == "") {
								if (!t._oThis.util.pe_up(pe_fD,
										'\x45\x6c\x65\x41\x72\x72\x61\x79',
										t._oThis.config.pe_zj))
									continue;
							}
							if (pe_zF == null)
								pe_bC.pe_it(pe_fD.firstChild, pe_fD.lastChild);
						} else {
							if (pe_aeT)
								pe_zF = pe_amq(pe_fD);
							if (pe_zF == null)
								pe_bC.pe_zN(pe_fD);
						}
					} else {
						if (pe_aeT)
							pe_zF = pe_amq(pe_fD);
						if (pe_zF == null)
							pe_bC.pe_it(pe_fD.firstChild, pe_fD.lastChild);
					}
					if (t.pe_RO) {
						pe_gy = t._oThis.pe_arh(t.pe_RO, t.pe_ahx, t.pe_rY,
								pe_bC);
						if (!pe_gy)
							idoc.execCommand(t.pe_RO, false, t.pe_ahx || null);
					}
					if (!pe_pR)
						pe_pR = pe_fD;
					try {
						if (pe_zF != null) {
							pe_fD.removeChild(pe_zF[0]);
							pe_fD.removeChild(pe_zF[1]);
						}
					} catch (e) {
						var pe_afZ = idoc
								.getElementById("\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65\x5f\x5f\x53\x74\x61\x72\x74");
						var pe_agf = idoc
								.getElementById("\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65\x5f\x5f\x45\x6e\x64");
						if (pe_afZ)
							pe_afZ.parentNode.removeChild(pe_afZ);
						if (pe_agf)
							pe_agf.parentNode.removeChild(pe_agf);
					}
					if (agentInfo.IsGecko && t.pe_rY && !pe_gy) {
						var pe_bU = t._oThis
								.getFunctionals("\x73\x74\x79\x6c\x65\x67\x65\x74\x74\x65\x72");
						pe_bU.pe_sj = t.pe_rY;
						pe_bU.pe_asI();
					} else if (agentInfo.IsSafari || agentInfo.IsChrome) {
						if (NamoSE.pe_cy.pe_oU.word_listset.InArray(t.pe_rY)) {
							var pe_id = (t.pe_rY == "\x69\x6e\x73\x65\x72\x74\x75\x6e\x6f\x72\x64\x65\x72\x65\x64\x6c\x69\x73\x74") ? "\x75\x6c"
									: "\x6f\x6c";
							var pe_eZ = t._oThis.pe_IU(pe_id);
							if (pe_eZ != null)
								t._oThis.pe_amM(pe_eZ, pe_id);
							if (pe_fD.lastChild
									&& pe_fD.lastChild.nodeType == 1
									&& [ '\x55\x4c', '\x4f\x4c' ]
											.InArray(pe_fD.lastChild.nodeName)) {
								var pe_aEb = idoc.createElement("\x70");
								pe_fD.appendChild(pe_aEb);
							}
						}
					}
				}
			}
			if (pe_pR) {
				var pe_hK = NamoSE.Util.pe_bP(pe_pR, "\x70");
				var selectNode = (pe_hK && pe_hK.length > 0) ? pe_hK[0] : pe_pR;
				var pe_agl = t._oThis
						.getFunctionals('\x65\x6e\x74\x65\x72\x6b\x65\x79');
				pe_agl.pe_ki(selectNode);
			}
		}
	},
	pe_aGl : function(pe_bG) {
		if (typeof pe_bG == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_aui = function() {
			if (/[\t\n\r]/.test(pe_bG.innerHTML)) {
				pe_bG.innerHTML = pe_bG.innerHTML.replace(/[\t\n\r]/g, '');
			}
		};
		if (agentInfo.IsOpera) {
			if (pe_bG.firstChild && pe_bG.firstChild.nodeType == 1
					&& pe_bG.firstChild.nodeName == "\x50") {
				if (pe_bG.lastChild && pe_bG.firstChild == pe_bG.lastChild
						&& pe_bG.lastChild.lastChild
						&& pe_bG.lastChild.lastChild.nodeType == 1
						&& pe_bG.lastChild.lastChild.nodeName == "\x42\x52") {
					var pe_aoF = NamoSE.Util.pe_bP(pe_bG.firstChild, "\x70");
					if (pe_aoF && pe_aoF.length > 0) {
						pe_bG.innerHTML = pe_bG.lastChild.innerHTML;
					}
				}
			}
			if (pe_bG.lastChild && pe_bG.lastChild.nodeType == 1
					&& pe_bG.lastChild.nodeName == "\x50") {
				if (pe_bG.firstChild && pe_bG.firstChild != pe_bG.lastChild) {
					if (!pe_bG.lastChild.firstChild
							&& pe_bG.lastChild.innerHTML == "") {
						pe_bG.removeChild(pe_bG.lastChild);
					}
				} else {
					if (pe_bG.lastChild.lastChild
							&& pe_bG.lastChild.lastChild.nodeType == 1
							&& pe_bG.lastChild.lastChild.nodeName == "\x42\x52") {
						if (pe_bG.lastChild.lastChild != pe_bG.lastChild.firstChild
								&& pe_bG.lastChild.innerHTML.Trim()
										.toLowerCase() != "\x3c\x62\x72\x3e") {
							pe_bG.lastChild
									.removeChild(pe_bG.lastChild.lastChild);
						}
					}
				}
			}
			if (pe_bG.lastChild && pe_bG.lastChild.nodeType == 1
					&& pe_bG.lastChild.nodeName == "\x42\x52") {
				pe_bG.removeChild(pe_bG.lastChild);
			}
			pe_aui();
		} else if (agentInfo.IsSafari || agentInfo.IsChrome) {
			pe_aui();
		}
	},
	pe_aGm : function() {
		var t = this;
		var table = t.pe_nY;
		if (!(table && table.tagName == '\x54\x41\x42\x4c\x45'))
			return;
		if (t._oThis.pe_bV && t._oThis.pe_bV.length > 0) {
			var pe_pR = null;
			var pe_jR = (agentInfo.IsIE) ? "\x3c\x70\x3e\x26\x6e\x62\x73\x70\x3b\x3c\x2f\x70\x3e"
					: "\x3c\x70\x3e\x3c\x62\x72\x20\x2f\x3e\x3c\x2f\x70\x3e";
			for (var i = 0; i < t._oThis.pe_bV.length; i++) {
				var pe_fD = t._oThis.pe_bV[i];
				if (pe_fD
						&& !t._oThis
								.pe_hO(pe_fD,
										"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b")) {
					pe_fD.innerHTML = pe_jR;
					if (!pe_pR)
						pe_pR = pe_fD;
				}
			}
			if (pe_pR && !agentInfo.IsOpera) {
				var pe_hK = NamoSE.Util.pe_bP(pe_pR, "\x70");
				var selectNode = (pe_hK && pe_hK.length > 0) ? pe_hK[0] : pe_pR;
				var pe_agl = t._oThis
						.getFunctionals('\x65\x6e\x74\x65\x72\x6b\x65\x79');
				pe_agl.pe_ki(selectNode);
			}
			NamoSE.Util.pe_bO(function() {
				t._oThis.pe_dt(false);
			}, 20);
		}
	}
};
var pe_aFM = {
	_oThis : null,
	pe_bC : null,
	start : function(pe_hg) {
		var t = this;
		try {
			var idoc = t._oThis.getDocument();
			var pe_RC = t.pe_bC.sel;
			var oRange = t.pe_bC.range;
			var pe_aba = oRange;
			var pe_bK;
			var pe_dc;
			if (agentInfo.IsIE) {
				pe_bK = t._oThis.pe_gH(oRange, true);
				pe_dc = t._oThis.pe_gH(oRange, false);
			} else {
				pe_bK = pe_RC.anchorNode;
				pe_dc = pe_RC.focusNode;
			}
			if (pe_bK.nodeName.toLowerCase() == "\x62\x6f\x64\x79") {
				var eleP = idoc.createElement('\x70');
				eleP.innerHTML = "\x26\x6e\x62\x73\x70\x3b";
				pe_bK.insertBefore(eleP, null);
				pe_dc = pe_bK = eleP;
			}
			var pe_zk = pe_bK;
			var pe_zl = pe_dc;
			while (pe_zk.nodeName != "\x50" && pe_zk.nodeName != "\x4f\x4c"
					&& pe_zk.nodeName != "\x55\x4c"
					&& pe_zk.nodeName != "\x44\x49\x56") {
				pe_zk = pe_zk.parentNode;
				if (pe_zk.nodeName == "\x42\x4f\x44\x59") {
					break;
				}
			}
			while (pe_zl.nodeName != "\x50" && pe_zl.nodeName != "\x4f\x4c"
					&& pe_zl.nodeName != "\x55\x4c"
					&& pe_zl.nodeName != "\x44\x49\x56") {
				pe_zl = pe_zl.parentNode;
				if (pe_zl.nodeName == "\x42\x4f\x44\x59") {
					break;
				}
			}
			var pe_LJ = true;
			var pe_avL = true;
			while (pe_bK.nodeName != "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45") {
				pe_bK = pe_bK.parentNode;
				if (pe_bK.nodeName == "\x42\x4f\x44\x59") {
					pe_LJ = false;
					break;
				}
			}
			while (pe_dc.nodeName != "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45") {
				pe_dc = pe_dc.parentNode;
				if (pe_dc.nodeName == "\x42\x4f\x44\x59") {
					pe_avL = false;
					break;
				}
			}
			var pe_fQ = "";
			if (pe_hg == "\x62\x71\x30\x31") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x2d\x6c\x65\x66\x74\x2d\x63\x6f\x6c\x6f\x72\x3a\x20\x23\x63\x63\x63\x3b\x20\x62\x6f\x72\x64\x65\x72\x2d\x6c\x65\x66\x74\x2d\x77\x69\x64\x74\x68\x3a\x32\x70\x78\x3b\x20\x62\x6f\x72\x64\x65\x72\x2d\x6c\x65\x66\x74\x2d\x73\x74\x79\x6c\x65\x3a\x73\x6f\x6c\x69\x64\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x32") {
				pe_fQ = "\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x69\x6d\x61\x67\x65\x3a\x75\x72\x6c\x28"
						+ this._oThis.baseURL
						+ this._oThis.config.pe_cN
						+ "\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65\x2f\x62\x67\x5f\x62\x71\x30\x32\x2e\x67\x69\x66\x29\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x72\x65\x70\x65\x61\x74\x3a\x6e\x6f\x2d\x72\x65\x70\x65\x61\x74\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x33") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x61\x73\x68\x65\x64\x20\x23\x63\x63\x63\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x34") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x61\x73\x68\x65\x64\x20\x23\x36\x36\x62\x32\x34\x36\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x35") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x61\x73\x68\x65\x64\x20\x23\x63\x63\x63\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x72\x67\x62\x28\x32\x35\x30\x2c\x32\x35\x30\x2c\x32\x35\x30\x29\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x36") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x37") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x36\x36\x62\x32\x34\x36\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x38") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x72\x67\x62\x28\x32\x35\x30\x2c\x32\x35\x30\x2c\x32\x35\x30\x29\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x30\x39") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x32\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			} else if (pe_hg == "\x62\x71\x31\x30") {
				pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x32\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x72\x67\x62\x28\x32\x35\x30\x2c\x32\x35\x30\x2c\x32\x35\x30\x29\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
			}
			if (pe_bK == pe_dc && pe_LJ && pe_LJ) {
				if (pe_hg == "\x63\x61\x6e\x63\x65\x6c") {
					if (agentInfo.IsIE) {
						var pe_hy = pe_dc.innerHTML;
						pe_dc.outerHTML = pe_hy;
					} else if (agentInfo.IsOpera) {
						t._oThis.pe_bC = t._oThis.getSelection();
						pe_bC.pe_hU();
						var pe_hy = pe_dc.innerHTML;
						pe_dc.outerHTML = pe_hy;
						var pe_cX = pe_bC.pe_iX();
						pe_bC.pe_hW(pe_cX[0], pe_cX[1]);
						pe_bC.pe_hI(pe_cX[0], pe_cX[1]);
					} else {
						oRange.selectNodeContents(pe_dc);
						var pe_NL = oRange.cloneContents();
						oRange.selectNode(pe_dc);
						oRange.deleteContents();
						oRange.insertNode(pe_NL);
					}
				} else {
					if (agentInfo.IsIE && !agentInfo.IsIE8) {
						var pe_hy = pe_dc.innerHTML;
						if (!pe_dc.nextSibling) {
							pe_dc.outerHTML = pe_bK.outerHTML = "\x3c\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x20\x73\x74\x79\x6c\x65\x3d\x27"
									+ pe_fQ
									+ "\x27\x3e"
									+ pe_hy
									+ "\x3c\x2f\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x3e\x3c\x70\x3e\x3c\x2f\x62\x72\x3e\x3c\x2f\x70\x3e";
						} else {
							pe_dc.outerHTML = pe_bK.outerHTML = "\x3c\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x20\x73\x74\x79\x6c\x65\x3d\x27"
									+ pe_fQ
									+ "\x27\x3e"
									+ pe_hy
									+ "\x3c\x2f\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x3e";
						}
					} else {
						pe_dc.setAttribute("\x73\x74\x79\x6c\x65", pe_fQ);
					}
				}
			} else if ((pe_bK.parentNode == pe_dc.parentNode
					&& pe_bK.parentNode.nodeName == "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45"
					&& pe_LJ && pe_LJ)
					|| (pe_zk.parentNode == pe_dc.parentNode && pe_dc.parentNode.nodeName == "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45")) {
				if (pe_hg == "\x63\x61\x6e\x63\x65\x6c") {
					if (agentInfo.IsIE) {
						var pe_hy = pe_dc.parentNode.innerHTML;
						pe_dc.parentNode.outerHTML = pe_hy;
					} else if (agentInfo.IsOpera) {
						t._oThis.pe_bC = t._oThis.getSelection();
						pe_bC.pe_hU();
						var pe_hy = pe_dc.parentNode.innerHTML;
						pe_dc.parentNode.outerHTML = pe_hy;
						var pe_cX = pe_bC.pe_iX();
						pe_bC.pe_hW(pe_cX[0], pe_cX[1]);
						pe_bC.pe_hI(pe_cX[0], pe_cX[1]);
					} else {
						oRange.selectNodeContents(pe_dc.parentNode);
						var pe_NL = oRange.cloneContents();
						oRange.selectNode(pe_dc.parentNode);
						oRange.deleteContents();
						oRange.insertNode(pe_NL);
					}
				} else {
					if (agentInfo.IsIE && !agentInfo.IsIE8) {
						var pe_hy = pe_dc.parentNode.innerHTML;
						if (!pe_dc.parentNode.nextSibling) {
							pe_dc.parentNode.outerHTML = "\x3c\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x20\x73\x74\x79\x6c\x65\x3d\x27"
									+ pe_fQ
									+ "\x27\x3e"
									+ pe_hy
									+ "\x3c\x2f\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x3e\x3c\x70\x3e\x3c\x2f\x62\x72\x3e\x3c\x2f\x70\x3e";
						} else {
							pe_dc.parentNode.outerHTML = "\x3c\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x20\x73\x74\x79\x6c\x65\x3d\x27"
									+ pe_fQ
									+ "\x27\x3e"
									+ pe_hy
									+ "\x3c\x2f\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x3e";
						}
					} else {
						pe_dc.parentNode.setAttribute("\x73\x74\x79\x6c\x65",
								pe_fQ);
						return;
					}
				}
			} else if (pe_bK.parentNode == pe_zl.parentNode
					&& pe_bK.parentNode.nodeName == "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45") {
				if (pe_hg == "\x63\x61\x6e\x63\x65\x6c") {
					if (agentInfo.IsIE) {
						var pe_hy = pe_bK.parentNode.innerHTML;
						pe_bK.parentNode.outerHTML = pe_hy;
					} else if (agentInfo.IsOpera) {
						t._oThis.pe_bC = t._oThis.getSelection();
						pe_bC.pe_hU();
						var pe_hy = pe_bK.parentNode.innerHTML;
						pe_bK.parentNode.outerHTML = pe_hy;
						var pe_cX = pe_bC.pe_iX();
						pe_bC.pe_hW(pe_cX[0], pe_cX[1]);
						pe_bC.pe_hI(pe_cX[0], pe_cX[1]);
					} else {
						oRange.selectNodeContents(pe_bK.parentNode);
						var pe_NL = oRange.cloneContents();
						oRange.selectNode(pe_bK.parentNode);
						oRange.deleteContents();
						oRange.insertNode(pe_NL);
					}
				} else {
					if (agentInfo.IsIE && !agentInfo.IsIE8) {
						var pe_hy = pe_bK.parentNode.innerHTML;
						if (!pe_bK.parentNode.nextSibling) {
							pe_bK.parentNode.outerHTML = "\x3c\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x20\x73\x74\x79\x6c\x65\x3d\x27"
									+ pe_fQ
									+ "\x27\x3e"
									+ pe_hy
									+ "\x3c\x2f\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x3e\x3c\x70\x3e\x26\x6e\x62\x73\x70\x3b\x3c\x2f\x70\x3e";
						} else {
							pe_bK.parentNode.outerHTML = "\x3c\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x20\x73\x74\x79\x6c\x65\x3d\x27"
									+ pe_fQ
									+ "\x27\x3e"
									+ pe_hy
									+ "\x3c\x2f\x62\x6c\x6f\x63\x6b\x51\x75\x6f\x74\x65\x3e";
						}
					} else {
						pe_bK.parentNode.setAttribute("\x73\x74\x79\x6c\x65",
								pe_fQ);
					}
				}
			} else {
				t.pe_aFw(pe_hg);
				return;
			}
			if (agentInfo.IsIE && !agentInfo.IsIE8) {
				pe_aba.selectNode();
			} else {
				t.pe_bC.pe_bM();
			}
		} catch (exp) {
		}
	},
	pe_aFw : function(pe_hg) {
		var t = this;
		var pe_RC = t.pe_bC.sel;
		var oRange = t.pe_bC.range;
		var idoc = t._oThis.getDocument();
		var pe_bK;
		var pe_dc;
		if (agentInfo.IsIE) {
			pe_bK = t._oThis.pe_gH(oRange, true);
			pe_dc = t._oThis.pe_gH(oRange, false);
		} else {
			pe_bK = pe_RC.anchorNode;
			pe_dc = pe_RC.focusNode;
		}
		if (pe_bK.nodeName.toLowerCase() == "\x62\x6f\x64\x79") {
			var eleP = idoc.createElement('\x70');
			eleP.innerHTML = "\x26\x6e\x62\x73\x70\x3b";
			pe_bK.insertBefore(eleP, null);
			pe_dc = pe_bK = eleP;
		}
		while (pe_bK.nodeName != "\x50" && pe_bK.nodeName != "\x4f\x4c"
				&& pe_bK.nodeName != "\x55\x4c"
				&& pe_bK.nodeName != "\x44\x49\x56") {
			pe_bK = pe_bK.parentNode;
			if (pe_bK.nodeName == "\x42\x4f\x44\x59") {
				return;
			}
		}
		while (pe_bK.parentNode.nodeName == "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45") {
			pe_bK = pe_bK.parentNode;
			if (pe_bK.nodeName == "\x42\x4f\x44\x59") {
				return;
			}
		}
		while (pe_dc.nodeName != "\x50" && pe_dc.nodeName != "\x4f\x4c"
				&& pe_dc.nodeName != "\x55\x4c"
				&& pe_dc.nodeName != "\x44\x49\x56") {
			pe_dc = pe_dc.parentNode;
			if (pe_dc.nodeName == "\x42\x4f\x44\x59") {
				return;
			}
		}
		while (pe_dc.parentNode.nodeName == "\x42\x4c\x4f\x43\x4b\x51\x55\x4f\x54\x45") {
			pe_dc = pe_dc.parentNode;
			if (pe_dc.nodeName == "\x42\x4f\x44\x59") {
				return;
			}
		}
		var pe_fQ = "";
		if (pe_hg == "\x62\x71\x30\x31") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x2d\x6c\x65\x66\x74\x2d\x63\x6f\x6c\x6f\x72\x3a\x20\x23\x63\x63\x63\x3b\x20\x62\x6f\x72\x64\x65\x72\x2d\x6c\x65\x66\x74\x2d\x77\x69\x64\x74\x68\x3a\x32\x70\x78\x3b\x20\x62\x6f\x72\x64\x65\x72\x2d\x6c\x65\x66\x74\x2d\x73\x74\x79\x6c\x65\x3a\x73\x6f\x6c\x69\x64\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x32") {
			pe_fQ = "\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x69\x6d\x61\x67\x65\x3a\x75\x72\x6c\x28"
					+ this._oThis.baseURL
					+ this._oThis.config.pe_cN
					+ "\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65\x2f\x62\x67\x5f\x62\x71\x30\x32\x2e\x67\x69\x66\x29\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x72\x65\x70\x65\x61\x74\x3a\x6e\x6f\x2d\x72\x65\x70\x65\x61\x74\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x33") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x61\x73\x68\x65\x64\x20\x23\x63\x63\x63\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x34") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x61\x73\x68\x65\x64\x20\x23\x36\x36\x62\x32\x34\x36\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x35") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x61\x73\x68\x65\x64\x20\x23\x63\x63\x63\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x72\x67\x62\x28\x32\x35\x30\x2c\x32\x35\x30\x2c\x32\x35\x30\x29\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x36") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x37") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x36\x36\x62\x32\x34\x36\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x38") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x72\x67\x62\x28\x32\x35\x30\x2c\x32\x35\x30\x2c\x32\x35\x30\x29\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x30\x39") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x32\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else if (pe_hg == "\x62\x71\x31\x30") {
			pe_fQ = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x32\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x23\x65\x35\x65\x35\x65\x35\x3b\x20\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x72\x67\x62\x28\x32\x35\x30\x2c\x32\x35\x30\x2c\x32\x35\x30\x29\x3b\x20\x70\x61\x64\x64\x69\x6e\x67\x3a\x31\x30\x70\x78\x3b\x20\x63\x6f\x6c\x6f\x72\x3a\x23\x38\x38\x38\x3b";
		} else {
			return;
		}
		if (pe_bK.nodeName.toLowerCase() == "\x62\x6f\x64\x79") {
			var eleP = idoc.createElement('\x70');
			eleP.innerHTML = "\x26\x6e\x62\x73\x70\x3b";
			pe_bK.insertBefore(eleP, null);
			pe_bK = eleP;
		}
		if (pe_bK.innerHTML.length <= 0) {
			pe_bK.innerHTML = "\x26\x6e\x62\x73\x70\x3b";
		}
		var pe_hy = pe_bK.outerHTML;
		while (pe_bK != pe_dc) {
			pe_bK = pe_bK.nextSibling;
			var pe_jT = pe_bK.previousSibling;
			pe_jT.parentNode.removeChild(pe_jT);
			if (pe_bK.outerHTML) {
				pe_hy = pe_hy + pe_bK.outerHTML;
			}
		}
		var pEle = null;
		var pe_Ns = idoc
				.createElement('\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65');
		pe_Ns.style.cssText = pe_fQ;
		pe_Ns.innerHTML = pe_hy;
		if (!pe_bK.nextSibling) {
			pEle = idoc.createElement('\x70');
			pEle.innerHTML = '\x26\x6e\x62\x73\x70\x3b';
		}
		pe_bK.parentNode.insertBefore(pe_Ns, pe_bK);
		pe_bK.parentNode.removeChild(pe_bK);
		if (pEle) {
			pe_Ns.parentNode.appendChild(pEle);
		}
		var pe_bC = t._oThis.getSelection();
		pe_bC.sel = pe_bC.getSelection();
		pe_bC.range = pe_bC.pe_bY();
		pe_bC.pe_aCz(this.pe_aEH(pe_Ns), true);
	},
	pe_aEH : function(Element) {
		var retEl = Element;
		for (var i = 0; i < Element.childNodes.length; i++) {
			var pe_aaO = Element.childNodes[i];
			if (pe_aaO && pe_aaO.nodeType == 1) {
				retEl = pe_aaO;
				break;
			}
		}
		return retEl;
	}
};
var pe_axI = {
	_oThis : null,
	pe_bC : null,
	start : function() {
		var t = this;
		var pe_Rs = 0;
		var pe_Qu = 0;
		var pe_aeQ = 0;
		var pe_aft = "";
		var pe_Wm = true;
		try {
			var pe_aCo = t;
			if (agentInfo.IsIE && parseInt(pe_cm) < 7)
				pe_aCn = t;
			t._oThis.pe_gn.height = t._oThis.pe_gn.style.height;
			if (!(this._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e'] && this._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e'].length > 0)) {
				t.pe_alU('\x73\x61\x76\x65');
				t._oThis.pe_ei.style.position = "\x61\x62\x73\x6f\x6c\x75\x74\x65";
				t._oThis.pe_ei.style.left = "\x30\x70\x78";
				t._oThis.pe_ei.style.top = "\x30\x70\x78";
				t._oThis.pe_hn().body.style.overflow = "\x68\x69\x64\x64\x65\x6e";
				NamoSE.Util.pe_hB(t._oThis.pe_hn(), "\x68\x74\x6d\x6c").style.overflow = "\x68\x69\x64\x64\x65\x6e";
				parent.window.scroll(0, 0);
				var pe_QF = this.pe_aet();
				var pe_mi = NamoSE.Util.pe_Xd(t._oThis.pe_hn());
				pe_Rs = pe_mi.x;
				pe_Qu = pe_mi.y - pe_QF;
				pe_aeQ = this._oThis.pe_fU.fullscreen[2];
				pe_aft = "\x66\x65\x78\x63\x75\x74\x65";
				this._oThis.pe_fU.fullscreen[2] = pe_Qu;
			} else {
				t._oThis.pe_ei.style.position = "\x73\x74\x61\x74\x69\x63";
				t._oThis.pe_ei.style.left = "";
				t._oThis.pe_ei.style.top = "";
				if (this._oThis.pe_fU.fullscreen[4]
						&& this._oThis.pe_fU.fullscreen[4] != "") {
					t._oThis.pe_hn().body.style.overflow = this._oThis.pe_fU.fullscreen[4];
				} else {
					t._oThis.pe_hn().body.style.overflow = "";
				}
				if (this._oThis.pe_fU.fullscreen[5]
						&& this._oThis.pe_fU.fullscreen[5] != "") {
					NamoSE.Util.pe_hB(t._oThis.pe_hn(), "\x68\x74\x6d\x6c").style.overflow = this._oThis.pe_fU.fullscreen[5];
				} else {
					NamoSE.Util.pe_hB(t._oThis.pe_hn(), "\x68\x74\x6d\x6c").style.overflow = "";
				}
				pe_Rs = this._oThis.params.Width.replace("\x70\x78", "");
				pe_Qu = this._oThis.params.Height.replace("\x70\x78", "");
				pe_aeQ = this._oThis.pe_fU.fullscreen[2];
				pe_aft = "\x72\x65\x73\x74\x6f\x72\x65";
				t.pe_alU('\x72\x65\x73\x74\x6f\x72\x65');
			}
			if ((pe_Rs > 0 || String(pe_Rs).indexOf("\x25") != -1) && pe_Qu > 0) {
				if (agentInfo.IsGecko) {
					this._oThis.pe_Xh();
					this.pe_aBg();
				}
				pe_aCo.pe_amb(pe_Rs, pe_Qu, pe_aeQ, pe_aft, pe_Wm)
			}
		} catch (exp) {
		}
	},
	pe_amb : function(pe_iZ, pe_jp, pe_aCx, pe_Yd, pe_Wm) {
		var t = this._oThis;
		if (typeof pe_iZ == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
				|| typeof pe_jp == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		if (typeof pe_Yd == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_Yd = "";
		var pe_Qa = 0;
		var pe_pu = 0;
		t.pe_ei.style.width = (String(pe_iZ).indexOf("\x25") != -1) ? pe_iZ
				: pe_iZ + "\x70\x78";
		t.pe_kp.style.width = t.pe_ei.style.width;
		t.pe_hx["\x70\x65\x5f\x74\x6a"] = (t.util.pe_jH(document
				.getElementById("\x70\x65\x5f\x76\x57")) - t.util
				.pe_jH(document.getElementById("\x70\x65\x5f\x55\x6a")))
				+ document.getElementById("\x70\x65\x5f\x76\x57").offsetWidth;
		var pe_aaH = 0;
		if (pe_Sd == "\x31") {
			var pe_abU = (agentInfo.IsIE && parseInt(pe_cm) < 8) ? 5 : 2;
			if ((agentInfo.IsIE && parseInt(pe_cm) >= 8) || agentInfo.IsSafari)
				pe_abU = 0;
			if (pe_Yd == "\x66\x65\x78\x63\x75\x74\x65") {
				pe_aaH = pe_abU;
			} else if (pe_Yd == "\x72\x65\x73\x74\x6f\x72\x65") {
				pe_aaH = -pe_abU;
			}
		}
		if (!pe_Wm) {
			pe_Qa = t.pe_hx["\x70\x65\x5f\x6f\x49"] - t.pe_kp.scrollHeight;
		}
		pe_pu = parseInt(pe_jp) - pe_aCx + pe_Qa + pe_aaH;
		if (agentInfo.IsIE)
			t.pe_wb = false;
		if (pe_Wm) {
			t.pe_gn.style.height = (parseInt(t.pe_gn.height.replace("\x70\x78")) + pe_pu)
					+ "\x70\x78";
		} else {
			t.pe_gn.style.height = (parseInt(t.pe_gn.style.height
					.replace("\x70\x78")) + pe_pu)
					+ "\x70\x78";
		}
		t.editorTextarea.style.height = (parseInt(t.editorTextarea.style.height
				.replace("\x70\x78")) + pe_pu)
				+ "\x70\x78";
		t.pe_hx["\x70\x65\x5f\x6f\x49"] = t.pe_kp.scrollHeight;
		if (agentInfo.IsIE)
			t.pe_wb = true;
		var pe_QF = this.pe_aet();
		t.pe_ei.style.height = (parseInt(pe_jp) + pe_QF) + "\x70\x78";
	},
	pe_alU : function(pe_AP) {
		var t = this;
		var pe_hE = this._oThis.pe_hn().compatMode == '\x43\x53\x53\x31\x43\x6f\x6d\x70\x61\x74';
		var pe_JJ = (pe_hE) ? this._oThis.pe_hn().documentElement : this._oThis
				.pe_hn().body;
		if (agentInfo.IsSafari || agentInfo.IsChrome)
			pe_JJ = this._oThis.pe_hn().body;
		var pWin = parent.window;
		var pe_axB = function(e) {
			t.pe_abl(e, t)
		};
		var node = t._oThis.pe_ei;
		while (node && node.tagName != "\x42\x4f\x44\x59") {
			node = node.parentNode;
		}
		if (pe_AP == "\x72\x65\x73\x74\x6f\x72\x65") {
			if (this._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e']
					&& this._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e'].length > 0) {
				var pe_aHA = (!this._oThis.pe_fU.fullscreen[3]) ? ""
						: this._oThis.pe_fU.fullscreen[3];
				if (agentInfo.IsIE && parseInt(pe_cm) < 7) {
					NamoSE.Util.pe_GV(pWin, '\x72\x65\x73\x69\x7a\x65',
							t.pe_abl);
				} else {
					pWin.onresize = pe_aHA;
				}
				pe_JJ.scrollTop = this._oThis.pe_fU.fullscreen[0];
				pe_JJ.scrollLeft = this._oThis.pe_fU.fullscreen[1];
				this._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e'] = [];
			}
			this.pe_alV(pWin, pe_AP);
		} else {
			var pe_aGY = pWin.onresize;
			var pe_aHf = this._oThis.pe_hn().body.style.overflow;
			var pe_aGZ = NamoSE.Util
					.pe_hB(t._oThis.pe_hn(), "\x68\x74\x6d\x6c").style.overflow;
			var pe_aHn = (String(this._oThis.params.Width).indexOf("\x25") != -1) ? this._oThis.pe_hx.pe_tj
					: this._oThis.params.Width;
			if (agentInfo.IsIE && parseInt(pe_cm) < 7) {
				NamoSE.Util.pe_bJ(pWin, '\x72\x65\x73\x69\x7a\x65', t.pe_abl);
			} else {
				pWin.onresize = pe_axB;
			}
			this._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e'] = [
					pe_JJ.scrollTop, pe_JJ.scrollLeft,
					this._oThis.params.Height, pe_aGY, pe_aHf, pe_aGZ, pe_aHn ];
			this.pe_alV(pWin, pe_AP);
		}
	},
	pe_abl : function(e, t) {
		if (!t && agentInfo.IsIE && parseInt(pe_cm) < 7)
			t = pe_aCn;
		if (!t)
			return false;
		if (t._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e']
				&& t._oThis.pe_fU['\x66\x75\x6c\x6c\x73\x63\x72\x65\x65\x6e'].length > 0) {
			var pe_QF = t.pe_aet();
			var pe_mi = NamoSE.Util.pe_Xd(t._oThis.pe_hn());
			var pe_aDO = pe_mi.x;
			var pe_adW = pe_mi.y - pe_QF;
			if (pe_adW < NamoSE.pe_cy.pe_air)
				return false;
			var pe_aDN = t._oThis.pe_fU.fullscreen[2];
			t._oThis.pe_fU.fullscreen[2] = pe_adW;
			NamoSE.Util.pe_bO(function() {
				t.pe_amb(pe_aDO, pe_adW, pe_aDN)
			}, 10);
		}
	},
	pe_aet : function() {
		var pe_Ik = (pe_ev == "\x4d\x61\x63\x69\x6e\x74\x6f\x73\x68" && (agentInfo.IsGecko || agentInfo.IsChrome)) ? 2
				: 0;
		return ((agentInfo.IsIE && parseInt(pe_cm) < 8) ? 0 : (5 + pe_Ik));
	},
	pe_alV : function(iWin, pe_AP) {
		if (!pe_AP || pe_AP == "")
			return;
		var node = this._oThis.pe_ei;
		if (pe_AP == "\x72\x65\x73\x74\x6f\x72\x65") {
			if (this._oThis.pe_II && this._oThis.pe_II.length > 0) {
				for (var i = 0; i < this._oThis.pe_II.length; i++) {
					var pe_zO = this._oThis.pe_II[i];
					if (pe_zO && pe_zO[0]) {
						if (pe_zO[1] && pe_zO[1] != "") {
							pe_zO[0].style.cssText = pe_zO[1];
						} else {
							pe_zO[0].setAttribute('\x73\x74\x79\x6c\x65', '');
							pe_zO[0].removeAttribute("\x73\x74\x79\x6c\x65");
						}
					}
				}
				this._oThis.pe_II = [];
			}
		} else {
			while (node && node.tagName != "\x42\x4f\x44\x59") {
				if (node.nodeName != "\x42\x4f\x44\x59") {
					var pe_aer = NamoSE.Util.pe_mB(iWin.document, node,
							'\x70\x6f\x73\x69\x74\x69\x6f\x6e');
					if (pe_aer && pe_aer != ""
							&& pe_aer != "\x73\x74\x61\x74\x69\x63") {
						var pe_ayr = [ node, node.style.cssText ];
						this._oThis.pe_II.push(pe_ayr);
						node.style.position = "\x73\x74\x61\x74\x69\x63";
					}
				}
				node = node.parentNode;
			}
		}
	},
	pe_aBg : function() {
		var pe_fq = this._oThis.pe_uG();
		pe_fq.style.display = "";
		NamoSE.Util.pe_bO(function() {
			pe_fq.contentWindow.focus();
			pe_fq.style.display = "\x6e\x6f\x6e\x65";
		}, 30);
	}
};
var pe_avb = {
	_oThis : null,
	pe_nY : null,
	pe_dI : null,
	pe_bC : null,
	pe_aIE : '\x64\x4d\x6f\x75\x73\x65\x45\x76\x65\x6e\x74',
	pe_Iy : NamoSE.pe_cy.pe_akJ,
	pe_alH : '\x63\x65\x6c\x6c\x5f\x72\x65\x73\x69\x7a\x65\x5f\x77\x69\x64\x74\x68\x2e\x67\x69\x66',
	pe_azU : '\x63\x65\x6c\x6c\x5f\x72\x65\x73\x69\x7a\x65\x5f\x68\x65\x69\x67\x68\x74\x2e\x67\x69\x66',
	pe_Vq : 15,
	pe_IM : 5,
	pe_Po : 10,
	pe_cW : null,
	pe_uA : null,
	start : function() {
		var t = this;
		if (!t.pe_dI || t.pe_dI.button == 2)
			return;
		t.pe_fS = t._oThis.getDocument();
		switch (t.pe_dI.type) {
		case '\x6d\x6f\x75\x73\x65\x64\x6f\x77\x6e':
			t.pe_afC();
			break;
		case '\x6d\x6f\x75\x73\x65\x75\x70':
			t.pe_afE();
			break;
		case '\x6d\x6f\x75\x73\x65\x6d\x6f\x76\x65':
			t.pe_afD();
			break;
		default:
			return;
		}
	},
	pe_aBy : function(type) {
		var t = this;
		if (typeof type == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		var pe_lK;
		var pe_fv = null;
		var pe_hc = null;
		try {
			if (agentInfo.IsIE) {
				pe_fv = t.pe_bC.range.parentElement();
				pe_hc = t.pe_cW.pe_Ap(pe_fv);
				if (pe_hc) {
					pe_fv = pe_hc;
				}
			} else {
				pe_fv = t.pe_bC.range.startContainer;
				if (pe_fv) {
					pe_hc = t.pe_cW.pe_Ap(pe_fv);
					if (pe_hc) {
						pe_fv = pe_hc;
					}
				} else {
					pe_fv = t.pe_bC.range.commonAncestorContainer;
				}
			}
			pe_lK = t.pe_bC.pe_dG(pe_fv, [ '\x54\x44', '\x54\x48' ]);
		} catch (e) {
		}
		t.pe_afJ(type, pe_lK);
		return;
	},
	pe_afC : function() {
		var t = this;
		var pe_zS = NamoSE.Util.pe_cw(t.pe_dI);
		if (agentInfo.IsIE && parseInt(pe_cm) < 8) {
			if (!pe_zS
					|| (pe_zS.nodeType == 1 && pe_zS.nodeName == "\x42\x4f\x44\x59")) {
				var pe_ane = t.pe_fS.body.clientWidth;
				var pe_anb = t.pe_fS.body.clientHeight;
				if (t.pe_dI.x && t.pe_dI.y && pe_ane && pe_anb
						&& (t.pe_dI.x > pe_ane || t.pe_dI.y > pe_anb))
					return;
			}
		} else {
			if (!pe_zS
					|| (pe_zS.nodeType == 1 && [ '\x48\x54\x4d\x4c' ]
							.InArray(pe_zS.nodeName)))
				return;
		}
		t.pe_tA();
		var pe_jz = NamoSE.Util.pe_WZ(t.pe_fS);
		t._oThis.pe_UY = pe_jz.x + (t.pe_dI.clientX || t.pe_dI.pageX);
		t._oThis.pe_UX = pe_jz.y + (t.pe_dI.clientY || t.pe_dI.pageY);
		t._oThis.pe_alr = t._oThis.pe_UY;
		t._oThis.pe_alp = t._oThis.pe_UX;
		if (t._oThis.pe_zK && t._oThis.pe_zK != '') {
			t._oThis.pe_na = true;
			t._oThis.pe_dt(false, undefined, undefined, false);
			t.pe_ayy();
		} else {
			t._oThis.pe_na = false;
		}
		var pe_VL = pe_zS;
		var pe_akI = false;
		while (pe_VL.nodeName != "\x48\x54\x4d\x4c") {
			if (pe_VL.nodeName == "\x54\x41\x42\x4c\x45") {
				pe_akI = true;
				break;
			}
			pe_VL = pe_VL.parentNode;
		}
		if (!t._oThis.pe_na && pe_akI) {
			t._oThis.pe_pF = true;
			t.pe_uA = t.pe_cW.pe_eI(pe_zS, [ '\x54\x44', '\x54\x48' ]);
		}
	},
	pe_afD : function(e) {
		var t = this;
		var pe_jz = NamoSE.Util.pe_WZ(t.pe_fS);
		var endX = "";
		var endY = "";
		if (agentInfo.IsOpera || agentInfo.IsIE11) {
			if (e) {
				endX = pe_jz.x + (e.clientX || e.pageX);
				endY = pe_jz.y + (e.clientY || e.pageY)
						- t._oThis.pe_eR.clientHeight;
			} else {
				endX = pe_jz.x + (t.pe_dI.clientX || t.pe_dI.pageX);
				endY = pe_jz.y + (t.pe_dI.clientY || t.pe_dI.pageY);
			}
		} else if (agentInfo.IsIE) {
			if (e && e.button == 0) {
				endX = pe_jz.x + (e.clientX || e.pageX);
				endY = pe_jz.y + (e.clientY || e.pageY)
						- t._oThis.pe_eR.clientHeight;
			} else {
				endX = pe_jz.x + (t.pe_dI.clientX || t.pe_dI.pageX);
				endY = pe_jz.y + (t.pe_dI.clientY || t.pe_dI.pageY);
			}
		} else {
			endX = pe_jz.x + (t.pe_dI.clientX || t.pe_dI.pageX);
			endY = pe_jz.y + (t.pe_dI.clientY || t.pe_dI.pageY);
		}
		t._oThis.pe_alr = endX;
		t._oThis.pe_alp = endY;
		var pe_aha = endX - t._oThis.pe_UY;
		var pe_ahg = endY - t._oThis.pe_UX;
		if (agentInfo.IsIE9 || agentInfo.IsOpera || agentInfo.IsIE11) {
			pe_aha = pe_aha - 8;
			pe_ahg = pe_ahg - 8;
		}
		if (!(t._oThis.pe_pF || t._oThis.pe_na)) {
			t.pe_aAo(endX, endY);
		} else if (t._oThis.pe_pF) {
			t.pe_afJ('\x6d\x6f\x75\x73\x65');
			if (agentInfo.IsSafari || agentInfo.IsChrome) {
				if (t._oThis.pe_bV && t._oThis.pe_bV.length > 1) {
					t.pe_bC = t._oThis.getSelection();
					t.pe_bC.sel = t.pe_bC.getSelection();
					t.pe_bC.sel.removeAllRanges();
					t._oThis.util.stop(t.pe_dI);
				}
			}
		} else if (t._oThis.pe_na) {
			t._oThis.util.stop(t.pe_dI);
			if (agentInfo.IsGecko)
				t.pe_apL('\x6d\x6f\x75\x73\x65\x6d\x6f\x76\x65');
			t.pe_aFn(pe_ahg, pe_aha);
		}
	},
	pe_afE : function() {
		var t = this;
		var endX = t.pe_dI.clientX || t.pe_dI.pageX;
		var endY = t.pe_dI.clientY || t.pe_dI.pageY;
		if (t._oThis.pe_pF) {
			t.pe_apL('\x6d\x6f\x75\x73\x65\x75\x70', t.pe_dI);
			var pe_fg = t.pe_aEu();
			if (pe_fg) {
				t._oThis.pe_pF = false;
				t._oThis.pe_na = false;
				t.pe_uA = null;
				alert(pe_bE.pe_CB);
				t.pe_tA();
			}
		}
		if (t._oThis.pe_na) {
			t._oThis.pe_dt(false, undefined, undefined, false);
		}
		t._oThis.pe_pF = false;
		t._oThis.pe_na = false;
		t.pe_uA = null;
	},
	pe_aEu : function() {
		var t = this;
		var pe_fg = false;
		if (t._oThis.pe_bV && t._oThis.pe_bV.length > 1) {
			for (var i = 0; i < t._oThis.pe_bV.length; i++) {
				var pe_ZQ = t._oThis.pe_bV[i];
				if (pe_ZQ && pe_ZQ.nodeType == 1
						&& [ '\x54\x44', '\x54\x48' ].InArray(pe_ZQ.nodeName)) {
					if (t._oThis
							.pe_hO(pe_ZQ,
									"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b")) {
						pe_fg = true;
						break;
					}
				}
			}
		}
		return pe_fg;
	},
	pe_apL : function(evt, pe_asx) {
		var t = this;
		var pe_anw = false;
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		if (t._oThis.pe_vF == true && pe_asx) {
			var pe_jQ = NamoSE.Util.pe_cw(pe_asx);
			if (pe_jQ) {
				pe_anw = t.pe_aBP(pe_jQ, t.pe_bC);
			}
		}
		var pe_qs = t.pe_cW.pe_amo(t.pe_bC);
		if (pe_qs) {
			if (!agentInfo.IsIE) {
				var pe_aHc = t.pe_bC.pe_dG(
						t.pe_bC.range.commonAncestorContainer
								|| t.pe_bC.range.parentElement(),
						'\x54\x41\x42\x4c\x45');
				t.pe_bC.sel = t.pe_bC.getSelection();
				t.pe_bC.range = t.pe_bC.pe_bY();
				if (evt == "\x6d\x6f\x75\x73\x65\x75\x70" && t._oThis.pe_bV
						&& t._oThis.pe_bV.length > 1 && (!pe_aHc || pe_anw)) {
					var pe_bU = t._oThis
							.getFunctionals('\x73\x74\x61\x74\x75\x73\x68\x69\x67\x68\x6c\x69\x67\x68\x74');
					pe_bU.start();
				}
			}
		} else {
			if (evt == "\x6d\x6f\x75\x73\x65\x75\x70")
				t.pe_aHW(t.pe_bC);
		}
	},
	pe_aHW : function(pe_bC) {
		var t = this;
		if (t._oThis.pe_bV && t._oThis.pe_bV.length == 1) {
			t.pe_tA();
			if (t.pe_uA) {
				var pe_Bj, pe_HQ;
				try {
					if (agentInfo.IsIE) {
						var pe_PZ = pe_bC.pe_PB(pe_bC.range);
						pe_PZ.collapse(true);
						pe_Bj = pe_PZ.parentElement();
						var pe_auo = pe_bC.pe_PB(pe_bC.range);
						pe_auo.collapse(false);
						pe_HQ = pe_auo.parentElement();
					} else {
						pe_Bj = pe_bC.range.startContainer;
						pe_HQ = pe_bC.range.endContainer;
					}
					pe_Bj = pe_bC.pe_dG(pe_Bj, [ '\x54\x44', '\x54\x48' ]);
					pe_HQ = pe_bC.pe_dG(pe_HQ, [ '\x54\x44', '\x54\x48' ]);
				} catch (e) {
				}
				if (!(pe_Bj && pe_HQ && pe_Bj == pe_HQ && t.pe_uA == pe_Bj)) {
					if (t.pe_uA.nodeType == 1
							&& [ '\x54\x44', '\x54\x48' ]
									.InArray(t.pe_uA.nodeName)) {
						var pe_hK = NamoSE.Util.pe_bP(t.pe_uA, "\x70");
						var selectNode = (pe_hK && pe_hK.length > 0) ? pe_hK[0]
								: t.pe_uA;
						var pe_aoL = t._oThis
								.getFunctionals('\x65\x6e\x74\x65\x72\x6b\x65\x79');
						if (agentInfo.IsOpera) {
							NamoSE.Util.pe_bO(function() {
								pe_aoL.pe_ki(selectNode);
							}, 10);
						} else {
							pe_aoL.pe_ki(selectNode);
						}
					}
				}
			}
			if (!(agentInfo.IsIE && pe_cm < 9)) {
				var pe_apy = t._oThis
						.getFunctionals('\x73\x74\x61\x74\x75\x73\x68\x69\x67\x68\x6c\x69\x67\x68\x74');
				if (agentInfo.IsOpera) {
					NamoSE.Util.pe_bO(function() {
						pe_apy.start();
					}, 20);
				} else {
					pe_apy.start();
				}
			}
		}
	},
	pe_aBP : function(pe_LR, pe_bC) {
		var t = this;
		if (typeof pe_LR == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return false;
		if (typeof pe_bC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return false;
		var pe_DA = null;
		var pe_Zh = null;
		var pe_AU = null;
		var pe_amy = null;
		if (!pe_LR
				|| (pe_LR.nodeType == 1 && [ '\x54\x41\x42\x4c\x45',
						'\x54\x42\x4f\x44\x59', '\x54\x52' ]
						.InArray(pe_LR.nodeName)))
			return false;
		pe_DA = t.pe_cW.pe_eI(pe_LR, [ '\x54\x44', '\x54\x48' ]);
		if (!(pe_DA && pe_DA.nodeType == 1 && [ '\x54\x44', '\x54\x48' ]
				.InArray(pe_DA.nodeName)))
			return false;
		pe_Zh = t.pe_cW.pe_eI(pe_DA, '\x54\x41\x42\x4c\x45');
		pe_AU = t._oThis.pe_alj;
		if (!(pe_AU && pe_AU.nodeType == 1 && [ '\x54\x44', '\x54\x48' ]
				.InArray(pe_AU.nodeName)))
			return false;
		pe_amy = t.pe_cW.pe_eI(pe_AU, '\x54\x41\x42\x4c\x45');
		if (pe_DA == pe_AU)
			return false;
		if (pe_Zh != pe_amy)
			return false;
		var pe_Qx = t.pe_auk(
				'\x63\x65\x6c\x6c\x70\x6f\x73\x69\x74\x69\x6f\x6e', pe_AU,
				pe_DA, pe_Zh);
		if (pe_Qx && pe_Qx.scPos && pe_Qx.ccPos) {
			return t.pe_aFq(pe_Qx.scPos, pe_Qx.ccPos, pe_Zh);
		} else {
			return false;
		}
	},
	pe_aFq : function(pe_zD, pe_za, pe_abN) {
		var t = this;
		if (typeof pe_zD == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return false;
		if (typeof pe_za == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return false;
		if (typeof pe_abN == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return false;
		var pe_OZ = pe_zD[0];
		var pe_PN = pe_zD[1];
		var pe_axM = pe_zD[2];
		var pe_ayt = pe_zD[3];
		var pe_LY = pe_za[0];
		var pe_Mk = pe_za[1];
		var pe_aEL = pe_za[2];
		var pe_aEM = pe_za[3];
		var pe_amW, pe_amZ, pe_aoz, pe_apE;
		pe_amW = (pe_OZ > pe_LY) ? pe_LY : pe_OZ;
		pe_amZ = (pe_PN > pe_Mk) ? pe_Mk : pe_PN;
		pe_OZ += pe_axM;
		pe_PN += pe_ayt;
		pe_LY += pe_aEL;
		pe_Mk += pe_aEM;
		pe_aoz = (pe_OZ > pe_LY) ? pe_OZ : pe_LY;
		pe_apE = (pe_PN > pe_Mk) ? pe_PN : pe_Mk;
		var pe_anP = t.pe_auk('\x63\x65\x6c\x6c\x74\x61\x72\x67\x65\x74', [
				pe_amW, pe_amZ ], [ pe_aoz, pe_apE ], pe_abN);
		if (pe_anP) {
			t.pe_afJ('\x74\x61\x72\x67\x65\x74', pe_anP, pe_abN);
			return true;
		} else {
			return false;
		}
	},
	pe_auk : function(mode, pe_xd, pe_AB, pe_Na) {
		var t = this;
		if (typeof mode == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		if (typeof pe_xd == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || !pe_xd)
			return null;
		if (typeof pe_AB == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || !pe_AB)
			return null;
		if (typeof pe_Na == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || !pe_Na)
			return null;
		var pe_za = [];
		var pe_zD = [];
		var pe_Ij = [];
		var pe_atW = [];
		try {
			for (var i = 0; i < pe_Na.rows.length; i++) {
				var pe_QN = 0;
				for (var j = 0; j < pe_Na.rows[i].cells.length; j++) {
					var cell = pe_Na.rows[i].cells[j];
					var pe_IK = (cell
							.getAttribute('\x63\x6f\x6c\x73\x70\x61\x6e') && cell
							.getAttribute('\x63\x6f\x6c\x73\x70\x61\x6e') > 1) ? cell
							.getAttribute('\x63\x6f\x6c\x73\x70\x61\x6e') - 1
							: 0;
					var pe_Jl = (cell
							.getAttribute('\x72\x6f\x77\x73\x70\x61\x6e') && cell
							.getAttribute('\x72\x6f\x77\x73\x70\x61\x6e') > 1) ? cell
							.getAttribute('\x72\x6f\x77\x73\x70\x61\x6e') - 1
							: 0;
					if (pe_Ij.length > 0) {
						var pe_LI = [];
						var pe_aIT = 0;
						for (y = 0; y < pe_Ij.length; y++) {
							var pe_aGc = pe_Ij[y][0];
							var pe_aGb = pe_Ij[y][1];
							var pe_aGa = pe_Ij[y][2];
							if (pe_aGc == i) {
								pe_LI.push(pe_aGb + "\x2d" + pe_aGa);
							}
						}
						if (pe_LI.length > 0) {
							pe_LI.sort();
							for (var z = 0; z < pe_LI.length; z++) {
								var pe_Um = pe_LI[z].split("\x2d");
								if (!isNaN(pe_Um[0]) && !isNaN(pe_Um[1])) {
									var pe_asd = parseInt(pe_Um[0]);
									var pe_aFZ = parseInt(pe_Um[1]);
									if (pe_asd == (j + pe_QN)
											|| (pe_asd == 0 && j == 0)) {
										pe_QN += pe_aFZ;
									}
								}
							}
						}
					}
					var pe_Ok = j + 1 + pe_QN;
					var pe_NS = i + 1;
					if (mode == "\x63\x65\x6c\x6c\x70\x6f\x73\x69\x74\x69\x6f\x6e") {
						if (cell == pe_xd || cell == pe_AB) {
							if (cell == pe_xd) {
								pe_zD.push(pe_NS, pe_Ok, pe_Jl, pe_IK);
							} else {
								pe_za.push(pe_NS, pe_Ok, pe_Jl, pe_IK);
							}
						}
					} else if (mode == "\x63\x65\x6c\x6c\x74\x61\x72\x67\x65\x74") {
						if (pe_NS >= pe_xd[0] && pe_NS <= pe_AB[0]
								&& pe_Ok >= pe_xd[1] && pe_Ok <= pe_AB[1]) {
							var pe_ajg = pe_NS + pe_Jl;
							var pe_ajf = pe_Ok + pe_IK;
							if (pe_ajg >= pe_xd[0] && pe_ajg <= pe_AB[0]
									&& pe_ajf >= pe_xd[1] && pe_ajf <= pe_AB[1]) {
								pe_atW.push(cell);
							}
						}
					}
					if (pe_Jl > 0) {
						var pe_aDG = j + pe_QN;
						var pe_aDH = 1 + pe_IK;
						for (var x = 1; x < pe_Jl + 1; x++) {
							var pe_aCV = i + x;
							pe_Ij.push([ pe_aCV, pe_aDG, pe_aDH ]);
						}
					}
					if (pe_IK > 0)
						pe_QN += pe_IK;
				}
			}
			if (mode == "\x63\x65\x6c\x6c\x70\x6f\x73\x69\x74\x69\x6f\x6e") {
				return {
					"\x73\x63\x50\x6f\x73" : pe_zD,
					"\x63\x63\x50\x6f\x73" : pe_za
				};
			} else if (mode == "\x63\x65\x6c\x6c\x74\x61\x72\x67\x65\x74") {
				return pe_atW;
			} else {
				return null;
			}
		} catch (exp) {
			return null;
		}
	},
	pe_amn : function() {
		var t = this;
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		try {
			t.pe_bC.range.collapse(true);
			t.pe_bC.pe_bM();
		} catch (e) {
		}
	},
	pe_eI : function(ele, tag) {
		var node = ele;
		var pe_mL = false;
		if (typeof (tag) == "\x6f\x62\x6a\x65\x63\x74" && tag.length > 0) {
			pe_mL = true;
		}
		if (pe_mL) {
			while (node && !tag.InArray(node.tagName)) {
				node = node.parentNode;
			}
		} else {
			while (node && node.tagName != tag) {
				node = node.parentNode;
			}
		}
		if ((!node) || (node.tagName == "\x48\x54\x4d\x4c")) {
			return false;
		} else {
			return node;
		}
	},
	pe_asN : function(pe_bG, pe_PM, pe_ail, pe_aik) {
		var t = this;
		if (typeof pe_bG == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		if (!(pe_bG && [ '\x54\x44', '\x54\x48' ].InArray(pe_bG.tagName)))
			return;
		var pe_RW = t.pe_eI(pe_bG, '\x54\x41\x42\x4c\x45');
		if (!(pe_RW && [ '\x54\x41\x42\x4c\x45' ].InArray(pe_RW.tagName)))
			return;
		t._oThis.pe_alx = pe_bG;
		if (agentInfo.IsIE || agentInfo.IsOpera || agentInfo.IsIE11) {
			if (pe_PM != "\x65"
					&& !document
							.getElementById("\x72\x6f\x77\x43\x75\x72\x73\x6f\x72")) {
				var pe_bF = document.createElement("\x64\x69\x76");
				var pe_ahw = t.pe_eI(pe_bG, '\x54\x41\x42\x4c\x45').style.width;
				pe_bF.innerHTML = '\x3c\x64\x69\x76\x20\x73\x74\x79\x6c\x65\x3d\x22\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x23\x30\x30\x30\x30\x30\x30\x3b\x66\x69\x6c\x74\x65\x72\x3a\x61\x6c\x70\x68\x61\x28\x6f\x70\x61\x63\x69\x74\x79\x3d\x30\x29\x3b\x6f\x70\x61\x63\x69\x74\x79\x3a\x30\x2e\x30\x3b\x2d\x6d\x6f\x7a\x2d\x6f\x70\x61\x63\x69\x74\x79\x3a\x30\x2e\x30\x3b\x2d\x6b\x68\x74\x6d\x6c\x2d\x6f\x70\x61\x63\x69\x74\x79\x3a\x30\x2e\x30\x3b\x63\x75\x72\x73\x6f\x72\x3a\x20\x72\x6f\x77\x2d\x72\x65\x73\x69\x7a\x65\x3b\x20\x6c\x65\x66\x74\x3a\x20\x30\x70\x78\x3b\x20\x74\x6f\x70\x3a\x20\x30\x70\x78\x3b\x20\x77\x69\x64\x74\x68\x3a\x20'
						+ pe_ahw
						+ '\x3b\x20\x20\x68\x65\x69\x67\x68\x74\x3a\x20\x31\x30\x70\x78\x3b\x66\x6f\x6e\x74\x2d\x73\x69\x7a\x65\x3a\x31\x70\x78\x3b\x7a\x2d\x69\x6e\x64\x65\x78\x3a\x20\x39\x39\x39\x3b\x20\x22\x3e\x3c\x2f\x64\x69\x76\x3e';
				pe_bF.id = "\x72\x6f\x77\x43\x75\x72\x73\x6f\x72";
				pe_bF.style.zIndex = 99;
				pe_bF.style.position = "\x61\x62\x73\x6f\x6c\x75\x74\x65";
				pe_bF.style.overflow = "\x68\x69\x64\x64\x65\x6e";
				NamoSE.Util
						.pe_bJ(
								pe_bF,
								'\x6d\x6f\x75\x73\x65\x64\x6f\x77\x6e',
								function(e) {
									if (agentInfo.IsIE || agentInfo.IsIE11) {
										pe_bF.setCapture();
									}
									pe_bF.firstChild.style.height = "\x32\x30\x30\x70\x78";
									t.pe_aFO(pe_bF, e);
									t._oThis.pe_Qm = t._oThis.pe_alx;
									t._oThis.pe_zK = '\x73';
									t.pe_afC();
									NamoSE.Util.stop(e);
									return false;
								});
				NamoSE.Util.pe_bJ(pe_bF,
						'\x6d\x6f\x75\x73\x65\x6d\x6f\x76\x65', function(e) {
							t.pe_afD(e);
						});
				NamoSE.Util
						.pe_bJ(
								pe_bF,
								'\x6d\x6f\x75\x73\x65\x75\x70',
								function(e) {
									if (agentInfo.IsIE || agentInfo.IsIE11) {
										pe_bF.releaseCapture();
									}
									document.body
											.removeChild(document
													.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72'));
									t.pe_afE();
								});
				if (document
						.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72')) {
					document
							.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72').parentNode
							.removeChild(document
									.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72'));
				}
			} else if (pe_PM == "\x65"
					&& !document
							.getElementById("\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72")) {
				var pe_bF = document.createElement("\x64\x69\x76");
				var pe_aiA = t.pe_eI(pe_bG, '\x54\x41\x42\x4c\x45').style.height;
				pe_bF.innerHTML = '\x3c\x64\x69\x76\x20\x73\x74\x79\x6c\x65\x3d\x22\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72\x3a\x23\x30\x30\x30\x30\x30\x30\x3b\x66\x69\x6c\x74\x65\x72\x3a\x61\x6c\x70\x68\x61\x28\x6f\x70\x61\x63\x69\x74\x79\x3d\x30\x29\x3b\x6f\x70\x61\x63\x69\x74\x79\x3a\x30\x2e\x30\x3b\x2d\x6d\x6f\x7a\x2d\x6f\x70\x61\x63\x69\x74\x79\x3a\x30\x2e\x30\x3b\x2d\x6b\x68\x74\x6d\x6c\x2d\x6f\x70\x61\x63\x69\x74\x79\x3a\x30\x2e\x30\x3b\x63\x75\x72\x73\x6f\x72\x3a\x20\x63\x6f\x6c\x2d\x72\x65\x73\x69\x7a\x65\x3b\x20\x6c\x65\x66\x74\x3a\x20\x30\x70\x78\x3b\x20\x74\x6f\x70\x3a\x20\x30\x70\x78\x3b\x20\x77\x69\x64\x74\x68\x3a\x20\x31\x30\x70\x78\x3b\x20\x68\x65\x69\x67\x68\x74\x3a\x20'
						+ pe_aiA
						+ '\x3b\x20\x66\x6f\x6e\x74\x2d\x73\x69\x7a\x65\x3a\x31\x70\x78\x3b\x7a\x2d\x69\x6e\x64\x65\x78\x3a\x20\x39\x39\x39\x3b\x20\x22\x3e\x3c\x2f\x64\x69\x76\x3e';
				pe_bF.id = "\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72";
				pe_bF.style.zIndex = 99;
				pe_bF.style.position = "\x61\x62\x73\x6f\x6c\x75\x74\x65";
				pe_bF.style.overflow = "\x68\x69\x64\x64\x65\x6e";
				NamoSE.Util
						.pe_bJ(
								pe_bF,
								'\x6d\x6f\x75\x73\x65\x64\x6f\x77\x6e',
								function(e) {
									if (agentInfo.IsIE || agentInfo.IsIE11) {
										pe_bF.setCapture();
									}
									pe_bF.firstChild.style.width = "\x32\x30\x30\x70\x78";
									t.pe_aFC(pe_bF);
									t._oThis.pe_Qm = t._oThis.pe_alx;
									t._oThis.pe_zK = '\x65';
									t.pe_afC();
									NamoSE.Util.stop(e);
									return false;
								});
				NamoSE.Util.pe_bJ(pe_bF,
						'\x6d\x6f\x75\x73\x65\x6d\x6f\x76\x65', function(e) {
							t.pe_afD(e);
						});
				NamoSE.Util
						.pe_bJ(
								pe_bF,
								'\x6d\x6f\x75\x73\x65\x75\x70',
								function(e) {
									if (agentInfo.IsIE || agentInfo.IsIE11) {
										pe_bF.releaseCapture();
									}
									document.body
											.removeChild(document
													.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72'));
									t.pe_afE();
								});
				if (document
						.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72')) {
					document
							.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72').parentNode
							.removeChild(document
									.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72'));
				}
			} else if (document
					.getElementById("\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72")) {
				var pe_aiA = t.pe_eI(pe_bG, '\x54\x41\x42\x4c\x45').clientHeight
						+ "\x70\x78";
				document.getElementById("\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72").firstChild.style.height = pe_aiA;
			} else if (document
					.getElementById("\x72\x6f\x77\x43\x75\x72\x73\x6f\x72")) {
				var pe_ahw = t.pe_eI(pe_bG, '\x54\x41\x42\x4c\x45').clientWidth
						+ "\x70\x78";
				document.getElementById("\x72\x6f\x77\x43\x75\x72\x73\x6f\x72").firstChild.style.width = pe_ahw;
			}
			if (pe_PM == "\x65") {
				if (pe_bF) {
					pe_de = pe_bF;
				} else {
					pe_de = document
							.getElementById("\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72");
				}
			} else {
				if (pe_bF) {
					pe_de = pe_bF;
				} else {
					pe_de = document
							.getElementById("\x72\x6f\x77\x43\x75\x72\x73\x6f\x72");
				}
			}
			var pe_Bo = 0;
			var pe_Bq = 0;
			var pe_PH = parseInt(t.pe_Po / 2);
			var pe_jz = NamoSE.Util.pe_WZ(t._oThis.getDocument());
			var pe_Bn = t._oThis.util.pe_kV(t._oThis.editorFrame) - pe_jz.y;
			var pe_Bm = t._oThis.util.pe_jH(t._oThis.editorFrame) - pe_jz.x;
			var pe_avs = t._oThis.util.pe_jH(pe_RW.rows[0].cells[0]);
			var pe_avj = t._oThis.util.pe_kV(pe_RW.rows[0].cells[0]);
			if (pe_PM == "\x65") {
				pe_Bo = pe_Bn + pe_avj;
				pe_Bq = pe_Bm + (pe_ail + pe_bG.clientWidth - pe_PH);
			} else {
				pe_Bo = pe_Bn + (pe_aik + pe_bG.clientHeight - pe_PH);
				pe_Bq = pe_Bm + pe_avs;
			}
			pe_de.style.top = pe_Bo + "\x70\x78";
			pe_de.style.left = pe_Bq + "\x70\x78";
			document.body.appendChild(pe_de);
		} else {
			var pe_de = document
					.getElementById("\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x43\x65\x6c\x6c\x43\x75\x72\x73\x6f\x72\x53\x74\x79\x6c\x65");
			if (!pe_de) {
				var pe_bF = document.createElement("\x64\x69\x76");
				pe_bF.id = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x43\x65\x6c\x6c\x43\x75\x72\x73\x6f\x72\x53\x74\x79\x6c\x65";
				pe_bF.style.width = pe_bF.style.height = t.pe_Po + "\x70\x78";
				pe_bF.style.zIndex = 10;
				pe_bF.style.position = "\x61\x62\x73\x6f\x6c\x75\x74\x65";
				pe_bF.style.display = "\x6e\x6f\x6e\x65";
				pe_bF.style.backgroundRepeat = '\x6e\x6f\x2d\x72\x65\x70\x65\x61\x74';
				if (agentInfo.IsIE || agentInfo.IsIE11)
					pe_bF.style.cursor = "\x6e\x6f\x74\x2d\x61\x6c\x6c\x6f\x77\x65\x64";
				NamoSE.Util.pe_bJ(pe_bF,
						'\x6d\x6f\x75\x73\x65\x64\x6f\x77\x6e', function(e) {
							t.pe_qP();
							if (agentInfo.IsIE && e.button == 1
									|| agentInfo.IsIE11) {
								try {
									var pe_bC = t._oThis.getSelection();
									pe_bC.sel = pe_bC.getSelection();
									pe_bC.range = pe_bC.pe_bY();
									if (pe_bC.range != null) {
										NamoSE.Util.pe_bO(function() {
											pe_bC.pe_bM();
										}, 10);
									}
								} catch (ex) {
								}
							}
							NamoSE.Util.stop(e);
							return false;
						});
				document.body.appendChild(pe_bF);
				pe_de = pe_bF;
			}
			var pe_Bo = 0;
			var pe_Bq = 0;
			var pe_PH = parseInt(t.pe_Po / 2);
			var pe_jz = NamoSE.Util.pe_WZ(t._oThis.getDocument());
			var pe_Bn = t._oThis.util.pe_kV(t._oThis.editorFrame) - pe_jz.y;
			var pe_Bm = t._oThis.util.pe_jH(t._oThis.editorFrame) - pe_jz.x;
			if (pe_PM == "\x65") {
				pe_Bo = pe_Bn
						+ (pe_aik + parseInt(pe_bG.clientHeight / 2) - pe_PH)
						+ t.pe_IM;
				pe_Bq = pe_Bm + (pe_ail + pe_bG.clientWidth - t.pe_Po);
				pe_de.style.backgroundImage = '\x75\x72\x6c\x28\x22'
						+ t._oThis.baseURL + t._oThis.config.pe_cN + t.pe_alH
						+ '\x22\x29';
				if (pe_de.firstChild)
					pe_de.firstChild.src = t._oThis.baseURL
							+ t._oThis.config.pe_cN + t.pe_alH;
			} else {
				pe_Bo = pe_Bn + (pe_aik + pe_bG.clientHeight - t.pe_Po);
				pe_Bq = pe_Bm
						+ (pe_ail + parseInt(pe_bG.clientWidth / 2) - pe_PH)
						+ t.pe_IM;
				pe_de.style.backgroundImage = '\x75\x72\x6c\x28\x22'
						+ t._oThis.baseURL + t._oThis.config.pe_cN + t.pe_azU
						+ '\x22\x29';
			}
			pe_de.style.top = pe_Bo + "\x70\x78";
			pe_de.style.left = pe_Bq + "\x70\x78";
			pe_de.style.display = '';
		}
	},
	pe_aFO : function(ele, e) {
		var t = this;
		var pe_Bm = t._oThis.util.pe_jH(ele);
		NamoSE.Util
				.pe_bJ(
						document
								.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72'),
						"\x6d\x6f\x75\x73\x65\x6d\x6f\x76\x65",
						function(e) {
							document
									.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72').style.top = ((e.clientY || e.pageY) - 100)
									+ "\x70\x78";
							document
									.getElementById('\x72\x6f\x77\x43\x75\x72\x73\x6f\x72').style.left = pe_Bm
									+ "\x70\x78";
							NamoSE.Util.stop(e);
							return false;
						});
	},
	pe_aFC : function(ele) {
		var t = this;
		var pe_Bn = this._oThis.util.pe_kV(ele);
		NamoSE.Util
				.pe_bJ(
						document
								.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72'),
						"\x6d\x6f\x75\x73\x65\x6d\x6f\x76\x65",
						function(e) {
							document
									.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72').style.top = pe_Bn
									+ "\x70\x78";
							document
									.getElementById('\x63\x6f\x6c\x43\x75\x72\x73\x6f\x72').style.left = (t._oThis.util
									.pe_WV(e).x - 100)
									+ "\x70\x78";
						});
	},
	pe_qP : function() {
		if (agentInfo.IsIE || agentInfo.IsOpera || agentInfo.IsIE11) {
			var pe_de = document
					.getElementById("\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x43\x65\x6c\x6c\x43\x75\x72\x73\x6f\x72\x53\x74\x79\x6c\x65");
			if (pe_de && pe_de.style.display != "\x6e\x6f\x6e\x65")
				pe_de.style.display = "\x6e\x6f\x6e\x65";
		} else {
			if (this._oThis.pe_Co != null) {
				for (var i = 0; i < this._oThis.pe_Co.length; i++) {
					if (this._oThis.pe_Co[i]) {
						this._oThis.pe_Co[i].style.cursor = "";
					}
				}
				this._oThis.pe_Co = [];
			}
		}
	},
	pe_aAo : function(posX, posY) {
		var t = this;
		var table = t.pe_nY;
		var cell;
		var pe_ow, pe_oE, pe_vw, pe_vV;
		var pe_aFr = false;
		t._oThis.pe_zK = '';
		if (!(table && table.tagName == '\x54\x41\x42\x4c\x45')) {
			t.pe_qP();
			return;
		}
		var pe_fg = t._oThis.pe_hO(table,
				"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b");
		if (pe_fg) {
			t._oThis.pe_pF = false;
			t._oThis.pe_na = false;
			t.pe_qP();
			return false;
		}
		var pe_jQ = NamoSE.Util.pe_cw(t.pe_dI);
		if (!pe_jQ
				|| (pe_jQ.nodeType == 1 && [ '\x54\x41\x42\x4c\x45',
						'\x54\x42\x4f\x44\x59', '\x54\x52' ]
						.InArray(pe_jQ.nodeName))) {
			t.pe_qP();
			return false;
		}
		cell = t.pe_cW.pe_eI(pe_jQ, [ '\x54\x44', '\x54\x48' ]);
		if (!(cell && cell.nodeType == 1 && [ '\x54\x44', '\x54\x48' ]
				.InArray(cell.nodeName))) {
			t.pe_qP();
			return false;
		}
		pe_aET = t.pe_cW.pe_eI(cell, '\x54\x41\x42\x4c\x45');
		if (pe_aET != table) {
			t.pe_qP();
			return false;
		}
		if (t._oThis.getDocument().body.style.cursor == '\x63\x72\x6f\x73\x73\x68\x61\x69\x72')
			return;
		pe_ow = t._oThis.util.pe_jH(cell);
		pe_oE = t._oThis.util.pe_kV(cell);
		pe_vw = pe_ow + cell.clientWidth;
		pe_vV = pe_oE + cell.clientHeight;
		if ((!pe_aFr) && posX >= pe_ow && posX <= (pe_vw + t.pe_IM)
				&& posY >= pe_oE && posY <= (pe_vV + t.pe_IM)) {
			if (posX >= pe_vw - t.pe_IM) {
				if (agentInfo.IsIE || agentInfo.IsOpera || agentInfo.IsIE11) {
					t.pe_asN(cell, '\x65', pe_ow, pe_oE);
				} else {
					(agentInfo.IsOpera) ? cell.style.cursor = '\x45\x2d\x72\x65\x73\x69\x7a\x65'
							: cell.style.cursor = '\x63\x6f\x6c\x2d\x72\x65\x73\x69\x7a\x65';
					t._oThis.pe_Co.push(cell);
				}
				t._oThis.pe_zK = '\x65';
				t._oThis.pe_Qm = cell;
			} else if (posY >= pe_vV - t.pe_IM) {
				if (agentInfo.IsIE || agentInfo.IsOpera || agentInfo.IsIE11) {
					t.pe_asN(cell, '\x73', pe_ow, pe_oE);
				} else {
					(agentInfo.IsOpera) ? cell.style.cursor = '\x53\x2d\x72\x65\x73\x69\x7a\x65'
							: cell.style.cursor = '\x72\x6f\x77\x2d\x72\x65\x73\x69\x7a\x65';
					t._oThis.pe_Co.push(cell);
				}
				t._oThis.pe_zK = '\x73';
				t._oThis.pe_Qm = cell;
			} else {
				if (!(agentInfo.IsIE || agentInfo.IsOpera || agentInfo.IsIE11)) {
					cell.style.cursor = '';
				}
				t.pe_qP();
			}
		} else {
			if (!(agentInfo.IsIE || agentInfo.IsOpera || agentInfo.IsIE11)) {
				cell.style.cursor = '';
			}
			t.pe_qP();
		}
		return false;
	},
	pe_afJ : function(mode, pe_de, pe_nc) {
		var t = this;
		if (typeof mode == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64') {
			mode = '\x6d\x6f\x75\x73\x65';
		}
		switch (mode) {
		case '\x63\x65\x6c\x6c':
			if (typeof pe_de == '\x75\x6e\x64\x65\x66\x69\x6e\x64')
				return;
			if (!(pe_de && [ '\x54\x44', '\x54\x48' ].InArray(pe_de.tagName)))
				return;
			t.pe_tA();
			var table = t.pe_cW.pe_eI(pe_de, '\x54\x41\x42\x4c\x45');
			t._oThis.pe_tU = null;
			t._oThis.pe_bV = new Array();
			t._oThis.pe_ma = new Array();
			t._oThis.pe_tU = table;
			t._oThis.pe_bV.push(pe_de);
			t._oThis.pe_ma.push(pe_de.style.backgroundColor);
			pe_de.style.backgroundColor = t.pe_Iy;
			pe_de.alt = '\x73\x65\x6c\x65\x63\x74';
			t.pe_amn();
			break;
		case '\x74\x61\x62\x6c\x65':
			if (typeof pe_de == '\x75\x6e\x64\x65\x66\x69\x6e\x64')
				return;
			if (!(pe_de && [ '\x54\x44', '\x54\x48' ].InArray(pe_de.tagName)))
				return;
			var table = t.pe_cW.pe_eI(pe_de, '\x54\x41\x42\x4c\x45');
			if (!(table && table.tagName == '\x54\x41\x42\x4c\x45'))
				return;
			t.pe_tA();
			t._oThis.pe_tU = table;
			t._oThis.pe_bV = new Array();
			t._oThis.pe_ma = new Array();
			var pe_fg = false;
			for (var i = 0; i < table.rows.length; i++) {
				for (var j = 0; j < table.rows[i].cells.length; j++) {
					var cell = table.rows[i].cells[j];
					if (t._oThis
							.pe_hO(cell,
									"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b")) {
						pe_fg = true;
						break;
					}
					t._oThis.pe_bV.push(cell);
					t._oThis.pe_ma.push(cell.style.backgroundColor);
					cell.style.backgroundColor = t.pe_Iy;
					cell.alt = '\x73\x65\x6c\x65\x63\x74';
				}
				if (pe_fg)
					break;
			}
			if (pe_fg) {
				t.pe_tA();
				t._oThis.pe_pF = false;
				t._oThis.pe_na = false;
				alert(pe_bE.pe_CB);
			} else {
				t.pe_amn();
			}
			break;
		case '\x74\x61\x72\x67\x65\x74':
			if (typeof pe_de == '\x75\x6e\x64\x65\x66\x69\x6e\x64')
				return;
			if (typeof pe_nc == '\x75\x6e\x64\x65\x66\x69\x6e\x64')
				return;
			if (!(typeof (pe_de) == "\x6f\x62\x6a\x65\x63\x74" && pe_de.length > 0))
				return;
			var table = pe_nc;
			if (!(table && table.tagName == '\x54\x41\x42\x4c\x45'))
				return;
			t.pe_tA();
			t._oThis.pe_tU = table;
			t._oThis.pe_bV = new Array();
			t._oThis.pe_ma = new Array();
			var pe_fg = false;
			for (var i = 0; i < pe_de.length; i++) {
				var cell = pe_de[i];
				if (t._oThis
						.pe_hO(cell,
								"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b")) {
					pe_fg = true;
					break;
				}
				t._oThis.pe_bV.push(cell);
				t._oThis.pe_ma.push(cell.style.backgroundColor);
				cell.style.backgroundColor = t.pe_Iy;
				cell.alt = '\x73\x65\x6c\x65\x63\x74';
			}
			if (pe_fg) {
				t.pe_tA();
				t._oThis.pe_pF = false;
				t._oThis.pe_na = false;
				t._oThis.pe_vF = false;
				alert(pe_bE.pe_CB);
			}
			break;
		case '\x6d\x6f\x75\x73\x65':
			var table = t.pe_nY;
			if (!(table && table.tagName == '\x54\x41\x42\x4c\x45'))
				return;
			var pe_fg = t._oThis.pe_hO(table,
					"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b");
			if (pe_fg) {
				t._oThis.pe_pF = false;
				t._oThis.pe_na = false;
				return false;
			}
			t.pe_tA();
			t._oThis.pe_tU = table;
			t._oThis.pe_bV = new Array();
			t._oThis.pe_ma = new Array();
			var pe_aDS = 0;
			var cell;
			var pe_lm = false;
			var pe_ow, pe_oE, pe_vw, pe_vV;
			var pe_Xb, pe_Vj, pe_OA, pe_OG;
			pe_Xb = t._oThis.pe_UY;
			pe_Vj = t._oThis.pe_UX;
			pe_OA = t._oThis.pe_alr;
			pe_OG = t._oThis.pe_alp;
			if (pe_Xb > pe_OA) {
				pe_Xb = pe_OA;
				pe_OA = t._oThis.pe_UY;
			}
			if (pe_Vj > pe_OG) {
				pe_Vj = pe_OG;
				pe_OG = t._oThis.pe_UX;
			}
			for (var i = 0; i < table.rows.length; i++) {
				for (var j = 0; j < table.rows[i].cells.length; j++) {
					cell = table.rows[i].cells[j];
					pe_ow = t._oThis.util.pe_jH(cell);
					pe_oE = t._oThis.util.pe_kV(cell);
					pe_vw = pe_ow + cell.clientWidth;
					pe_vV = pe_oE + cell.clientHeight;
					if (pe_ow > pe_OA || pe_vw < pe_Xb || pe_oE > pe_OG
							|| pe_vV < pe_Vj) {
					} else {
						t._oThis.pe_bV.push(cell);
						t._oThis.pe_ma.push(cell.style.backgroundColor);
						cell.style.backgroundColor = t.pe_Iy;
						cell.alt = '\x73\x65\x6c\x65\x63\x74';
						++pe_aDS;
					}
				}
			}
			break;
		}
	},
	pe_tA : function() {
		this.pe_cW.pe_gd();
	},
	pe_aFn : function(pe_De, pe_Df) {
		var t = this;
		var pe_pw = t._oThis.pe_azY;
		var pe_tv = t._oThis.pe_azG;
		var pe_wc = t._oThis.pe_azN;
		var pe_Ia = t._oThis.pe_azI;
		var table = t._oThis.pe_UZ;
		var pe_RS = t._oThis.pe_aly;
		var pe_Iz = true;
		t.pe_qP();
		switch (t._oThis.pe_zK) {
		case '\x65':
			if (isNaN(pe_Df))
				return;
			for (var i = 0; i < pe_pw.length; ++i) {
				if (pe_tv[i] + pe_Df < t.pe_Vq) {
					pe_Iz = false;
					break;
				}
			}
			if (pe_Iz) {
				for (var i = 0; i < pe_wc.length; ++i) {
					if (pe_Ia[i] - pe_Df < t.pe_Vq) {
						pe_Iz = false;
						break;
					}
				}
			}
			if (pe_Iz) {
				for (var i = 0; i < pe_pw.length; ++i) {
					pe_pw[i].style.width = pe_tv[i] + pe_Df + '\x70\x78';
				}
				for (var i = 0; i < pe_wc.length; ++i) {
					pe_wc[i].style.width = pe_Ia[i] - pe_Df + '\x70\x78';
				}
				if ((pe_wc.length == 0) && (pe_RS + pe_Df > t.pe_Vq)) {
					table.style.width = pe_RS + pe_Df + '\x70\x78';
				}
			}
			break;
		case '\x73':
			if (isNaN(pe_De))
				return;
			if (pe_De > 0) {
				for (var i = 0; i < pe_pw.length; ++i) {
					pe_pw[i].style.height = pe_tv[i] + pe_De + '\x70\x78';
				}
				table.style.height = pe_RS + pe_De + '\x70\x78';
			} else {
				for (var i = 0; i < pe_pw.length; ++i) {
					if (pe_tv[i] + pe_De < t.pe_Vq) {
						pe_Iz = false;
						break;
					}
				}
				if (pe_Iz) {
					for (var i = 0; i < pe_pw.length; ++i) {
						pe_pw[i].style.height = pe_tv[i] + pe_De + '\x70\x78';
					}
					table.style.height = pe_RS + pe_De + '\x70\x78';
				}
			}
			break;
		}
	},
	pe_aJy : function(curX, curY) {
		var t = this;
		var table = t.pe_nY;
		if (!(table && table.tagName == '\x54\x41\x42\x4c\x45'))
			return;
		for (var i = 0; i < table.rows.length; i++) {
			for (var j = 0; j < table.rows[i].cells.length; j++) {
				cell = table.rows[i].cells[j];
				pe_ow = t._oThis.util.pe_jH(cell);
				pe_oE = t._oThis.util.pe_kV(cell);
				pe_vw = pe_ow + cell.clientWidth;
				pe_vV = pe_oE + cell.clientHeight;
				if (curX >= pe_ow && curX <= pe_vw && curY >= pe_oE
						&& curY <= pe_vV) {
					try {
						if (agentInfo.isIE) {
							var range = t.pe_fS.selection.createRange();
							range.moveToElementText(cell);
							range.collapse(true);
						}
					} catch (e) {
					}
					return;
				}
			}
		}
	},
	pe_aIw : function() {
	},
	pe_ayy : function() {
		var t = this;
		var pe_de = t._oThis.pe_Qm;
		t._oThis.pe_UZ = t.pe_cW.pe_eI(pe_de, '\x54\x41\x42\x4c\x45');
		var pe_cn = t.pe_cW.pe_or(t._oThis.pe_UZ);
		var loc = t.pe_cW.pe_sb(pe_cn, t._oThis.pe_Qm);
		var pe_pw = new Array();
		var pe_tv = new Array();
		var pe_wc = new Array();
		var pe_Ia = new Array();
		switch (t._oThis.pe_zK) {
		case '\x65':
			try {
				var pe_arw = loc.pe_eT + pe_cn[loc.pe_en][loc.pe_eT].colSpan;
			} catch (e) {
				return;
			}
			var i = 0;
			while (i < pe_cn.length) {
				var pe_Ce = pe_cn[i][loc.pe_eT];
				var rowSpan = pe_Ce.rowSpan;
				pe_pw.push(pe_Ce.pe_dA);
				pe_tv.push(pe_Ce.pe_dA.clientWidth);
				i += rowSpan;
			}
			if (pe_arw < pe_cn[0].length) {
				i = 0;
				while (i < pe_cn.length) {
					var pe_Cb = pe_cn[i][pe_arw];
					var rowSpan = pe_Cb.rowSpan;
					pe_wc.push(pe_Cb.pe_dA);
					pe_Ia.push(pe_Cb.pe_dA.clientWidth);
					i += rowSpan;
				}
			}
			t._oThis.pe_aly = t._oThis.pe_UZ.clientWidth;
			break;
		case '\x73':
			try {
				var pe_arC = loc.pe_en + pe_cn[loc.pe_en][loc.pe_eT].rowSpan;
			} catch (e) {
				return;
			}
			var i = 0;
			while (i < pe_cn[0].length) {
				var pe_Ce = pe_cn[loc.pe_en][i];
				var colSpan = pe_Ce.colSpan;
				pe_pw.push(pe_Ce.pe_dA);
				pe_tv.push(pe_Ce.pe_dA.clientHeight);
				i += colSpan;
			}
			if (pe_arC < pe_cn.length) {
				i = 0;
				while (i < pe_cn[0].length) {
					var pe_Cb = pe_cn[pe_arC][i];
					var colSpan = pe_Cb.colSpan;
					pe_wc.push(pe_Cb.pe_dA);
					pe_Ia.push(pe_Cb.pe_dA.clientHeight);
					i += colSpan;
				}
			}
			t._oThis.pe_aly = t._oThis.pe_UZ.clientHeight;
			break;
		}
		t._oThis.pe_azY = pe_pw;
		t._oThis.pe_azN = pe_wc;
		t._oThis.pe_azG = pe_tv;
		t._oThis.pe_azI = pe_Ia;
	}
};
var pe_aFU = {
	_oThis : null,
	pe_nY : null,
	pe_dI : null,
	pe_bC : null,
	pe_cW : null,
	start : function() {
		var t = this;
		if (t._oThis.getDocument().getElementById('\x64\x65\x6c\x62\x6f\x78'))
			t._oThis.getDocument().body.removeChild(t._oThis.getDocument()
					.getElementById('\x64\x65\x6c\x62\x6f\x78'));
		if (!t.pe_dI || !t._oThis.pe_bV || !t._oThis.pe_ic
				|| (t._oThis.pe_bV && !(t._oThis.pe_bV.length > 1)))
			return;
		t.pe_fS = t._oThis.getDocument();
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		t.pe_cq();
	},
	pe_cq : function() {
		var t = this;
		if (!agentInfo.IsOpera)
			t._oThis.pe_dt(false);
		try {
			var sum = 0;
			var pe_dm = '';
			var pe_hG = false;
			for (var i = 0; i < t._oThis.pe_bV.length; i++) {
				if (agentInfo.IsIE && !agentInfo.IsIE9) {
					pe_dm = t._oThis.pe_bV[i].innerText;
				} else {
					pe_dm = t._oThis.pe_bV[i].textContent;
				}
				var pe_la = (pe_dm.indexOf("\x2c") > -1) ? true : false;
				pe_dm = (pe_la) ? pe_dm.replace(/\,/g, '') : pe_dm;
				if (pe_la && !pe_hG)
					pe_hG = true;
				if (isNaN(pe_dm)) {
					sum += 0;
				} else if (pe_dm.replace(/\s/gi, '')) {
					sum += parseFloat(pe_dm);
				}
			}
			var point = sum.toString().indexOf("\x2e");
			if (point > -1) {
				sum = Number(sum.toString().substring(0, point + 3));
			}
			if (pe_hG) {
				var pe_gZ = sum.toString().split("\x2e");
				sum = pe_gZ[0].replace(/\B(?=(\d{3})+(?!\d))/g, "\x2c")
						+ (pe_gZ[1] ? "\x2e" + pe_gZ[1] : "");
			}
			if (t._oThis.pe_kt && t._oThis.pe_kt.range
					&& t._oThis.pe_kt.range.startContainer) {
				var pe_dz = [];
				var container = t._oThis.pe_kt.range.startContainer;
				var i = 0;
				var pe_ri = function(i) {
					if (container && container.parentNode) {
						var flag = false;
						if (container.parentNode.nodeName.toLowerCase() != "\x74\x64") {
							if (container.nodeName.toLowerCase() == '\x74\x64')
								flag = false;
							else
								flag = true;
						}
						if (flag) {
							pe_dz[i] = container.parentNode.cloneNode(false);
							container = container.parentNode;
							i += 1;
							pe_ri(i);
						} else {
							if (pe_dz.length > 0) {
								if (agentInfo.IsIE && !agentInfo.IsIE9) {
									pe_dz[0].innerText = sum;
								} else {
									pe_dz[0].textContent = sum;
								}
								for (var i = 0; i < (pe_dz.length - 1); i++) {
									pe_dz[i + 1].appendChild(pe_dz[i]);
								}
								t._oThis.pe_ic.innerHTML = pe_dz[pe_dz.length - 1].outerHTML;
							} else {
								if (container.nodeName.toLowerCase() == '\x70'
										|| container.nodeName.toLowerCase() == '\x73\x70\x61\x6e') {
									pe_dz[0] = container.cloneNode(false);
									if (agentInfo.IsIE && !agentInfo.IsIE9) {
										pe_dz[0].innerText = sum;
									} else {
										pe_dz[0].textContent = sum;
									}
									t._oThis.pe_ic.innerHTML = pe_dz[0].outerHTML;
								} else {
									t._oThis.pe_ic.innerHTML = sum;
								}
							}
						}
					}
				};
				pe_ri(i);
			} else {
				var pe_dz = [];
				var i = 0;
				var container = t._oThis.pe_gH(pe_bC.range, true);
				container = container.firstChild;
				if (container) {
					var pe_ri = function(i) {
						if (container && container.parentNode) {
							var flag = false;
							if (container.parentNode.nodeName.toLowerCase() != "\x74\x64") {
								if (container.nodeName.toLowerCase() == '\x74\x64')
									flag = false;
								else
									flag = true;
							}
							if (flag) {
								pe_dz[i] = container.parentNode
										.cloneNode(false);
								container = container.parentNode;
								i += 1;
								pe_ri(i);
							} else {
								if (pe_dz.length > 0) {
									if (agentInfo.IsIE && !agentInfo.IsIE9) {
										pe_dz[0].innerText = sum;
									} else {
										pe_dz[0].textContent = sum;
									}
									for (var i = 0; i < (pe_dz.length - 1); i++) {
										pe_dz[i + 1].appendChild(pe_dz[i]);
									}
									t._oThis.pe_ic.innerHTML = pe_dz[pe_dz.length - 1].outerHTML;
								} else {
									if (container.nodeName.toLowerCase() == '\x70'
											|| container.nodeName.toLowerCase() == '\x73\x70\x61\x6e') {
										pe_dz[0] = container.cloneNode(false);
										if (agentInfo.IsIE && !agentInfo.IsIE9) {
											pe_dz[0].innerText = sum;
										} else {
											pe_dz[0].textContent = sum;
										}
										t._oThis.pe_ic.innerHTML = pe_dz[0].outerHTML;
									} else {
										t._oThis.pe_ic.innerHTML = sum;
									}
								}
							}
						}
					};
					pe_ri(i);
				} else {
					if (agentInfo.IsIE && !agentInfo.IsIE9) {
						t._oThis.pe_ic.innerText = sum;
					} else {
						t._oThis.pe_ic.textContent = sum;
					}
				}
			}
			t.pe_bC = t._oThis.pe_kt;
			t.pe_bC.sel = t._oThis.pe_kt.sel;
			t.pe_bC.range = t._oThis.pe_kt.range;
			if (!agentInfo.IsIE)
				t.pe_bC.range.selectNodeContents(t._oThis.pe_ic);
			t.pe_bC.range.collapse(false);
			if (agentInfo.IsIE) {
				t.pe_bC.range.select();
			} else if (!agentInfo.IsOpera) {
				var pe_cp = t.pe_bC.range.cloneRange();
				t.pe_bC.sel.removeAllRanges();
				t.pe_bC.sel.addRange(pe_cp);
			} else {
				t.pe_bC.sel.removeAllRanges();
			}
		} catch (e) {
			return;
		}
	}
};
var pe_aFW = {
	_oThis : null,
	pe_nY : null,
	pe_dI : null,
	pe_bC : null,
	pe_cW : null,
	start : function() {
		var t = this;
		if (t._oThis.getDocument().getElementById('\x64\x65\x6c\x62\x6f\x78'))
			t._oThis.getDocument().body.removeChild(t._oThis.getDocument()
					.getElementById('\x64\x65\x6c\x62\x6f\x78'));
		if (!t.pe_dI || !t._oThis.pe_bV || !t._oThis.pe_ic
				|| (t._oThis.pe_bV && !(t._oThis.pe_bV.length > 1)))
			return;
		t.pe_fS = t._oThis.getDocument();
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		t.pe_cq();
	},
	pe_cq : function() {
		if (!agentInfo.IsOpera)
			t._oThis.pe_dt(false);
		try {
			var sum = 0;
			var pe_dm = '';
			var pe_hG = false;
			for (var i = 0; i < t._oThis.pe_bV.length; i++) {
				if (agentInfo.IsIE && !agentInfo.IsIE9) {
					pe_dm = t._oThis.pe_bV[i].innerText;
				} else {
					pe_dm = t._oThis.pe_bV[i].textContent;
				}
				var pe_la = (pe_dm.indexOf("\x2c") > -1) ? true : false;
				pe_dm = (pe_la) ? pe_dm.replace(/\,/g, '') : pe_dm;
				if (pe_la && !pe_hG)
					pe_hG = true;
				if (isNaN(pe_dm)) {
					sum += 0;
				} else if (pe_dm.replace(/\s/gi, '')) {
					sum += parseFloat(pe_dm);
				}
			}
			sum = sum / t._oThis.pe_bV.length;
			var point = sum.toString().indexOf("\x2e");
			if (point > -1) {
				sum = Number(sum.toString().substring(0, point + 3));
			}
			if (pe_hG) {
				var pe_gZ = sum.toString().split("\x2e");
				sum = pe_gZ[0].replace(/\B(?=(\d{3})+(?!\d))/g, "\x2c")
						+ (pe_gZ[1] ? "\x2e" + pe_gZ[1] : "");
			}
			if (t._oThis.pe_kt && t._oThis.pe_kt.range
					&& t._oThis.pe_kt.range.startContainer) {
				var pe_dz = [];
				var container = t._oThis.pe_kt.range.startContainer;
				var i = 0;
				var pe_ri = function(i) {
					if (container && container.parentNode) {
						var flag = false;
						if (container.parentNode.nodeName.toLowerCase() != "\x74\x64") {
							if (container.nodeName.toLowerCase() == '\x74\x64')
								flag = false;
							else
								flag = true;
						}
						if (flag) {
							pe_dz[i] = container.parentNode.cloneNode(false);
							container = container.parentNode;
							i += 1;
							pe_ri(i);
						} else {
							if (pe_dz.length > 0) {
								if (agentInfo.IsIE && !agentInfo.IsIE9) {
									pe_dz[0].innerText = sum;
								} else {
									pe_dz[0].textContent = sum;
								}
								for (var i = 0; i < (pe_dz.length - 1); i++) {
									pe_dz[i + 1].appendChild(pe_dz[i]);
								}
								t._oThis.pe_ic.innerHTML = pe_dz[pe_dz.length - 1].outerHTML;
							} else {
								if (container.nodeName.toLowerCase() == '\x70'
										|| container.nodeName.toLowerCase() == '\x73\x70\x61\x6e') {
									pe_dz[0] = container.cloneNode(false);
									if (agentInfo.IsIE && !agentInfo.IsIE9) {
										pe_dz[0].innerText = sum;
									} else {
										pe_dz[0].textContent = sum;
									}
									t._oThis.pe_ic.innerHTML = pe_dz[0].outerHTML;
								} else {
									t._oThis.pe_ic.innerText = sum;
								}
							}
						}
					}
				};
				pe_ri(i);
			} else {
				var pe_dz = [];
				var i = 0;
				var container = t._oThis.pe_gH(pe_bC.range, true);
				container = container.firstChild;
				if (container) {
					var pe_ri = function(i) {
						if (container && container.parentNode) {
							var flag = false;
							if (container.parentNode.nodeName.toLowerCase() != "\x74\x64") {
								if (container.nodeName.toLowerCase() == '\x74\x64')
									flag = false;
								else
									flag = true;
							}
							if (flag) {
								pe_dz[i] = container.parentNode
										.cloneNode(false);
								container = container.parentNode;
								i += 1;
								pe_ri(i);
							} else {
								if (pe_dz.length > 0) {
									if (agentInfo.IsIE && !agentInfo.IsIE9) {
										pe_dz[0].innerText = sum;
									} else {
										pe_dz[0].textContent = sum;
									}
									for (var i = 0; i < (pe_dz.length - 1); i++) {
										pe_dz[i + 1].appendChild(pe_dz[i]);
									}
									t._oThis.pe_ic.innerHTML = pe_dz[pe_dz.length - 1].outerHTML;
								} else {
									if (container.nodeName.toLowerCase() == '\x70'
											|| container.nodeName.toLowerCase() == '\x73\x70\x61\x6e') {
										pe_dz[0] = container.cloneNode(false);
										if (agentInfo.IsIE && !agentInfo.IsIE9) {
											t._oThis.pe_ic.innerText = sum;
										} else {
											t._oThis.pe_ic.textContent = sum;
										}
										t._oThis.pe_ic.innerHTML = pe_dz[0].outerHTML;
									} else {
										t._oThis.pe_ic.innerHTML = sum;
									}
								}
							}
						}
					};
					pe_ri(i);
				} else {
					if (agentInfo.IsIE && !agentInfo.IsIE9) {
						t._oThis.pe_ic.innerText = sum;
					} else {
						t._oThis.pe_ic.textContent = sum;
					}
				}
			}
			t.pe_bC = t._oThis.pe_kt;
			t.pe_bC.sel = t._oThis.pe_kt.sel;
			t.pe_bC.range = t._oThis.pe_kt.range;
			if (!agentInfo.IsIE)
				t.pe_bC.range.selectNodeContents(t._oThis.pe_ic);
			t.pe_bC.range.collapse(false);
			;
			if (agentInfo.IsIE) {
				t.pe_bC.range.select();
			} else if (!agentInfo.IsOpera) {
				var pe_cp = t.pe_bC.range.cloneRange();
				t.pe_bC.sel.removeAllRanges();
				t.pe_bC.sel.addRange(pe_cp);
			} else {
				t.pe_bC.sel.removeAllRanges();
			}
		} catch (e) {
			return;
		}
	}
};
var pe_auU = {
	_oThis : null,
	pe_bC : null,
	pe_bU : null,
	pe_aFN : function(cmd) {
		if (!cmd)
			return;
		var t = this;
		var pe_nc = pe_lK = null;
		var pe_Id = false;
		if (!(t._oThis.pe_rK("\x6d\x61\x6e\x61\x67\x65\x72") || t._oThis
				.pe_rK("\x74\x65\x73\x74\x5f\x6d\x61\x6e\x61\x67\x65\x72"))) {
			alert(pe_bE.pe_Lz);
			return;
		}
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		if (t.pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c") {
			pe_nc = t.pe_bC.pe_fJ();
		} else {
			pe_nc = t.pe_bC.pe_gu('\x54\x41\x42\x4c\x45');
			if (agentInfo.IsIE && !t.pe_bC.isCollapsed() && pe_nc == null) {
				var pe_cp = t.pe_bC.range.duplicate();
				pe_cp.collapse(true);
				if (pe_cp.parentElement) {
					pe_nc = t.pe_bC.pe_dG(pe_cp.parentElement(),
							'\x54\x41\x42\x4c\x45');
				}
			}
		}
		if (!pe_nc || pe_nc.nodeName != "\x54\x41\x42\x4c\x45")
			return;
		if (cmd == "\x63\x65\x6c\x6c\x6c\x6f\x63\x6b") {
			if (t._oThis.pe_bV && t._oThis.pe_bV.length > 0)
				pe_Id = true;
			pe_lK = t.pe_bC.pe_dG(t.pe_bC.range.commonAncestorContainer
					|| t.pe_bC.range.parentElement(),
					[ '\x54\x44', '\x54\x48' ]);
			if (!(pe_Id || pe_lK))
				return;
			this.pe_aBI(pe_lK, pe_Id);
		} else {
			this.pe_aCi(pe_nc);
		}
	},
	pe_aCi : function(pe_dL) {
		var t = this;
		var pe_lq = [
				"\x4e\x61\x6d\x6f\x53\x45\x5f\x74\x61\x62\x6c\x65\x6c\x6f\x63\x6b\x5f\x73\x68\x6f\x77",
				"\x4e\x61\x6d\x6f\x53\x45\x5f\x63\x65\x6c\x6c\x6c\x6f\x63\x6b\x5f\x73\x68\x6f\x77" ];
		var pe_atu = function(pe_ajE) {
			for (var x = 0; x < pe_dL.rows.length; x++) {
				for (var y = 0; y < pe_dL.rows[x].cells.length; y++) {
					var cell = pe_dL.rows[x].cells[y];
					if (cell
							&& t._oThis
									.pe_hO(
											cell,
											"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b\x5f\x6e\x6f\x4c\x69\x63\x65\x6e\x73\x65")) {
						if (pe_ajE == "\x64\x65\x6c") {
							t.pe_Kz(cell, '\x64\x65\x6c', pe_lq[1]);
						} else if (pe_ajE == "\x61\x64\x64") {
							t._oThis.pe_sK(cell, '\x61\x64\x64', pe_lq[1]);
						}
					}
				}
			}
		};
		if (t._oThis
				.pe_hO(
						pe_dL,
						"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b\x5f\x6e\x6f\x4c\x69\x63\x65\x6e\x73\x65")) {
			t.pe_Kz(pe_dL, '\x64\x65\x6c', pe_lq[0]);
			pe_atu('\x61\x64\x64');
		} else {
			t.pe_Kz(pe_dL, '\x61\x64\x64', pe_lq[0]);
			pe_atu('\x64\x65\x6c');
		}
	},
	pe_aBI : function(pe_aEQ, pe_pe) {
		var t = this;
		var cells = [];
		var pe_lq = [
				"\x4e\x61\x6d\x6f\x53\x45\x5f\x74\x61\x62\x6c\x65\x6c\x6f\x63\x6b\x5f\x73\x68\x6f\x77",
				"\x4e\x61\x6d\x6f\x53\x45\x5f\x63\x65\x6c\x6c\x6c\x6f\x63\x6b\x5f\x73\x68\x6f\x77" ];
		if (pe_pe) {
			cells = t._oThis.pe_bV;
		} else {
			cells = [ pe_aEQ ];
		}
		for (var i = 0; i < cells.length; i++) {
			if (cells[i]) {
				if (t._oThis
						.pe_hO(
								cells[i],
								"\x6e\x61\x6d\x6f\x74\x61\x62\x6c\x65\x5f\x6c\x6f\x63\x6b\x5f\x6e\x6f\x4c\x69\x63\x65\x6e\x73\x65")) {
					t.pe_Kz(cells[i], '\x64\x65\x6c', pe_lq[1]);
				} else {
					t.pe_Kz(cells[i], '\x61\x64\x64', pe_lq[1]);
				}
			}
		}
	},
	pe_Kz : function(pe_Md, pe_Zi, pe_amu) {
		if (pe_Zi == "\x61\x64\x64") {
			pe_Md.setAttribute("\x6e\x61\x6d\x6f\x5f\x6c\x6f\x63\x6b",
					"\x6e\x61\x6d\x6f\x5f\x6c\x6f\x63\x6b");
			this._oThis.pe_sK(pe_Md, '\x61\x64\x64', pe_amu);
		} else if (pe_Zi == "\x64\x65\x6c") {
			pe_Md.removeAttribute("\x6e\x61\x6d\x6f\x5f\x6c\x6f\x63\x6b");
			pe_Md
					.removeAttribute("\x6d\x61\x6e\x61\x67\x65\x72\x5f\x6d\x6f\x64\x65");
			this._oThis.pe_sK(pe_Md, '\x64\x65\x6c', pe_amu);
		}
	}
};
var pe_azZ = {
	_oThis : null,
	pe_bU : null,
	pe_bC : null,
	pe_cW : null,
	pe_Vs : null,
	pe_azP : NamoSE.pe_cy.pe_azC,
	pe_aJF : NamoSE.pe_cy.pe_azD,
	pe_azO : NamoSE.pe_cy.pe_azM,
	execUndoHistory : function() {
		var t = this;
		if (this._oThis._historyStackIdx <= 0) {
			this._oThis.pe_zp = false;
		}
		if (!this._oThis.pe_zp) {
			this.pe_abk();
		}
		this._oThis.pe_zp = true;
		this._oThis._historyStackIdx--;
		if (this._oThis._historyStackIdx < 0) {
			this._oThis._historyStackIdx = 0;
		}
		if (this._oThis._historyStackIdx >= 0) {
			this.pe_abp(this._oThis.pe_iB[this._oThis._historyStackIdx]);
			this.pe_abo();
		} else {
			this._oThis._historyStackIdx++;
		}
		this.pe_aqr();
	},
	execRedoHistory : function() {
		var t = this;
		this._oThis._historyStackIdx++;
		if (this._oThis._historyStackIdx <= this._oThis.pe_iB.length - 1) {
			this.pe_abp(this._oThis.pe_iB[this._oThis._historyStackIdx]);
			this.pe_abo();
		} else {
			this._oThis._historyStackIdx--;
		}
		this.pe_aqr();
	},
	pe_abk : function(pe_afw, pe_Ah, pe_QC, pe_VZ, pe_aeM) {
		if (typeof pe_afw == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_afw = false;
		if (typeof pe_Ah == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_Ah = true;
		if (typeof pe_QC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_QC = false;
		if (typeof pe_VZ == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_VZ = '\x6e\x6f\x6e\x65';
		if (typeof pe_aeM == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_aeM = true;
		this.pe_Vs = null;
		var pe_aAa = this;
		var pe_gG = function() {
			var pe_bU = pe_aAa._oThis
					.getFunctionals('\x73\x74\x61\x74\x75\x73\x68\x69\x67\x68\x6c\x69\x67\x68\x74');
			pe_bU.start();
		};
		var pe_pn = this.pe_XL();
		var pe_akP = (pe_pn.length > this.pe_azO);
		if (!this._oThis.pe_rR) {
			if (!pe_akP) {
				this._oThis.pe_rR = true;
			} else {
				return;
			}
		} else {
			if (pe_akP) {
				this.pe_aql();
				this._oThis.pe_rR = false;
				NamoSE.Util.pe_bO(pe_gG, 10);
				return;
			}
		}
		var pe_UU;
		pe_UU = this.pe_asn(this._oThis.pe_iB[this._oThis._historyStackIdx]);
		if (pe_pn)
			pe_pn = pe_pn.toLowerCase();
		if (pe_pn == pe_UU) {
			this._oThis.pe_zp = false;
			return;
		} else {
		}
		if (!agentInfo.IsIE)
			this._oThis.pe_dy().focus();
		this.pe_bC.sel = this.pe_bC.getSelection();
		var pe_uz = [];
		if (!pe_Ah) {
			pe_uz = [ null, null ];
		} else {
			try {
				this.pe_bC.range = this.pe_bC.pe_bY();
				if (agentInfo.IsOpera) {
					var pe_yO = this.pe_bC.range.startContainer;
					if (pe_yO && pe_yO.nodeType == 3 && pe_yO.parentNode
							&& pe_yO.parentNode.nodeType == 1
							&& pe_yO.parentNode.nodeName == "\x50") {
						if (!this._oThis.util.pe_asa(pe_yO.parentNode)) {
							if (pe_yO.nodeValue.Trim() == ""
									&& pe_yO.nodeValue == "") {
								return;
							}
						}
					}
				}
				if (this.pe_bC.pe_dV() != "\x43\x6f\x6e\x74\x72\x6f\x6c"
						&& pe_VZ != "\x6b\x65\x79\x69\x6e\x70\x75\x74"
						&& pe_aeM) {
					this.pe_Vs = this.pe_bC.pe_PB(this.pe_bC.range);
					this.pe_bC.range.collapse(false);
					this.pe_bC.pe_bM();
				} else {
				}
				var pe_ZG = false;
				var pe_arn = 0;
				if (pe_VZ == "\x6b\x65\x79\x69\x6e\x70\x75\x74") {
					if (!agentInfo.IsIE) {
						if (this.pe_bC.range.startContainer)
							pe_ZG = true;
					}
				}
				if (pe_ZG) {
					try {
						var pe_aok = this.pe_bC.range.startContainer;
						var pe_VV = this._oThis.getDocument().createElement(
								"\x53\x50\x41\x4e");
						pe_VV.id = "\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74";
						pe_VV.innerHTML = "";
						pe_aok.parentNode.insertBefore(pe_VV, pe_aok);
						pe_arn = this.pe_bC.range.startOffset;
						pe_uz = [ pe_VV, null ];
					} catch (exp) {
						pe_ZG = false;
						pe_uz = this.pe_bC.pe_hU();
					}
				} else {
					pe_uz = this.pe_bC.pe_hU();
				}
			} catch (e) {
				pe_uz = [ null, null ];
			}
		}
		this.pe_cW.pe_aHX();
		pe_pn = this.pe_XL(pe_ZG, pe_arn);
		if (pe_uz[0] || pe_uz[1])
			this.pe_bC.pe_hI(pe_uz[0], pe_uz[1]);
		this.pe_amv();
		if (this._oThis.pe_iB.length >= this.pe_azP)
			this._oThis.pe_iB.shift();
		this._oThis.pe_iB.push(pe_pn);
		if (this._oThis.pe_hj == "\x77\x79\x73\x69\x77\x79\x67"
				&& (this._oThis.pe_Op == "\x68\x74\x6d\x6c" || this._oThis.pe_Op == "\x70\x72\x65\x76\x69\x65\x77")) {
			this._oThis.pe_iB.shift();
			this._oThis.pe_Op = "";
		}
		this._oThis._historyStackIdx = this._oThis.pe_iB.length - 1;
		this._oThis.pe_zp = false;
		this.pe_cW.pe_awi();
		this.pe_aDA(pe_QC);
		if (pe_afw) {
			var pe_HX = document.getElementById("\x75\x6e\x64\x6f");
			var pe_As = document.getElementById("\x72\x65\x64\x6f");
			if (pe_HX || pe_As) {
				var pe_GJ = false;
				var pe_NI = (this._oThis._historyStackIdx > 0) ? '\x64\x65\x66\x61\x75\x6c\x74'
						: '\x64\x69\x73\x61\x62\x6c\x65';
				var pe_afR = (this._oThis._historyStackIdx < this._oThis.pe_iB.length - 1) ? '\x64\x65\x66\x61\x75\x6c\x74'
						: '\x64\x69\x73\x61\x62\x6c\x65';
				if (pe_HX
						&& pe_NI != pe_HX
								.getAttribute('\x73\x74\x61\x74\x75\x73'))
					pe_GJ = true;
				if (pe_As
						&& pe_afR != pe_As
								.getAttribute('\x73\x74\x61\x74\x75\x73'))
					pe_GJ = true;
				if (pe_GJ) {
					NamoSE.Util.pe_bO(pe_gG, 10);
				}
			}
		}
	},
	pe_azo : function(pe_Ah) {
		if (typeof pe_Ah == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_Ah = true;
		this.pe_asM();
		this.pe_abk(false, pe_Ah, true);
	},
	pe_aql : function() {
		if (this._oThis.pe_iB.length > 1) {
			var pe_apf = this._oThis.pe_iB[0];
			this.pe_asM();
			this._oThis.pe_iB[0] = pe_apf;
			this._oThis._historyStackIdx = this._oThis.pe_iB.length - 1;
			pe_apf = null;
		}
	},
	pe_asM : function() {
		this._oThis.pe_iB = [];
		this._oThis._historyStackIdx = -1;
		this.pe_awV = 0;
		this._oThis.pe_zp = false;
		this._oThis.pe_rR = true;
	},
	pe_aqr : function() {
		this._oThis.pe_tU = null;
		this._oThis.pe_bV = new Array();
		this._oThis.pe_ma = new Array();
	},
	pe_amv : function() {
		while (this._oThis.pe_iB.length - 1 > this._oThis._historyStackIdx) {
			this._oThis.pe_iB.pop();
		}
	},
	pe_XL : function(pe_abC, pe_ams) {
		if (typeof pe_abC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_abC = false;
		var pe_Ri = this._oThis.getDocument().body.innerHTML;
		if (pe_abC) {
			var pe_fq = this._oThis.pe_uG();
			var eDoc = pe_fq.contentWindow.document;
			eDoc.body.innerHTML = pe_Ri;
			var pe_HH = eDoc
					.getElementById("\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74");
			if (pe_HH && pe_HH.nextSibling && pe_HH.nextSibling.nodeType == 3) {
				try {
					var pe_adD = eDoc.createRange();
					pe_adD.setStart(pe_HH.nextSibling, pe_ams);
					pe_adD.setEnd(pe_HH.nextSibling, pe_ams);
					pe_adD.insertNode(pe_HH);
					pe_Ri = eDoc.body.innerHTML;
				} catch (exp) {
				}
			}
			eDoc.body.innerHTML = "";
			pe_fq.style.display = "\x6e\x6f\x6e\x65";
		}
		if (agentInfo.IsIE)
			pe_Ri = this._oThis.pe_Vk(this._oThis.getDocument(), pe_Ri);
		return pe_Ri;
	},
	pe_abp : function(pe_fz) {
		if (typeof pe_fz == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return;
		var pe_fu = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65";
		var pe_ms = "\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x27"
				+ pe_fu
				+ "\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x63\x6f\x6c\x6f\x72\x3a\x23\x46\x46\x46\x46\x46\x46\x27\x3e\x62\x6c\x61\x6e\x6b\x3c\x2f\x73\x70\x61\x6e\x3e";
		if (pe_fz == "\x3c\x70\x3e\x3c\x2f\x70\x3e"
				|| pe_fz == "\x3c\x50\x3e\x3c\x2f\x50\x3e") {
			pe_fz = "\x3c\x70\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x45\x6e\x64\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x2f\x70\x3e";
		}
		if (pe_fz == "\x3c\x70\x3e\x3c\x62\x72\x3e\x3c\x2f\x70\x3e"
				|| pe_fz == "\x3c\x50\x3e\x3c\x42\x52\x3e\x3c\x2f\x50\x3e") {
			pe_fz = "\x3c\x70\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x45\x6e\x64\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x62\x72\x3e\x3c\x2f\x70\x3e";
		}
		if (pe_fz == "\x3c\x70\x3e\x3c\x62\x72\x2f\x3e\x3c\x2f\x70\x3e"
				|| pe_fz == "\x3c\x50\x3e\x3c\x42\x52\x2f\x3e\x3c\x2f\x50\x3e") {
			pe_fz = "\x3c\x70\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x45\x6e\x64\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x62\x72\x3e\x3c\x2f\x70\x3e";
		}
		if (pe_fz == "\x3c\x70\x3e\x3c\x2f\x70\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x45\x6e\x64\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e"
				|| pe_fz == "\x3c\x50\x3e\x3c\x2f\x50\x3e\x3c\x53\x50\x41\x4e\x20\x69\x64\x3d\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\x3e\x3c\x2f\x53\x50\x41\x4e\x3e\x3c\x53\x50\x41\x4e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x45\x6e\x64\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x53\x50\x41\x4e\x3e") {
			pe_fz = "\x3c\x70\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x45\x6e\x64\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x73\x70\x61\x6e\x3e\x3c\x62\x72\x3e\x3c\x2f\x70\x3e";
		}
		try {
			var idoc = this._oThis.getDocument();
			if (agentInfo.IsIE) {
				pe_fz = pe_ms + pe_fz;
			}
			pe_fz = this._oThis.pe_wL(pe_fz);
			idoc.body.innerHTML = pe_fz;
			if (agentInfo.IsIE) {
				if (idoc.getElementById(pe_fu))
					idoc.body.removeChild(idoc.getElementById(pe_fu));
			}
		} catch (e) {
		}
	},
	pe_ash : function() {
		if (this._oThis._historyStackIdx != 0)
			return false;
		var pe_pn = this.pe_XL();
		var pe_UU = this
				.pe_asn(this._oThis.pe_iB[this._oThis._historyStackIdx]);
		if (pe_pn)
			pe_pn = pe_pn.toLowerCase();
		return (pe_pn == pe_UU);
	},
	pe_asn : function(pe_fz) {
		if (typeof pe_fz == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			return null;
		if (!pe_fz)
			return pe_fz;
		pe_fz = pe_fz.toLowerCase();
		pe_fz = pe_fz
				.replace(
						'\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x5f\x73\x65\x73\x70\x61\x6e\x5f\x73\x74\x61\x72\x74\x63\x61\x72\x65\x74\x3e\x3c\x2f\x73\x70\x61\x6e\x3e',
						'');
		pe_fz = pe_fz
				.replace(
						'\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x22\x5f\x73\x65\x73\x70\x61\x6e\x5f\x73\x74\x61\x72\x74\x63\x61\x72\x65\x74\x22\x3e\x3c\x2f\x73\x70\x61\x6e\x3e',
						'');
		pe_fz = pe_fz
				.replace(
						'\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x5f\x73\x65\x73\x70\x61\x6e\x5f\x65\x6e\x64\x63\x61\x72\x65\x74\x3e\x3c\x2f\x73\x70\x61\x6e\x3e',
						'');
		pe_fz = pe_fz
				.replace(
						'\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x22\x5f\x73\x65\x73\x70\x61\x6e\x5f\x65\x6e\x64\x63\x61\x72\x65\x74\x22\x3e\x3c\x2f\x73\x70\x61\x6e\x3e',
						'');
		return pe_fz;
	},
	pe_aDA : function(pe_QC) {
		if (this.pe_Vs) {
			if (agentInfo.IsOpera && parseInt(pe_cm) < 10 && pe_QC) {
				var content = this.pe_XL();
				this.pe_abp(content);
				content = null;
				this._oThis.pe_Yr();
			} else {
				try {
					this.pe_bC.range = this.pe_Vs;
					this.pe_bC.pe_bM();
				} catch (exp) {
				}
			}
		}
	},
	pe_abo : function() {
		var pe_op = this.pe_bC.pe_iX();
		var pe_zL = this.pe_bC.pe_hW(pe_op[0], pe_op[1]);
		if (pe_zL) {
			if (!agentInfo.IsIE && this.pe_bC.range.endContainer)
				NamoSE.Util.scrollIntoView(this.pe_bC.range.endContainer,
						this.pe_bC);
		}
		this.pe_bC.pe_hI(pe_op[0], pe_op[1]);
	}
};
var pe_vO = {
	_oThis : null,
	pe_aij : {
		"\x70\x78" : 1,
		"\x70\x74" : 0.8,
		"\x6d\x6d" : 0.27
	},
	pe_ana : function(iframe, e, idoc) {
		var pe_jf = false;
		if (!agentInfo.IsChrome) {
			return pe_jf;
		}
		try {
			var pe_tZ = e.clipboardData
					.getData('\x74\x65\x78\x74\x2f\x68\x74\x6d\x6c');
			if (/<[^>]*?class="?xl\d+"?[^>]*>/.test(pe_tZ)
					|| /[0-9\.]mm/.test(pe_tZ)) {
				this._oThis.pe_Bk(idoc);
				this._oThis.pe_LA(idoc, "\x70\x61\x73\x74\x65");
				if (this._oThis.pe_zG(idoc, "\x64\x6f\x6d"))
					this._oThis.pe_zR(idoc, "\x64\x6f\x6d");
				this._oThis.pe_sH(idoc, "\x64\x6f\x6d");
				this._oThis.pe_sr(idoc, "\x64\x6f\x6d");
				this._oThis.pe_nO(idoc);
				iframe.document.open();
				iframe.frameElement.style.display = '\x6e\x6f\x6e\x65';
				iframe.document.write(pe_tZ);
				iframe.document.close();
				var styleSheets = iframe.document.styleSheets;
				for (var i = 0; i < styleSheets.length; i++) {
					var CSSRuleList = styleSheets[i];
					for (var j = 0; j < CSSRuleList.cssRules.length; j++) {
						var CSSStyleRule = CSSRuleList.cssRules[j];
						var pe_ns = CSSStyleRule.selectorText;
						if (pe_ns.length <= 0)
							continue;
						if (pe_ns.indexOf("\x2e") == 0)
							continue;
						if (pe_ns.toLowerCase() == "\x74\x61\x62\x6c\x65")
							continue;
						var Eles = iframe.document.getElementsByTagName(pe_ns);
						for (var k = 0; k < Eles.length; k++) {
							var Element = Eles[k];
							var fontFamily = CSSStyleRule.style.fontFamily;
							var fontSize = CSSStyleRule.style.fontSize;
							var fontStretch = CSSStyleRule.style.fontStretch;
							var fontStyle = CSSStyleRule.style.fontStyle;
							var fontVariant = CSSStyleRule.style.fontVariant;
							var fontWeight = CSSStyleRule.style.fontWeight;
							if (fontFamily.length > 0) {
								Element.style.fontFamily = fontFamily;
							}
							if (fontSize.length > 0) {
								if (Element.style.fontSize <= 0) {
									Element.style.fontSize = fontSize;
								}
							}
							if (fontStretch.length > 0) {
								if (Element.style.fontStretch <= 0) {
									Element.style.fontStretch = fontStretch;
								}
							}
							if (fontStyle.length > 0) {
								if (Element.style.fontStyle <= 0) {
									Element.style.fontStyle = fontStyle;
								}
							}
							if (fontVariant.length > 0) {
								if (Element.style.fontVariant <= 0) {
									Element.style.fontVariant = fontVariant;
								}
							}
							if (fontWeight.length > 0) {
								if (Element.style.fontWeight <= 0) {
									Element.style.fontWeight = fontWeight;
								}
							}
						}
					}
				}
				for (var i = 0; i < styleSheets.length; i++) {
					var CSSRuleList = styleSheets[i];
					for (var j = 0; j < CSSRuleList.cssRules.length; j++) {
						var CSSStyleRule = CSSRuleList.cssRules[j];
						var pe_ns = CSSStyleRule.selectorText;
						if (pe_ns.length <= 0)
							continue;
						pe_ns = pe_ns.replace("\x2e", "");
						var Eles = iframe.document
								.getElementsByClassName(pe_ns);
						for (var k = 0; k < Eles.length; k++) {
							var Element = Eles[k];
							var borderBottom = Element.style.borderBottom;
							var borderTop = Element.style.borderTop;
							var borderLeft = Element.style.borderLeft;
							var borderRight = Element.style.borderRight;
							var cssText = CSSStyleRule.style.cssText;
							Element.style.cssText = cssText;
							if (borderBottom.length > 0) {
								Element.style.borderBottom = borderBottom;
							}
							if (borderTop.length > 0) {
								Element.style.borderTop = borderTop;
							}
							if (borderLeft.length > 0) {
								Element.style.borderLeft = borderLeft;
							}
							if (borderRight.length > 0) {
								Element.style.borderRight = borderRight;
							}
							cssText = Element.style.cssText;
							cssText = cssText.replace(/(0.5pt)/g,
									'\x31\x70\x78');
							Element.style.cssText = cssText;
						}
					}
				}
				var x = this._oThis.util.pe_bP(iframe.document.body,
						"\x66\x6f\x6e\x74");
				if (x.length > 0) {
					this._oThis.util.pe_adx(x[0], iframe.document);
				}
				if (e.preventDefault) {
					e.stopPropagation();
					e.preventDefault();
				}
				var tds = this._oThis.util.pe_bP(iframe.document.body,
						"\x74\x64");
				if (tds.length > 0) {
					for (var i = 0; i < tds.length; i++) {
						tds[i].removeAttribute("\x63\x6c\x61\x73\x73");
					}
				}// -->
				var pe_ec = iframe.document.body.childNodes;
				var pe_NX = [];
				var pe_ht = function(w) {
					var pe_ce;
					var pe_gw = String(w).replace(/[0-9\.]/gi, "");
					if (pe_gw == "\x6d\x6d") {
						pe_ce = pe_l(w);
					} else if (pe_gw == "\x70\x74") {
						pe_ce = pe_k(w);
					} else if (pe_gw == "") {
						pe_ce = parseInt(w);
					} else {
						return w;
					}
					if (String(pe_ce) == "\x4e\x61\x4e"
							&& typeof (w) == "\x73\x74\x72\x69\x6e\x67") {
						switch (w.toLowerCase().Trim()) {
						case '\x6d\x65\x64\x69\x75\x6d':
						case '\x74\x68\x69\x6e':
						case '\x74\x68\x69\x63\x6b':
						case '\x69\x6e\x69\x74\x69\x61\x6c':
							return "";
						}
					}
					return pe_ce + "\x70\x78";
				};
				var pe_arR = function(pe_ec) {
					for (var i = 0; pe_ec.length > i; i++) {
						if (pe_ec[i].nodeType == 8) {
							pe_NX.push(pe_ec[i]);
						}
						if (pe_ec[i].nodeType == 1) {
							if (pe_ec[i].nodeName == "\x54\x44"
									&& pe_ec[i].style
									&& pe_ec[i].style.borderWidth) {
								pe_ec[i].style.borderWidth = pe_ht(pe_ec[i].style.borderWidth);
							}
							if (pe_ec[i].nodeName == "\x54\x44"
									&& pe_ec[i].style
									&& pe_ec[i].style.borderLeftWidth) {
								pe_ec[i].style.borderLeftWidth = pe_ht(pe_ec[i].style.borderLeftWidth);
							}
							if (pe_ec[i].nodeName == "\x54\x44"
									&& pe_ec[i].style
									&& pe_ec[i].style.borderRightWidth) {
								pe_ec[i].style.borderRightWidth = pe_ht(pe_ec[i].style.borderRightWidth);
							}
							if (pe_ec[i].nodeName == "\x54\x44"
									&& pe_ec[i].style
									&& pe_ec[i].style.borderTopWidth) {
								pe_ec[i].style.borderTopWidth = pe_ht(pe_ec[i].style.borderTopWidth);
							}
							if (pe_ec[i].nodeName == "\x54\x44"
									&& pe_ec[i].style
									&& pe_ec[i].style.borderBottomWidth) {
								pe_ec[i].style.borderBottomWidth = pe_ht(pe_ec[i].style.borderBottomWidth);
							}
							pe_arR(pe_ec[i].childNodes);
						}
					}
				};
				pe_arR(pe_ec);
				for (var i = 0; pe_NX.length > i; i++) {
					if (pe_NX[i].parentNode) {
						pe_NX[i].parentNode.removeChild(pe_NX[i]);
					}
				}
				if (iframe.document.body.lastChild.nodeType == 3) {
					iframe.document.body.lastChild.parentNode
							.removeChild(iframe.document.body.lastChild);
				}
				var pe_yJ = iframe.document.body
						.getElementsByTagName("\x74\x61\x62\x6c\x65");
				for (var i = 0; pe_yJ.length > i; i++) {
					var colgroup = pe_yJ[i]
							.getElementsByTagName("\x63\x6f\x6c\x67\x72\x6f\x75\x70");
					if (colgroup.length > 0) {
						colgroup[0].parentNode.removeChild(colgroup[0]);
					}
				}
				var html = iframe.document.body.innerHTML
						+ "\x3c\x62\x72\x20\x2f\x3e";
				idoc.execCommand("\x49\x6e\x73\x65\x72\x74\x48\x54\x4d\x4c",
						false, html);
				this._oThis.pe_Gt(idoc);
				if (this._oThis.getDocument() == idoc) {
					var pe_bR = this._oThis.getSelection();
					var pe_eA = pe_bR;
					pe_eA.sel = pe_eA.getSelection();
					pe_eA.range = pe_eA.pe_bY();
					if (pe_eA.range.endContainer) {
						NamoSE.Util.scrollIntoView(pe_eA.range.endContainer,
								pe_eA);
					}
				}
				pe_jf = true;
			} else {
				if (e.clipboardData.items != null
						&& e.clipboardData.items.length > 0) {
					var pe_ade = e.clipboardData.items;
					var pe_aee = new Array();
					for (var i = 0; pe_ade.length > i; i++) {
						if (pe_ade[i].kind == "\x66\x69\x6c\x65") {
							pe_aee.push(pe_ade[i]);
							break;
						}
					}
					if (pe_aee.length > 0) {
						this._oThis
								.pe_dT(
										'\x69\x6d\x61\x67\x65\x44\x72\x61\x67\x41\x6e\x64\x44\x72\x6f\x70',
										pe_aee, e);
						if (e.preventDefault) {
							e.stopPropagation();
							e.preventDefault();
						}
						pe_jf = true;
					}
				}
			}
		} catch (error) {
			alert("\x65\x72\x72\x6f\x72\x20\x3a\x20\x70\x65\x5f\x61\x6e\x61\x2e\n"
					+ error);
		}
		return pe_jf;
	},
	pe_anf : function(iframe, e, idoc) {
		var pe_jf = false;
		if (!agentInfo.IsSafari) {
			return pe_jf;
		}
		try {
			var pe_tZ = e.clipboardData
					.getData('\x74\x65\x78\x74\x2f\x68\x74\x6d\x6c');
			if (/<[^>]*?class="?xl\d+"?[^>]*>/.test(pe_tZ)) {
				this._oThis.pe_Bk(idoc);
				this._oThis.pe_LA(idoc, "\x70\x61\x73\x74\x65");
				if (this._oThis.pe_zG(idoc, "\x64\x6f\x6d"))
					this._oThis.pe_zR(idoc, "\x64\x6f\x6d");
				this._oThis.pe_sH(idoc, "\x64\x6f\x6d");
				this._oThis.pe_sr(idoc, "\x64\x6f\x6d");
				this._oThis.pe_nO(idoc);
				var pe_akH = "";
				pe_akH = "\x3c\x74\x61\x62\x6c\x65\x20\x20\x62\x6f\x72\x64\x65\x72\x3d\x27\x30\x27\x20\x63\x65\x6c\x6c\x70\x61\x64\x64\x69\x6e\x67\x3d\x27\x30\x27\x20\x63\x65\x6c\x6c\x73\x70\x61\x63\x69\x6e\x67\x3d\x27\x30\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x62\x6f\x72\x64\x65\x72\x2d\x63\x6f\x6c\x6c\x61\x70\x73\x65\x3a\x63\x6f\x6c\x6c\x61\x70\x73\x65\x3b\x27\x3e"
						+ pe_tZ + "\x3c\x2f\x74\x61\x62\x6c\x65\x3e";
				iframe.document.open();
				iframe.frameElement.style.display = '\x6e\x6f\x6e\x65';
				iframe.document.write(pe_akH);
				iframe.document.close();
				var x = this._oThis.util
						.pe_bP(iframe.document.body, "\x74\x64");
				if (x.length > 0) {
					for (var i = 0; i < x.length; i++) {
						var Element = x[i];
						Element.style.borderTop = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
						Element.style.borderBottom = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
						Element.style.borderLeft = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
						Element.style.borderRight = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
					}
				}
				if (e.preventDefault) {
					e.stopPropagation();
					e.preventDefault();
				}
				var tds = this._oThis.util.pe_bP(iframe.document.body,
						"\x74\x64");
				if (tds.length > 0) {
					for (var i = 0; i < tds.length; i++) {
						tds[i].removeAttribute("\x63\x6c\x61\x73\x73");
					}
				}
				var spans = this._oThis.util.pe_bP(iframe.document.body,
						"\x73\x70\x61\x6e");
				if (spans.length > 0) {
					for (var i = 0; i < spans.length; i++) {
						spans[i].removeAttribute("\x73\x74\x79\x6c\x65");
					}
				}
				var pe_yJ = iframe.document.body
						.getElementsByTagName("\x74\x61\x62\x6c\x65");
				for (var i = 0; pe_yJ.length > i; i++) {
					var colgroup = pe_yJ[i]
							.getElementsByTagName("\x63\x6f\x6c\x67\x72\x6f\x75\x70");
					if (colgroup.length > 0) {
						colgroup[0].parentNode.removeChild(colgroup[0]);
					}
				}
				var html = iframe.document.body.firstElementChild.outerHTML
						+ "\x3c\x62\x72\x20\x2f\x3e";
				idoc.execCommand("\x49\x6e\x73\x65\x72\x74\x48\x54\x4d\x4c",
						false, html);
				this._oThis.pe_Gt(idoc);
				if (this._oThis.getDocument() == idoc) {
					var pe_bR = this._oThis.getSelection();
					var pe_eA = pe_bR;
					pe_eA.sel = pe_eA.getSelection();
					pe_eA.range = pe_eA.pe_bY();
					if (pe_eA.range.endContainer) {
						NamoSE.Util.scrollIntoView(pe_eA.range.endContainer,
								pe_eA);
					}
				}
				pe_jf = true;
			} else if (/[0-9\.]mm/.test(pe_tZ) || /StartFragment/.test(pe_tZ)) {
				this._oThis.pe_Bk(idoc);
				this._oThis.pe_LA(idoc, "\x70\x61\x73\x74\x65");
				if (this._oThis.pe_zG(idoc, "\x64\x6f\x6d"))
					this._oThis.pe_zR(idoc, "\x64\x6f\x6d");
				this._oThis.pe_sH(idoc, "\x64\x6f\x6d");
				this._oThis.pe_sr(idoc, "\x64\x6f\x6d");
				this._oThis.pe_nO(idoc);
				iframe.document.open();
				iframe.frameElement.style.display = '\x6e\x6f\x6e\x65';
				iframe.document.write(pe_tZ);
				iframe.document.close();
				var tds = this._oThis.util.pe_bP(iframe.document.body,
						"\x74\x64");
				var pe_ht = function(w) {
					var pe_ce;
					var pe_gw = String(w).replace(/[0-9\.]/gi, "");
					if (pe_gw == "\x6d\x6d") {
						pe_ce = pe_l(w);
					} else if (pe_gw == "\x70\x74") {
						pe_ce = pe_k(w);
					} else if (pe_gw == "") {
						pe_ce = parseInt(w);
					} else {
						return w;
					}
					if (String(pe_ce) == "\x4e\x61\x4e"
							&& typeof (w) == "\x73\x74\x72\x69\x6e\x67") {
						switch (w.toLowerCase().Trim()) {
						case '\x6d\x65\x64\x69\x75\x6d':
						case '\x74\x68\x69\x6e':
						case '\x74\x68\x69\x63\x6b':
						case '\x69\x6e\x69\x74\x69\x61\x6c':
							return "";
						}
					}
					return pe_ce + "\x70\x78";
				};
				if (tds.length > 0) {
					for (var i = 0; i < tds.length; i++) {
						if (tds[i].style && tds[i].style.borderWidth) {
							tds[i].style.borderWidth = pe_ht(tds[i].style.borderWidth);
						}
						if (tds[i].style && tds[i].style.borderLeftWidth) {
							tds[i].style.borderLeftWidth = pe_ht(tds[i].style.borderLeftWidth);
						}
						if (tds[i].style && tds[i].style.borderRightWidth) {
							tds[i].style.borderRightWidth = pe_ht(tds[i].style.borderRightWidth);
						}
						if (tds[i].style && tds[i].style.borderTopWidth) {
							tds[i].style.borderTopWidth = pe_ht(tds[i].style.borderTopWidth);
						}
						if (tds[i].style && tds[i].style.borderBottomWidth) {
							tds[i].style.borderBottomWidth = pe_ht(tds[i].style.borderBottomWidth);
						}
					}
				}
				while (iframe.document.body.firstChild
						&& iframe.document.body.firstChild.nodeName != "\x50") {
					iframe.document.body.firstChild.parentNode
							.removeChild(iframe.document.body.firstChild);
				}
				var pe_yJ = iframe.document.body
						.getElementsByTagName("\x74\x61\x62\x6c\x65");
				for (var i = 0; pe_yJ.length > i; i++) {
					var colgroup = pe_yJ[i]
							.getElementsByTagName("\x63\x6f\x6c\x67\x72\x6f\x75\x70");
					if (colgroup.length > 0) {
						colgroup[0].parentNode.removeChild(colgroup[0]);
					}
				}
				var html = iframe.document.body.innerHTML
						+ "\x3c\x62\x72\x20\x2f\x3e";
				idoc.execCommand("\x49\x6e\x73\x65\x72\x74\x48\x54\x4d\x4c",
						false, html);
				this._oThis.pe_Gt(idoc);
				if (this._oThis.getDocument() == idoc) {
					var pe_bR = this._oThis.getSelection();
					var pe_eA = pe_bR;
					pe_eA.sel = pe_eA.getSelection();
					pe_eA.range = pe_eA.pe_bY();
					if (pe_eA.range.endContainer) {
						NamoSE.Util.scrollIntoView(pe_eA.range.endContainer,
								pe_eA);
					}
				}
				if (e.preventDefault) {
					e.stopPropagation();
					e.preventDefault();
				}
				pe_jf = true;
			}
		} catch (error) {
			alert("\x65\x72\x72\x6f\x72\x20\x3a\x20\x70\x65\x5f\x61\x6e\x66\x2e\n"
					+ error);
		}
		return pe_jf;
	},
	pe_aGW : function(e, idoc) {
		var pe_jf = false;
		var iframe = this._oThis.pe_oh;
		iframe = (iframe.contentWindow) ? iframe.contentWindow
				: (iframe.contentDocument.document) ? iframe.contentDocument.document
						: iframe.contentDocument;
		if (agentInfo.IsChrome) {
			pe_jf = this.pe_ana(iframe, e, idoc);
		} else if (agentInfo.IsSafari) {
			pe_jf = this.pe_anf(iframe, e, idoc);
		}
		return pe_jf;
	},
	start : function(idoc, pe_nh) {
		var t = this;
		if (typeof idoc == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64" || !idoc)
			idoc = t._oThis.getDocument();
		try {
			var pe_iU = "";
			var pe_aub = [], pe_ajF = [];
			var pe_bC = t._oThis.getSelection();
			pe_bC.sel = pe_bC.getSelection();
			pe_bC.range = pe_bC.pe_bY();
			source = idoc.body.innerHTML;
			var pe_fI = source.toLowerCase();
			if (agentInfo.IsSafari || agentInfo.IsChrome)
				pe_bC.pe_hU();
			if (agentInfo.IsIE
					&& (/<o:p/.test(pe_fI) || /<[^>]*?class="?xl\d+"?[^>]*>/
							.test(pe_fI))) {
				pe_bC.pe_hU();
			}
			try {
				pe_fI = pe_fI
						.replace(
								/version:[\s\S]*?endfragment:/,
								function(str) {
									if (/starthtml:/.test(str)
											&& /endhtml:/.test(str))
										pe_iU = /sourceurl/.test(str) ? "\x4a\x75\x6e\x67\x55\x6d"
												: "\x48\x61\x6e\x67\x6c\x65";
									return str;
								});
				if (!pe_iU) {
					pe_fI = pe_fI.replace(/<meta[^>]*>/, function(str) {
						if (/JungUm/.test(str))
							pe_iU = "\x4a\x75\x6e\x67\x55\x6d";
						else if (/Microsoft Word/.test(str))
							pe_iU = "\x4d\x53\x57\x6f\x72\x64";
						return str;
					});
				}
				if (pe_iU)
					pe_iU = pe_iU;
				else if (/<[^>]*?class="?xl\d+"?[^>]*>/.test(pe_fI))
					pe_iU = "\x4d\x53\x45\x78\x63\x65\x6c";
				else if (/html public[\s\S]*?-\/\/w3c\/\/[\s\S]*?&gt;/
						.test(pe_fI))
					pe_iU = "\x48\x61\x6e\x67\x6c\x65";
				else if (/<[^>]*?src="file:\/\/[^"]*?(\\|\/)hnc\1/.test(pe_fI))
					pe_iU = "\x48\x61\x6e\x67\x6c\x65";
				else if (/<[^>]*?src="file:\/\/[^"]*?(\\|\/)msohtml\1/
						.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (/<!--\[if[^\]*]-->/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (/<[^>]*?class="mso[^>]*>/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (/<\w+:\w+\b[^>]*>/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (/<o:p/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (/<[^>]*?style="[^>"]*mso-/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (agentInfo.IsIE11 && /mso-/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
				else if (/<[^>]*?src="data:image/.test(pe_fI))
					pe_iU = "\x4d\x53\x57\x6f\x72\x64";
			} catch (e2) {
				pe_iU = "\x65\x72\x72\x6f\x72";
			}
			var x = this._oThis.util.pe_bP(idoc.body, "\x66\x6f\x6e\x74");
			if (x.length > 0) {
				t._oThis.util.pe_adx(x[0], idoc);
			}
			switch (pe_iU) {
			case "\x4d\x53\x57\x6f\x72\x64":
				t.pe_awH(idoc, pe_nh);
				break;
			case "\x4d\x53\x45\x78\x63\x65\x6c":
				t.pe_awI(idoc, pe_aub, pe_ajF, pe_nh);
				break;
			case "\x48\x61\x6e\x67\x6c\x65":
			case "\x4a\x75\x6e\x67\x55\x6d":
				t.pe_awF(idoc, pe_nh);
				break;
			}
			var pe_eH = idoc.body.getElementsByTagName("\x69\x6d\x67");
			for (var i = 0; pe_eH.length > i; i++) {
				if (pe_eH[i].src.toLowerCase().indexOf(
						"\x77\x6f\x72\x64\x5f\x69\x6d\x61\x67\x65") > -1) {
					if (!pe_eH[i].alt) {
						pe_eH[i].alt = "\x77\x6f\x72\x64\x5f\x69\x6d\x61\x67\x65";
					}
					if (!pe_eH[i].title) {
						pe_eH[i].title = "\x77\x6f\x72\x64\x5f\x69\x6d\x61\x67\x65";
					}
				}
				if (pe_eH[i].src.toLowerCase().indexOf(
						"\x6e\x6f\x69\x6d\x61\x67\x65") > -1) {
					if (!pe_eH[i].alt) {
						pe_eH[i].alt = "\x6e\x6f\x69\x6d\x61\x67\x65";
					}
					if (!pe_eH[i].title) {
						pe_eH[i].title = "\x6e\x6f\x69\x6d\x61\x67\x65";
					}
				}
				if (pe_eH[i].src.toLowerCase().indexOf(
						"\x6e\x6f\x5f\x69\x6d\x61\x67\x65") > -1) {
					if (!pe_eH[i].alt) {
						pe_eH[i].alt = "\x6e\x6f\x69\x6d\x61\x67\x65";
					}
					if (!pe_eH[i].title) {
						pe_eH[i].title = "\x6e\x6f\x69\x6d\x61\x67\x65";
					}
				}
			}
			var tds = this._oThis.util.pe_bP(idoc.body, "\x74\x64");
			if (tds.length > 0) {
				for (var i = 0; i < tds.length; i++) {
					tds[i].removeAttribute("\x63\x6c\x61\x73\x73");
					tds[i]
							.removeAttribute("\x63\x6c\x61\x73\x73\x4e\x61\x6d\x65");
				}
			}
			this._oThis.pe_Gt(idoc);
			var pe_cX = pe_bC.pe_iX();
			if (pe_cX[0]) {
				var pe_zL = pe_bC.pe_hW(pe_cX[0], pe_cX[1]);
				if (!agentInfo.IsIE && pe_zL) {
					pe_bC.sel = pe_bC.getSelection();
					if (pe_bC.sel.rangeCount == 0) {
						pe_bC.range = idoc.createRange();
					} else {
						pe_bC.range = pe_bC.pe_bY();
					}
					if (pe_bC.range.endContainer)
						NamoSE.Util.scrollIntoView(pe_bC.range.endContainer,
								pe_bC);
				}
			}
		} catch (e) {
			alert("\x65\x72\x72\x6f\x72\x20\x3a\x20\x73\x74\x61\x72\x74\x2e\n"
					+ e);
		}
	},
	pe_awH : function(idoc, pe_nh, pe_nh) {
		var t = this;
		if (typeof idoc == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64" || !idoc)
			idoc = t._oThis.getDocument();
		var pe_eH = idoc.getElementsByTagName("\x69\x6d\x67");
		for (var i = 0; pe_eH.length > i; i++) {
			if (pe_eH[i].style && !pe_eH[i].style.width) {
				pe_eH[i].style.width = pe_eH[i].clientWidth + "\x70\x78";
			}
			if (pe_eH[i].style && !pe_eH[i].style.height) {
				pe_eH[i].style.height = pe_eH[i].clientHeight + "\x70\x78";
			}
		}
		t.pe_adT(idoc, pe_nh);
	},
	pe_awI : function(idoc, pe_aub, pe_ajF, pe_nh) {
		var t = this;
		if (typeof idoc == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64" || !idoc)
			idoc = t._oThis.getDocument();
		if (agentInfo.IsIE) {
			var trEle = this._oThis.util.pe_bP(idoc.body, "\x74\x72");
			for (var i = 0; i < trEle.length; i++) {
				var pe_BI = trEle[i].firstChild;
				if (pe_BI && pe_BI.nodeType) {
					if (!(pe_BI.nodeType == 1 && pe_BI.nodeName.toLowerCase() == "\x74\x64")) {
						if (pe_BI.removeNode) {
							pe_BI.removeNode(true);
						} else {
							pe_BI.parentNode.removeChild(ele);
						}
					}
				}
			}
		}
		if (agentInfo.IsGecko) {
			var colGroup = this._oThis.util.pe_bP(idoc.body,
					"\x63\x6f\x6c\x67\x72\x6f\x75\x70");
			if (colGroup.length > 0) {
				for (var i = 0; i < colGroup.length; i++) {
					if (colGroup[i].parentElement) {
						if (colGroup[i].parentElement.tagName.toLowerCase() == "\x74\x61\x62\x6c\x65") {
							var pe_aky = colGroup[i].parentElement;
							if (pe_aky.style.borderCollapse.length <= 0) {
								pe_aky.style.borderCollapse = "\x63\x6f\x6c\x6c\x61\x70\x73\x65";
							}
						}
					}
					if (colGroup[i].removeNode) {
						colGroup[i].removeNode(true);
					} else {
						colGroup[i].parentNode.removeChild(colGroup[i]);
					}
				}
			}
			var x = this._oThis.util.pe_bP(idoc.body, "\x74\x64");
			if (x.length > 0) {
				for (var i = 0; i < x.length; i++) {
					var Element = x[i];
					if (Element.className.indexOf("\x78\x6c") == 0) {
						Element.style.borderTop = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
						Element.style.borderBottom = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
						Element.style.borderLeft = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
						Element.style.borderRight = "\x31\x70\x78\x20\x73\x6f\x6c\x69\x64\x20\x72\x67\x62\x28\x30\x2c\x30\x2c\x30\x29";
					}
				}
			}
		}
		t.pe_adT(idoc, pe_nh);
	},
	pe_awF : function(idoc, pe_nh) {
		var t = this;
		if (typeof idoc == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64" || !idoc)
			idoc = t._oThis.getDocument();
		t.pe_adT(idoc, pe_nh);
	},
	pe_adT : function(idoc, pe_nh) {
		var t = this;
		if (typeof idoc == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64" || !idoc)
			idoc = t._oThis.getDocument();
		var result = "";
		var pe_adk = agentInfo.IsIE ? "\x3c\x70\x3e\x26\x6e\x62\x73\x70\x3b\x3c\x2f\x70\x3e"
				: "\x3c\x70\x3e\x3c\x62\x72\x20\x2f\x3e\x3c\x2f\x70\x3e";
		var pe_WK = "";
		if (t._oThis.params.NoImage) {
			pe_WK = t._oThis.baseURL + t._oThis.config.pe_cN
					+ "\x4e\x6f\x5f\x49\x6d\x61\x67\x65\x2e\x67\x69\x66";
		} else {
			pe_WK = t._oThis.baseURL
					+ t._oThis.config.pe_cN
					+ "\x77\x6f\x72\x64\x5f\x69\x6d\x61\x67\x65\x2e\x67\x69\x66";
		}
		var source = idoc.body.innerHTML;
		source = source.replace(/(0.5pt)/g, '\x31\x70\x78');
		try {
			source = source
					.replace(
							/<span([^>]*?id="_SESpan[^>]*>)<\/span[^>]*>/gi,
							"\x3c\x6e\x61\x6d\x6f\x62\x6f\x6f\x6b\x6d\x61\x72\x6b\x24\x31\x3c\x2f\x6e\x61\x6d\x6f\x62\x6f\x6f\x6b\x6d\x61\x72\x6b\x3e");
		} catch (e) {
		}
		try {
			if (agentInfo.IsGecko)
				source = source
						.replace(
								/<p\b[^>]*>(\s*<!--\[if (gte mso|!)[\s\S]*\[endif\]-->\s*)+<\/p\b[^>]*>/gi,
								"");
			else if (agentInfo.IsChrome || agentInfo.IsSafari
					|| agentInfo.IsIE10) {
				source = source.replace(
						/<!--\[if ![^>]*>([\s\S]*?)<!--\[endif\]-->/gi,
						"\x24\x31");
				source = source.replace(
						/<!--\[if ![^>]*>([\s\S]*?)<!--\[endif\]-->/gi,
						"\x24\x31");
				source = source.replace(
						/<![if ![^>]*>([\s\S]*?)<!\[endif\]>/gi, "\x24\x31");// -->
			}
			source = source.replace(/<!--\[if[\s\S]*?\[endif\]-->/gi, "");
			source = source.replace(/<![if[\s\S]*?<!\[endif\]>/gi, "");
		} catch (e) {
		}
		try {
			source = source.replace(
					/<p\b[^>]*>(\s|&nbsp;)*(?=<(?:table|p\b|div))/gi, "");
			source = source
					.replace(
							/(\/(?:table|p\b|div)\s*>\s*(<namobookmark[\s\S]*?namobookmark>)?)\s*<\/p\b[^>]*>/gi,
							"\x24\x31");
		} catch (e) {
		}
		try {
			source = source
					.replace(
							/<p\b[^>]*>(<font[^>]*>\s*<\/font[^>]*>)<\/p\b[^>]*>/gi,
							"");
		} catch (e) {
		}
		try {
			source = source.replace(/<xml[^>]*>[\s\S]*?<\/xml[^>]*>/gi, "");
			source = source.replace(/<\?xml[^>\/]*\/>/gi, "");
		} catch (e) {
		}
		try {
			source = source.replace(/<title[^>]*>[\s\S]*?<\/title[^>]*>/, "");
		} catch (e) {
		}
		try {
			if (!agentInfo.IsIE)
				source = source
						.replace(
								/<span[^>]*>\s*(<table[^>]*>[\s\S]*?<\/table[^>]*>)\s*<\/span[^>]*>/gi,
								function(str, table) {
									if (table.indexOf("\x3c\x69\x6d\x67") != -1) {
										var image = str.match(/<img\b[^>]*>/i);
										if (image
												&& /(\\|\/)msohtml/i
														.test(image))
											return image;
										return table;
									} else
										return table;
								});
			else
				source = source
						.replace(
								/<v:shape\b[^>]*>[\s\S]*?<\/v:shape\b[^>]*>/gi,
								function(str) {
									var pe_pV = "\x3c\x69\x6d\x67\x20";
									var pe_ZF = "";
									var imageAlt = "";
									var pe_vu = "";
									var pe_pA = idoc
											.createElement("\x64\x69\x76");
									pe_pA.innerHTML = str;
									var shape = pe_pA.firstChild;
									var pe_GT = NamoSE.Util
											.pe_hB(
													shape,
													(agentInfo.IsIE && pe_cm < 9) ? "\x70\x65\x5f\x47\x54"
															: "\x76\x3a\x70\x65\x5f\x47\x54");
									pe_ZF = pe_GT ? pe_GT
											.getAttribute("\x73\x72\x63") : "";
									pe_pV += "\x73\x72\x63\x3d\""
											+ (pe_ZF ? pe_ZF
													: "\x66\x69\x6c\x65\x3a\x2f\x2f\x2f\x6e\x6f\x69\x6d\x61\x67\x65\x2e\x67\x69\x66")
											+ "\"\x20";
									imageAlt = shape
											.getAttribute("\x61\x6c\x74")
											|| (pe_GT ? pe_GT
													.getAttribute("\x6f\x3a\x74\x69\x74\x6c\x65")
													: "")
											|| shape.getAttribute("\x69\x64");
									if (imageAlt)
										pe_pV += "\x61\x6c\x74\x3d\""
												+ imageAlt + "\"\x20";
									if (shape.style.width)
										pe_vu += "\x77\x69\x64\x74\x68\x3a\x20"
												+ t.pe_ht(shape.style.width)
												+ "\x3b";
									if (shape.style.height)
										pe_vu += "\x20\x68\x65\x69\x67\x68\x74\x3a\x20"
												+ t.pe_ht(shape.style.height)
												+ "\x3b";
									if (pe_vu)
										pe_pV += "\x73\x74\x79\x6c\x65\x3d\""
												+ pe_vu + "\"\x20";
									pe_pV += "\x2f\x3e";
									delete pe_pA;
									return pe_pV;
								});
		} catch (e) {
		}
		try {
			t
					.pe_anX(
							source,
							{
								start : function(tag, pe_gF, pe_fp, style) {
									if (tag == "\x66\x6f\x6e\x74"
											|| tag == "\x6d\x65\x74\x61"
											|| tag.indexOf("\x3f") == 0)
										return true;
									var temp = "\x3c" + tag;
									var pe_is, pe_dw;
									if (style) {
										pe_is = style.name;
										pe_dw = style.pe_aqs;
										pe_dw = pe_dw.replace(
												/\\?"|'|&quot;/gi, "");
										pe_dw = pe_dw.replace(/\s+$/, "");
										if (pe_dw.substring(pe_dw.length - 1) != "\x3b")
											pe_dw += "\x3b";
										var pe_adV = [
												"\x6d\x61\x72\x67\x69\x6e",
												"\x70\x61\x64\x64\x69\x6e\x67",
												"\x62\x6f\x72\x64\x65\x72",
												"\x77\x69\x64\x74\x68",
												"\x68\x65\x69\x67\x68\x74" ];
										for (var i = 0; i < pe_adV.length; i++) {
											pe_dw = pe_dw
													.replace(
															new RegExp(
																	"\x28\x5b\x2d\\\x77\x5d\x2a"
																			+ pe_adV[i]
																			+ "\x5b\x2d\\\x77\x5d\x2a\x29\\\x73\x2a\x3a\\\x73\x2a\x28\x5b\x5e\x3b\x5d\x2b\x29\x3b",
																	"\x67\x69"),
															function(str,
																	attrName,
																	val) {
																try {
																	val = val
																			.replace(
																					/\.\d+pt/gi,
																					function(
																							str2,
																							index) {
																						return (index == 0 || !/\d/
																								.test(val
																										.substring(
																												index - 1,
																												index))) ? "\x30"
																								+ str2
																								: str2;
																					});
																	val = val
																			.replace(
																					/\b\d*\.?\d+pt\b/gi,
																					function(
																							str2) {
																						if (pe_adV[i] == "\x62\x6f\x72\x64\x65\x72")
																							str2 = t
																									.pe_aEU(str2);
																						return t
																								.pe_ht(str2);
																					});
																	val = val
																			.replace(
																					/\b0(?:pt|mm|cm|in)\b/gi,
																					"\x30\x70\x78");
																	return attrName
																			+ "\x3a\x20"
																			+ val
																			+ "\x3b";
																} catch (e) {
																	return str;
																}
															});
										}
										pe_dw = pe_dw
												.replace(
														/([-\w]*border[-\w]*)\s*:\s*([^;]+);/gi,
														function(str, attrName,
																val) {
															try {
																if (attrName
																		.indexOf("\x6d\x73\x6f\x2d") != -1)
																	return str;
																var pe_xa = val
																		.split("\x20");
																if (pe_xa) {
																	for (var i = 0; i < pe_xa.length; i++) {
																		if (pe_xa[i] == "\x77\x69\x6e\x64\x6f\x77\x74\x65\x78\x74")
																			pe_xa[i] = "\x62\x6c\x61\x63\x6b";
																		if (pe_xa[i] == "\x63\x75\x72\x72\x65\x6e\x74\x43\x6f\x6c\x6f\x72"
																				|| pe_xa[i] == "\x2d\x6d\x6f\x7a\x2d\x75\x73\x65\x2d\x74\x65\x78\x74\x2d\x63\x6f\x6c\x6f\x72")
																			pe_xa[i] = "\x62\x6c\x61\x63\x6b";
																	}
																	val = pe_xa
																			.join("\x20");
																}
																return attrName
																		+ "\x3a\x20"
																		+ val
																		+ "\x3b";
															} catch (e) {
																return str;
															}
														});
										var pe_aup = [
												"\x6d\x73\x6f\x28\x3f\x3a\x2d\\\x77\x2b\x29\x3f\x2d\x66\x6f\x6e\x74\x2d\x73\x69\x7a\x65",
												"\x6d\x73\x6f\x28\x3f\x3a\x2d\\\x77\x2b\x29\x3f\x2d\x66\x6f\x6e\x74\x2d\x66\x61\x6d\x69\x6c\x79" ];
										var pe_agO = [
												"\x66\x6f\x6e\x74\x2d\x73\x69\x7a\x65",
												"\x66\x6f\x6e\x74\x2d\x66\x61\x6d\x69\x6c\x79" ];
										for (var i = 0; i < pe_aup.length; i++) {
											var newValue = "";
											pe_dw = pe_dw
													.replace(
															new RegExp(
																	pe_aup[i]
																			+ "\\\x73\x2a\x3a\\\x73\x2a\x28\x5b\x5e\x3b\x5d\x2a\x29\x3b",
																	"\x69"),
															function(str, val) {
																if (i == 0) {
																	newValue = val;
																}
																return "";
															});
											if (!newValue)
												continue;
											pe_dw = pe_dw
													.replace(
															new RegExp(
																	"\\\x62\x28\x5b\\\x77\x2d\x5d\x2a"
																			+ pe_agO[i]
																			+ "\x29\\\x73\x2a\x3a\\\x73\x2a\x28\x5b\x5e\x3b\x5d\x2b\x29\x3b",
																	"\x69"),
															function(str,
																	attrName,
																	pe_aig) {
																if (attrName
																		.toLowerCase() != pe_agO[i])
																	return str;
																newValue = pe_aig;
																return "";
															});
											if (newValue)
												pe_dw += "\x20" + pe_agO[i]
														+ "\x3a\x20" + newValue
														+ "\x3b";
										}
									} else {
										pe_is = "\x73\x74\x79\x6c\x65";
										pe_dw = "";
									}
									var count = 0;
									for (var i = 0; i < pe_gF.length; i++) {
										var name = pe_gF[i].name;
										var value = pe_gF[i].pe_aqs;
										if ([ "\x6c\x61\x6e\x67",
												"\x63\x6c\x65\x61\x72",
												"\x73\x68\x61\x70\x65\x73",
												"\x73\x68\x61\x70\x65",
												"\x64\x70\x69",
												"\x76\x73\x70\x61\x63\x65",
												"\x68\x73\x70\x61\x63\x65",
												"\x63\x6f\x6d\x70\x61\x63\x74" ]
												.InArray(name))
											continue;
										if (name == "\x63\x6c\x61\x73\x73")
											value = value.replace(
													/\bmso\w+\b/gi, "");
										if (name == "\x68\x72\x65\x66"
												&& tag == "\x6c\x69\x6e\x6b"
												&& /file:\/\/[\s\S]*?msohtml/
														.test(value))
											return true;
										if (name == "\x73\x72\x63"
												&& tag == "\x69\x6d\x67"
												&& (value
														.indexOf("\x66\x69\x6c\x65\x3a\x2f\x2f") == 0 || value
														.indexOf("\x64\x61\x74\x61\x3a") == 0)) {
											pe_dw += "\x20\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x6f\x74\x74\x65\x64\x20\x23\x30\x30\x30\x30\x30\x30\x3b";
											if (!(/data:image/.test(value) && t._oThis.params.ShowWordImage)) {
												value = pe_WK;
											}
										}
										if ([ "\x77\x69\x64\x74\x68",
												"\x68\x65\x69\x67\x68\x74",
												"\x76\x61\x6c\x69\x67\x6e",
												"\x62\x67\x63\x6f\x6c\x6f\x72" ]
												.InArray(name)) {
											var pe_DK = "";
											var func = "";
											switch (name) {
											case "\x77\x69\x64\x74\x68":
											case "\x68\x65\x69\x67\x68\x74":
												pe_DK = name;
												func = t.pe_ht;
												break;
											case "\x61\x6c\x69\x67\x6e":
												pe_DK = "\x74\x65\x78\x74\x2d\x61\x6c\x69\x67\x6e";
												break;
											case "\x76\x61\x6c\x69\x67\x6e":
												pe_DK = "\x76\x65\x72\x74\x69\x63\x61\x6c\x2d\x61\x6c\x69\x67\x6e";
												break;
											case "\x62\x67\x63\x6f\x6c\x6f\x72":
												pe_DK = "\x62\x61\x63\x6b\x67\x72\x6f\x75\x6e\x64\x2d\x63\x6f\x6c\x6f\x72";
												break;
											}
											var newValue = "";
											if (style) {
												pe_dw = pe_dw
														.replace(
																new RegExp(
																		"\\\x62\x28\x5b\\\x77\x2d\x5d\x2a"
																				+ pe_DK
																				+ "\x29\\\x73\x2a\x3a\\\x73\x2a\x28\x5b\x5e\x3b\x5d\x2b\x29\x3b",
																		"\x69"),
																function(
																		str,
																		attrName,
																		pe_aig) {
																	if (attrName
																			.toLowerCase() != pe_DK)
																		return str;
																	newValue = pe_aig;
																	return "";
																});
											}
											if (!newValue)
												newValue = value;
											if (func)
												newValue = func(newValue);
											pe_dw += "\x20" + pe_DK
													+ "\x3a\x20" + newValue
													+ "\x3b";
											continue;
										}
										if (value.Trim() != "")
											temp += "\x20" + name + '\x3d\x22'
													+ value + '\x22';
									}
									if (pe_dw) {
										pe_dw = pe_dw
												.replace(
														/\bmso-[^:;]*?:[^;]*?(?:;|$)/gi,
														"");
										pe_dw = pe_dw.replace(/(^\s+|\s+$)/g,
												"");
										pe_dw = pe_dw.replace(/\s+/g, "\x20");
										if (pe_dw.lastIndexOf("\x3b") == pe_dw.length - 1)
											pe_dw = pe_dw.substring(0,
													pe_dw.length - 1);
										if (pe_dw.Trim() != "")
											temp += "\x20" + pe_is + '\x3d\x22'
													+ pe_dw + '\x22';
									}
									temp += (pe_fp ? "\x2f" : "") + "\x3e";
									if (temp.toLowerCase() == "\x3c\x73\x70\x61\x6e\x3e")
										return true;
									result += temp;
									return false;
								},
								end : function(tag) {
									result += "\x3c\x2f" + tag + "\x3e";
								},
								pe_pN : function(text) {
									result += text;
								},
								comment : function(text) {
									result += "\x3c\x21\x2d\x2d" + text
											+ "\x2d\x2d\x3e";
								}
							}, pe_nh);
		} catch (e) {
			return true;
		}
		try {
			if (agentInfo.IsIE)
				result = result
						.replace(
								/<v:group[\s\S]*?<\/v:group>/gi,
								function(str) {
									var pe_pV = "\x3c\x69\x6d\x67\x20";
									var pe_ZF = "";
									var imageAlt = "";
									var pe_vu = "\x62\x6f\x72\x64\x65\x72\x3a\x20\x31\x70\x78\x20\x64\x6f\x74\x74\x65\x64\x20\x23\x30\x30\x30\x30\x30\x30\x3b";
									var pe_pA = idoc
											.createElement("\x64\x69\x76");
									pe_pA.innerHTML = str;
									var group = pe_pA.firstChild;
									pe_pV += "\x73\x72\x63\x3d\"" + pe_WK
											+ "\"\x20";
									imageAlt = group
											.getAttribute("\x61\x6c\x74")
											|| group.getAttribute("\x69\x64");
									if (imageAlt)
										pe_pV += "\x61\x6c\x74\x3d\""
												+ imageAlt + "\"\x20";
									if (group.style.width)
										pe_vu += "\x20\x77\x69\x64\x74\x68\x3a\x20"
												+ t.pe_ht(group.style.width)
												+ "\x3b";
									if (group.style.height)
										pe_vu += "\x20\x68\x65\x69\x67\x68\x74\x3a\x20"
												+ t.pe_ht(group.style.height)
												+ "\x3b";
									if (pe_vu)
										pe_pV += "\x73\x74\x79\x6c\x65\x3d\""
												+ pe_vu + "\"\x20";
									pe_pV += "\x2f\x3e";
									delete pe_pA;
									return pe_pV;
								});
		} catch (e) {
		}
		try {
			for (var i = 0; i < 2; i++) {
				result = result.replace(/<(\w+)[^>]*><\/\1[^>]*>/gi, function(
						str, tag) {
					return ([ "\x70", "\x74\x64", "\x74\x68", "\x74\x72",
							"\x6e\x61\x6d\x6f\x62\x6f\x6f\x6b\x6d\x61\x72\x6b",
							"\x73\x70\x61\x6e" ].InArray(tag)) ? str : "";
				});
			}
		} catch (e) {
		}
		try {
			if (!agentInfo.IsIE)
				result = result.replace(/<p\s*>&nbsp;<\/p\s*>/gi, pe_adk);
		} catch (e) {
		}
		try {
			result = result.replace(/<p\b[^>]*><\/p\b[^>]*>/gi, pe_adk);
		} catch (e) {
		}
		try {
			if (!/<namobookmark[^>]*>/i.test)
				result += "\x3c\x70\x3e\x3c\x6e\x61\x6d\x6f\x62\x6f\x6f\x6b\x6d\x61\x72\x6b\x20\x69\x64\x3d\"\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74\"\x3e\x3c\x2f\x6e\x61\x6d\x6f\x62\x6f\x6f\x6b\x6d\x61\x72\x6b\x3e\x26\x6e\x62\x73\x70\x3b\x3c\x2f\x70\x3e";
			result = result.replace(/(<\/?)namobookmark?/gi,
					"\x24\x31\x73\x70\x61\x6e");
		} catch (e) {
		}
		try {
			result = result.replace(/\/(?:table|div)[^>]*>$/i, "\x24\x26"
					+ pe_adk);
		} catch (e) {
		}
		var pe_ms = "";
		if (agentInfo.IsIE) {
			var pe_fu = "\x4e\x61\x6d\x6f\x53\x45\x5f\x5f\x42\x6c\x61\x6e\x6b\x53\x70\x61\x63\x65";
			pe_ms = "\x3c\x73\x70\x61\x6e\x20\x69\x64\x3d\x27"
					+ pe_fu
					+ "\x27\x20\x73\x74\x79\x6c\x65\x3d\x27\x63\x6f\x6c\x6f\x72\x3a\x23\x46\x46\x46\x46\x46\x46\x27\x3e\x62\x6c\x61\x6e\x6b\x3c\x2f\x73\x70\x61\x6e\x3e";
		}
		idoc.body.innerHTML = pe_ms + result;
		if (agentInfo.IsIE) {
			if (idoc.getElementById(pe_fu))
				idoc.body.removeChild(idoc.getElementById(pe_fu));
		}
	},
	pe_aJQ : function(ele) {
		var t = this;
		if (typeof ele == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64" || !ele)
			return;
		var pe_ank = [ "", "\x54\x6f\x70", "\x52\x69\x67\x68\x74",
				"\x42\x6f\x74\x74\x6f\x6d", "\x4c\x65\x66\x74" ];
		var pe_AJ = NamoSE.Util.pe_XI(ele);
		if (!pe_AJ)
			return;
		if (pe_AJ.substring(pe_AJ.length - 1) != "\x3b")
			pe_AJ += "\x3b";
		for (var i = 0; i < pe_ank.length; i++) {
			var pe_CK = pe_ank[i];
			var pe_amT = "\x6d\x73\x6f\x2d\x62\x6f\x72\x64\x65\x72\x2d"
					+ pe_CK.toLowerCase()
					+ (i == 0 ? "\x61\x6c\x74" : "\x2d\x61\x6c\x74");
			if (pe_AJ.indexOf(pe_amT) == -1)
				continue;
			var pe_aHs = new RegExp(pe_amT
					+ "\\\x73\x2a\x3a\x28\x5b\x5e\x3b\x5d\x2a\x29\x3b", "\x69");
			var pe_tc = "";
			pe_AJ = pe_AJ.replace(pe_aHs, function(a, b) {
				pe_tc = b.Trim();
				return "";
			});
			if (!pe_tc)
				continue;
			var pe_tc = pe_tc.split("\x20");
			var pe_wS = "";
			var pe_Bi = "";
			var pe_wT = "";
			switch (pe_tc.length) {
			case 3:
				pe_wS = pe_tc[0];
				pe_Bi = pe_tc[1];
				pe_wT = pe_tc[2];
				break;
			case 2:
				pe_wS = pe_tc[0];
				pe_wT = pe_tc[1];
				break;
			}
			if (!pe_wS)
				pe_wS = ele.style["\x62\x6f\x72\x64\x65\x72" + pe_CK
						+ "\x53\x74\x79\x6c\x65"];
			if (pe_wS) {
				pe_wS = t.pe_adY(pe_wS);
				ele.style["\x62\x6f\x72\x64\x65\x72" + pe_CK
						+ "\x53\x74\x79\x6c\x65"] = pe_wS;
			}
			if (!pe_Bi)
				pe_Bi = ele.style["\x62\x6f\x72\x64\x65\x72" + pe_CK
						+ "\x43\x6f\x6c\x6f\x72"];
			if (pe_Bi) {
				if (!(agentInfo.IsIE || agentInfo.IsOpera))
					pe_Bi = pe_b(pe_Bi);
				ele.style["\x62\x6f\x72\x64\x65\x72" + pe_CK
						+ "\x43\x6f\x6c\x6f\x72"] = pe_Bi;
			}
			if (!pe_wT)
				pe_wT = ele.style["\x62\x6f\x72\x64\x65\x72" + pe_CK
						+ "\x57\x69\x64\x74\x68"];
			if (pe_wT) {
				pe_wT = t.pe_ht(pe_wT);
				ele.style["\x62\x6f\x72\x64\x65\x72" + pe_CK
						+ "\x57\x69\x64\x74\x68"] = pe_wT;
			}
		}
	},
	pe_ht : function(w) {
		var pe_ce;
		var pe_gw = String(w).replace(/[0-9\.]/gi, "");
		if (pe_gw == "\x6d\x6d") {
			pe_ce = pe_l(w);
		} else if (pe_gw == "\x70\x74") {
			pe_ce = pe_k(w);
		} else if (pe_gw == "") {
			pe_ce = parseInt(w);
		} else {
			return w;
		}
		if (String(pe_ce) == "\x4e\x61\x4e"
				&& typeof (w) == "\x73\x74\x72\x69\x6e\x67") {
			switch (w.toLowerCase().Trim()) {
			case '\x6d\x65\x64\x69\x75\x6d':
			case '\x74\x68\x69\x6e':
			case '\x74\x68\x69\x63\x6b':
			case '\x69\x6e\x69\x74\x69\x61\x6c':
				return "";
			}
		}
		return pe_ce + "\x70\x78";
	},
	pe_aEU : function(tVal) {
		if (typeof tVal == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || tVal == "")
			return null;
		var pe_alF = tVal;
		var pe_gw = String(tVal).replace(/[0-9\.]/gi, "");
		var pe_alE = parseFloat(String(tVal).replace(pe_gw, ""));
		var pe_EF = -1;
		switch (pe_gw) {
		case '\x70\x78':
			pe_EF = this.pe_aij.px;
			break;
		case '\x70\x74':
			pe_EF = this.pe_aij.pt;
			break;
		case '\x6d\x6d':
			pe_EF = this.pe_aij.mm;
			break;
		}
		if (pe_EF > -1 && pe_alE != "\x4e\x61\x4e") {
			if (pe_alE < pe_EF)
				pe_alF = String(pe_EF) + pe_gw;
		}
		return pe_alF;
	},
	pe_aJY : function(pe_GH) {
		if (typeof pe_GH == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
				|| pe_GH == "")
			return false;
		var pe_da = false;
		if ((/^(http|https)/i.test(pe_GH)) && pe_GH.indexOf("\x2e") != -1) {
			var pe_agi = pe_GH.substring(pe_GH.lastIndexOf("\x2e") + 1);
			if (pe_agi && pe_agi != "") {
				if (this._oThis.config.pe_AC.InArray(pe_agi.toLowerCase())) {
					pe_da = true;
				}
			}
		}
		return pe_da;
	},
	pe_aut : function(pe_eJ, pe_VR) {
		if (typeof pe_eJ == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || !pe_eJ)
			return null;
		if (typeof pe_VR == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
				|| pe_VR == "")
			return null;
		var pe_ef = NamoSE.Util.pe_XI(pe_eJ);
		if (pe_ef && pe_ef != "" && pe_ef.substring(pe_ef.length - 1) != "\x3b")
			pe_ef += "\x3b";
		var pe_asg = function(rPos) {
			var pe_QQ = "";
			switch (rPos) {
			case '\x74\x6f\x70':
				pe_ef = pe_ef.replace(/mso-border-top-alt\s?:([\s\S]*?);/i,
						function(a, b) {
							pe_QQ = b.Trim();
							return "";
						});
				break;
			case '\x72\x69\x67\x68\x74':
				pe_ef = pe_ef.replace(/mso-border-right-alt\s?:([\s\S]*?);/i,
						function(a, b) {
							pe_QQ = b.Trim();
							return "";
						});
				break;
			case '\x62\x6f\x74\x74\x6f\x6d':
				pe_ef = pe_ef.replace(/mso-border-bottom-alt\s?:([\s\S]*?);/i,
						function(a, b) {
							pe_QQ = b.Trim();
							return "";
						});
				break;
			case '\x6c\x65\x66\x74':
				pe_ef = pe_ef.replace(/mso-border-left-alt\s?:([\s\S]*?);/i,
						function(a, b) {
							pe_QQ = b.Trim();
							return "";
						});
				break;
			}
			return pe_QQ;
		};
		var pe_atV = function(pe_agj) {
			if (pe_agj != "" && / /.test(pe_agj)) {
				var pe_hk = pe_agj.split("\x20");
				return {
					'\x70\x65\x5f\x64\x43' : pe_hk[0],
					'\x70\x65\x5f\x69\x75' : pe_hk[1],
					'\x70\x65\x5f\x69\x61' : pe_hk[2]
				};
			} else {
				return null;
			}
		};
		var pe_vd = null;
		try {
			if (pe_VR == "\x61\x6c\x6c") {
				var pe_JX = [];
				var pe_akz = [ '\x74\x6f\x70', '\x72\x69\x67\x68\x74',
						'\x62\x6f\x74\x74\x6f\x6d', '\x6c\x65\x66\x74' ];
				var pe_Sx = {};
				var pe_TE = {};
				var pe_Tx = {};
				var pe_Tr = {};
				for (var i = 0; i < pe_akz.length; i++) {
					pe_JX.push(pe_asg(pe_akz[i]));
				}
				for (var i = 0; i < pe_JX.length; i++) {
					if (!pe_JX[i] || pe_JX[i] == "") {
						pe_vd = null;
						break;
					} else {
						var pe_QK = pe_atV(pe_JX[i]);
						if (pe_QK == null) {
							pe_vd = null;
							break;
						} else {
							switch (i) {
							case 0:
								pe_Sx = pe_QK;
								break;
							case 1:
								pe_TE = pe_QK;
								break;
							case 2:
								pe_Tx = pe_QK;
								break;
							case 3:
								pe_Tr = pe_QK;
								break;
							}
						}
					}
				}
				var pe_wP = pe_Sx.pe_dC;
				var pe_sy = pe_Sx.pe_iu;
				var pe_Ld = pe_Sx.pe_ia;
				if (!(pe_wP == pe_TE.pe_dC && pe_wP == pe_Tx.pe_dC && pe_wP == pe_Tr.pe_dC))
					pe_wP = "";
				if (!(pe_sy == pe_TE.pe_iu && pe_sy == pe_Tx.pe_iu && pe_sy == pe_Tr.pe_iu))
					pe_sy = "";
				if (!(pe_Ld == pe_TE.pe_ia && pe_Ld == pe_Tx.pe_ia && pe_Ld == pe_Tr.pe_ia))
					pe_Ld = "";
				pe_vd = {
					'\x70\x65\x5f\x64\x43' : pe_wP,
					'\x70\x65\x5f\x69\x75' : pe_sy,
					'\x70\x65\x5f\x69\x61' : pe_Ld,
					'\x70\x65\x5f\x61\x6e\x69' : pe_ef
				};
			} else {
				var pe_ahp = pe_asg(pe_VR);
				if (!pe_ahp || pe_ahp == "") {
					pe_vd = null;
				} else {
					pe_vd = pe_atV(pe_ahp);
				}
			}
		} catch (exp) {
		}
		return pe_vd;
	},
	pe_asj : function(pe_eJ, rFlag) {
		if (typeof pe_eJ == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || !pe_eJ)
			return null;
		var pe_vd = null;
		var pe_zT = pe_eJ.rows.item(0).cells[0];
		try {
			if (pe_zT) {
				var pe_Ff = true;
				var pe_CU = pe_zT.style.borderWidth;
				var pe_Nq = pe_zT.style.borderColor;
				var pe_CZ = pe_zT.style.borderStyle;
				if (/ /.test(pe_CU)) {
					var pe_yo = pe_CU.split("\x20");
					if (pe_yo.length == 4 && pe_yo[0] == pe_yo[1]
							&& pe_yo[0] == pe_yo[2] && pe_yo[0] == pe_yo[3]) {
						pe_CU = pe_yo[0];
					} else {
						pe_Ff = false;
					}
				}
				if (pe_Ff && / /.test(pe_Nq)) {
					var pe_XU = pe_zT.style.borderTopColor;
					var pe_awq = pe_zT.style.borderRightColor;
					var pe_ave = pe_zT.style.borderBottomColor;
					var pe_awr = pe_zT.style.borderLeftColor;
					if (pe_XU == pe_awq && pe_XU == pe_ave && pe_XU == pe_awr) {
						pe_Nq = pe_XU;
					} else {
						pe_Ff = false;
					}
				}
				if (pe_Ff && / /.test(pe_CZ)) {
					var pe_ym = pe_CZ.split("\x20");
					if (pe_ym.length == 4 && pe_ym[0] == pe_ym[1]
							&& pe_ym[0] == pe_ym[2] && pe_ym[0] == pe_ym[3]) {
						pe_CZ = pe_ym[0];
					} else {
						pe_Ff = false;
					}
				}
				if (pe_Ff && pe_CZ != "" && pe_CU != "") {
					var pe_ajz = function(pe_ZN, pe_TK, pe_SC) {
						var pe_mS = true;
						for (var i = 0; i < pe_eJ.rows.length; i++) {
							var pe_oc = pe_eJ.rows.item(i);
							if (pe_oc && pe_oc.cells.length > 0) {
								for (var j = 0; j < pe_oc.cells.length; j++) {
									var pe_iV = pe_oc.cells.item(j);
									if (pe_iV) {
										if (!pe_ZN
												.InArray(pe_iV.style.borderTopWidth)) {
											pe_mS = false;
											break;
										}
										if (!pe_ZN
												.InArray(pe_iV.style.borderRightWidth)) {
											pe_mS = false;
											break;
										}
										if (!pe_ZN
												.InArray(pe_iV.style.borderBottomWidth)) {
											pe_mS = false;
											break;
										}
										if (!pe_ZN
												.InArray(pe_iV.style.borderLeftWidth)) {
											pe_mS = false;
											break;
										}
										if (!pe_TK
												.InArray(pe_iV.style.borderTopColor)) {
											pe_mS = false;
											break;
										}
										if (!pe_TK
												.InArray(pe_iV.style.borderRightColor)) {
											pe_mS = false;
											break;
										}
										if (!pe_TK
												.InArray(pe_iV.style.borderBottomColor)) {
											pe_mS = false;
											break;
										}
										if (!pe_TK
												.InArray(pe_iV.style.borderLeftColor)) {
											pe_mS = false;
											break;
										}
										if (!pe_SC
												.InArray(pe_iV.style.borderTopStyle)) {
											pe_mS = false;
											break;
										}
										if (!pe_SC
												.InArray(pe_iV.style.borderRightStyle)) {
											pe_mS = false;
											break;
										}
										if (!pe_SC
												.InArray(pe_iV.style.borderBottomStyle)) {
											pe_mS = false;
											break;
										}
										if (!pe_SC
												.InArray(pe_iV.style.borderLeftStyle)) {
											pe_mS = false;
											break;
										}
									}
								}
								if (!pe_mS)
									break;
							}
						}
						return pe_mS;
					};
					var pe_adH = false;
					if (agentInfo.IsGecko) {
						pe_adH = pe_ajz(
								[ pe_CU, '\x6d\x65\x64\x69\x75\x6d' ],
								[ pe_Nq,
										'\x2d\x6d\x6f\x7a\x2d\x75\x73\x65\x2d\x74\x65\x78\x74\x2d\x63\x6f\x6c\x6f\x72' ],
								[ pe_CZ, '\x6e\x6f\x6e\x65' ]);
					} else {
						pe_adH = pe_ajz([ pe_CU ], [ pe_Nq ], [ pe_CZ ]);
					}
					if (pe_adH) {
						pe_vd = {
							'\x70\x65\x5f\x64\x43' : pe_CZ,
							'\x70\x65\x5f\x69\x75' : pe_Nq,
							'\x70\x65\x5f\x69\x61' : pe_CU
						};
					}
				}
			}
		} catch (exp) {
		}
		return pe_vd;
	},
	pe_adY : function(pe_dC) {
		if (typeof pe_dC == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64'
				|| pe_dC == "")
			return "";
		switch (pe_dC) {
		case "\x64\x6f\x74\x2d\x64\x61\x73\x68":
		case "\x64\x6f\x74\x2d\x64\x6f\x74\x2d\x64\x61\x73\x68":
		case "\x64\x61\x73\x68\x2d\x73\x6d\x61\x6c\x6c\x2d\x67\x61\x70":
			pe_dC = "\x64\x61\x73\x68\x65\x64";
			break;
		case "\x74\x72\x69\x70\x6c\x65":
		case "\x74\x68\x69\x6e\x2d\x74\x68\x69\x63\x6b\x2d\x73\x6d\x61\x6c\x6c\x2d\x67\x61\x70":
		case "\x74\x68\x69\x6e\x2d\x74\x68\x69\x63\x6b\x2d\x74\x68\x69\x6e\x2d\x73\x6d\x61\x6c\x6c\x2d\x67\x61\x70":
		case "\x74\x68\x69\x6e\x2d\x74\x68\x69\x63\x6b\x2d\x6d\x65\x64\x69\x75\x6d\x2d\x67\x61\x70":
		case "\x74\x68\x69\x63\x6b\x2d\x74\x68\x69\x6e\x2d\x6d\x65\x64\x69\x75\x6d\x2d\x67\x61\x70":
		case "\x74\x68\x69\x6e\x2d\x74\x68\x69\x63\x6b\x2d\x74\x68\x69\x6e\x2d\x6d\x65\x64\x69\x75\x6d\x2d\x67\x61\x70":
		case "\x74\x68\x69\x6e\x2d\x74\x68\x69\x63\x6b\x2d\x6c\x61\x72\x67\x65\x2d\x67\x61\x70":
		case "\x74\x68\x69\x63\x6b\x2d\x74\x68\x69\x6e\x2d\x6c\x61\x72\x67\x65\x2d\x67\x61\x70":
		case "\x74\x68\x69\x6e\x2d\x74\x68\x69\x63\x6b\x2d\x74\x68\x69\x6e\x2d\x6c\x61\x72\x67\x65\x2d\x67\x61\x70":
		case "\x64\x6f\x75\x62\x6c\x65\x2d\x77\x61\x76\x65":
			pe_dC = "\x64\x6f\x75\x62\x6c\x65";
			break;
		case "\x77\x61\x76\x65":
		case "\x64\x61\x73\x68\x2d\x64\x6f\x74\x2d\x73\x74\x72\x6f\x6b\x65\x64":
			pe_dC = "\x73\x6f\x6c\x69\x64";
			break;
		case "\x74\x68\x72\x65\x65\x2d\x64\x2d\x65\x6d\x62\x6f\x73\x73":
			pe_dC = "\x72\x69\x64\x67\x65";
			break;
		case "\x74\x68\x72\x65\x65\x2d\x64\x2d\x65\x6e\x67\x72\x61\x76\x65":
			pe_dC = "\x67\x72\x6f\x6f\x76\x65";
			break;
		case "\x69\x6e\x73\x65\x74":
			pe_dC = "\x6f\x75\x74\x73\x65\x74";
			break;
		case "\x62\x6f\x72\x64\x65\x72":
			pe_dC = "";
			break;
		}
		return pe_dC;
	},
	pe_aIf : function(pe_eJ, pe_agH) {
		if (typeof pe_eJ == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64' || !pe_eJ)
			return false;
		if (typeof pe_agH == '\x75\x6e\x64\x65\x66\x69\x6e\x65\x64')
			pe_agH = "\x4e\x65\x78\x74";
		var pe_agd = false;
		var pe_aku = true;
		var pe_pG = pe_eJ;
		try {
			while (pe_aku) {
				if (!pe_pG || pe_pG.nodeType != 8) {
					pe_aku = true;
					break;
				}
				var pe_fx = null;
				if (pe_agH == "\x50\x72\x65\x76\x69\x6f\x75\x73") {
					pe_fx = NamoSE.Util.pe_ff(pe_pG.previousSibling,
							"\x70\x65\x5f\x70\x5a");
				} else {
					pe_fx = NamoSE.Util.pe_ff(pe_pG.nextSibling,
							"\x70\x65\x5f\x4b\x52");
				}
				if (pe_pG.nodeValue != ""
						&& /\[endif\]/.test(pe_pG.nodeValue)
						&& (/\[if \!mso\]/.test(pe_pG.nodeValue) || /\[if gte mso/
								.test(pe_pG.nodeValue))) {
					if (pe_pG.parentNode)
						pe_pG.parentNode.removeChild(pe_pG);
				}
				pe_pG = pe_fx;
			}
			pe_agd = true;
		} catch (e) {
			pe_agd = false;
		}
		return pe_agd;
	}
};
(function() {
	var pe_gv = /^<(\??\w+(?:\:\w+)?)((?:\s+(?:\w+(?:-\w+)*|\w+(?:\:\w+)?)(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/, pe_ara = /^<\/(\w+(?:\:\w+)?)[^>]*>/, attr = /((?:\w+(?:-\w+)*|\w+(?:\:\w+)?))(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/g, pe_azk = /^<\/?\s+[^>]*>/;
	var empty = pe_i("\x61\x72\x65\x61\x2c\x62\x61\x73\x65\x2c\x62\x61\x73\x65\x66\x6f\x6e\x74\x2c\x62\x72\x2c\x63\x6f\x6c\x2c\x66\x72\x61\x6d\x65\x2c\x68\x72\x2c\x69\x6d\x67\x2c\x69\x6e\x70\x75\x74\x2c\x69\x73\x69\x6e\x64\x65\x78\x2c\x6c\x69\x6e\x6b\x2c\x6d\x65\x74\x61\x2c\x70\x61\x72\x61\x6d\x2c\x65\x6d\x62\x65\x64");
	var block = pe_i("\x61\x64\x64\x72\x65\x73\x73\x2c\x61\x70\x70\x6c\x65\x74\x2c\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65\x2c\x62\x75\x74\x74\x6f\x6e\x2c\x63\x65\x6e\x74\x65\x72\x2c\x64\x64\x2c\x64\x65\x6c\x2c\x64\x69\x72\x2c\x64\x69\x76\x2c\x64\x6c\x2c\x64\x74\x2c\x66\x69\x65\x6c\x64\x73\x65\x74\x2c\x66\x6f\x72\x6d\x2c\x66\x72\x61\x6d\x65\x73\x65\x74\x2c\x68\x72\x2c\x69\x66\x72\x61\x6d\x65\x2c\x69\x6e\x73\x2c\x69\x73\x69\x6e\x64\x65\x78\x2c\x6c\x69\x2c\x6d\x61\x70\x2c\x6d\x65\x6e\x75\x2c\x6e\x6f\x66\x72\x61\x6d\x65\x73\x2c\x6e\x6f\x73\x63\x72\x69\x70\x74\x2c\x6f\x62\x6a\x65\x63\x74\x2c\x6f\x6c\x2c\x70\x2c\x70\x72\x65\x2c\x73\x63\x72\x69\x70\x74\x2c\x74\x61\x62\x6c\x65\x2c\x74\x62\x6f\x64\x79\x2c\x74\x64\x2c\x74\x66\x6f\x6f\x74\x2c\x74\x68\x2c\x74\x68\x65\x61\x64\x2c\x74\x72\x2c\x75\x6c");
	var inline = pe_i("\x61\x2c\x61\x62\x62\x72\x2c\x61\x63\x72\x6f\x6e\x79\x6d\x2c\x61\x70\x70\x6c\x65\x74\x2c\x62\x2c\x62\x61\x73\x65\x66\x6f\x6e\x74\x2c\x62\x64\x6f\x2c\x62\x69\x67\x2c\x62\x72\x2c\x62\x75\x74\x74\x6f\x6e\x2c\x63\x69\x74\x65\x2c\x63\x6f\x64\x65\x2c\x64\x65\x6c\x2c\x64\x66\x6e\x2c\x65\x6d\x2c\x66\x6f\x6e\x74\x2c\x69\x2c\x69\x66\x72\x61\x6d\x65\x2c\x69\x6d\x67\x2c\x69\x6e\x70\x75\x74\x2c\x69\x6e\x73\x2c\x6b\x62\x64\x2c\x6c\x61\x62\x65\x6c\x2c\x6d\x61\x70\x2c\x6f\x62\x6a\x65\x63\x74\x2c\x71\x2c\x73\x2c\x73\x61\x6d\x70\x2c\x73\x63\x72\x69\x70\x74\x2c\x73\x65\x6c\x65\x63\x74\x2c\x73\x6d\x61\x6c\x6c\x2c\x73\x70\x61\x6e\x2c\x73\x74\x72\x69\x6b\x65\x2c\x73\x74\x72\x6f\x6e\x67\x2c\x73\x75\x62\x2c\x73\x75\x70\x2c\x74\x65\x78\x74\x61\x72\x65\x61\x2c\x74\x74\x2c\x75\x2c\x76\x61\x72");
	var pe_aBp = pe_i("\x63\x6f\x6c\x67\x72\x6f\x75\x70\x2c\x64\x64\x2c\x64\x74\x2c\x6c\x69\x2c\x6f\x70\x74\x69\x6f\x6e\x73\x2c\x70\x2c\x74\x64\x2c\x74\x66\x6f\x6f\x74\x2c\x74\x68\x2c\x74\x68\x65\x61\x64\x2c\x74\x72");
	var pe_awE = pe_i("\x63\x68\x65\x63\x6b\x65\x64\x2c\x63\x6f\x6d\x70\x61\x63\x74\x2c\x64\x65\x63\x6c\x61\x72\x65\x2c\x64\x65\x66\x65\x72\x2c\x64\x69\x73\x61\x62\x6c\x65\x64\x2c\x69\x73\x6d\x61\x70\x2c\x6d\x75\x6c\x74\x69\x70\x6c\x65\x2c\x6e\x6f\x68\x72\x65\x66\x2c\x6e\x6f\x72\x65\x73\x69\x7a\x65\x2c\x6e\x6f\x73\x68\x61\x64\x65\x2c\x6e\x6f\x77\x72\x61\x70\x2c\x72\x65\x61\x64\x6f\x6e\x6c\x79\x2c\x73\x65\x6c\x65\x63\x74\x65\x64");
	var pe_anJ = pe_i("\x73\x63\x72\x69\x70\x74\x2c\x73\x74\x79\x6c\x65");
	var pe_qI = pe_i("\x76\x3a\x67\x72\x6f\x75\x70");
	var pe_anX = pe_vO.pe_anX = function(html, pe_rn, pe_nh) {
		if (pe_nh) {
			inline = pe_i("\x61\x2c\x61\x62\x62\x72\x2c\x61\x63\x72\x6f\x6e\x79\x6d\x2c\x61\x70\x70\x6c\x65\x74\x2c\x62\x2c\x62\x61\x73\x65\x66\x6f\x6e\x74\x2c\x62\x64\x6f\x2c\x62\x69\x67\x2c\x62\x72\x2c\x62\x75\x74\x74\x6f\x6e\x2c\x63\x69\x74\x65\x2c\x63\x6f\x64\x65\x2c\x64\x65\x6c\x2c\x64\x66\x6e\x2c\x65\x6d\x2c\x66\x6f\x6e\x74\x2c\x69\x2c\x69\x66\x72\x61\x6d\x65\x2c\x69\x6d\x67\x2c\x69\x6e\x70\x75\x74\x2c\x69\x6e\x73\x2c\x6b\x62\x64\x2c\x6c\x61\x62\x65\x6c\x2c\x6d\x61\x70\x2c\x6f\x62\x6a\x65\x63\x74\x2c\x71\x2c\x73\x2c\x73\x61\x6d\x70\x2c\x73\x63\x72\x69\x70\x74\x2c\x73\x65\x6c\x65\x63\x74\x2c\x73\x6d\x61\x6c\x6c\x2c\x73\x74\x72\x69\x6b\x65\x2c\x73\x74\x72\x6f\x6e\x67\x2c\x73\x75\x62\x2c\x73\x75\x70\x2c\x74\x65\x78\x74\x61\x72\x65\x61\x2c\x74\x74\x2c\x75\x2c\x76\x61\x72");
		}
		var index, pe_pN, match, pe_fa = [], last = html, error;
		pe_fa.last = function() {
			return this[this.length - 1];
		};
		while (html) {
			error = false;
			pe_pN = true;
			if (!pe_fa.last() || !pe_anJ[pe_fa.last().toLowerCase()]) {
				if (html.indexOf("\x3c\x21\x2d\x2d") == 0) {
					index = html.indexOf("\x2d\x2d\x3e");
					if (index >= 0) {
						if (pe_rn.comment
								&& !(pe_fa.last() && pe_qI[pe_fa.last()
										.toLowerCase().replace(/#\d+/, "")]))
							pe_rn.comment(html.substring(4, index));
						html = html.substring(index + 3);
						pe_pN = false;
					}
				} else if (html.indexOf("\x3c\x2f") == 0) {
					match = html.match(pe_ara);
					if (match) {
						html = html.substring(match[0].length);
						match[0].replace(pe_ara, pe_I);
						pe_pN = false;
					} else
						error = true;
				} else if (html.indexOf("\x3c") == 0) {
					match = html.match(pe_gv);
					if (match) {
						html = html.substring(match[0].length);
						match[0].replace(pe_gv, pe_aw);
						pe_pN = false;
					} else
						error = true
				}
				if (error) {
					match = html.match(pe_azk);
					if (match) {
						html = html.substring(match[0].length);
						pe_pN = false;
					}
				}
				if (pe_pN) {
					index = html.indexOf("\x3c");
					var text = index < 0 ? html : html.substring(0, index);
					html = index < 0 ? "" : html.substring(index);
					if (pe_rn.pe_pN
							&& !(pe_fa.last() && pe_qI[pe_fa.last()
									.toLowerCase().replace(/#\d+/, "")]))
						pe_rn.pe_pN(text);
				}
			} else {
				html = html.replace(new RegExp(
						"\x28\x5b\\\x73\\\x53\x5d\x2a\x3f\x29\x3c\/"
								+ pe_fa.last() + "\x5b\x5e\x3e\x5d\x2a\x3e"),
						function(all, text) {
							text = text.replace(/<!--([\s\S]*?)-->/g,
									"\x24\x31").replace(
									/<!\[CDATA\[([\s\S]*?)]]>/g, "\x24\x31");
							if (pe_rn.pe_pN)
								pe_rn.pe_pN(text);
							return "";
						});
				pe_I("", pe_fa.last());
			}
			if (html == last)
				throw "\x50\x61\x72\x73\x65\x20\x45\x72\x72\x6f\x72\x3a\x20"
						+ html;
			last = html;
		}
		pe_I();
		function pe_aw(tag, tagName, rest, pe_fp) {
			var pe_qb = tagName.toLowerCase();
			if (!pe_qI[pe_qb] && tagName.indexOf("\x3a") != -1)
				return;
			if (pe_fa.last()) {
				if (!pe_qI[pe_qb]
						&& pe_qI[pe_fa.last().toLowerCase().replace(/#\d+/, "")])
					return;
				if (pe_qI[pe_qb]
						&& (pe_fa.last().indexOf(tagName + "\x23") != -1)) {
					pe_fa[pe_fa.length - 1] = pe_fa.last().replace(/#(\d+)/,
							function(str, count) {
								return "\x23" + (parseInt(count) + 1);
							});
					return;
				}
			}
			if (pe_aBp[pe_qb] && pe_fa.last() == tagName) {
				pe_I("", tagName);
			}
			pe_fp = empty[pe_qb] || !!pe_fp;
			if (pe_rn.start) {
				var pe_gF = [];
				var style;
				rest.replace(attr, function(match, name) {
					name = name.toLowerCase();
					var value = arguments[2] ? arguments[2]
							: arguments[3] ? arguments[3]
									: arguments[4] ? arguments[4]
											: pe_awE[name] ? name : "";
					var obj = {
						name : name,
						value : value,
						pe_aqs : value.replace(/(^|[^\\])"/g, '\x24\x31\\\"')
					};
					if (name == "\x73\x74\x79\x6c\x65")
						style = obj;
					else
						pe_gF.push(obj);
				});
				if (pe_rn.start)
					var remove = pe_rn.start(pe_qb, pe_gF, pe_fp, style);
				if (pe_qI[pe_qb])
					pe_fa.push(tagName + "\x23\x31");
				else if (!pe_fp) {
					if (remove)
						pe_fa.push("\x24" + tagName);
					else
						pe_fa.push(tagName);
				}
			} else if (!pe_fp)
				pe_fa.push(tagName);
		}
		;
		function pe_I(tag, tagName) {
			if (!tagName)
				var pos = 0;
			else {
				var pe_qb = tagName.toLowerCase();
				if (!pe_qI[pe_qb] && tagName.indexOf("\x3a") != -1)
					return;
				else if (pe_fa.last()
						&& !pe_qI[pe_qb]
						&& pe_qI[pe_fa.last().toLowerCase().replace(/#\d+/, "")])
					return;
				else if (pe_fa.last() && pe_qI[pe_qb]
						&& (pe_fa.last().indexOf(tagName + "\x23") != -1)) {
					var pos;
					pe_fa[pe_fa.length - 1] = pe_fa.last().replace(/#(\d+)/,
							function(str, count) {
								if (count == "\x31") {
									pos = pe_fa.length - 1;
									return "";
								}
								return "\x23" + (parseInt(count) - 1);
							});
					if (!pos)
						return;
				} else {
					for (var pos = pe_fa.length - 1; pos >= 0; pos--)
						if (pe_fa[pos] == tagName
								|| pe_fa[pos] == "\x24" + tagName)
							break;
				}
			}
			if (pos >= 0) {
				for (var i = pe_fa.length - 1; i >= pos; i--)
					if (pe_rn.end && pe_fa[i].indexOf("\x24") != 0)
						pe_rn.end(pe_fa[i].toLowerCase());
				pe_fa.length = pos;
			}
		}
	};
	function pe_i(str) {
		var obj = {}, items = str.split("\x2c");
		for (var i = 0; i < items.length; i++)
			obj[items[i]] = true;
		return obj;
	}
})();
var pe_axT = {
	_oThis : null,
	pe_cx : null,
	pe_awP : [ "\x70", "\x68\x31", "\x68\x32", "\x68\x33", "\x68\x34",
			"\x68\x35", "\x68\x36", "\x61\x64\x64\x72\x65\x73\x73",
			"\x70\x72\x65" ],
	pe_axX : [ "\x62\x6f\x64\x79", "\x74\x61\x62\x6c\x65",
			"\x74\x68\x65\x61\x64", "\x74\x62\x6f\x64\x79", "\x74\x72",
			"\x74\x68", "\x74\x64", "\x75\x6c", "\x6f\x6c",
			"\x62\x6c\x6f\x63\x6b\x71\x75\x6f\x74\x65", "\x66\x6f\x72\x6d",
			"\x6c\x69", "\x64\x69\x76" ],
	pe_axh : [ "\x69\x6d\x67", "\x6f\x62\x6a\x65\x63\x74", "\x62\x69\x67",
			"\x73\x6d\x61\x6c\x6c", "\x73\x75\x62", "\x73\x75\x70" ],
	pe_azR : [ "\x68\x72" ],
	pe_zo : null,
	start : function() {
		this.pe_cx = this._oThis.getDocument();
		var selection = this._oThis.getSelection();
		selection.sel = selection.getSelection();
		selection.range = selection.pe_bY();
		var pe_anF = selection.pe_hU();
		var pe_Pd = pe_anF[0];
		var pe_agu = pe_anF[1];
		try {
			var pe_dg = this.pe_adR(pe_Pd, true);
			var pe_avK = this.pe_adR(pe_agu || pe_Pd, false);
			var pe_eV = pe_dg;
			var pe_ft = null, pe_mA = null;
			while (pe_eV) {
				var pe_auN = pe_eV == pe_avK;
				if (this.pe_adu(pe_eV)) {
					if (this.pe_zo == "\x70\x72\x65") {
						var pe_Nr = pe_eV.firstChild;
						var pe_ft = pe_eV;
						var pe_ajQ = false;
						while (pe_Nr) {
							var pe_adJ = this.pe_awn(pe_Nr);
							var pe_aFu = pe_Nr.nextSibling;
							if (pe_adJ || pe_ajQ) {
								pe_va = this.pe_cx
										.createElement(pe_adJ ? pe_eV.nodeName
												: this.pe_zo);
								if (pe_ft.nextSibling)
									pe_ft.parentNode.insertBefore(pe_va,
											pe_ft.nextSibling);
								else
									pe_ft.parentNode.appendChild(pe_va);
								pe_ft = pe_va;
								pe_ajQ = pe_adJ;
							}
							if (pe_eV != pe_ft)
								pe_ft.appendChild(pe_Nr);
							pe_Nr = pe_aFu;
						}
						pe_mA = pe_ft.nextSibling;
						if (pe_eV.nodeName.toLowerCase() != this.pe_zo)
							pe_eV = this._oThis.util.renameNode(pe_eV,
									this.pe_zo, this.pe_cx);
					} else {
						if (pe_eV.nodeName.toLowerCase() != this.pe_zo) {
							pe_eV = this._oThis.util.renameNode(pe_eV,
									this.pe_zo, this.pe_cx);
							if (this.pe_cx
									.getElementById("\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74")) {
								pe_Pd = this.pe_cx
										.getElementById("\x5f\x53\x45\x53\x70\x61\x6e\x5f\x53\x74\x61\x72\x74\x43\x61\x72\x65\x74");
							}
						}
						pe_mA = pe_eV.nextSibling;
					}
					pe_ft = null;
				} else if (this.pe_aqQ(pe_eV)) {
					pe_ft = null;
					if (pe_eV.nodeName.toLowerCase() == "\x62\x6f\x64\x79")
						break;
					pe_mA = pe_eV.firstChild || pe_eV.nextSibling;
				} else if (pe_eV.nodeType == 3 && pe_eV.nodeValue == "\n") {
					if (pe_ft) {
						pe_ft.appendChild(pe_eV);
						pe_eV = pe_ft;
					}
					pe_mA = pe_eV.nextSibling;
				} else if (this.pe_awo(pe_eV)) {
					pe_ft = null;
					pe_mA = pe_eV.nextSibling;
				} else {
					if (!pe_ft) {
						pe_ft = this.pe_cx.createElement(this.pe_zo);
						pe_eV.parentNode.replaceChild(pe_ft, pe_eV);
					}
					pe_ft.appendChild(pe_eV);
					pe_eV = pe_ft;
					pe_mA = pe_eV.nextSibling;
				}
				if (pe_auN)
					break;
				if (pe_mA)
					pe_eV = pe_mA;
				else if (pe_eV.parentNode) {
					pe_mA = pe_eV.parentNode;
					while (pe_mA && !pe_mA.nextSibling)
						pe_mA = pe_mA.parentNode;
					pe_eV = pe_mA ? pe_mA.nextSibling : null;
				} else
					pe_eV = null;
			}
			selection.pe_hW(pe_Pd, pe_agu);
		} catch (e) {
			selection.pe_hI(pe_Pd, pe_agu);
		}
	},
	pe_aqR : function(block) {
		return this.pe_adu(block) || this.pe_aqQ(block);
	},
	pe_adu : function(block) {
		try {
			var name = block.nodeName.toLowerCase();
			return this.pe_awP.InArray(name);
		} catch (e) {
			return false;
		}
	},
	pe_aqQ : function(block) {
		try {
			var name = block.nodeName.toLowerCase();
			return this.pe_axX.InArray(name);
		} catch (e) {
			return false;
		}
	},
	pe_awn : function(block) {
		try {
			var name = block.nodeName.toLowerCase();
			return this.pe_axh.InArray(name);
		} catch (e) {
			return false;
		}
	},
	pe_awo : function(block) {
		try {
			var name = block.nodeName.toLowerCase();
			return this.pe_azR.InArray(name);
		} catch (e) {
			return false;
		}
	},
	pe_adR : function(node, start) {
		if (!node)
			return null;
		if (typeof start == "\x75\x6e\x64\x65\x66\x69\x6e\x65\x64")
			start = true;
		var temp = null;
		var block = node;
		while (block && !this.pe_aqR(block)) {
			temp = block;
			block = block.parentNode;
		}
		if (!block)
			return null;
		if ([ "\x62\x6f\x64\x79", "\x6c\x69", "\x74\x64" ]
				.InArray(block.nodeName.toLowerCase())) {
			block = temp;
			while (block && !this.pe_aqR(block)) {
				temp = block;
				block = start ? block.previousSibling : block.nextSibling;
			}
			return temp;
		} else
			return block;
	}
};
var pe_avQ = {
	_oThis : null,
	pe_bC : null,
	pe_bU : null,
	_cmd : null,
	pe_BW : null,
	pe_fS : null,
	pe_aFQ : function(cmd) {
		if (!cmd)
			return;
		var t = this;
		var pe_Id = false;
		t._cmd = cmd;
		t.pe_fS = t._oThis.getDocument();
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		pe_nc = t.pe_bC.pe_gu("\x54\x41\x42\x4c\x45");
		if (!pe_nc || pe_nc.nodeName != "\x54\x41\x42\x4c\x45") {
			return;
		} else {
			t.pe_BW = pe_nc;
		}
		if (t._oThis.pe_bV && t._oThis.pe_bV.length > 0) {
			pe_Id = true;
		}
		if (!pe_Id)
			return;
		t.pe_aAg();
	},
	pe_axe : function() {
		var t = this;
		var pe_iW = null;
		var pe_eB = null;
		var pe_Yc = new Array();
		pe_iW = t.pe_atF();
		pe_eB = t.pe_BW.getElementsByTagName('\x74\x64');
		for (var i = 0; i < pe_iW.length; i++) {
			for (var j = 0; j < pe_eB.length; j++) {
				if (pe_Yc.InArray(j)) {
					continue;
				}
				var pe_iN = 0;
				var pe_jq = 0;
				var nTop = 0;
				var pe_jB = 0;
				pe_iN = NamoSE.Util
						.pe_mB(t.pe_fS, pe_eB[j], '\x6c\x65\x66\x74');
				pe_iN = (isNaN(pe_iN)) ? pe_eB[j].offsetLeft : pe_iN;
				pe_jq = parseInt(NamoSE.Util.pe_mB(t.pe_fS, pe_eB[j],
						'\x77\x69\x64\x74\x68').replace("\x70\x78", ""));
				pe_jq = (pe_jq > pe_eB[j].clientWidth) ? pe_jq
						: pe_eB[j].clientWidth;
				nTop = NamoSE.Util.pe_mB(t.pe_fS, pe_eB[j], '\x74\x6f\x70');
				nTop = (isNaN(nTop)) ? pe_eB[j].offsetTop : nTop;
				pe_jB = parseInt(NamoSE.Util.pe_mB(t.pe_fS, pe_eB[j],
						'\x68\x65\x69\x67\x68\x74').replace("\x70\x78", ""));
				pe_jB = (pe_jB > pe_eB[j].clientHeight) ? pe_jB
						: pe_eB[j].clientHeight;
				if (t._cmd == '\x70\x65\x5f\x4a\x54'
						|| t._cmd == '\x70\x65\x5f\x73\x46') {
					if ((pe_iN < pe_iW[i].pe_ali)
							&& ((pe_iN + pe_jq) > pe_iW[i].pe_ali)) {
						if (pe_jq <= pe_iW[i].w) {
							pe_Yc.push(j);
						}
					} else {
						if (pe_iW[i].x <= pe_iN
								&& ((pe_iW[i].x + pe_iW[i].w) >= (pe_iN + pe_jq))) {
							pe_Yc.push(j);
						}
					}
				}
			}
		}
		return pe_Yc;
	},
	pe_axd : function() {
		var t = this;
		var pe_iW = null;
		var pe_eB = null;
		var pe_XP = new Array();
		pe_iW = t.pe_atF();
		pe_eB = t.pe_BW.getElementsByTagName('\x74\x64');
		for (var i = 0; i < pe_iW.length; i++) {
			for (var j = 0; j < pe_eB.length; j++) {
				if (pe_XP.InArray(j)) {
					continue;
				}
				var pe_iN = 0;
				var pe_jq = 0;
				var nTop = 0;
				var pe_jB = 0;
				pe_iN = NamoSE.Util
						.pe_mB(t.pe_fS, pe_eB[j], '\x6c\x65\x66\x74');
				pe_iN = (isNaN(pe_iN)) ? pe_eB[j].offsetLeft : pe_iN;
				pe_jq = parseInt(NamoSE.Util.pe_mB(t.pe_fS, pe_eB[j],
						'\x77\x69\x64\x74\x68').replace("\x70\x78", ""));
				pe_jq = (pe_jq > pe_eB[j].clientWidth) ? pe_jq
						: pe_eB[j].clientWidth;
				nTop = NamoSE.Util.pe_mB(t.pe_fS, pe_eB[j], '\x74\x6f\x70');
				nTop = (isNaN(nTop)) ? pe_eB[j].offsetTop : nTop;
				pe_jB = parseInt(NamoSE.Util.pe_mB(t.pe_fS, pe_eB[j],
						'\x68\x65\x69\x67\x68\x74').replace("\x70\x78", ""));
				pe_jB = (pe_jB > pe_eB[j].clientHeight) ? pe_jB
						: pe_eB[j].clientHeight;
				if (t._cmd == '\x70\x65\x5f\x4a\x53'
						|| t._cmd == '\x70\x65\x5f\x73\x46') {
					if ((nTop < pe_iW[i].pe_alg)
							&& ((nTop + pe_jB) > pe_iW[i].pe_alg)) {
						if (pe_jB <= pe_iW[i].h) {
							pe_XP.push(j);
						}
					} else {
						if (pe_iW[i].y <= nTop
								&& ((pe_iW[i].y + pe_iW[i].h) >= (nTop + pe_jB))) {
							pe_XP.push(j);
						}
					}
				}
			}
		}
		return pe_XP;
	},
	pe_atF : function() {
		var t = this;
		var pe_aqf = 0;
		var pe_ajb = null;
		var pe_iW = new Array();
		pe_aqf = t._oThis.pe_bV.length;
		for (var i = 0; i < pe_aqf; i++) {
			var pe_iN = 0;
			var pe_jq = 0;
			var nTop = 0;
			var pe_jB = 0;
			pe_iN = NamoSE.Util.pe_mB(t.pe_fS, t._oThis.pe_bV[i],
					'\x6c\x65\x66\x74');
			pe_iN = (isNaN(pe_iN)) ? t._oThis.pe_bV[i].offsetLeft : pe_iN;
			pe_jq = parseInt(NamoSE.Util.pe_mB(t.pe_fS, t._oThis.pe_bV[i],
					'\x77\x69\x64\x74\x68').replace("\x70\x78", ""));
			pe_jq = (pe_jq > t._oThis.pe_bV[i].clientWidth) ? pe_jq
					: t._oThis.pe_bV[i].clientWidth;
			nTop = NamoSE.Util
					.pe_mB(t.pe_fS, t._oThis.pe_bV[i], '\x74\x6f\x70');
			nTop = (isNaN(nTop)) ? t._oThis.pe_bV[i].offsetTop : nTop;
			pe_jB = parseInt(NamoSE.Util.pe_mB(t.pe_fS, t._oThis.pe_bV[i],
					'\x68\x65\x69\x67\x68\x74').replace("\x70\x78", ""));
			pe_jB = (pe_jB > t._oThis.pe_bV[i].clientHeight) ? pe_jB
					: t._oThis.pe_bV[i].clientHeight;
			pe_ajb = {
				"\x70\x65\x5f\x61\x6c\x69" : (pe_jq / 2) + pe_iN,
				"\x70\x65\x5f\x61\x6c\x67" : (pe_jB / 2) + nTop,
				"\x78" : pe_iN,
				"\x79" : nTop,
				"\x77" : pe_jq,
				"\x68" : pe_jB
			};
			pe_iW.push(pe_ajb);
		}
		return pe_iW;
	},
	pe_ayA : function(pe_Jm) {
		var t = this;
		var pe_eB = null;
		var pe_Dx = 0;
		var pe_aoo = 0;
		pe_eB = t.pe_BW.getElementsByTagName('\x74\x64');
		pe_Dx = pe_Jm.length;
		var nCol = pe_Dx;
		for (var i = 0; i < pe_Dx; i++) {
			var pe_KM = pe_Jm[i];
			pe_aoo += parseInt(NamoSE.Util.pe_mB(t.pe_fS, pe_eB[pe_KM],
					'\x77\x69\x64\x74\x68').replace("\x70\x78", ""));
			nCol += (pe_eB[pe_KM].colSpan - 1);
		}
		return pe_aoo / nCol;
	},
	pe_ayz : function(pe_Jm) {
		var t = this;
		var pe_eB = null;
		var pe_Dx = 0;
		var pe_aov = 0;
		pe_eB = t.pe_BW.getElementsByTagName('\x74\x64');
		pe_Dx = pe_Jm.length;
		var nRow = pe_Dx;
		for (var i = 0; i < pe_Dx; i++) {
			var pe_KM = pe_Jm[i];
			pe_aov += parseInt(NamoSE.Util.pe_mB(t.pe_fS, pe_eB[pe_KM],
					'\x68\x65\x69\x67\x68\x74').replace("\x70\x78", ""));
			nRow += (pe_eB[pe_KM].rowSpan - 1);
		}
		return pe_aov / nRow;
	},
	pe_aAg : function() {
		var t = this;
		var pe_apO = 0;
		var pe_arA = 0;
		var pe_eB = null;
		var pe_Sn = new Array();
		var pe_Sr = new Array();
		pe_eB = t.pe_BW.getElementsByTagName('\x74\x64');
		if (t._cmd == '\x70\x65\x5f\x4a\x54'
				|| t._cmd == '\x70\x65\x5f\x73\x46') {
			pe_Sn = t.pe_axe();
			pe_apO = t.pe_ayA(pe_Sn);
		}
		if (t._cmd == '\x70\x65\x5f\x4a\x53'
				|| t._cmd == '\x70\x65\x5f\x73\x46') {
			pe_Sr = t.pe_axd();
			pe_arA = t.pe_ayz(pe_Sr);
		}
		for (var i = 0; i < pe_Sn.length; i++) {
			var pe_KN = pe_Sn[i];
			if (t._cmd == '\x70\x65\x5f\x4a\x54'
					|| t._cmd == '\x70\x65\x5f\x73\x46') {
				pe_eB[pe_KN].style.width = (pe_apO * parseInt(pe_eB[pe_KN].colSpan))
						+ "\x70\x78";
			}
		}
		for (var i = 0; i < pe_Sr.length; i++) {
			var pe_KN = pe_Sr[i];
			if (t._cmd == '\x70\x65\x5f\x4a\x53'
					|| t._cmd == '\x70\x65\x5f\x73\x46') {
				pe_eB[pe_KN].style.height = (pe_arA * parseInt(pe_eB[pe_KN].rowSpan))
						+ "\x70\x78";
			}
		}
	}
};
var pe_aGF = {
	_oThis : null,
	pe_bC : null,
	pe_bU : null,
	_cmd : null,
	pe_BW : null,
	pe_fS : null,
	start : function(cmd) {
		if (!cmd)
			return;
		var t = this;
		t._cmd = cmd;
		t.pe_fS = t._oThis.getDocument();
		t.pe_bC = t._oThis.getSelection();
		t.pe_bC.sel = t.pe_bC.getSelection();
		t.pe_bC.range = t.pe_bC.pe_bY();
		var pe_se;
		if (agentInfo.IsIE || agentInfo.IsIE11) {
			if (t.pe_bC.pe_dV() == "\x43\x6f\x6e\x74\x72\x6f\x6c") {
				pe_bG = t.pe_bC.pe_fJ();
				if (pe_bG == null)
					return;
				if (pe_bG.tagName.toLowerCase() == "\x64\x69\x76") {
					pe_se = pe_bG;
				}
			} else {
				pe_bG = t.pe_bC.pe_dG(t._oThis.pe_gH(t.pe_bC.range, true),
						"\x44\x49\x56");
				if (pe_bG && pe_bG.tagName.toLowerCase() == "\x64\x69\x76") {
					pe_se = pe_bG;
				}
			}
		} else {
			pe_se = t.pe_bC.sel.anchorNode.parentNode;
			while (pe_se.nodeName != "\x44\x49\x56") {
				pe_se = pe_se.parentNode;
				if (pe_se.nodeName == "\x48\x54\x4d\x4c") {
					break;
				}
			}
		}
		if (!pe_se || pe_se.nodeName != "\x44\x49\x56") {
			return;
		}
		var layer = t.pe_fS.getElementsByTagName("\x64\x69\x76");
		var pe_avp = layer.length;
		var d = new Array();
		for (var i = 0; i < pe_avp; i++) {
			d.push(layer[i]);
		}
		var pe_PR = 0;
		var pe_tz = 0;
		var pe_arE = t.pe_awJ(d);
		for (var i = 0; i < pe_arE.length; i++) {
			for (var j = 0; j < d.length; j++) {
				if (pe_arE[i] == d[j]) {
					if (d[j] == pe_se) {
						pe_PR = j;
						pe_tz = (i + 1);
					}
					d[j].style.zIndex = (i + 1);
					continue;
				}
			}
		}
		if (d.length > 0) {
			if (cmd == 0) {
				if (pe_tz != d.length) {
					for (var nArr = 0; nArr < d.length; ++nArr) {
						if (nArr == pe_PR) {
							d[nArr].style.zIndex = d.length;
						} else {
							if (pe_tz < d[nArr].style.zIndex) {
								d[nArr].style.zIndex = (parseInt(d[nArr].style.zIndex) - 1);
							}
						}
					}
				}
			} else if (cmd == 3) {
				if (pe_tz != 1) {
					for (var nArr = 0; nArr < d.length; ++nArr) {
						if (nArr == pe_PR) {
							d[nArr].style.zIndex = 1;
						} else {
							if (pe_tz > d[nArr].style.zIndex) {
								d[nArr].style.zIndex = (parseInt(d[nArr].style.zIndex) + 1);
							}
						}
					}
				}
			} else if (cmd == "\x6d\x6f\x76\x65\x66\x6f\x72\x77\x61\x72\x64") {
				if (pe_tz != d.length) {
					for (var nArr = 0; nArr < d.length; ++nArr) {
						if (nArr == pe_PR) {
							d[nArr].style.zIndex = (parseInt(d[nArr].style.zIndex) + 1);
						} else {
							if (d[nArr].style.zIndex == (pe_tz + 1)) {
								d[nArr].style.zIndex = (parseInt(d[nArr].style.zIndex) - 1);
							}
						}
					}
				}
			} else if (cmd == "\x6d\x6f\x76\x65\x62\x61\x63\x6b\x77\x61\x72\x64") {
				if (pe_tz != 1) {
					for (var nArr = 0; nArr < d.length; ++nArr) {
						if (nArr == pe_PR) {
							d[nArr].style.zIndex = (parseInt(d[nArr].style.zIndex) - 1);
						} else {
							if (d[nArr].style.zIndex == (pe_tz - 1)) {
								d[nArr].style.zIndex = (parseInt(d[nArr].style.zIndex) + 1);
							}
						}
					}
				}
			}
		}
	},
	pe_awJ : function(list) {
		return list.sort(function(a, b) {
			var x = parseInt(a.style.zIndex);
			var y = parseInt(b.style.zIndex);
			if (isNaN(x)) {
				x = 0;
			}
			if (isNaN(y)) {
				y = 0;
			}
			return ((x < y) ? -1 : ((x > y) ? 1 : 0));
		});
	}
};
var pe_ayW = {
	_oThis : null,
	init : function() {
		var t = this;
		var pe_dP = t._oThis.pe_qG(this);
		t._oThis.pCmd = "\x69\x6d\x61\x67\x65";
		t._oThis.pBtn = (document.getElementById(t._oThis.pCmd)) ? document
				.getElementById(t._oThis.pCmd) : t._oThis.pe_eL;
		var pe_cR = pe_dP.pe_uK(t._oThis.pCmd, t._oThis.pe_fT);
		if (pe_cR == null)
			return false;
		var pe_mu = pe_cR.start();
	},
	start : function(obj) {
		var t = this;
		t.init();
		var pe_iI = t._oThis.pe_AI();
		var imageDomain = (t._oThis.params.UserDomain && t._oThis.params.UserDomain
				.Trim() != "") ? t._oThis.params.UserDomain : "";
		var filename = obj[0].name || "";
		var pe_acj = t._oThis.util.pe_Fn(filename);
		var pe_gC = t._oThis.pe_wm();
		var pe_oA = pe_gC.pe_oA;
		var pe_pL = pe_gC.pe_pL;
		var pe_eP = t._oThis
				.pe_pH('\x49\x6d\x61\x67\x65\x55\x70\x6c\x6f\x61\x64');
		var pe_jW = t._oThis.params.WebLanguage.toLowerCase();
		var useExternalServer = "";
		var imageUPath = (t._oThis.params.ImageSavePath == null) ? ""
				: t._oThis.params.ImageSavePath;
		var defaultUPath = t._oThis.baseURL + t._oThis.config.pe_zi;
		var fileType = (obj[0].type.indexOf('\x2f') > 0) ? obj[0].type
				.substring(obj[0].type.indexOf('\x2f') + 1) : "";
		if (t._oThis.params.UploadFileExecutePath
				&& t._oThis.params.UploadFileExecutePath
						.indexOf(t._oThis.pe_tL) != 0) {
			var pe_jA = (t._oThis.params.WebLanguage.toLowerCase() == "\x61\x73\x70\x2e\x6e\x65\x74") ? "\x61\x73\x70\x78"
					: t._oThis.params.WebLanguage.toLowerCase();
			useExternalServer = t._oThis.baseURL
					+ "\x77\x65\x62\x73\x6f\x75\x72\x63\x65\x2f"
					+ t._oThis.params.WebLanguage.toLowerCase()
					+ "\x2f\x49\x6d\x61\x67\x65\x55\x70\x6c\x6f\x61\x64\x45\x78\x65\x63\x75\x74\x65\x2e"
					+ pe_jA;
			if (t._oThis.params.UploadFileExecutePath.indexOf("\x2e") != -1) {
				var pe_kA = t._oThis.params.UploadFileExecutePath
						.substring(t._oThis.params.UploadFileExecutePath
								.lastIndexOf("\x2e") + 1);
				if ([ "\x61\x73\x70", "\x6a\x73\x70", "\x61\x73\x70\x78",
						"\x70\x68\x70" ].InArray(pe_kA.toLowerCase()))
					pe_jW = pe_kA.toLowerCase();
			}
		}
		var pe_cA = new FormData();
		pe_cA.enctype = '\x6d\x75\x6c\x74\x69\x70\x61\x72\x74\x2f\x66\x6f\x72\x6d\x2d\x64\x61\x74\x61';
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x53\x69\x7a\x65\x4c\x69\x6d\x69\x74',
				pe_iI.image);
		pe_cA.append('\x69\x6d\x61\x67\x65\x6d\x6f\x64\x69\x66\x79', '');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x45\x64\x69\x74\x6f\x72\x46\x6c\x61\x67',
				'');
		pe_cA
				.append(
						'\x75\x70\x6c\x6f\x61\x64\x46\x69\x6c\x65\x53\x75\x62\x44\x69\x72',
						true);
		pe_cA.append('\x69\x6d\x61\x67\x65\x44\x6f\x6d\x61\x69\x6e',
				imageDomain);
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x49\x6e\x73\x65\x72\x74\x46\x6c\x61\x67\x31',
						'\x31');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x46\x69\x6c\x65\x5f\x54\x65\x78\x74',
				'\x43\x3a\\\x66\x61\x6b\x65\x70\x61\x74\x68\\' + filename);
		var pe_adE = "\x69\x6d\x61\x67\x65\x46\x69\x6c\x65";
		if (t._oThis.params.InputFileName) {
			pe_adE = t._oThis.params.InputFileName;
		}
		if (obj[0].constructor.name == '\x44\x61\x74\x61\x54\x72\x61\x6e\x73\x66\x65\x72\x49\x74\x65\x6d') {
			pe_cA.append(pe_adE, obj[0].getAsFile());
		} else {
			pe_cA.append(pe_adE, obj[0]);
		}
		pe_cA.append('\x5f\x5f\x43\x6c\x69\x63\x6b', '\x30');
		pe_cA
				.append('\x69\x6d\x61\x67\x65\x49\x6e\x70\x75\x74\x55\x72\x6c',
						'');
		pe_cA.append('\x69\x6d\x61\x67\x65\x54\x69\x74\x6c\x65',
				'\x65\x78\x74\x65\x72\x6e\x61\x6c\x5f\x69\x6d\x61\x67\x65');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x54\x69\x74\x6c\x65\x56\x69\x65\x77',
				'\x65\x78\x74\x65\x72\x6e\x61\x6c\x5f\x69\x6d\x61\x67\x65');
		pe_cA.append('\x69\x6d\x61\x67\x65\x41\x6c\x74',
				'\x65\x78\x74\x65\x72\x6e\x61\x6c\x5f\x69\x6d\x61\x67\x65');
		pe_cA.append('\x69\x6d\x61\x67\x65\x41\x6c\x74\x56\x69\x65\x77',
				'\x65\x78\x74\x65\x72\x6e\x61\x6c\x5f\x69\x6d\x61\x67\x65');
		pe_cA.append('\x69\x6d\x61\x67\x65\x57\x69\x64\x74\x68', '');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x57\x69\x64\x74\x68\x55\x6e\x69\x74',
				'\x70\x78');
		pe_cA.append('\x69\x6d\x61\x67\x65\x48\x65\x69\x67\x68\x74', '');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x48\x65\x69\x67\x68\x74\x55\x6e\x69\x74',
				'\x70\x78');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x4c\x65\x66\x74', '');
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x4c\x65\x66\x74\x55\x6e\x69\x74',
						'\x70\x78');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x52\x69\x67\x68\x74',
				'');
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x52\x69\x67\x68\x74\x55\x6e\x69\x74',
						'\x70\x78');
		pe_cA
				.append('\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x54\x6f\x70',
						'');
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x54\x6f\x70\x55\x6e\x69\x74',
						'\x70\x78');
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x42\x6f\x74\x74\x6f\x6d',
						'');
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x4d\x61\x67\x69\x6e\x42\x6f\x74\x74\x6f\x6d\x55\x6e\x69\x74',
						'\x70\x78');
		pe_cA.append('\x69\x6d\x61\x67\x65\x41\x6c\x69\x67\x6e',
				'\x62\x61\x73\x65\x6c\x69\x6e\x65');
		pe_cA.append('\x69\x6d\x61\x67\x65\x42\x6f\x72\x64\x65\x72', '\x30');
		pe_cA.append('\x69\x6d\x61\x67\x65\x49\x64', '');
		pe_cA.append('\x69\x6d\x61\x67\x65\x43\x6c\x61\x73\x73', '');
		pe_cA.append('\x69\x6d\x61\x67\x65\x55\x50\x61\x74\x68', imageUPath);
		pe_cA.append('\x64\x65\x66\x61\x75\x6c\x74\x55\x50\x61\x74\x68',
				defaultUPath);
		pe_cA.append('\x69\x6d\x61\x67\x65\x4d\x61\x78\x43\x6f\x75\x6e\x74',
				t._oThis.config.pe_zB);
		pe_cA.append('\x69\x6d\x61\x67\x65\x4b\x69\x6e\x64',
				'\x69\x6d\x61\x67\x65');
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x54\x65\x6d\x70\x46\x4e\x61\x6d\x65',
				pe_acj);
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x55\x4e\x61\x6d\x65\x54\x79\x70\x65',
				pe_oA);
		pe_cA
				.append(
						'\x69\x6d\x61\x67\x65\x55\x4e\x61\x6d\x65\x45\x6e\x63\x6f\x64\x65',
						pe_pL);
		pe_cA.append(
				'\x69\x6d\x61\x67\x65\x56\x69\x65\x77\x65\x72\x50\x6c\x61\x79',
				false);
		pe_cA.append('\x69\x6d\x61\x67\x65\x4f\x72\x67\x50\x61\x74\x68',
				(t._oThis.config.pe_DW == "\x54\x72\x75\x65") ? filename : "");
		pe_cA.append('\x65\x64\x69\x74\x6f\x72\x46\x72\x61\x6d\x65',
				t._oThis.editorFrame.id);
		pe_cA
				.append(
						'\x75\x73\x65\x45\x78\x74\x65\x72\x6e\x61\x6c\x53\x65\x72\x76\x65\x72',
						useExternalServer);
		pe_cA.append('\x63\x68\x65\x63\x6b\x50\x6c\x75\x67\x69\x6e',
				'\x66\x61\x6c\x73\x65');
		pe_cA.append('\x66\x69\x6c\x65\x54\x79\x70\x65', fileType);
		var pe_hh = "";
		if (pe_eP.substr(pe_eP.lastIndexOf("\x2e")).toLowerCase() == "\x2e\x6a\x73\x70") {
			var pe_hN = t._oThis.pe_sN();
			pe_hh = pe_hN
					+ "\x69\x6d\x61\x67\x65\x53\x69\x7a\x65\x4c\x69\x6d\x69\x74\x3d"
					+ pe_iI.image
					+ "\x26\x69\x6d\x61\x67\x65\x55\x50\x61\x74\x68\x3d"
					+ imageUPath
					+ "\x26\x64\x65\x66\x61\x75\x6c\x74\x55\x50\x61\x74\x68\x3d"
					+ defaultUPath
					+ "\x26\x69\x6d\x61\x67\x65\x56\x69\x65\x77\x65\x72\x50\x6c\x61\x79\x3d\x66\x61\x6c\x73\x65\x26\x69\x6d\x61\x67\x65\x44\x6f\x6d\x61\x69\x6e\x3d"
					+ imageDomain
					+ "\x26\x75\x70\x6c\x6f\x61\x64\x46\x69\x6c\x65\x53\x75\x62\x44\x69\x72\x3d\x74\x72\x75\x65\x26\x75\x73\x65\x45\x78\x74\x65\x72\x6e\x61\x6c\x53\x65\x72\x76\x65\x72\x3d"
					+ useExternalServer
					+ "\x26\x63\x68\x65\x63\x6b\x50\x6c\x75\x67\x69\x6e\x3d\x66\x61\x6c\x73\x65\x26\x66\x69\x6c\x65\x54\x79\x70\x65\x3d"
					+ fileType;
		}
		var xhr = new XMLHttpRequest();
		xhr.open('\x50\x4f\x53\x54', pe_eP + pe_hh);
		var pe_bC = t._oThis.getSelection();
		var sel = pe_bC.sel = pe_bC.getSelection();
		var range = pe_bC.range = pe_bC.pe_bY();
		if (agentInfo.IsIE || agentInfo.IsIE11) {
			try {
				if (!pe_bC.pe_jZ()) {
					var pe_mK = pe_bC.pe_cQ();
					if (!pe_mK) {
						t._oThis.pe_dy().focus();
						if (t._oThis.pe_ku != null) {
							pe_bC.sel = pe_bC.getSelection();
							pe_bC.range = t._oThis.pe_ku;
							pe_bC.pe_bM();
						}
					}
				}
			} catch (e) {
				t._oThis.pe_dy().focus();
			}
		}
		xhr.onload = function() {
			if (xhr.status === 200) {
				var param = JSON.parse(xhr.responseText);
				if (param != null) {
					var result, addmsg, pe_ake = "";
					result = param.result;
					addmsg = JSON.stringify(param.addmsg);
					if (addmsg != null && addmsg.length > 0) {
						pe_ake = addmsg.substring(addmsg.indexOf('\x5b') + 1,
								addmsg.lastIndexOf('\x5d'));
					}
				}
				var pe_bR;
				pe_bR = t._oThis.getSelection();
				var sel = pe_bR.sel = pe_bR.getSelection();
				var range = pe_bR.range = pe_bR.pe_bY();
				if (agentInfo.IsIE) {
					sel = pe_bR.pe_Fh();
					range = pe_bR.pe_Fj(sel);
				}
				if (agentInfo.IsIE10 || agentInfo.IsIE11) {
					var pe_cp = range.cloneRange();
					var lastP;
					if (t._oThis.getDocument().body
							&& t._oThis.getDocument().body.lastElementChild
							&& t._oThis.getDocument().body.lastElementChild.nodeName == "\x50") {
						lastP = t._oThis.getDocument().body.lastElementChild;
					} else {
						var newP = t._oThis.getDocument().createElement("\x50");
						t._oThis.getDocument().body.appendChild(newP);
						lastP = newP;
					}
					pe_cp.selectNodeContents(lastP);
					pe_cp.collapse(false);
					sel.removeAllRanges();
					sel.addRange(pe_cp);
				}
				setInsertImageFile(result, pe_ake);
			} else {
			}
		};
		xhr.send(pe_cA);
	}
};
function pe_aE() {
	pe_X("\x49\x6d\x61\x67\x65\x45\x64\x69\x74\x6f\x72").upload();
};
function pe_aA() {
	pe_X("\x49\x6d\x61\x67\x65\x45\x64\x69\x74\x6f\x72").close();
};
var pe_aac = true;
function photoEditorImageUploadCompleteHandler(result, pe_awS, pe_awQ, pe_alI,
		pe_aci) {
	pe_aac = false;
	eval("\x76\x61\x72\x20\x70\x65\x5f\x62\x4c\x20\x3d\x20" + pe_aci);
	var pe_aoZ = "\x63\x6c\x6f\x73\x65";
	if (pe_alI > 1 && pe_awS + pe_awQ != pe_alI)
		pe_aoZ = "\x63\x6f\x6e\x74\x69\x6e\x75\x65";
	opener.setInsertImageFile(pe_bL.result, pe_bL.addmsg, pe_aoZ);
	pe_aac = true;
};
function photoEditorSlideshowUploadCompleteHandler(result, pe_aci, flashVars) {
	if (result == "\x73\x75\x63\x63\x65\x73\x73") {
		var addmsg = {};
		addmsg.imageURL = opener.pe_sE + opener.NamoSE.pe_cy.pe_aHG;
		addmsg.imageTitle = "\x73\x6c\x69\x64\x65\x73\x68\x6f\x77";
		addmsg.imageKind = "\x70\x68\x6f\x74\x6f\x45\x64\x69\x74\x6f\x72\x53\x6c\x69\x64\x65\x73\x68\x6f\x77";
		addmsg.imageWidth = "\x38\x30\x30";
		addmsg.imageHeight = "\x36\x30\x30";
		addmsg.imageOrgPath = "";
		addmsg.flashVars = (typeof flashVars == "\x73\x74\x72\x69\x6e\x67") ? flashVars
				: "";
		addmsg.editorFrame = opener.pe_asR;
		opener.setInsertImageFile(result, addmsg);
	} else {
		eval("\x76\x61\x72\x20\x70\x65\x5f\x62\x4c\x20\x3d\x20" + pe_aci);
		opener.setInsertImageFile(pe_bL.result, pe_bL.addmsg);
	}
	return;
};
var pe_aoH;
function closePhotoEditor() {
	var pe_aBq = function() {
		if (pe_aac)
			window.close();
	};
	var pe_aEj = function() {
		window.clearInterval(pe_aoH);
		window.close();
	};
	window.setTimeout(pe_aEj, 1000);
	pe_aoH = window.setInterval(pe_aBq, 50);
};
function pe_X(pe_asT) {
	if (navigator.appName.indexOf("\x4d\x69\x63\x72\x6f\x73\x6f\x66\x74") != -1
			&& parseInt(
					navigator.userAgent.toLowerCase().match(/msie (\d+)/)[1],
					10) < 9) {
		return window[pe_asT];
	} else {
		return document[pe_asT];
	}
}
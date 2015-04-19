/**
 * 
 */

var async = {
	munsi : {},
	util : {}
};

async.munsi.navigate = function(gndStr) {
	alert(gndStr);
};


async.munsi.ajaxCall = function(urlPath,dataJSON,embedInElement){
	async.loadingDialog.showPleaseWait();
	$.ajax({
		type: "POST",
		url: urlPath,
		data: dataJSON,
		dataType: 'html'
		})
		.done(function( data ) {
			$("#"+embedInElement).html(data);
			async.loadingDialog.hidePleaseWait();
		})
		.fail(function() {
			async.loadingDialog.hidePleaseWait();
			console.error( "error in fetching data from server....." );
		});

};

async.loadingDialog = (function () {
    var pleaseWaitDiv = $('<div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false"><div class="modal-dialog" style="width:350px"><div class="modal-content" style="border-radius:8px"><div class="modal-header"><h3>Processing...</h3></div><div class="modal-body"><div class="progress progress-striped active"><div class="progress-bar progress-bar-blue" style="width: 100%;"></div></div></div></div></div></div>');
    return {
        showPleaseWait: function() {
            pleaseWaitDiv.modal();
        },
        hidePleaseWait: function () {
            pleaseWaitDiv.modal('hide');
        },

    };
})();

async.renderPage = function(pageName){
	var URL = "hello.action";
	var DATA = {reqPage:pageName};
	var embedInElement = "id_EmbedPage";
	async.munsi.ajaxCall(URL,DATA,embedInElement);
}
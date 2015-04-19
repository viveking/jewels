var g_isDirty=false;

$(function(){

	$("#sidebar").click(function(event) {
		
		if ($(event.target).is("li")){
			var hrefEle  = $(event.target).find("[data-href]");
			alert("clicked: " + hrefEle.data("href"));
		}
		else{
			if(g_isDirty){
				bootbox.dialog({
					message: "It looks like you have been editing something -- if you leave before submitting your changes will be lost.", 
					title: "<span class='red'>Validation Prompt</span>",
					buttons: {
						success : {
							label : "Leave Page",
							className: "btn-sm btn-primary",
							 callback: function() {

									var hrefEle  = $(event.target).closest("li").find("[data-href]");
									g_isDirty=false;
									if (hrefEle.data("href")){
										$("#sidebar li").removeClass("active");
										console.log("clicked: " + hrefEle.data("href"));
										var parentLi = hrefEle.closest("li");
										 parentLi.addClass("active");
										var URL = "hello.action";
										var DATA = {reqPage:hrefEle.data("href")};
										var embedInElement = "id_EmbedPage";

										async.munsi.ajaxCall(URL,DATA,embedInElement);
									}

							  }
						},
					    danger: {
					      label: "Cancel",
					      className: "btn-sm btn-danger"
					    }
					}
				});
			}else{

				var hrefEle  = $(event.target).closest("li").find("[data-href]");
				g_isDirty=false;
				if (hrefEle.data("href")){
					$("#sidebar li").removeClass("active");
					console.log("clicked: " + hrefEle.data("href"));
					var parentLi = hrefEle.closest("li");
					 parentLi.addClass("active");
					var URL = "hello.action";
					var DATA = {reqPage:hrefEle.data("href")};
					var embedInElement = "id_EmbedPage";

					async.munsi.ajaxCall(URL,DATA,embedInElement);
				}

			}
		}
	});


	//-------------------------------------------
	//----------------- HotKeys -----------------
	//-------------------------------------------
	
	//-----> press g for setting focus on jqgrid
	$(document).bind('keydown', 'Alt+m', function(){
	    $("#sidebar-collapse").click();
    });
	

});

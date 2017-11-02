$(document).ready(function () {
	$(".nav li").on("click", function() {
		$("li").removeClass("active");
		$(this).addClass("active");
	});
})


$(function () {
	$(".js-next").on("click", function() {
		var nextId = parseInt($(".js-next").attr("data-id")) + 1;
		$.get("/outfits/" + nextId + ".json", function(data) {
			$(".title").text(data["title"]);
			$(".season").text(data["season"]["title"]);
			$(".js-next").attr("data-id", data["id"]);
		});
	});
}); 
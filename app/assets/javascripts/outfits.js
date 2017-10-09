$(function () {

	$(".js-next").on("click", function() {
		var nextId = parseInt($(".js-next").attr("data-id")) + 1;
		$.get("/outfits/" + nextId + ".json", function(data) {
			$(".title").text(data["title"]);
			$(".season").text(data["season"]["title"]);
			$(".clothing-items").html("")
			data.items.forEach(function(item) {
				$('.clothing-items').append(`<li>
					<a href="/outfits/${data.id}/items/${item.id}">${item.title}</a> - 
					<a rel="nofollow" data-method="delete" href="/item_outfits/1?item=${item.id}&amp;outfit=${data.id}">Remove from Outfit</a>
					</li>
					`)
			})
			$(".js-next").attr("data-id", data["id"]);
		});
	});

	var user_id = parseInt($("#user_id").attr("data-id"))
	$.get('/users/' + user_id + '/outfits.json', function(data) {
		$(".outfits").empty();
		data.forEach(function(outfit) {
			$(".outfits").append(
				`<li> 
				${outfit.season.title} - 
				<a href="/outfits/${outfit.id}">${outfit.title}</a>
				</li>`
				)
		})
	})
}); 



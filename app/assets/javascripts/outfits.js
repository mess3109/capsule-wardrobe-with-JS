$(function () {

	$(".js-next").on("click", function() {
		var nextId = parseInt($(".js-next").attr("data-id")) + 1;
		$.get("/outfits/" + nextId + ".json", function(outfit) {
			$(".title").text(outfit["title"]);
			$(".season").text(outfit["season"]["title"]);
			$(".clothing-items").html("")
			outfit.items.forEach(function(item) {
				appendClothingItem(item, outfit)
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

	$('form').submit(function(event) {
		event.preventDefault();
		var values = $(this).serialize();
		$.post('/item_outfits', values).done(function (data){
			console.log(data)
			alert('click')
			debugger

			// appendClothingItem(item, outfit)
		});

	})

}); 

function appendClothingItem(item, outfit) {
	$('.clothing-items').append(`<li>
		<a href="/outfits/${outfit.id}/items/${item.id}">${outfittitle}</a> - 
		<a rel="nofollow" data-method="delete" href="/item_outfits/1?item=${item.id}&amp;outfit=${outfit.id}">Remove from Outfit</a>
		</li>
		`)
}



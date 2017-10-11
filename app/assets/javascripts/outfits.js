$(document).ready(function () {
	$(".js-next").on("click", function() {
		var nextId = parseInt($("#outfit_id").attr("data-id")) + 1;
		currentClothingItems(nextId)
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

	$('.delete_url').on("click",function(event) {
		event.preventDefault();
		alert('click')
		console.log(this)
		debugger
		// $(`#${}`).remove();
	})

//shows all clothing items in outfit on outfit show page
currentClothingItems(parseInt($("#outfit_id").attr("data-id")))

}); 

function appendClothingItem(item, outfit) {
	$('.clothing-items').append(`<li id="${item.id}">
		<a href="/outfits/${outfit.id}/items/${item.id}">${item.title}</a> - 
		<a rel="nofollow" class="delete_url" data-method="delete" href="/item_outfits/1?item=${item.id}&amp;outfit=${outfit.id}">Remove from Outfit</a>
		</li>
		`)
}

function currentClothingItems(outfit_id) {
	$.get("/outfits/" + outfit_id + ".json", function(outfit) {
		$(".title").text(outfit["title"]);
		$(".season").text(outfit["season"]["title"]);
		$(".clothing-items").html("")
		outfit.items.forEach(function(item) {
			appendClothingItem(item, outfit)
		})
		$("#outfit_id").attr("data-id", outfit["id"]);
		$( "input[name='outfit_id']" ).val(outfit["id"])
	});
}





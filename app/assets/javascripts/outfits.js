$(document).ready(function () {
	$(".js-next").on("click", function() {
		var nextId = parseInt($("#outfit_id").attr("data-id")) + 1;
		currentClothingItems(nextId)
		showItemsNotUsed(nextId)
	});

	//get request of outfits for index page
	var user_id = parseInt($("#user_id").attr("data-id"))
	$.get('/users/' + user_id + '/outfits.json', function(data) {
		$(".outfits").empty();
		data.forEach(function(outfit) {
			outfit = new Outfit(outfit.id, outfit.title, outfit.season, outfit.items)
			$(".outfits").append(outfit.createOutfitLink())
		})
	})

	//shows all clothing items in outfit on outfit show page
	let outfit_id = parseInt($("#outfit_id").attr("data-id"))
	currentClothingItems(outfit_id)
	showItemsNotUsed(outfit_id)

}); 

//adds clothing item to list of clothing items for given outfit
function appendClothingItem(item, outfit) {
	$('.clothing-items').append(`<li id="item-${item.id}">
		<a href="/outfits/${outfit.id}/items/${item.id}">${item.title}</a> - 
		<a rel="nofollow" class="delete-url" id="item-${item.id}" data-method="delete" href="/item_outfits/${outfit.id}?item=${item.id}&amp;outfit=${outfit.id}">Remove from Outfit</a>
		</li>
		`)
	$(".delete-url").on('click', function(event) {
		$(`#${this.id}`).remove();

	})
}

//get request for clothing items in a given outfit
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

function showItemsNotUsed(outfit_id) {
	$("#items_not_in_outfit").html("");
	$.get("/outfits/" + outfit_id + "/items_not_used.json", function(items) {
		items.forEach(function(item) {
			$("#items_not_in_outfit").append(`
				<li id="item-${item.id}"> 
				<a href="/items/${item.id}">${item.title} </a> - ${item.category.title} - 
				<form>
				<input type="hidden" name="item_id" value="${item.id}">
				<input type="hidden" name="outfit_id" value="${outfit_id}">
				<input type="submit" value="Add Clothing item">
				</form></li>
				`)
		})

		//adds event listener to add clothing item to outfit via post request
		$('form').submit(function(event) {
			event.preventDefault();
			var values = $(this).serialize();
			$.post('/item_outfits', values).done(function (itemOutfit) {
				$(`#item-${itemOutfit.item.id}`).remove();
				appendClothingItem(itemOutfit.item, itemOutfit.outfit);

			});
		})
	});
}

//JS model object
function Outfit(id, title, season, items) {
	this.id = id
	this.title = title
	this.season = season
	this.items = items
}

Outfit.prototype.createOutfitLink = function() {
	let outfitLink = `<li> 
	${this.season.title} - 
	<a href="/outfits/${this.id}">${this.title}</a>
	</li>`
	return outfitLink
}


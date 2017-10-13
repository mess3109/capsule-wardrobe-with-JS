$(document).ready(function () {
	let user_id = parseInt($("#user_id").attr("data-id"))

	$(".js-next").on("click", function() {
		let outfit_id = parseInt($("#outfit_id").attr("data-id"))
		$.get('/users/' + user_id + '/outfits.json', function(data) {
			data.sort(function(a,b) {return a.id - b.id});
			console.log(data)
			for (var i = 0; i < data.length; i++) {
				if (data[i].id === outfit_id) {
					let nextId = data[i + 1].id;
					currentClothingItems(nextId)
					showItemsNotUsed(nextId)
				}  else if (data[data.length-1].id === outfit_id){
					alert('No more outfits!')
					break;
				}
			}
		})
	});

	//creates outfit preview on index page
	$(document).on('click', '.outfit-show', function(e){
		e.preventDefault()
		let id = $(this).attr("data-id")
		$.get(`/outfits/${id}.json`)
		.done(function(outfit) {
			$('.outfit-show-spec').empty()
			$('.outfit-show-spec').append(`<h4>${outfit.title}</h4>`)
			outfit.items.forEach(function(item) {
				$('.outfit-show-spec').append(`${item.title}<br>`)
			})
			$('.outfit-show-spec').append(`<p><a href="/outfits/${outfit.id}">See more detail...</a></p>`)
		})
	})

	//get request of outfits for index page
	$.get('/users/' + user_id + '/outfits.json', function(data) {
		$(".outfits").empty();
		data.forEach(function(outfit) {
			outfit = new Outfit(outfit.id, outfit.title, outfit.season, outfit.items)
			$(".outfits").append(outfit.createOutfitLink())
		})
	})

	let outfit_id = parseInt($("#outfit_id").attr("data-id"))
	
	$(document).on('click', '.delete-url', function(event) {
		$(`#item-${parseInt($(this).attr("data-id"))}`).remove();
		appendClothingItemNotUsed(parseInt($(this).attr("data-id")), outfit_id)
	})

		//adds event listener to add clothing item to outfit via post request
		$(document).on('submit', '.items-not-in-outfit form',  function(event) {
			event.preventDefault();
			var values = $(this).serialize();
			$.post('/item_outfits', values).done(function (itemOutfit) {
				$(`#item-${itemOutfit.item.id}`).remove();
				appendClothingItem(itemOutfit.item, itemOutfit.outfit);
			});
		})
	}); 

//adds clothing item to list of clothing items for given outfit
function appendClothingItem(item, outfit) {
	item = new Item(item.id, item.title, item.category, item.outfits)
	$('.clothing-items').append(item.RemoveClothingItemLink(outfit.id))

}


function appendClothingItemNotUsed(item_id, outfit_id) {
	$.get('/items/' + item_id + '.json', function(item) {
		item = new Item(item.id, item.title, item.category, item.outfits)
		$(".items-not-in-outfit").append(item.AddClothingItemLink(outfit_id))
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
		$(".items-not-in-outfit").html("");
		$.get("/outfits/" + outfit_id + "/items_not_used.json", function(items) {
			items.forEach(function(item) {
				item = new Item(id, title, category, outfits)
				// $(".items-not-in-outfit").append(`
				// 	<li id="item-${item.id}"> 
				// 	<a href="/items/${item.id}">${item.title} </a> - ${item.category.title} - 
				// 	<form>
				// 	<input type="hidden" name="item_id" value="${item.id}">
				// 	<input type="hidden" name="outfit_id" value="${outfit_id}">
				// 	<input type="submit" value="Add" class="button">
				// 	</form></li>
				// 	`)
				$(".items-not-in-outfit").append(item.AddClothingItemLink(outfit_id))
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
	<a class="outfit-show" data-id="${this.id}" href="/outfits/${this.id}">${this.title}</a>
	</li>`
	return outfitLink
}



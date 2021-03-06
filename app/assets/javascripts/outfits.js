$(document).ready(function () {

	$(".js-next").on("click", function() {
		let outfit_id = parseInt($("#outfit_id").attr("data-id"))
		$.get('/outfits.json', function(data) {
			data.sort(function(a,b) {return a.id - b.id});
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

	$(".js-prev").on("click", function() {
		let outfit_id = parseInt($("#outfit_id").attr("data-id"))
		$.get('/outfits.json', function(data) {
			data.sort(function(a,b) {return a.id - b.id});
			for (var i = 0; i < data.length; i++) {
				if (data[0].id === outfit_id){
					alert('No more outfits!')
					break;
				} else if (data[i].id === outfit_id) {
					let nextId = data[i - 1].id;
					currentClothingItems(nextId)
					showItemsNotUsed(nextId)
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
	$.get('/outfits.json', function(data) {
		$(".outfits").empty();
		data.forEach(function(outfit) {
			const newOutfit = new Outfit(outfit)
			$(".outfits").append(newOutfit.createOutfitLink())
		})
	})

	let outfit_id = parseInt($("#outfit_id").attr("data-id"))
	
	//adds event listener to shift clothing item after delete request goes through the controller
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
function appendClothingItem(itemAttributes, outfit) {
	var item = new Item(itemAttributes)
	$('.clothing-items').append(item.RemoveClothingItemLink(outfit.id))
}

//adds clothing item to lisst of clothing items not used in given outfit
function appendClothingItemNotUsed(item_id, outfit_id) {
	$.get('/items/' + item_id + '.json', function(itemAttributes) {
		const item = new Item(itemAttributes)
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

//populates items not used on outfits show page
function showItemsNotUsed(outfit_id) {
	$(".items-not-in-outfit").html("");
	$.get("/outfits/" + outfit_id + "/items_not_used.json", function(items) {
		items.forEach(function(itemAttributes) {
			const item = new Item(itemAttributes)
			$(".items-not-in-outfit").append(item.AddClothingItemLink(outfit_id))
		})
	});
}

//JS model object
function Outfit(attributes) {
	for (var key in attributes) {
		this[key] = attributes[key]
	}
}

//link to outfit show page from outfit index page
Outfit.prototype.createOutfitLink = function() {
	let outfitLink = `<li> 
	${this.season.title} - 
	<a class="outfit-show" data-id="${this.id}" href="/outfits/${this.id}">${this.title}</a>
	</li>`
	return outfitLink
}



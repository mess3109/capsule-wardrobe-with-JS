
$(document).ready(function () {
		//creates item preview on index page
		$(document).on('click', '.item-show', function(e){
			e.preventDefault()
			let id = $(this).attr("data-id")
			$.get(`/items/${id}.json`)
			.done(function(item) {
				$('.item-show-spec').empty()
				$('.item-show-spec').append(`<h4>${item.title}</h4>`)
				$('.item-show-spec').append(`<p><a href="/items/${item.id}">See more detail...</a></p>`)
			})
		})

	})



function Item(id, title, category, outfits) {
	this.id = id
	this.title = title
	this.category = category
	this.outfits = outfits
}


Item.prototype.RemoveClothingItemLink = function(outfit_id) {
	let link = `<li id="item-${this.id}">
	<a href="/outfits/${outfit_id}/items/${this.id}">${this.title}</a> - ${this.category.title}
	<a rel="nofollow" class="delete-url" data-id="${this.id}" data-method="delete" href="/item_outfits/${outfit_id}?item=${this.id}&amp;outfit=${outfit_id}">Remove</a>
	</li>
	`
	return link
}

Item.prototype.AddClothingItemLink = function(outfit_id) {
	let link = `<li id="item-${this.id}"> 
	<a href="/items/${this.id}">${this.title} </a> - ${this.category.title} - 
	<form>
	<input type="hidden" name="item_id" value="${this.id}">
	<input type="hidden" name="outfit_id" value="${outfit_id}">
	<input type="submit" value="Add" class="button">
	</form></li>
	`
	return link
}

Item.prototype.createItemLink = function() {
	let itemLink = `<li> 
	${this.category.title} - 
	<a class="item-show" data-id="${this.id}" href="/items/${this.id}">${this.title}</a>
	</li>`
	return itemLink
}

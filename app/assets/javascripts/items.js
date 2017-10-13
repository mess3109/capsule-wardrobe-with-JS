function Item(id, title, category, outfits) {
	this.id = id
	this.title = title
	this.category = category
	this.outfits = outfits
}


// Item.prototype.RemoveClothingItemLink(outfit_id) {
// 	let link = `<li id="item-${this.id}">
// 	<a href="/outfits/${outfit_id}/items/${this.id}">${this.title}</a> - 
// 	<a rel="nofollow" class="delete-url" data-id="${this.id}" id="item-${this.id}" data-method="delete" href="/item_outfits/${outfit.id}?item=${item.id}&amp;outfit=${outfit.id}">Remove from Outfit</a>
// 	</li>
// 	`
// 	return link
// }
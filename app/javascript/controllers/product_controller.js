import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["quantity", "sku", "addToCartButton" ]

  add_to_cart(event) {
    event.preventDefault();
    let product_id = this.data.get("id");
    let quantity = this.quantityTarget.value;
    let sku = this.skuTarget.value;

    if (quantity > 0) {
      this.addToCartButtonTarget.classList.add('is-loading');
      let data = new FormData();
      data.append("id", product_id);
      data.append("quantity", quantity);
      data.append("sku", sku);

      Rails.ajax({
        url: '/api/v1/cart',
        data,
        type: 'POST',
        dataType: 'json',
        success: (response) => {
          console.log(response);
        },
        error: (error) => {
          console.log(error);
        }
      });
    }
  }

  quantity_minus(event) {
    event.preventDefault();
    let q = Number(this.quantityTarget.value);
    if (q > 1) {
      this.quantityTarget.value = q - 1
    }
  }

  quantity_plus(event) {
    event.preventDefault();
    let q = Number(this.quantityTarget.value);
    this.quantityTarget.value = q + 1
  }
}

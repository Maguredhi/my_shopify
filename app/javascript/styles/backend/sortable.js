import Sortable from 'sortablejs';
import Rails from '@rails/ujs';

document.addEventListener('turbolinks:load', () => {
  let el = document.querySelector('.sortable-items');

  if (el) {
    Sortable.create(el, {
      // onEnd 當放開時抓的是哪一個
      onEnd: event => {
        let [model, id] = event.item.dataset.item.split('_');
        // 用 JS 的 FormData 建立一個假 form 傳進 Rails
        let data = new FormData();
        data.append("id", id)
        data.append("from", event.oldIndex)
        data.append("to", event.newIndex)
        console.log(data);

        Rails.ajax({
          url: '/admin/categories/sort',
          // 不能用 method
          type: 'PUT',
          data,
          success: resp => {
            console.log(resp);
          },
          error: err => {
            console.log(err);
          }
        })
      }
    })
  }
})

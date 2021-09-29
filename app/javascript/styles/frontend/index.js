import './application.scss'
import './google_button.scss'
import bulmaCarousel from 'bulma-carousel';

// render carousel
document.addEventListener('turbolinks:load', () => {
  bulmaCarousel.attach('#carousel', {
    slidesToScroll: 1,
    slidesToShow: 3,
    infinite: true,
    autoplay: true
  });
})

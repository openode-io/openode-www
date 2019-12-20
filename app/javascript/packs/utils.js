import Typed from 'typed.js'

document.addEventListener("turbolinks:load", function() {
  const el = document.querySelector('.typed');

  if (el){
    new Typed('.typed', {
      strings: ["Fast","^1500 Open","^1500 Advanced", "^1500 Frictionless"],
      typeSpeed: 80
    });
  }
})
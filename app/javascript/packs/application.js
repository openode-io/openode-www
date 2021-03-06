// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '../stylesheets/application'
import './bootstrap_custom.js'
import '../utils/utils.js'

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'

// Import all the macro components of the application
import * as instances from '../instances_public'

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()

Vue.use(TurbolinksAdapter)
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

document.addEventListener('turbolinks:load', function () {
  /* Vue Settings */
  Object.keys(instances).forEach((instanceName) => {
    const instance = instances[instanceName]
    const elements = document.querySelectorAll(instance.el)

    elements.forEach((element) => {
      const props = JSON.parse(element.getAttribute('data-props'))

      new Vue({
        el: element,
        render: h => h(instance.component, { props })
      })
    })
  })
})

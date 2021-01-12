// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '../stylesheets/admin'
import './bootstrap_custom.js'
import '../utils/utils.js'

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'

// Import all the macro components of the application
import * as instances from '../instances'

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()

require("chartkick")
require("chart.js")

Vue.use(TurbolinksAdapter)
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

import { createConsumer } from '@rails/actioncable'
let activeConsumers = []

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

    const scrollableItems = document.getElementsByClassName("scroll-down");

    for (const scrollableItem of scrollableItems) {
     scrollableItem.scrollTop = scrollableItem.scrollHeight; 
    }

    const streamedElements = document.getElementsByClassName("ws-stream");

    for (const streamedElement of streamedElements) {
      const token = streamedElement.getAttribute('data-stream-token')
      const params = JSON.parse(streamedElement.getAttribute('data-stream-parameters'))

      if (!activeConsumers.includes(JSON.stringify(params))) {
        const webSocketConsumer = createConsumer(`wss://api.openode.io/streams?token=${token}`)

        webSocketConsumer.subscriptions.create(params, {
          received(data) {
            // specific to deployment, if more consumer, refactor!
            consumeDeploymentsChannel(data)
          }
        })

        activeConsumers.push(JSON.stringify(params))
      }
    }

  })
})


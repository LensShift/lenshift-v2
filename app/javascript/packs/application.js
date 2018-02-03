/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import navbar from '../components/navbar'
import footer from '../components/footer'
import lensShifterProfileForm from '../components/lensShifterProfileForm'
import resourceDocForm from '../components/resourceDocForm'
import resourceItemForm from '../components/resourceItemForm'
import resourceList from '../components/resourceList'

document.addEventListener('DOMContentLoaded', () => {
  // document.body.appendChild(document.createElement('app'))
  
  // Vue.component('app-navbar', navbar)
  // Vue.component('app-footer', footer)

  Vue.filter('truncate', function(text, stop, clamp) {
    return text.slice(0, stop) + (stop < text.length ? clamp || '...' : '')
  })

  const app = new Vue({
  	el: '#app',
  	components: {
  		'app-navbar': navbar,
  		'app-footer': footer,
      'lens-shifter-profile-form': lensShifterProfileForm,
      'resource-doc-form': resourceDocForm,
      'resource-item-form': resourceItemForm,
      'resource-list': resourceList
  	}
  	// render: h => h(App)
  })

  console.log(app)
})

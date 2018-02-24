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
import lensShifterProfileForm from '../components/lensShifterProfileForm'
import resourceDocForm from '../components/resourceDocForm'
import resourceItemForm from '../components/resourceItemForm'
import resourceList from '../components/resourceList'
import streamNew from '../components/streamNew'
import streamForm from '../components/streamForm'
import streamFellowShow from '../components/streamFellowShow'
import streamShow from '../components/streamShow'
import streamList from '../components/streamList'
import sideMenu from '../components/sideMenu'
import streamEdit from '../components/streamEdit'
import resourceFellowList from '../components/resourceFellowList'
import streamFellowList from '../components/streamFellowList'

document.addEventListener('DOMContentLoaded', () => {
  // document.body.appendChild(document.createElement('app'))
  
  // Vue.component('app-navbar', navbar)
  // Vue.component('app-footer', footer)

  Vue.filter('truncate', function(text, stop, clamp) {
    return text.slice(0, stop) + (stop < text.length ? clamp || '...' : '')
  })

  var draggable = require('vuedraggable')
  Vue.use(draggable);
  Vue.use(require('vue-moment'));
  var velocity = require('velocity-animate');

  const app = new Vue({
  	el: '#app',
    data() {
      return {
        scrollPosition: 0,
        navPosition: ''
      }
    },
  	components: {
      'lens-shifter-profile-form': lensShifterProfileForm,
      'resource-doc-form': resourceDocForm,
      'resource-item-form': resourceItemForm,
      'resource-list': resourceList,
      'stream-new': streamNew,
      'stream-form': streamForm,
      'stream-fellow-show': streamShow,
      'stream-list': streamList,
      'stream-show': streamShow,
      'stream-edit': streamEdit,
      'side-menu': sideMenu,
      'resource-fellow-list': resourceFellowList,
      'stream-fellow-list': streamFellowList
  	},
    created() {
      console.log('I am created', document.body)
      window.onscroll = function(e) {

        var currentScrollPosition = e.srcElement.scrollingElement.scrollTop;
        // console.log('scrolling', currentScrollPosition)
        if (currentScrollPosition > this.scrollPosition && currentScrollPosition > 75) {
         document.getElementById('ls-top-bar').classList.add('nav-up');
        } else {
         document.getElementById('ls-top-bar').classList.remove('nav-up')
        }
        this.scrollPosition = currentScrollPosition;
      }
      
    },
    destroyed() {
      document.body.removeEventListener('scroll', this.handleScroll);
    }
  	// render: h => h(App)
  })

  console.log(app)
})

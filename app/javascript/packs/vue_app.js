/* eslint no-console: 0 */

import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import TodoList from '../todo-list.vue'

document.addEventListener('DOMContentLoaded', () => {
  const vm = new Vue({
    el: '#root',
    components: {
      'app': App,
      'todo-list': TodoList,
    }
  })
})

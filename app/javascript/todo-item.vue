<template>
  <li class="todo-item" :id="'todo-item-' + item.id">
    <label v-bind:for="'checkbox-' + item.id">{{ item.attributes.title }}</label>
      <input type="checkbox" v-bind:id="'checkbox-' + item.id" v-model="item.attributes.completed" v-on:change="toggle">
    </label>
    <button v-on:click="deleteItem">Delete</button>
  </li>
</template>

<script>
const NProgress = require('nprogress');
const axios = require('axios');
axios.interceptors.request.use(config => {
  NProgress.start()
  return config
})
axios.interceptors.response.use(response => {
  NProgress.done()
  return response
})

export default {
  props: {
    item: Object,
    list: String
  },
  methods: {
    deleteItem: function (event) {
      const url = this.todoPath(this.item);
      axios
        .delete(url)
        .then(response => {
          this.$emit("todo-deleted", this.item)
        })
        .catch(response => {
          error => alert(error)
        })
    },
    toggle: function (event) {
      const url = this.todoPath(this.item);
      const completed = this.item.attributes.completed == true ? 1 : 0;
      const data = { item: { completed: completed }};
      axios
        .patch(url, data)
        .catch(error => alert(error))
    },
    todoPath: function(item) {
      return `/api/v1/lists/${this.list}/items/${item.id}.json`;
    }
  }
}
</script>

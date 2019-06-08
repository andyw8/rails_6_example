<template>
  <div id="new-todo-item">
    <label>Title
      <input id="title" v-model="title">
    </label>
    <button id="add" v-on:click="addItem">Add Item</button>
  </div>
</template>

<script>
const axios = require('axios');

export default {
  data: function() {
    return {
      title: ""
    }
  },
  methods: {
    addItem: function (event) {
      const data = { item: { title: this.title }};
      const url = "/items";
      var vm = this;
      axios
        .post(url, data)
        .then(response => { 
          this.$emit("todo-added", response.data.data)
          this.title = "";
        })
        .catch(error => console.log(error))
    }
  },
  mounted () {
    console.log(this);
  }
}
</script>

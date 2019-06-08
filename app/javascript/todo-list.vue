<template>
  <div>
    <div>
      Items: {{ itemCount() }}
      <ul>
        <todo-item v-for="item in items" v-bind:item="item" v-on:todo-deleted="remove"/>
      </ul>
      <new-todo-item v-on:todo-added="add"></new-todo-item>
    </div>
  </div>
</template>

<script>
import TodoItem from 'todo-item.vue';
import NewTodoItem from 'new-todo-item.vue';

const axios = require('axios');

export default {
  components: {
    'todo-item': TodoItem,
    'new-todo-item': NewTodoItem,
  },
  data: function () {
    return {
      info: null,
      items: []
    }
  },
  methods: {
    add: function(todo) {
      this.items.push(todo)
    },
    remove: function(todo) {
      for( var i = 0; i < this.items.length; i++){ 
        if ( this.items[i].id === todo.id) {
          this.items.splice(i, 1); 
          return;
        }
      }
    },
    itemCount: function() {
      return this.items.length;
    }
  },
  mounted () {
    axios
      .get('/api/v1/items.json')
      .then(response => (this.items = response.data.data))
  }
}
</script>

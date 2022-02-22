<template>
  <div class="container ml10 mt10 mb10 text-sm">
    <span v-for="(item, id) in items" :key="id">
      <template v-if="item.url">
        <nuxt-link :to="item.url"
          ><span>{{ item.name }}</span></nuxt-link
        >
      </template>
      <template v-else>
        <span>{{ item.name }}</span>
      </template>
      <span v-if="!isLastIndex(id)"> > </span>
    </span>
  </div>
</template>

<script>
export default {
  components: {},
  props: {
    items: {
      type: Array,
      required: true,
    },
  },
  methods: {
    isLastIndex(index) {
      return this.items.length - 1 === index
    },
  },
}
</script>

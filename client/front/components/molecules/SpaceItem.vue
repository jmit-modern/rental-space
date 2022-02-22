<template>
  <div class="border text-xs mx-1 bg-light hover:shadow-xl">
    <nuxt-link :to="`/space/${item.id}`">
      <img
        :src="imgUrl"
        alt=""
        class="w-full object-none hover:opacity-80 h-48"
      />
    </nuxt-link>
    <div class="p-4">
      <div
        class="border-b border-secondary pb-2 mb-4 h-14 text-primary font-bold"
      >
        <nuxt-link :to="`/space/${item.id}`">{{ item.name }}</nuxt-link>
      </div>
      <div class="flex items-center pb-1">
        <outline-user-icon class="w-5 h-5 mr-3" stroke="#000" />
        <span>～ {{ item.capacity }}人</span>
      </div>
      <div class="flex items-center pb-1">
        <outline-location-marker-icon class="w-5 h-5 mr-3" stroke="#000" />
        <span class="whitespace-nowrap overflow-hidden overflow-ellipsis">{{
          item.address1
        }}</span>
      </div>
      <div class="flex items-center pb-1">
        <span class="font-bold text-base w-5 text-center mr-3">¥</span>
        <span>{{ item.price }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  props: {
    item: {
      type: Object,
      default: null,
    },
  },
  computed: {
    imgUrl() {
      return this.item.featuredImage && this.item.featuredImage.url
        ? this.item.featuredImage.url
        : require('~/assets/image/not-found.png')
    },
  },
}
</script>

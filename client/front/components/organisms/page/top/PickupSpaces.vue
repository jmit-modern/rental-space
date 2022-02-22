<template>
  <div class="px-4">
    <div class="pt-20 text-center text-3xl font-bold mb-12 text-primary">
      {{ $t('top.pickupSpace.title') }}
    </div>
    <vue-slick-carousel v-if="pickupSpaces.length" v-bind="options">
      <div v-for="(item, index) in pickupSpaces" :key="index">
        <space-item :item="item" />
      </div>
    </vue-slick-carousel>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import VueSlickCarousel from 'vue-slick-carousel'
import 'vue-slick-carousel/dist/vue-slick-carousel.css'
// optional style for arrows & dots
import 'vue-slick-carousel/dist/vue-slick-carousel-theme.css'
import SpaceItem from '@/components/molecules/SpaceItem'

export default {
  components: { VueSlickCarousel, SpaceItem },
  data() {
    return {
      options: {
        dots: true,
        infinite: true,
        autoplay: true,
        rows: 1,
        initialSlide: 2,
        speed: 500,
        slidesToShow: 4,
        slidesToScroll: 1,
        swipeToSlide: true,
        arrows: true,
      },
    }
  },
  async fetch() {
    await Promise.all([
      this.$store.dispatch('top/fetchPickupSpaces', { limit: 7 }),
    ])
  },
  computed: {
    ...mapGetters({
      pickupSpaces: 'top/pickupSpaces',
    }),
  },
}
</script>

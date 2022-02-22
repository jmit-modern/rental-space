<template>
  <div>
    <CoolLightBox
      :items="images"
      :index="index"
      :use-zoom-bar="true"
      @close="index = null"
    >
    </CoolLightBox>

    <div class="images-wrapper relative">
      <div
        class="w-full h-96 rounded-xl bg-center bg-no-repeat bg-local bg-cover"
        :style="{ backgroundImage: 'url(' + images[0] + ')' }"
      ></div>
      <div
        class="
          bg-main
          absolute
          border-2 border-orange
          rounded-lg
          py-1
          px-3
          right-2
          bottom-2
          cursor-pointer
          text-orange
          hover:bg-orange hover:text-main
        "
        @click="index = 0"
      >
        写真を見る <span v-if="imageCount > 1">({{ imageCount }})</span>
      </div>
    </div>
  </div>
</template>

<script>
import CoolLightBox from 'vue-cool-lightbox'
import 'vue-cool-lightbox/dist/vue-cool-lightbox.min.css'

export default {
  components: {
    CoolLightBox,
  },
  props: {
    images: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      index: null,
    }
  },
  computed: {
    imageCount() {
      return this.images.length
    },
  },
}
</script>

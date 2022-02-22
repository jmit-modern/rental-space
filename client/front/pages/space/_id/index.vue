<template>
  <div class="pt-20 max-w-7xl mx-auto">
    <div class="mb-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <!-- Image Section -->
    <section v-if="spaceImages.length">
      <ImageBox :images="spaceImages" />
    </section>
    <!-- End: Image Section -->

    <!-- Space Content Section -->
    <section class="flex mt-10 space-x-5 items-start">
      <div class="w-0 flex-1 overflow-hidden">
        <SpaceContent :space="space" />
      </div>
      <div class="w-80 sticky top-10">
        <SpaceReserve :space="space" />
      </div>
    </section>
    <!-- End:Space Content Section -->
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import SpaceReserve from '@/components/organisms/page/space/Reserve'
import SpaceContent from '@/components/organisms/page/space/Content'
import ImageBox from '@/components/organisms/ImageBox'

export default {
  components: {
    SpaceContent,
    SpaceReserve,
    ImageBox,
    Breadcrumb,
  },
  data() {
    return {
      images: [],
    }
  },
  async fetch() {
    const { params } = this.$route
    await this.$store.dispatch('space/fetchDetail', params)
    this.images = this.space.spaceImages
  },
  computed: {
    ...mapGetters({
      space: 'space/detail',
    }),
    spaceImages() {
      return this.images.map((item) => item.url) || []
    },
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: this.$t('top.breadcrumb'),
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: this.$t('space.breadcrumb'),
          url: this.localeRoute({ name: 'space' }),
        },
        {
          id: 3,
          name: this.$t('space.detail.breadcrumb'),
        },
      ]
      return items
    },
  },
}
</script>
<style lang="scss">
table {
  border-color: red;
}
</style>

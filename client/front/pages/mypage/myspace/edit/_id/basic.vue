<template>
  <div v-if="!$fetchState.pending">
    <SpaceForm :data="inputs" form-type="edit" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SpaceForm from '@/components/organisms/templates/mypage/myspace/Form'

export default {
  components: {
    SpaceForm,
  },
  data() {
    return {
      inputs: {
        spaceImages: [],
      },
    }
  },
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('space/fetchDetail', { id })])
    this.inputs = { ...this.space }
  },
  computed: {
    ...mapGetters({
      space: 'space/detail',
    }),
  },
}
</script>

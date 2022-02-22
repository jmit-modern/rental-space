<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8">
          <div class="text-xl">{{ $t('mypage.mySpace.spaceEdit') }}</div>
        </div>
        <TabLinks :tabs="tabItems" />
        <nuxt-child />
      </div>
    </mypage-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'

import TabLinks from '@/components/molecules/navigation/TabLinks'

export default {
  components: {
    Breadcrumb,
    MypageLayout,
    TabLinks,
  },
  middleware({ redirect, route, localePath }) {
    if (route.name === localePath({ name: 'mypage-myspace-edit-id' }).name) {
      return redirect(
        localePath({
          name: 'mypage-myspace-edit-id-basic',
          params: { id: route.params.id },
        })
      )
    }
  },
  computed: {
    ...mapGetters({
      space: 'space/detail',
    }),
    id() {
      return this.$route.params.id
    },
    tabItems() {
      return [
        {
          title: this.$t('mypage.mySpace.tabLinks.basic'),
          route: this.localeRoute({
            name: 'mypage-myspace-edit-id-basic',
            params: { id: this.id },
          }),
        },
        {
          title: this.$t('mypage.mySpace.tabLinks.plan'),
          route: this.localeRoute({
            name: 'mypage-myspace-edit-id-plans',
            params: { id: this.id },
          }),
        },
        {
          title: this.$t('mypage.mySpace.tabLinks.facility'),
          route: this.localeRoute({
            name: 'mypage-myspace-edit-id-facilities',
            params: { id: this.id },
          }),
        },
      ]
    },
    breadcrumbs() {
      return [
        {
          id: 1,
          name: this.$t('pages.home'),
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: this.$t('navbar.mypage'),
          url: this.localeRoute({ name: 'mypage' }),
        },
        {
          id: 3,
          name: this.$t('mypage.mySpace.breadcrumb'),
          url: this.localeRoute({ name: 'mypage-myspace' }),
        },
        {
          id: 4,
          name: this.$t('mypage.mySpace.edit'),
        },
      ]
    },
  },
}
</script>

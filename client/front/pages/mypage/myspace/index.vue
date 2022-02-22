<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8 flex justify-between">
          <div class="text-xl">{{ $t('mypage.mySpace.spaceList') }}</div>
          <div>
            <nuxt-link
              to="/mypage/myspace/new"
              class="
                items-center
                px-5
                py-1.5
                border border-transparent
                shadow-sm
                text-base
                font-medium
                rounded-md
                text-main
                bg-orange
                focus:outline-none
                hover:opacity-80
                cursor-pointer
              "
              >{{ $t('form.register') }}</nuxt-link
            >
          </div>
        </div>
        <div v-if="!$fetchState.pending && spaces" class="divide-y">
          <div
            v-for="space in spaces"
            :key="space.id"
            class="flex items-center justify-between p-4"
          >
            <h1 class="font-bold text-lg">{{ space.name }}</h1>
            <div class="flex items-center space-x-2">
              <nuxt-link
                :to="
                  localeRoute({
                    name: 'mypage-myspace-edit-id-basic',
                    params: { id: space.id },
                  })
                "
              >
                <outline-pencil-icon class="w-6 h-6" />
              </nuxt-link>
              <div @click="deleteSpace(space.id)">
                <outline-trash-icon
                  class="w-6 h-6 text-tertiary cursor-pointer"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </mypage-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { filterQueryParams } from '@/utils/http'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import Breadcrumb from '@/components/organisms/Breadcrumb'

export default {
  components: {
    MypageLayout,
    Breadcrumb,
  },
  middleware: ['auth', 'spaceOwner'],
  data() {
    return {
      inputs: {},
    }
  },
  async fetch() {
    const { user } = this.$auth.user
    const params = {
      user_id: user.id,
    }
    const query = filterQueryParams(params)
    await Promise.all([this.$store.dispatch('space/fetch', query)])
  },
  computed: {
    ...mapGetters({
      spaces: 'space/data',
    }),
    breadcrumbs() {
      const items = [
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
          url: null,
        },
      ]
      return items
    },
  },
  methods: {
    async deleteSpace(id) {
      if (confirm('Do you really want to delete?')) {
        await this.$store.dispatch('space/delete', id)
      }
    },
  },
}
</script>

<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8 flex justify-between">
          <div class="text-xl">{{ $t('mypage.myEvent.eventList') }}</div>
          <div>
            <nuxt-link
              to="/mypage/myevent/new"
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
        <div v-if="!$fetchState.pending && myevents" class="divide-y">
          <div
            v-for="event in myevents"
            :key="event.id"
            class="flex items-center justify-between p-4"
          >
            <h1 class="font-bold text-lg">{{ event.name }}</h1>
            <div class="flex items-center space-x-2">
              <nuxt-link
                :to="
                  localePath({
                    name: 'mypage-myevent-edit-id',
                    params: { id: event.id },
                  })
                "
              >
                <outline-pencil-icon class="w-6 h-6" />
              </nuxt-link>
              <div @click="deleteEvent(event.id)">
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
  middleware: 'auth',
  data() {
    return {}
  },
  async fetch() {
    const { user } = this.$auth.user
    const params = {
      user_id: user.id,
    }
    const query = filterQueryParams(params)
    await Promise.all([this.$store.dispatch('event/fetch', query)])
  },
  computed: {
    ...mapGetters({
      events: 'event/data',
    }),
    myevents() {
      return this.events || []
    },
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: 'ホーム',
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: 'マイページ',
          url: this.localeRoute({ name: 'mypage' }),
        },
        {
          id: 3,
          name: 'マイイベント',
          url: null,
        },
      ]
      return items
    },
  },
  methods: {
    async deleteEvent(id) {
      if (confirm('Do you really want to delete?')) {
        await this.$store.dispatch('event/delete', id)
      }
    },
  },
}
</script>

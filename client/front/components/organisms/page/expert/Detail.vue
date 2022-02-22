<template>
  <div>
    <div class="border border-gray-300 rounded">
      <div class="flex px-6 py-4 border-b">
        <img
          class="inline-block h-16 w-16 rounded-full"
          :src="detail.user.photo"
          alt=""
        />
        <div class="ml-4">
          <div class="text-2xl">{{ detail.user.fullName }}</div>
          <div class="flex space-x-4 mt-2">
            <JobSuccess :percent="90" />
            <TopRated />
          </div>
        </div>
      </div>

      <div class="flex divide-x">
        <div class="w-60 divide-y">
          <div class="p-4 bg-blue-50">
            <div class="text-lg mb-4">
              {{
                $t('expert.detail.inviteUser', { name: detail.user.fullName })
              }}
            </div>
            <nuxt-link
              :to="
                localePath({
                  name: 'expert-id-reservation',
                  params: { id: detail.id },
                })
              "
              class="
                flex
                items-center
                justify-center
                bg-orange
                text-main
                p-2
                rounded
              "
            >
              <span>{{ $t('expert.detail.inviteNow') }}</span>
            </nuxt-link>
          </div>
          <div class="p-4">
            <span class="text-lg font-bold">211</span>
            <span class="text-sm">{{ $t('expert.detail.unit') }}</span>
          </div>
        </div>
        <div class="w-0 flex-1 divide-y">
          <div class="p-6 space-y-4">
            <div class="flex items-center justify-between">
              <div class="text-2xl font-bold mr-4 flex-1">
                {{ detail.skillTitle }}
              </div>
              <div class="text-base font-bold flex-initial">
                {{ yen(5000) }} / {{ $t('expert.detail.perHour') }}
              </div>
            </div>
            <div v-html="detail.description"></div>
          </div>
          <div class="p-6">
            <div class="text-lg font-bold mb-6">
              {{ $t('expert.detail.workHistory') }}
            </div>
            <div class="divide-y">
              <div class="space-y-3 py-4">
                <div class="text-lg font-bold">
                  PROFESSIONAL PHOTO RESTORATION NEEDED
                </div>
                <div class="flex items-center">
                  <StarRating :value="4" />
                  <div class="ml-2 text-sm">Jul 2, 2021</div>
                </div>
                <div class="text-sm">
                  "Ievgen is fast, listening, always trying to understand how
                  you as customer exact want the products to look like. He
                  respect you deadline. He is absolutely great to work with!"
                </div>
              </div>
              <div class="space-y-3 py-4">
                <div class="text-lg font-bold">
                  PROFESSIONAL PHOTO RESTORATION NEEDEd
                </div>
                <div class="flex items-center">
                  <StarRating :value="4" />
                  <div class="ml-2 text-sm">Jul 2, 2021</div>
                </div>
                <div class="text-sm">
                  "Ievgen is fast, listening, always trying to understand how
                  you as customer exact want the products to look like. He
                  respect you deadline. He is absolutely great to work with!"
                </div>
              </div>
            </div>
          </div>

          <div class="p-6">
            <div class="text-lg font-bold mb-6">
              {{ $t('expert.detail.skills') }}
            </div>
            <div class="flex mt-4 flex-wrap">
              <span
                v-for="(skill, index) in skills"
                :key="index"
                class="
                  inline-flex
                  items-center
                  px-2.5
                  py-0.5
                  rounded-full
                  text-xs
                  font-medium
                  bg-yellow-100
                  text-yellow-800
                  cursor-default
                  flex-none
                  mb-4
                  mr-2
                "
              >
                {{ skill.name }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { yen } from '@/utils/format'
import TopRated from '@/components/atoms/page/TopRated'
import JobSuccess from '@/components/atoms/page/JobSuccess'
import StarRating from '@/components/atoms/page/StarRating'

export default {
  components: {
    TopRated,
    JobSuccess,
    StarRating,
  },
  props: {
    detail: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {}
  },
  computed: {
    skills() {
      return this.detail.skills || []
    },
  },
  methods: {
    yen(...args) {
      return yen(...args)
    },
  },
}
</script>

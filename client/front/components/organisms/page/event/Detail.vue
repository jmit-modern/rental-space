<template>
  <div>
    <div class="text-xl font-bold mb-5">{{ detail.name }}</div>
    <div class="flex space-x-5 items-start">
      <div class="w-0 flex-1 overflow-hidden">
        <ImageBox v-if="eventImages" :images="eventImages" />

        <div class="mt-6">
          <div class="py-5">
            <div class="text-xl font-bold mb-5">
              {{ $t('event.detail.descTitle') }}
            </div>
            <div v-html="detail.description"></div>
          </div>
          <Divider />
          <!-- Access -->
          <div class="py-5">
            <h3 class="font-bold mb-3 text-lg">
              {{ $t('event.detail.access') }}
            </h3>
            <div class="mb-5">{{ $t('event.detail.mapArea') }}</div>
            <div class="table mb-5 text-sm">
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.location') }}
                </div>
                <div class="">{{ address1 }}</div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.nearestStation') }}
                </div>
                <div class="">{{ address2 }}</div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.access') }}
                </div>
                <div class="">{{ address3 }}</div>
              </div>
            </div>
            <div class="text-right">
              <a href="#">{{ $t('event.detail.checkInGMap') }}</a>
            </div>
          </div>
          <Divider />
          <div class="py-5">
            <h3 class="text-lg font-bold mb-3">
              {{ $t('event.detail.mainInfo') }}
            </h3>
            <div class="table mb-5 text-sm">
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.eventName') }}
                </div>
                <div>{{ detail.name }}</div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.holdingPeriod') }}
                </div>
                <div>
                  {{ formatDate(detail.startingAt) }}〜{{
                    formatDate(detail.endingAt)
                  }}
                </div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.venue') }}
                </div>
                <div>2F「シースケープ テラス・ダイニング」</div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.time') }}
                </div>
                <div>
                  <div>{{ $t('event.detail.timeStart') }}：15:00</div>
                  <div>{{ $t('event.detail.timeEnd') }}：17:00</div>
                  <div>{{ $t('event.detail.duration') }}：120分制</div>
                </div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.contact') }}
                </div>
                <div v-html="detail.contact"></div>
              </div>
              <div class="table-row">
                <div class="table-cell w-36 py-2 text-primary">
                  {{ $t('event.detail.officialSite') }}
                </div>
                <div>
                  <a href="#" target="_blank">スイーツ ウェディング</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="w-80 sticky top-10">
        <div class="border border-orange rounded-sm p-6">
          <div class="mb-5">
            <span class="text-2xl font-bold"
              >￥{{ formatNumber(detail.price) }}</span
            >
          </div>
          <nuxt-link
            :to="
              localePath({
                name: 'event-id-reserve-purchase',
                params: { id: eventId },
              })
            "
            class="
              bg-orange
              text-main
              hover:text hover:bg-opacity-80
              w-full
              py-3
              rounded-sm
              font-bold
              mb-4
              block
              text-center
            "
          >
            {{ $t('event.detail.buyTicket') }}
          </nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { formatNumber } from '@/utils/format'
import ImageBox from '@/components/organisms/ImageBox'
import Divider from '@/components/atoms/Divider'

export default {
  components: {
    ImageBox,
    Divider,
  },
  props: {
    detail: {
      type: Object,
      default: null,
    },
  },
  computed: {
    eventId() {
      return this.$route.params.id || this.detail.id
    },
    eventImages() {
      return this.detail.eventImages
        ? this.detail.eventImages.map((item) => item.url)
        : []
    },
    address1() {
      return this.detail.space ? this.detail.space.address1 : null
    },
    address2() {
      return this.detail.space ? this.detail.space.address2 : null
    },
    address3() {
      return this.detail.space ? this.detail.space.address3 : null
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
    formatDate(date) {
      return this.$dayjs(date).format('YYYY/MM/DD (dd) HH:mm')
    },
  },
}
</script>

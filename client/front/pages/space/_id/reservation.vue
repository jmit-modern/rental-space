<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="flex mt-10 space-x-5 items-start">
      <div class="w-0 flex-1 overflow-hidden">
        <div class="p-6">
          <ReservationDateTime :disabled-dates="disabledDates" />
        </div>
      </div>
      <div class="w-80 sticky top-10">
        <div class="text-lg mb-4">{{ $t('space.reservation.planList') }}</div>
        <div v-if="showPlans && !$fetchState.pending" class="space-y-4">
          <div
            v-for="plan in plans"
            :key="plan.id"
            class="border rounded p-2 bg-light cursor-pointer"
            @click="showReserveModal(plan)"
          >
            <div
              class="border border-orange p-1 inline-flex text-xs items-center"
            >
              <outline-lightning-bolt-icon class="w-4 h-4" stroke="#ff8e3c" />
              <span class="mx-1">{{ $t('space.reservation.reserveNow') }}</span>
              <solid-information-circle-icon class="w-4 h-4" />
            </div>
            <div class="mt-2">{{ plan.name }}</div>
            <div class="flex justify-between mt-2">
              <div class="text-xs">
                {{
                  $t('space.reservation.minUseHours', {
                    minTime: plan.minimumTime,
                  })
                }}
              </div>
              <div class="font-bold">
                ¥ {{ formatNumber(plan.price * timeDiff) }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ReserveModal ref="reserveModal" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import ReservationDateTime from '@/components/organisms/templates/space/ReservationDateTime'
import ReserveModal from '@/components/organisms/templates/space/ReserveModal'

export default {
  components: {
    Breadcrumb,
    ReservationDateTime,
    ReserveModal,
  },
  fetchOnServer: false,
  data() {
    return {
      disabledDates: [],
    }
  },
  async fetch() {
    const params = {
      space_id: this.spaceId,
    }
    const { disabledDates } = await this.$api.fetch(
      'reservation_disabled_dates',
      {
        params,
      }
    )
    // Reset plan on every reservation
    this.$store.commit('plan/reset')

    this.disabledDates = [...disabledDates]
    this.$store.commit('localStorage/setReservation', { spaceId: this.spaceId })
  },
  computed: {
    ...mapGetters({
      plans: 'plan/data',
      reserveDetail: 'localStorage/reservation',
    }),
    spaceId() {
      return this.$route.params.id
    },
    reserveFrom() {
      return this.reserveDetail?.reserveFrom || null
    },
    reserveTo() {
      return this.reserveDetail?.reserveTo || null
    },
    timeDiff() {
      return this.$dayjs(this.reserveTo).diff(
        this.$dayjs(this.reserveFrom),
        'hours'
      )
    },
    showPlans() {
      return this.$dayjs(this.reserveFrom) < this.$dayjs(this.reserveTo)
        ? this.reserveFrom && this.reserveTo && this.plans
        : false
    },
    breadcrumbs() {
      return [
        {
          id: 1,
          name: this.$t('top.breadcrumb'),
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: this.$t('space.reservation.breadcrumb'),
          url: null,
        },
      ]
    },
  },
  methods: {
    showReserveModal(plan) {
      this.$store.commit('plan/setDetail', plan)
      this.$refs.reserveModal.showModal()
    },
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>

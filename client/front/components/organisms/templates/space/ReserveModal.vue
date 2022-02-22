<template>
  <Modal v-show="isModalVisible" class-name="w-1/2" @close="closeModal">
    <template #header>
      <div class="flex justify-end items-center p-2">
        <div class="cursor-pointer" @click="closeModal">
          <outline-x-icon class="w-6 h-6" />
        </div>
      </div>
    </template>

    <template #body>
      <div class="p-4">
        <div class="border border-orange p-1 inline-flex text-xs items-center">
          <outline-lightning-bolt-icon class="w-4 h-4" stroke="#ff8e3c" />
          <span class="mx-1">{{ $t('space.reservation.reserveNow') }}</span>
          <solid-information-circle-icon class="w-4 h-4" />
        </div>
        <div class="mt-2">
          {{ space.name }}
        </div>
        <div class="text-xs mt-2">
          {{
            $t('space.reservation.minUseHours', {
              minTime: plan.minimumTime,
            })
          }}
        </div>

        <div class="mt-8 px-16 py-8 bg-light">
          <div class="pb-4">
            {{ formatDate(reserveFrom) }}〜{{ formatDate(reserveTo) }}
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div class="flex-1 mr-4">
              {{ plan.name }}
            </div>
            <div class="flex-initial">¥ {{ formatNumber(subTotal) }}</div>
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div>{{ $t('space.reservation.serviceFee') }}</div>
            <div>￥ {{ formatNumber(adminFee) }}</div>
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div>{{ $t('space.reservation.tax') }}</div>
            <div>￥ {{ formatNumber(ownerTax) }}</div>
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div class="font-bold">{{ $t('space.reservation.total') }}</div>
            <div class="font-bold text-lg">￥ {{ formatNumber(total) }}</div>
          </div>
          <Divider />

          <div class="text-xs mt-8">
            {{ $t('space.reservation.feeDesc1') }}
            <br />
            <br />
            {{ $t('space.reservation.feeDesc2') }}
          </div>
        </div>
      </div>
    </template>

    <template #footer>
      <div class="p-4">
        <button
          class="
            bg-orange
            p-2
            w-full
            border border-transparent
            shadow-sm
            text-base
            font-bold font-medium
            rounded-md
            text-main
            bg-orange
            focus:outline-none
            hover:opacity-80
            cursor-pointer
          "
          @click="confirmPlan"
        >
          {{ $t('space.reservation.reservePlan') }}
        </button>
      </div>
    </template>
  </Modal>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import Modal from '@/components/molecules/overlay/Modal'
import Divider from '@/components/atoms/Divider'

export default {
  components: {
    Modal,
    Divider,
  },
  data() {
    return {
      isModalVisible: false,
      preview: {},
    }
  },
  computed: {
    ...mapGetters({
      plan: 'plan/detail',
      reserveDetail: 'localStorage/reservation',
    }),
    planId() {
      return this.plan.id || null
    },
    spaceId() {
      return parseInt(this.$route.params.id) || null
    },
    space() {
      return this.preview.space || {}
    },
    subTotal() {
      return this.preview.checkout?.subTotal || null
    },
    adminFee() {
      return this.preview.checkout?.adminFee || null
    },
    ownerTax() {
      return this.preview.checkout?.ownerTax || null
    },
    total() {
      return this.preview.checkout?.total || null
    },
    reserveFrom() {
      return this.reserveDetail?.reserveFrom || null
    },
    reserveTo() {
      return this.reserveDetail?.reserveTo || null
    },
  },
  methods: {
    confirmPlan() {
      this.$store.commit('localStorage/setReservation', {
        planId: this.planId,
        spaceId: this.spaceId,
      })
      this.$router.push('/space/reserve')
    },
    async showModal() {
      try {
        const params = {
          spaceId: this.spaceId,
          planId: this.planId,
          reserveFrom: this.reserveFrom,
          reserveTo: this.reserveTo,
        }
        this.preview = await this.$api.store('reservations/checkout', params)
        this.isModalVisible = true
      } catch (error) {
        console.error(error)
      }
    },
    closeModal() {
      this.isModalVisible = false
    },
    formatNumber(...args) {
      return formatNumber(...args)
    },
    formatDate(date) {
      return this.$dayjs(date).format('YYYY/MM/DD (dd) HH:mm')
    },
  },
}
</script>

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
          <span class="mx-1">{{ $t('expert.reservation.reserveNow') }}</span>
          <solid-information-circle-icon class="w-4 h-4" />
        </div>
        <div class="mt-2">{{ expert.skillTitle }}</div>

        <div class="mt-8 px-16 py-8 bg-light">
          <div class="pb-4 flex justify-between">
            <div class="flex-1 mr-4">
              {{ expert.user.fullName }} ({{ expert.skillTitle }})
            </div>
            <div class="flex-initial">¥ {{ formatNumber(subTotal) }}</div>
          </div>
          <Divider />
          <div class="py-4">
            {{ formatDate(reserveFrom) }}〜{{ formatDate(reserveTo) }}
          </div>
          <Divider />
          <div class="py-4 flex">
            <div class="mr-4">{{ $t('expert.reservation.address') }}:</div>
            <div>{{ reserveDetail.location }}</div>
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div>{{ $t('expert.reservation.serviceFee') }}</div>
            <div>￥ {{ formatNumber(adminFee) }}</div>
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div>{{ $t('expert.reservation.tax') }}</div>
            <div>￥ {{ formatNumber(ownerTax) }}</div>
          </div>
          <Divider />
          <div class="py-4 flex justify-between">
            <div class="font-bold">{{ $t('expert.reservation.total') }}</div>
            <div class="font-bold text-lg">￥ {{ formatNumber(total) }}</div>
          </div>
          <Divider />

          <div class="text-xs mt-8">
            {{ $t('expert.reservation.feeDesc') }}
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
          {{ $t('expert.reservation.reserveExpert') }}
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
      reserveDetail: 'localStorage/expertReservation',
    }),
    expert() {
      return this.preview.expert || { user: {} }
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
    expertId() {
      return parseInt(this.$route.params.id) || null
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
      this.$store.commit('localStorage/setExpertReservation', {
        expertId: this.expertId,
      })
      this.$router.push(this.localeRoute({ name: 'expert-reserve' }))
    },
    async showModal() {
      try {
        const params = {
          expertId: this.expertId,
          reserveFrom: this.reserveFrom,
          reserveTo: this.reserveTo,
        }
        this.preview = await this.$api.store(
          'expert_reservations/checkout',
          params
        )
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

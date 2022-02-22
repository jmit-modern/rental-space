<template>
  <div class="max-w-7xl mx-auto">
    <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
      <form @submit.prevent="handleSubmit(showReserveModal)">
        <div class="mt-10">
          <Breadcrumb :items="breadcrumbs" />
        </div>
        <div>
          <ExpertReservationDateTime :disabled-dates="disabledDates" />
        </div>
        <div v-show="showLocation" class="mt-8">
          <h1 class="font-bold text-lg mb-4">
            {{ $t('expert.reservation.address') }}
            <span class="text-tertiary">*</span>
          </h1>
          <ValidationProvider
            v-slot="{ errors }"
            name="住所"
            rules="required"
            vid="location"
          >
            <input
              id="location"
              v-model="location"
              type="text"
              name="location"
              class="
                focus:ring-orange focus:border-orange
                block
                w-1/2
                shadow-sm
                sm:text-sm
                border-gray-300
                rounded-md
                flex-1
              "
            />
            <span class="input-invalid-message text-tertiary text-sm">
              {{ errors[0] }}
            </span>
          </ValidationProvider>
          <button
            :class="[
              'w-full items-center px-5 py-1.5 mt-4 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
            ]"
            type="submit"
          >
            {{ $t('expert.reservation.confirmOrder') }}
          </button>
        </div>
      </form>
    </ValidationObserver>
    <ReserveModal ref="reserveModal" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import ExpertReservationDateTime from '@/components/organisms/templates/expert/ExpertReservationDateTime'
import ReserveModal from '@/components/organisms/templates/expert/ReserveModal'

export default {
  components: {
    Breadcrumb,
    ExpertReservationDateTime,
    ReserveModal,
  },
  middleware: 'auth',
  data() {
    return {
      disabledDates: [],
    }
  },
  async fetch() {
    const params = {
      expert_id: this.expertId,
    }
    const disabledDatesResult = await this.$api.fetch(
      'expert_reservation_disabled_dates',
      {
        params,
      }
    )
    this.disabledDates = [...disabledDatesResult]
  },
  computed: {
    ...mapGetters({
      reservationDetail: 'localStorage/expertReservation',
    }),
    location: {
      get() {
        return this.reservationDetail.location
      },
      set(value) {
        this.$store.commit('localStorage/setExpertReservation', {
          location: value,
        })
      },
    },
    expertId() {
      return this.$route.params.id
    },
    reserveFrom() {
      return this.reservationDetail?.reserveFrom || null
    },
    reserveTo() {
      return this.reservationDetail?.reserveTo || null
    },
    showLocation() {
      return this.$dayjs(this.reserveFrom) < this.$dayjs(this.reserveTo)
        ? this.reserveFrom && this.reserveTo
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
          name: this.$t('expert.reservation.breadcrumb'),
          url: null,
        },
      ]
    },
  },
  methods: {
    showReserveModal() {
      this.$refs.reserveModal.showModal()
    },
  },
}
</script>

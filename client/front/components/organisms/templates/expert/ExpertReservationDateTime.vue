<template>
  <div>
    <client-only>
      <VueCalendar
        :show-limit="3"
        :events="events"
        :highlight="highlightDays"
        :disable="disabledDays"
        @show-all="showAll"
        @day-clicked="dayClicked"
        @event-clicked="eventClicked"
        @month-changed="monthChanged"
      ></VueCalendar>
    </client-only>

    <div v-show="reserveDate" class="mt-8">
      <h1 class="font-bold text-lg mb-4">
        {{ $t('expert.reservation.chooseTime') }}
      </h1>
      <div class="flex space-x-8">
        <div>
          <label class="mb-1 inline-block">{{
            $t('expert.reservation.startTime')
          }}</label>
          <TimePicker
            v-model="startTime"
            format="HH:mm"
            :hour-options="startTimeOptions"
            :minute-step="30"
            :placeholder="$t('expert.reservation.timePicker.placeholder')"
          />
        </div>
        <div>
          <label class="mb-1 inline-block">{{
            $t('expert.reservation.endTime')
          }}</label>
          <TimePicker
            v-model="endTime"
            format="HH:mm"
            :hour-options="endTimeOptions"
            :minute-step="30"
            :placeholder="$t('expert.reservation.timePicker.placeholder')"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { range } from '@/utils/array'
import VueCalendar from '@/components/atoms/calendar'
import TimePicker from '@/components/atoms/input/TimePicker'

export default {
  components: {
    VueCalendar,
    TimePicker,
  },
  props: {
    disabledDates: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      reserveDate: null,
      startTimeOptions: this.range(0, 23),
      endTimeOptions: this.range(0, 23),
      events: [
        // {
        //   start: new Date('2021-09-17'),
        //   end: new Date('2021-09-21'),
        //   title: 'FooEvent',
        //   classes: ['text-tertiary'],
        // },
      ],
      disabledDays: {
        to: new Date(), // Disable all dates up to specific date
        // from: new Date(YYYY-MM-dd), // Disable all dates after specific date
        // days: [6, 0], // Disable Saturday's and Sunday's
        dates: this.disabledDates.map((date) => new Date(date)),
      },
      highlightDays: {
        // to: new Date('YYYY-MM-dd'), // Highlight all dates up to specific date
        // from: new Date('YYYY-MM-dd'), // Highlight all dates after specific date
        // days: [6, 0], // Highlight Saturday's and Sunday's
        dates: [
          // Highlight an array of dates
          // new Date('2021-10-03'),
        ],
        classes: ['bg-tertiary'],
      },
    }
  },
  mounted() {
    this.highlightDays.dates.push(
      new Date(this.expertReserveDetail.reserveFrom)
    )
    this.reserveDate = this.expertReserveDetail.reserveFrom
      ? this.$dayjs(this.expertReserveDetail.reserveFrom).format('YYYY-MM-DD')
      : null
  },
  computed: {
    ...mapGetters({
      expertReserveDetail: 'localStorage/expertReservation',
    }),
    startTime: {
      get() {
        return this.$dayjs(this.expertReserveDetail.reserveFrom).format(
          'YYYY-MM-DD HH:mm:ss'
        )
      },
      set(value) {
        const timeStr = this.$dayjs(value).format('HH:mm')
        this.endTimeOptions = this.range(this.$dayjs(value).hour(), 23)
        this.$store.commit('localStorage/setExpertReservation', {
          reserveFrom: this.$dayjs([this.reserveDate, timeStr]).format(
            'YYYY-MM-DD HH:mm:ss'
          ),
        })
      },
    },
    endTime: {
      get() {
        return this.$dayjs(this.expertReserveDetail.reserveTo).format(
          'YYYY-MM-DD HH:mm:ss'
        )
      },
      set(value) {
        const timeStr = this.$dayjs(value).format('HH:mm')
        this.startTimeOptions = this.range(0, this.$dayjs(value).hour())
        this.$store.commit('localStorage/setExpertReservation', {
          reserveTo: this.$dayjs([this.reserveDate, timeStr]).format(
            'YYYY-MM-DD HH:mm:ss'
          ),
        })
      },
    },
    showTimePicker() {
      return (
        this.expertReserveDetail.reserveFrom &&
        this.expertReserveDetail.reserveTo
      )
    },
  },
  methods: {
    showAll(events) {
      // Do something...
    },
    dayClicked(day) {
      // Do something...

      // empty Array first and add the new data
      this.highlightDays.dates.splice(0, this.highlightDays.dates.length)
      this.highlightDays.dates.push(day.date)

      this.reserveDate = this.$dayjs(day.date).format('YYYY-MM-DD')

      /** Can be used for multiple dates selection */
      // if (
      //   !this.highlightDays.dates.some(
      //     (d) => day.date.toDateString() === d.toDateString()
      //   )
      // ) {
      //   this.highlightDays.dates.push(day.date)
      // } else {
      //   this.highlightDays.dates = this.highlightDays.dates.filter((d) => {
      //     return day.date.toDateString() !== d.toDateString()
      //   })
      // }
    },
    eventClicked(event) {
      // Do something...
    },
    monthChanged(start, end) {
      // Do something...
    },
    range(...args) {
      return range(...args)
    },
  },
}
</script>

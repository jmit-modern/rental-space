<template>
  <div
    class="
      grid grid-cols-1
      lg:grid-cols-4
      gap-4
      lg:gap-8
      items-center
      px-4
      py-5
      border-b border-gray-300
    "
  >
    <div class="label">
      <h5 class="font-bold text-primary">{{ $t('top.dateSearch.label') }}</h5>
    </div>
    <div class="col-span-3">
      <div class="flex flex-row items-center justify-between gap-4">
        <Datepicker
          v-model="inputs.pickDate"
          :input-class="['datepicker'].join(' ')"
          :clear-button="false"
        />
        <div class="flex flex-row items-center gap-2">
          <SelectInput
            v-model="inputs.startTime"
            :options="timeOptions"
            :input-class="'mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
            :unselect-option="{
              name: $t('top.dateSearch.timeFrom'),
              code: null,
            }"
          />
          <div>～</div>
          <SelectInput
            v-model="inputs.endTime"
            :options="timeOptions"
            :input-class="'mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
            :unselect-option="{ name: $t('top.dateSearch.timeTo'), code: null }"
          />
        </div>
        <PrefecturePicker v-model="inputs.prefecture" />
        <SearchButton @click.native="handleSearch" />
      </div>
    </div>
  </div>
</template>

<script>
import * as time from '@/constants/time'
import SelectInput from '@/components/atoms/input/SelectInput'
import Datepicker from '@/components/molecules/form/Datepicker'
import PrefecturePicker from '@/components/molecules/form/PrefecturePicker'
import SearchButton from '@/components/molecules/form/SearchButton'

export default {
  name: 'DateSearchForm',
  components: {
    Datepicker,
    PrefecturePicker,
    SearchButton,
    SelectInput,
  },
  data() {
    return {
      inputs: {
        pickDate: null,
        startTime: null,
        endTime: null,
        prefecture: null,
      },
      time,
    }
  },
  computed: {
    timeOptions() {
      return this.time.timeOptions
    },
  },
  methods: {
    handleSearch() {
      this.$emit('search', this.inputs)
    },
  },
}
</script>

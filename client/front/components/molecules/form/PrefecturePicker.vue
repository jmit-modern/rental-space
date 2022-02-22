<template>
  <div>
    <SelectInput
      v-model="inputPrefecture"
      :options="prefOptions"
      :input-class="'mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
      :useUnselectOption="true"
      :unselect-option="{
        name: $t('form.prefecturePicker.unselectOption'),
        code: null,
      }"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SelectInput from '@/components/atoms/input/SelectInput'
import formFieldMixin from '@/components/molecules/form/mixins/formFieldMixin'

export default {
  components: { SelectInput },
  mixins: [formFieldMixin],
  props: {
    value: {
      type: Number,
      default: null,
    },
  },
  computed: {
    ...mapGetters({
      prefOptions: 'master/prefOptions',
    }),
    inputPrefecture: {
      get() {
        return this.value
      },
      set(value) {
        this.$emit('input', value)
        this.$emit('change', value)
      },
    },
  },
}
</script>

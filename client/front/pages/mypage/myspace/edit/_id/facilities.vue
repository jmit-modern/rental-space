<template>
  <div>
    <ValidationObserver v-slot="{ invalid }">
      <div
        v-for="facilityCat in facilityCategories"
        :key="facilityCat.id"
        class="mb-8"
      >
        <div class="mb-3 font-bold">{{ facilityCat.name }}</div>
        <checkbox-list
          v-model="facilities"
          valid-name="設備・備品"
          name="facilities"
          :options="createOptions(facilityCat.facilities)"
          wrapper-tag="span"
          input-field-class="check-group"
          wrapper-class="check-group-wrap gap-4 grid grid-cols-5"
        />
      </div>

      <div class="flex justify-end">
        <button
          :class="[
            'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
            invalid
              ? 'cursor-not-allowed opacity-40'
              : 'hover:opacity-80 cursor-pointer',
          ]"
          :disabled="invalid"
          @click.prevent="handleSave"
        >
          {{ $t('form.save') }}
        </button>
      </div>
    </ValidationObserver>
    <Notification
      v-if="showAlert"
      :title="$t('form.updateNotification')"
      @hide="showAlert = false"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { createOptions } from '@/utils/dataStructure'
import CheckboxList from '@/components/molecules/form/CheckboxList'
import Notification from '@/components/molecules/overlay/Notification'

export default {
  components: {
    CheckboxList,
    Notification,
  },
  data() {
    return {
      facilities: [],
      showAlert: false,
    }
  },
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('space/fetchDetail', { id })])
    this.facilities = this.facilityIds
  },
  computed: {
    ...mapGetters({
      space: 'space/detail',
      facilityCategories: 'master/facilityCategories',
    }),
    facilityIds() {
      return this.space.facilities.map((facility) => facility.id)
    },
  },
  methods: {
    createOptions(...args) {
      return createOptions(...args)
    },
    async handleSave() {
      console.log(this.facilities)
      const { id } = this.$route.params
      const params = {
        facilities: this.facilities,
      }
      await this.$store.dispatch('space/updateFacilities', [id, params])

      this.showAlert = true
      setTimeout(() => (this.showAlert = false), 2000)
    },
  },
}
</script>

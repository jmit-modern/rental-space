<template>
  <div>
    <div class="flex justify-end">
      <div
        class="
          items-center
          px-5
          py-1.5
          border border-transparent
          shadow-sm
          text-base
          font-medium
          rounded-md
          text-main
          bg-orange
          focus:outline-none
          hover:opacity-80
          cursor-pointer
        "
        @click="showNewModal"
      >
        {{ $t('mypage.mySpace.planSetting.addPlan') }}
      </div>
    </div>

    <!-- Plan List Table -->
    <div v-if="plans" class="mt-6">
      <table class="table-fixed w-full">
        <tbody>
          <tr v-for="plan in plans" :key="plan.id" class="border-bottom-1">
            <td class="py-2 w-1/2">{{ plan.name }}</td>
            <td align="right" class="py-2 w-1/6">
              最低利用 {{ plan.minimumTime }}時間 ~
            </td>
            <td align="right" class="py-2 w-1/6">
              ￥{{ formatNumber(plan.price) }}
            </td>
            <td align="right" class="py-2 w-1/6">
              <div class="flex items-center justify-end space-x-2">
                <div @click="showModal(plan)">
                  <outline-pencil-icon class="w-6 h-6" />
                </div>

                <div @click="deletePlan(plan.id)">
                  <outline-trash-icon
                    class="w-6 h-6 text-tertiary cursor-pointer"
                  />
                </div>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- End: Plan List Table -->
    <PlanModal ref="planFormModal" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import PlanModal from '@/components/organisms/templates/mypage/myspace/PlanModal'

export default {
  components: {
    PlanModal,
  },
  data() {
    return {}
  },
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('space/fetchDetail', { id })])
  },
  computed: {
    ...mapGetters({
      space: 'space/detail',
    }),
    plans() {
      return this.space.spacePlans ? this.space.spacePlans : null
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
    showModal(plan) {
      this.$store.commit('plan/setDetail', plan)
      this.$refs.planFormModal.showModal('edit')
    },
    showNewModal() {
      this.$store.commit('plan/setDetail', {})
      this.$refs.planFormModal.showModal('new')
    },
    deletePlan(planId) {
      if (confirm('Do you really want to delete?')) {
        this.$store.dispatch('space/removePlan', [
          this.$route.params.id,
          planId,
        ])
      }
    },
  },
}
</script>

<template>
  <div>
    <Modal v-show="isModalVisible" class-name="w-1/2" @close="closeModal">
      <template #header>
        <div class="flex justify-end items-center p-2">
          <div class="cursor-pointer" @click="closeModal">
            <outline-x-icon class="w-6 h-6" />
          </div>
        </div>
      </template>

      <template #body>
        <div class="p-2">
          <plan-form :plan="plan" :form-type="formType" @submit="closeModal" />
        </div>
      </template>

      <template #footer> </template>
    </Modal>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Modal from '@/components/molecules/overlay/Modal'
import PlanForm from '@/components/organisms/templates/mypage/myspace/PlanForm'

export default {
  components: {
    Modal,
    PlanForm,
  },
  data() {
    return {
      formType: '',
      isModalVisible: false,
    }
  },
  computed: {
    ...mapGetters({
      plan: 'plan/detail',
    }),
  },
  methods: {
    showModal(formType) {
      this.isModalVisible = true
      this.formType = formType
    },
    closeModal() {
      this.isModalVisible = false
    },
  },
}
</script>

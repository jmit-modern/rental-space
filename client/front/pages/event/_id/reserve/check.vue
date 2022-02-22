<template>
  <div class="max-w-7xl mx-auto">
    <div class="text-center text-xl font-bold mt-16">
      <div v-if="isReservedUser">This User is Event participant</div>
      <div v-else class="text-tertiary">
        This User is not a event participant
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isReservedUser: false,
    }
  },
  async fetch() {
    const userId = this.$route.query.user_id
    const eventId = this.$route.params.id
    if (eventId && userId) {
      const { check } = await this.$api.store(
        `event_reservations/check_user_reserved`,
        {
          eventId,
          userId,
        }
      )
      this.isReservedUser = check
    }
  },
}
</script>

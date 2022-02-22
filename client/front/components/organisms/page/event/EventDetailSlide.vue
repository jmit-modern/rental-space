<template>
  <div class="w-screen max-w-7xl">
    <div class="h-full flex flex-col bg-white shadow-xl overflow-y-scroll pb-6">
      <div class="px-4 py-6 sm:px-6 border-b">
        <div class="flex items-start justify-between max-w-5xl">
          <div class="ml-3 h-7 flex items-center">
            <button
              class="
                bg-white
                rounded-md
                text-gray-400
                hover:text-gray-500
                focus:outline-none
              "
              @click="handleClose"
            >
              <span class="sr-only">Close panel</span>
              <outline-chevron-left-icon class="w-6 h-6" />
            </button>
          </div>
          <div class="text-lg font-medium text-gray-900">
            <a
              :href="`event/${event.id}`"
              target="_blank"
              class="flex items-center text-sm"
            >
              <span class="mr-1">{{ $t('event.slide.openNewWindow') }}</span>
              <outline-external-link-icon class="w-4 h-4" />
            </a>
          </div>
        </div>
      </div>
      <div class="mt-6 relative flex-1 px-4 sm:px-6 max-w-5xl">
        <!-- Replace with your content -->
        <Detail :detail="event" />
        <!-- /End replace -->
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Detail from '@/components/organisms/page/event/Detail'
export default {
  components: { Detail },
  computed: {
    ...mapGetters({
      event: 'event/detail',
    }),
  },
  methods: {
    handleClose() {
      this.$emit('close')
    },
  },
}
</script>

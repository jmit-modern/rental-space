<template>
  <div class="w-32">
    <span>{{ percent }}% {{ $t('expert.expertItem.jobSuccess') }}</span>
    <div class="relative progress_bar">
      <div
        class="
          overflow-hidden
          h-1
          text-xs
          flex
          rounded
          bg-tertiary bg-opacity-20
          w-full
        "
      >
        <div
          :style="`width: ${percent}%`"
          class="
            shadow-none
            flex flex-col
            text-center
            whitespace-nowrap
            text-white
            justify-center
            bg-orange
          "
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    percent: {
      type: Number,
      default: null,
    },
  },
}
</script>

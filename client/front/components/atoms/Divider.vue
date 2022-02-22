<template>
  <div :class="['relative', className]">
    <div class="absolute inset-0 flex items-center" aria-hidden="true">
      <div class="w-full border-t border-gray-300" />
    </div>
    <div v-if="label" class="relative flex justify-center">
      <span class="px-2 bg-white text-sm text-gray-500"> {{ label }} </span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      default: null,
    },
    className: {
      type: String,
      default: null,
    },
  },
}
</script>

<template>
  <transition name="modal-fade">
    <div
      class="
        fixed
        inset-0
        flex
        items-center
        justify-center
        bg-black bg-opacity-30
      "
    >
      <div
        :class="[
          'bg-white p-2 rounded absolute inset-y-8 overflow-y-auto',
          className,
        ]"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
        <slot name="header"></slot>
        <slot name="body"></slot>
        <slot name="footer"></slot>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  name: 'Modal',
  props: {
    className: {
      type: String,
      default: null,
    },
  },
  methods: {
    close() {
      this.$emit('close')
    },
  },
}
</script>

<style>
.modal-fade-enter,
.modal-fade-leave-to {
  opacity: 0;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.3s linear;
}
</style>

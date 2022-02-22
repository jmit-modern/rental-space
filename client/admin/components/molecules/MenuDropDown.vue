<template>
  <div class="relative">
    <div
      class="
        text-base
        font-medium
        py-2
        pl-16
        text-primary
        cursor-pointer
      "
      @click.prevent="toggleDropdown"
    >
      <slot name="header"></slot>
    </div>
    <div
      v-show="state"
      class="
        absolute
        right-0
        w-full
        py-2
        bg-white
        border
        rounded
        shadow-xl
        space-y
        text-center
      "
    >
      <slot name="submenu"></slot>
    </div>
  </div>
</template>

<script>
import closeOnOutsideClickMixin from "@/components/Mixins/CloseOnOutsideClick";
export default {
  mixins: [closeOnOutsideClickMixin],
  data() {
    return {
      state: false
    };
  },
  methods: {
    toggleDropdown(e) {
      this.state = !this.state;
    },
    close() {
      this.state = false;
    }
  }
};
</script>

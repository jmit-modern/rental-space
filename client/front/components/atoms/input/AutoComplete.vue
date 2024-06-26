<template>
  <div v-click-outside="clickedOutside" :class="['relative', wrapperClass]">
    <input
      ref="input"
      :value="value"
      :placeholder="placeholder"
      tabindex="0"
      :class="[
        'border border-gray-300 py-2 px-3 rounded-md focus:outline-none focus:shadow-outline w-full',
        inputClass,
      ]"
      @input="handleInput"
    />
    <span
      v-if="value"
      class="absolute inset-y-0 right-0 pr-3 flex items-center cursor-pointer"
      @click.prevent="reset()"
    >
      x
    </span>
    <div
      v-show="value && showOptions"
      tabindex="0"
      :class="dropdownClass"
      @click.self="handleSelf()"
      @focusout="showOptions = false"
    >
      <ul class="py-1">
        <li
          v-for="(item, index) in searchResults"
          :key="index"
          class="px-3 py-2 cursor-pointer hover:bg-gray-200"
          @click="handleClick(item)"
        >
          {{ item.name }}
        </li>
        <li v-if="!searchResults.length" class="px-3 py-2 text-center">
          No Matching Results
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import vClickOutside from 'v-click-outside'

export default {
  directives: {
    clickOutside: vClickOutside.directive,
  },
  props: {
    value: {
      type: String,
      required: false,
      default: null,
    },
    placeholder: {
      type: String,
      required: false,
      default: 'Enter text here.',
    },
    data: {
      type: Array,
      required: true,
      default: () => [],
    },
    wrapperClass: {
      type: String,
      required: false,
      default: '',
    },
    inputClass: {
      type: String,
      required: false,
      default: '',
    },
    dropdownClass: {
      type: String,
      required: false,
      default:
        'absolute w-full z-50 bg-white border border-gray-300 mt-1 mh-48 overflow-hidden overflow-y-scroll rounded-md shadow-md',
    },
  },

  data() {
    return {
      showOptions: false,
      chosenOption: '',
      searchTerm: '',
    }
  },

  computed: {
    searchResults() {
      return this.data
        ? this.data.filter((item) => {
            return item.name
              .toLowerCase()
              .includes(this.searchTerm.toLowerCase())
          })
        : []
    },
  },

  methods: {
    reset() {
      this.$emit('input', '')
      this.chosenOption = ''
    },

    handleInput(evt) {
      this.$emit('input', evt.target.value)
      this.searchTerm = evt.target.value
      this.showOptions = true
    },

    handleClick(item) {
      this.$emit('input', item.name)
      this.$emit('chosen', item)
      this.chosenOption = item.name
      this.showOptions = false
      this.$refs.input.focus()
    },

    clickedOutside() {
      this.showOptions = false

      if (!this.chosenOption) {
        this.$emit('input', '')
      }
    },
  },
}
</script>

<style scoped>
.mh-48 {
  max-height: 10rem;
}
</style>

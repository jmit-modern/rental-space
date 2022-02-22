<template>
  <div>
    <FileInputGroup
      v-model="newImage"
      inputClass="leading-4 focus:outline-none bg-white py-2 px-3 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 mb-4"
      @change="handleImageUpload"
    >
      <template #button>写真追加</template>
    </FileInputGroup>
    <div v-if="image" class="flex flex-wrap">
      <div class="relative pb-24 mr-8 mb-4 w-40">
        <img
          :src="image"
          class="absolute w-full h-full rounded object-cover"
          alt=""
        />
        <div class="inline-block" @click="removeImage(image)">
          <solid-x-circle-icon
            class="w-4 h-4 cursor-pointer absolute -right-4 -top-2"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import FileInputGroup from '@/components/molecules/input/FileInputGroup'

export default {
  props: {
    value: String,
    default: null,
  },
  components: {
    FileInputGroup,
  },
  data() {
    return {
      newImage: null,
    }
  },
  computed: {
    image() {
      return this.value
    },
  },
  methods: {
    removeImage(image) {
      this.$emit('remove', image)
    },
    handleImageUpload(file) {
      this.$emit('upload', file)
    },
  },
}
</script>

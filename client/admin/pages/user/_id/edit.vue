<template>
  <div>
    <ValidationObserver v-slot="{ invalid }">
      <div class="px-4 sm:p-6 space-y-6 w-2/3">
        <div class="flex space-x-6">
          <div>
            <label
              for="first-name"
              class="block text-sm font-medium text-gray-700"
              >(姓) <span class="text-tertiary">*</span>
            </label>
            <ValidationProvider
              v-slot="{ errors }"
              name="(姓)"
              rules="required"
            >
              <input
                id="first-name"
                v-model="inputs.firstName"
                type="text"
                name="first-name"
                autocomplete="given-name"
                class="
                  mt-1
                  focus:ring-orange focus:border-orange
                  block
                  w-full
                  shadow-sm
                  sm:text-sm
                  border-gray-300
                  rounded-md
                "
              />
              <span class="input-invalid-message text-tertiary text-sm">
                {{ errors[0] }}
              </span>
            </ValidationProvider>
          </div>

          <div>
            <label
              for="last-name"
              class="block text-sm font-medium text-gray-700"
              >(名) <span class="text-tertiary">*</span>
            </label>
            <ValidationProvider
              v-slot="{ errors }"
              name="(名)"
              rules="required"
            >
              <input
                id="last-name"
                v-model="inputs.lastName"
                type="text"
                name="last-name"
                autocomplete="family-name"
                class="
                  mt-1
                  focus:ring-orange focus:border-orange
                  block
                  w-full
                  shadow-sm
                  sm:text-sm
                  border-gray-300
                  rounded-md
                "
              />
              <span class="input-invalid-message text-tertiary text-sm">
                {{ errors[0] }}
              </span>
            </ValidationProvider>
          </div>
        </div>
        <div class="max-w-xs">
          <label for="username" class="block text-sm font-medium text-gray-700"
            >ユーザー名 <span class="text-tertiary">*</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            name="ユーザー名"
            rules="required"
          >
            <input
              id="username"
              v-model="inputs.username"
              type="text"
              name="username"
              autocomplete="username"
              class="
                mt-1
                focus:ring-orange focus:border-orange
                block
                w-full
                shadow-sm
                sm:text-sm
                border-gray-300
                rounded-md
              "
            />
            <span class="input-invalid-message text-tertiary text-sm">
              {{ errors[0] }}
            </span></ValidationProvider
          >
        </div>
        <div class="max-w-xs">
          <label for="username" class="block text-sm font-medium text-gray-700"
            >Email <span class="text-tertiary">*</span>
          </label>
          <ValidationProvider v-slot="{ errors }" name="Email" rules="required">
            <input
              id="email"
              v-model="inputs.email"
              type="text"
              name="email"
              class="
                mt-1
                focus:ring-orange focus:border-orange
                block
                w-full
                shadow-sm
                sm:text-sm
                border-gray-300
                rounded-md
              "
            />
            <span class="input-invalid-message text-tertiary text-sm">
              {{ errors[0] }}
            </span></ValidationProvider
          >
        </div>
        <div class="mt-8">
          <label class="block text-sm font-medium text-gray-700">
            プロフィール写真
          </label>
          <SingleImageInput
            v-model="inputs.photo"
            @upload="handleImageUpload"
            @remove="handleImageRemove"
          />
        </div>
        <div>
          <label for="about" class="block text-sm font-medium text-gray-700">
            自己紹介
          </label>
          <div class="mt-1">
            <textarea
              id="about"
              v-model="inputs.description"
              name="about"
              rows="3"
              class="
                shadow-sm
                focus:ring-orange focus:border-orange
                block
                w-full
                sm:text-sm
                border border-gray-300
                rounded-md
              "
              placeholder="Write your words"
            ></textarea>
          </div>
          <p class="mt-2 text-sm text-gray-500">
            Brief description for your profile. URLs are hyperlinked.
          </p>
        </div>
        <div class="max-w-lg">
          <label
            for="street-address"
            class="block text-sm font-medium text-gray-700"
            >住所（番地まで）</label
          >
          <input
            id="street-address"
            v-model="inputs.address"
            type="text"
            name="street-address"
            autocomplete="street-address"
            class="
              mt-1
              focus:ring-orange focus:border-orange
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            "
          />
        </div>
        <div class="max-w-xs">
          <label for="phone" class="block text-sm font-medium text-gray-700"
            >電話番号</label
          >
          <ValidationProvider
            v-slot="{ errors }"
            name="電話番号"
            rules="phoneNumber"
          >
            <input
              id="phone"
              v-model="inputs.phone"
              type="text"
              name="phone"
              autocomplete="phone"
              placeholder="01-2345-6789"
              class="
                mt-1
                focus:ring-orange focus:border-orange
                block
                w-full
                shadow-sm
                sm:text-sm
                border-gray-300
                rounded-md
              "
            />
            <span class="input-invalid-message text-tertiary text-sm">
              {{ errors[0] }}
            </span></ValidationProvider
          >
        </div>
        <div class="px-4 py-3 text-right sm:px-6">
          <button
            :class="[
              'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-red-500 focus:outline-none hover:opacity-80 cursor-pointer',
            ]"
            @click="blockUser"
          >
            Block this user
          </button>
          <button
            :class="[
              'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
              invalid
                ? 'cursor-not-allowed opacity-40'
                : 'hover:opacity-80 cursor-pointer',
            ]"
            :disabled="invalid"
            @click="updateProfile"
          >
            アップデートする
          </button>
        </div>
      </div>
    </ValidationObserver>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SingleImageInput from '@/components/organisms/page/input/SingleImageInput'

export default {
  components: {
    SingleImageInput,
  },
  data() {
    return {
      inputs: {},
      error: null,
    }
  },
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('user/fetchDetail', id)])
    this.inputs = { ...this.user }
  },
  computed: {
    ...mapGetters({
      user: 'user/detail',
    }),
    userId() {
      return this.user.id
    },
  },
  methods: {
    async handleImageUpload(file) {
      const formData = new FormData()
      formData.append('file', file)
      const result = await this.$api.store(
        'uploads/create',
        formData,
        {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          withCredentials: false,
        },
        { decamelizeRequest: false }
      )
      this.inputs.photo = result.url
    },
    async handleImageRemove(image) {
      const params = {
        url: image,
      }
      await this.$api.store('uploads/delete', params)
      this.inputs.photo = null
    },
    async updateProfile() {
      try {
        const params = { ...this.inputs }
        await this.$store.dispatch('user/update', [this.userId, params])
        this.showAlert = true
      } catch (e) {
        this.error = e.response.data.message
        this.error = "There's an error in user registration"
      }
    },
    blockUser() {},
  },
}
</script>

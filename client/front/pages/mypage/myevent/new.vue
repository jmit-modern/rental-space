<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8">
          <div class="text-xl">{{ $t('mypage.myEvent.eventNew') }}</div>
        </div>
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form @submit.prevent="handleSubmit(handleSave)">
            <div>
              <label for="name" class="block text-gray-700 mb-2"
                >{{ $t('mypage.myEvent.form.title') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('mypage.myEvent.form.title')"
                rules="required"
              >
                <input
                  id="name"
                  v-model="inputs.name"
                  type="text"
                  name="name"
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
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="mt-8">
              <label for="name" class="block text-gray-700 mb-2">{{
                $t('mypage.myEvent.form.image')
              }}</label>
              <ImageInput
                v-model="inputs.eventImages"
                @upload="handleImageUpload"
                @remove="handleImageRemove"
              />
            </div>
            <div class="mt-8">
              <label for="description" class="block text-gray-700 mb-2"
                >{{ $t('mypage.myEvent.form.description') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span></label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('mypage.myEvent.form.description')"
                rules="required"
              >
                <QuillEditor v-model="inputs.description" />
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="mt-8">
              <label for="pay_type" class="block text-gray-700 mb-2">{{
                $t('mypage.myEvent.form.payMethod')
              }}</label>
              <div class="flex space-x-8">
                <RadioBox
                  v-model="inputs.priceType"
                  :options="priceTypeOptions"
                  input-name="pay_type"
                  wrapper-class="flex space-x-4"
                />
              </div>
            </div>
            <div class="mt-8">
              <label for="price" class="block text-gray-700 mb-2"
                >{{ $t('mypage.myEvent.form.price') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('mypage.myEvent.form.price')"
                rules="required|integer"
              >
                <div class="mt-1 relative rounded-md shadow-sm w-48">
                  <input
                    id="price"
                    v-model="inputs.price"
                    type="text"
                    name="price"
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
                    placeholder="0"
                    aria-describedby="price-currency"
                  />
                  <div
                    class="
                      absolute
                      inset-y-0
                      right-0
                      pr-3
                      flex
                      items-center
                      pointer-events-none
                    "
                  >
                    <span id="price-currency" class="text-gray-500 sm:text-sm">
                      {{ $t('form.priceUnit') }}
                    </span>
                  </div>
                </div>
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="grid grid-cols-2 gap-8 mt-8">
              <div>
                <label for="startingAt" class="block text-gray-700 mb-2"
                  >{{ $t('mypage.myEvent.form.startTime') }}
                  <span class="text-tertiary text-xs">{{
                    $t('form.required')
                  }}</span></label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  :name="$t('mypage.myEvent.form.startTime')"
                  rules="date_lt:endingAt|required"
                  vid="startingAt"
                >
                  <DateTimePicker
                    v-model="inputs.startingAt"
                    name="startingAt"
                  />
                  <span class="text-tertiary">
                    {{ errors[0] }}
                  </span>
                </ValidationProvider>
              </div>
              <div>
                <label for="endingAt" class="block text-gray-700 mb-2"
                  >{{ $t('mypage.myEvent.form.endTime') }}
                  <span class="text-tertiary text-xs">{{
                    $t('form.required')
                  }}</span></label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  :name="$t('mypage.myEvent.form.endTime')"
                  rules="date_gt:startingAt|required"
                  vid="endingAt"
                >
                  <DateTimePicker v-model="inputs.endingAt" />
                  <span class="text-tertiary">
                    {{ errors[0] }}
                  </span>
                </ValidationProvider>
              </div>
            </div>

            <div class="mt-8">
              <label for="freeCancel" class="block text-gray-700 mb-2"
                >{{ $t('mypage.myEvent.form.freeCancel') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('mypage.myEvent.form.freeCancel')"
                rules="required|integer"
              >
                <div class="mt-1 relative rounded-md shadow-sm w-48">
                  <input
                    id="freeCancel"
                    v-model="inputs.cancellationDeadline"
                    type="text"
                    name="freeCancel"
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
                    placeholder="0"
                    aria-describedby="price-unit"
                  />
                  <div
                    class="
                      absolute
                      inset-y-0
                      right-0
                      pr-3
                      flex
                      items-center
                      pointer-events-none
                    "
                  >
                    <span id="price-unit" class="text-gray-500 sm:text-sm">
                      {{ $t('form.hourUnit') }}
                    </span>
                  </div>
                </div>
                <span class="text-xs">{{
                  $t('mypage.myEvent.form.freeCancelDesc')
                }}</span>
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>

            <div class="mt-8 w-80">
              <label for="category" class="block text-gray-700 mb-2"
                >{{ $t('mypage.myEvent.form.category') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('mypage.myEvent.form.category')"
                rules="required"
              >
                <SelectInput
                  v-model="inputs.categoryId"
                  id="category"
                  :options="categoryOptions"
                  :input-class="'block w-full pl-3 pr-10 py-1.5 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
                  :unselect-option="{
                    name: $t('form.categoryPicker.unselectOption'),
                    code: null,
                  }"
                />
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="mt-8 w-80">
              <label for="language" class="block text-gray-700 mb-2">{{
                $t('mypage.myEvent.form.language')
              }}</label>
              <SelectInput
                v-model="inputs.languageId"
                id="language"
                :options="languageOptions"
                :input-class="'block w-full pl-3 pr-10 py-1.5 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
                :unselect-option="{
                  name: $t('form.languagePicker.unselectOption'),
                  code: null,
                }"
              />
            </div>
            <div class="mt-8 w-80">
              <label for="name" class="block text-gray-700 mb-2">{{
                $t('mypage.myEvent.form.siteUrl')
              }}</label>
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('mypage.myEvent.form.siteUrl')"
                rules="url"
              >
                <input
                  id="name"
                  v-model="inputs.siteUrl"
                  type="text"
                  name="name"
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
                  placeholder="http://www.example.com"
                />
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="mt-8">
              <label for="status" class="block text-gray-700 mb-2">{{
                $t('form.status')
              }}</label>
              <div class="flex space-x-8">
                <RadioBox
                  v-model="inputs.status"
                  :options="statusOptions"
                  input-name="status"
                  wrapper-class="flex space-x-4"
                />
              </div>
            </div>
            <div class="flex items-center justify-end space-x-8 mt-12">
              <button
                type="submit"
                class="
                  items-center
                  px-5
                  py-1.5
                  border border-transparent
                  shadow-sm
                  text-base
                  font-medium
                  rounded-md
                  text-main
                  bg-orange
                  focus:outline-none
                  hover:opacity-80
                  cursor-pointer
                "
              >
                {{ $t('form.register') }}
              </button>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </mypage-layout>
    <Notification
      v-if="showAlert"
      title="Event Created Successfully!"
      @hide="showAlert = false"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import SelectInput from '@/components/atoms/input/SelectInput'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import QuillEditor from '@/components/molecules/form/QuillEditor'
import ImageInput from '@/components/organisms/page/input/ImageInput'
import DateTimePicker from '@/components/molecules/form/DateTimePicker'
import Notification from '@/components/molecules/overlay/Notification'
import RadioBox from '@/components/molecules/form/RadioBox'

export default {
  components: {
    MypageLayout,
    Breadcrumb,
    SelectInput,
    RadioBox,
    QuillEditor,
    Notification,
    ImageInput,
    DateTimePicker,
  },
  middleware: 'auth',
  data() {
    return {
      inputs: {
        name: null,
        description: null,
        price: null,
        priceType: 1,
        eventImages: [],
        startingAt: null,
        endingAt: null,
        cancellationDeadline: 48,
        categoryId: null,
        languageId: null,
        url: null,
        status: 0,
        userId: null,
      },
      statusOptions: [
        {
          code: 1,
          name: this.$t('form.publish'),
        },
        {
          code: 0,
          name: this.$t('form.unpublish'),
        },
      ],
      priceTypeOptions: [
        {
          code: 1,
          name: this.$t('mypage.myEvent.form.hourly'),
        },
        {
          code: 2,
          name: this.$t('mypage.myEvent.form.fixed'),
        },
      ],
      showAlert: false,
    }
  },
  fetch() {
    this.inputs.userId = this.user.id
  },
  computed: {
    ...mapGetters({
      categoryOptions: 'master/categoryOptions',
      languageOptions: 'master/languageOptions',
      user: 'user',
    }),
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: 'ホーム',
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: 'マイページ',
          url: this.localeRoute({ name: 'mypage' }),
        },
        {
          id: 3,
          name: 'マイイベント',
          url: this.localeRoute({ name: 'mypage-myevent' }),
        },
        {
          id: 4,
          name: '新規登録',
        },
      ]
      return items
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
    handlePayType(value) {},
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
      this.inputs.eventImages.push({ url: result.url })
    },
    async handleImageRemove(image) {
      const params = {
        url: image.url,
      }
      await this.$api.store('uploads/delete', params)
      const index = this.inputs.eventImages.findIndex(function (eventImage) {
        return eventImage.url === image.url
      })
      this.inputs.eventImages.splice(index, 1)
    },
    async handleSave() {
      // const isValid = await this.$refs.observer.validate()
      const params = { ...this.inputs }
      console.log(params)
      await this.$store.dispatch('event/create', params)
      this.showAlert = true
      this.$router.push('/mypage/myevent')
    },
  },
}
</script>

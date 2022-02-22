<template>
  <div>
    <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
      <form @submit.prevent="handleSubmit(handleSave)">
        <div>
          <label for="name" class="block text-gray-700 mb-2"
            >{{ $t('form.title') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            name="タイトル"
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

        <!-- Space Images -->
        <div class="mt-8">
          <label for="photo" class="block text-gray-700 mb-2">{{
            $t('form.image')
          }}</label>
          <ImageInput
            v-model="inputs.spaceImages"
            @upload="handleImageUpload"
            @remove="handleImageRemove"
          />
        </div>
        <!-- End: Space Images -->

        <!-- Space Description -->
        <div class="mt-8">
          <label for="description" class="block text-gray-700 mb-2">{{
            $t('form.description')
          }}</label>
          <QuillEditor v-model="inputs.description" />
        </div>
        <!-- End: Space Description -->

        <!-- Lodging -->
        <div class="mt-8">
          <label for="lodging" class="block text-gray-700 mb-2">{{
            $t('form.lodging')
          }}</label>
          <QuillEditor v-model="inputs.lodging" />
        </div>
        <!--End: Lodging -->

        <!-- Loud Volume -->
        <div class="mt-8">
          <label for="loud_volume" class="block text-gray-700 mb-2">{{
            $t('form.loudVolume')
          }}</label>
          <QuillEditor v-model="inputs.loudVolume" />
        </div>
        <!--End: Loud Volume -->

        <!-- Cooking -->
        <div class="mt-8">
          <label for="cooking" class="block text-gray-700 mb-2">{{
            $t('form.cooking')
          }}</label>
          <QuillEditor v-model="inputs.cooking" />
        </div>
        <!--End: Cooking -->

        <!-- Wifi -->
        <div class="mt-8">
          <label for="wifi" class="block text-gray-700 mb-2">{{
            $t('form.wifi')
          }}</label>
          <QuillEditor v-model="inputs.wifi" />
        </div>
        <!--End: Wifi -->

        <!-- Parking -->
        <div class="mt-8">
          <label for="wifi" class="block text-gray-700 mb-2">{{
            $t('form.parking')
          }}</label>
          <QuillEditor v-model="inputs.parking" />
        </div>
        <!--End: Parking -->

        <!-- Capacity -->
        <div class="mt-8">
          <label for="capacity" class="block text-gray-700 mb-2"
            >{{ $t('form.capacity') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.capacity')"
            rules="required|integer"
          >
            <div class="mt-1 relative rounded-md shadow-sm w-40">
              <input
                id="capacity"
                v-model="inputs.capacity"
                type="text"
                name="capacity"
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
                aria-describedby="capacity-unit"
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
                <span id="capacity-unit" class="text-gray-500 sm:text-sm">
                  {{ $t('form.capacityUnit') }}
                </span>
              </div>
            </div>
            <span class="input-invalid-message text-tertiary">
              {{ errors[0] }}
            </span>
          </ValidationProvider>
        </div>
        <!-- End: Capacity -->

        <!-- Space Address -->
        <div class="mt-8 grid grid-cols-2 gap-2">
          <div>
            <label for="address1" class="block text-gray-700 mb-2"
              >{{ $t('form.address1') }}
              <span class="text-tertiary text-xs">{{
                $t('form.required')
              }}</span></label
            >
            <ValidationProvider
              v-slot="{ errors }"
              :name="$t('form.address1')"
              rules="required"
            >
              <input
                id="address1"
                v-model="inputs.address1"
                type="text"
                name="address1"
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
          <div class="grid grid-cols-2 gap-2">
            <div>
              <label for=""
                >{{ $t('form.latitude') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span></label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('form.latitude')"
                rules="required|decimal"
              >
                <input
                  id="lat"
                  v-model="inputs.lat"
                  type="text"
                  name="lat"
                  placeholder="35.652832"
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
            <div>
              <label for=""
                >{{ $t('form.longitude') }}
                <span class="text-tertiary text-xs">{{
                  $t('form.required')
                }}</span></label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="$t('form.longitude')"
                rules="required|decimal"
              >
                <input
                  id="lng"
                  v-model="inputs.lng"
                  type="text"
                  name="lng"
                  placeholder="139.839478"
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
          </div>
        </div>

        <div class="mt-4">
          <label for="address2" class="block text-gray-700 mb-2">{{
            $t('form.nearestStation')
          }}</label>
          <QuillEditor v-model="inputs.address2" />
        </div>
        <div class="mt-4">
          <label for="address3" class="block text-gray-700 mb-2"
            >{{ $t('form.access') }}
          </label>
          <QuillEditor v-model="inputs.address3" />
        </div>
        <!-- End: Space Address -->

        <!-- Price -->
        <div class="mt-8">
          <label for="price" class="block text-gray-700 mb-2"
            >{{ $t('form.price') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.price')"
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
                  {{ $t('form.priceUnit') }}
                </span>
              </div>
            </div>
            <span class="input-invalid-message text-tertiary">
              {{ errors[0] }}
            </span>
          </ValidationProvider>
        </div>
        <!-- End: Price -->

        <!-- Space Type -->
        <div class="mt-8 w-80">
          <label for="" class="block text-gray-700 mb-2"
            >{{ $t('form.spaceType') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.spaceType')"
            rules="required"
          >
            <SelectInput
              v-model="inputs.spaceType"
              :options="spaceTypeOptions"
              :input-class="'block w-full pl-3 pr-10 py-1.5 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
              :unselect-option="{
                name: $t('form.spaceTypePicker.unselectOption'),
                code: null,
              }"
            />
            <span class="input-invalid-message text-tertiary">
              {{ errors[0] }}
            </span>
          </ValidationProvider>
        </div>
        <!-- End: Space Type -->

        <!-- Space Category -->
        <div class="mt-8 w-80">
          <label for="" class="block text-gray-700 mb-2"
            >{{ $t('form.category') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.category')"
            rules="required"
          >
            <SelectInput
              v-model="inputs.categoryId"
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
        <!-- End: Space Category -->

        <!-- Cancellation Deadline -->
        <div class="mt-8">
          <label for="price" class="block text-gray-700 mb-2"
            >{{ $t('form.freeCancel') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.freeCancel')"
            rules="required|integer"
          >
            <div class="mt-1 relative rounded-md shadow-sm w-48">
              <input
                id="price"
                v-model="inputs.cancellationDeadline"
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
            <span class="text-xs">{{ $t('form.freeCancelDesc') }}</span>
            <span class="input-invalid-message text-tertiary">
              {{ errors[0] }}
            </span>
          </ValidationProvider>
        </div>
        <!-- End: Cancellation Deadline -->

        <!-- Status radio box -->
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
        <!-- / Status radio box -->

        <div class="flex items-center justify-end space-x-8 mt-12">
          <button
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
              bg-red-600
              focus:outline-none
              hover:opacity-80
              cursor-pointer
            "
            @click.prevent="handleDelete"
          >
            {{ $t('form.delete') }}
          </button>
          <button
            type="submit"
            :class="[
              'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none hover:opacity-80 cursor-pointer',
            ]"
          >
            {{ $t('form.save') }}
          </button>
        </div>
      </form>
    </ValidationObserver>
    <Notification
      v-if="showAlert"
      :title="$t('form.updateNotification')"
      @hide="showAlert = false"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import QuillEditor from '@/components/molecules/form/QuillEditor'
import SelectInput from '@/components/atoms/input/SelectInput'
import ImageInput from '@/components/organisms/page/input/ImageInput'
import Notification from '@/components/molecules/overlay/Notification'
import RadioBox from '@/components/molecules/form/RadioBox'

export default {
  components: {
    QuillEditor,
    SelectInput,
    ImageInput,
    Notification,
    RadioBox,
  },
  props: {
    data: {
      type: Object,
      required: true,
    },
    formType: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      inputs: {
        spaceImages: [],
        userId: null,
      },
      showAlert: false,
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
    }
  },
  async fetch() {
    await Promise.all([this.$store.dispatch('space/fetchSpaceTypes')])

    this.inputs = { ...this.data }

    if (this.isFormTypeCreate) {
      this.inputs.userId = this.user.id
    }
  },
  computed: {
    ...mapGetters({
      categoryOptions: 'master/categoryOptions',
      languageOptions: 'master/languageOptions',
      spaceTypes: 'space/spaceTypes',
      user: 'user',
    }),
    spaceTypeOptions() {
      const options = []
      const self = this
      Object.keys(this.spaceTypes).forEach(function (key) {
        options.push({
          code: key,
          name: self.$t('form.spaceTypeOptions.' + key),
        })
      })
      return options
    },
    isFormTypeCreate() {
      return this.formType === 'create'
    },
    isFormTypeEdit() {
      return this.formType === 'edit'
    },
  },
  methods: {
    async handleImageUpload(file) {
      const formData = new FormData()
      formData.append('file', file)
      if (this.isFormTypeEdit) {
        await this.$store.dispatch('space/addImage', [
          this.$route.params.id,
          formData,
        ])
      } else if (this.isFormTypeCreate) {
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
        this.inputs.spaceImages.push({ url: result.url })
      }
    },
    async handleImageRemove(image) {
      if (this.isFormTypeEdit) {
        await this.$store.dispatch('space/removeImage', [
          this.$route.params.id,
          image.id,
        ])
      } else if (this.isFormTypeCreate) {
        const params = {
          url: image.url,
        }
        await this.$api.store('uploads/delete', params)
        const index = this.inputs.spaceImages.findIndex(function (spaceImage) {
          return spaceImage.url === image.url
        })
        this.inputs.spaceImages.splice(index, 1)
      }
    },
    async handleDelete() {
      const { id } = this.$route.params
      if (confirm('Do you really want to delete?')) {
        await this.$store.dispatch('space/delete', id)
        this.$router.push('/mypage/myspace')
      }
    },
    async handleSave() {
      const params = { ...this.inputs }
      const { id } = this.$route.params
      if (this.isFormTypeEdit) {
        await this.$store.dispatch('space/update', [id, params])
      } else if (this.isFormTypeCreate) {
        await this.$store.dispatch('space/create', params)
        this.showAlert = true
        setTimeout(() => (this.showAlert = false), 2000)
        this.$router.push(`/mypage/myspace`)
      }

      this.showAlert = true
      setTimeout(() => (this.showAlert = false), 2000)
    },
  },
}
</script>

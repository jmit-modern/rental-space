<template>
  <div>
    <ValidationObserver v-slot="{ invalid }">
      <form>
        <!-- Plan name -->
        <div>
          <label for="name" class="block text-gray-700 mb-2"
            >{{ $t('form.title') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.title')"
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
        <!--End: Plan name -->

        <!-- Minimum use time -->
        <div class="mt-8">
          <label for="minimum_time" class="block text-gray-700 mb-2"
            >{{ $t('form.minUseHours') }}
            <span class="text-tertiary text-xs">{{ $t('form.required') }}</span>
          </label>
          <ValidationProvider
            v-slot="{ errors }"
            :name="$t('form.minUseHours')"
            rules="required|integer"
          >
            <div class="mt-1 relative rounded-md shadow-sm w-48">
              <input
                id="minimum_time"
                v-model="inputs.minimumTime"
                type="text"
                name="minimum_time"
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
            <span class="input-invalid-message text-tertiary">
              {{ errors[0] }}
            </span>
          </ValidationProvider>
        </div>
        <!-- End: Minimum use time -->

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

        <div class="flex items-center justify-end space-x-8 mt-12">
          <button
            :class="[
              'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
              invalid
                ? 'cursor-not-allowed opacity-40'
                : 'hover:opacity-80 cursor-pointer',
            ]"
            :disabled="invalid"
            @click.prevent="handleSave"
          >
            {{ $t('form.save') }}
          </button>
        </div>
      </form>
    </ValidationObserver>
  </div>
</template>

<script>
export default {
  props: {
    plan: {
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
      inputs: {},
    }
  },
  computed: {
    isEditForm() {
      return this.formType === 'edit'
    },
    isCreateForm() {
      return this.formType === 'new'
    },
    planId() {
      return this.inputs.id ? this.inputs.id : null
    },
  },
  watch: {
    plan: {
      immediate: true,
      deep: true,
      handler(newVal, OldVal) {
        this.inputs = { ...newVal }
      },
    },
  },
  methods: {
    async handleSave() {
      const params = { ...this.inputs }
      if (this.isCreateForm) {
        await this.$store.dispatch('space/addPlan', [
          this.$route.params.id,
          params,
        ])
      }
      if (this.isEditForm) {
        await this.$store.dispatch('space/updatePlan', [
          this.$route.params.id,
          this.planId,
          params,
        ])
      }

      this.$emit('submit')
    },
  },
}
</script>

<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Steps :steps="steps" />
    </div>

    <div class="mt-8 py-4 bg-light">
      <ValidationObserver v-slot="{ invalid }">
        <form>
          <table class="table-fixed w-full">
            <tbody>
              <tr class="border-b">
                <th class="w-1/4 px-12 py-6 text-left">
                  {{ $t('expert.reserveStep.numberOfPeople') }}
                  <span class="text-tertiary text-xs">{{
                    $t('expert.reserveStep.required')
                  }}</span>
                </th>
                <td class="w-3/4 px-6 py-6">
                  <div class="flex items-center">
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="大人の人数"
                      rules="required|integer"
                    >
                      <div class="flex items-center">
                        <span class="mr-2 flex-initial">{{
                          $t('expert.reserveStep.adult')
                        }}</span>
                        <input
                          id="adults"
                          v-model="inputs.people"
                          type="text"
                          name="adults"
                          class="
                            focus:ring-orange focus:border-orange
                            block
                            w-full
                            shadow-sm
                            sm:text-sm
                            border-gray-300
                            rounded-md
                            flex-1
                          "
                        />
                      </div>
                      <span class="input-invalid-message text-tertiary">
                        {{ errors[0] }}
                      </span>
                    </ValidationProvider>
                    <div class="px-6">/</div>
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="子どもの人数"
                      rules="required|integer"
                    >
                      <div class="flex items-center">
                        <span class="mr-2 flex-initial">
                          {{ $t('expert.reserveStep.children') }}
                        </span>
                        <input
                          id="children"
                          v-model="inputs.children"
                          type="text"
                          name="children"
                          class="
                            focus:ring-orange focus:border-orange
                            block
                            w-full
                            shadow-sm
                            sm:text-sm
                            border-gray-300
                            rounded-md
                            flex-1
                          "
                        />
                      </div>
                      <span class="input-invalid-message text-tertiary">
                        {{ errors[0] }}
                      </span>
                    </ValidationProvider>
                  </div>
                </td>
              </tr>
              <tr class="border-b">
                <th class="w-1/4 px-12 py-6 text-left">
                  {{ $t('expert.reserveStep.purpose') }}
                  <span class="text-tertiary text-xs">{{
                    $t('expert.reserveStep.required')
                  }}</span>
                </th>
                <td class="w-3/4 px-6 py-6">
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="子どもの人数"
                    rules="required|integer"
                  >
                    <RadioBox
                      v-model="inputs.categoryId"
                      :options="categoryOptions"
                      input-name="category"
                      wrapper-class="grid grid-cols-4 gap-4"
                    />
                    <span class="input-invalid-message text-tertiary">
                      {{ errors[0] }}
                    </span>
                  </ValidationProvider>
                </td>
              </tr>
              <tr>
                <th class="w-1/4 px-12 py-6 text-left">
                  {{ $t('expert.reserveStep.description') }}
                  <span class="text-tertiary text-xs">{{
                    $t('expert.reserveStep.required')
                  }}</span>
                </th>
                <td class="w-3/4 px-6 py-6">
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="招待目的詳細"
                    rules="required"
                  >
                    <textarea
                      id="purpose_description"
                      v-model="inputs.description"
                      name="purpose_description"
                      rows="10"
                      class="
                        shadow-sm
                        focus:ring-orange focus:border-orange
                        block
                        w-full
                        sm:text-sm
                        border border-gray-300
                        rounded-md
                      "
                      :placeholder="'利用用途の詳細、事前にオーナーにお伝えしておきたいことなどを入力してください。\n【例】\n・YouTube用の動画撮影を行います。\n・コスプレ写真撮影などをする予定です。\n・友人の誕生日パーティーに使いたいです。\n・面接に使いたいです。\n・ワークショップで利用します。\n・勉強会に使用します。'"
                    ></textarea>
                    <span class="input-invalid-message text-tertiary">
                      {{ errors[0] }}
                    </span>
                  </ValidationProvider>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="px-12 py-6">
            <button
              :class="[
                'w-full items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
                invalid
                  ? 'cursor-not-allowed opacity-40'
                  : 'hover:opacity-80 cursor-pointer',
              ]"
              :disabled="invalid"
              @click.prevent="handleNext"
            >
              {{ $t('expert.reserveStep.next') }}
            </button>
          </div>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Steps from '@/components/molecules/navigation/Steps'
import RadioBox from '@/components/molecules/form/RadioBox'

export default {
  components: {
    Steps,
    RadioBox,
  },
  middleware: 'auth',
  fetchOnServer: false,
  data() {
    return {
      inputs: {},
      steps: [
        {
          id: '01',
          name: this.$t('expert.reserveStep.details'),
          route: '',
          status: 'current',
        },
        {
          id: '02',
          name: this.$t('expert.reserveStep.confirmation'),
          route: '',
          status: 'upcoming',
        },
        {
          id: '03',
          name: this.$t('expert.reserveStep.checkout'),
          route: '',
          status: 'upcoming',
        },
      ],
    }
  },
  fetch() {
    const { user } = this.$auth.user
    this.$store.commit('localStorage/setExpertReservation', { userId: user.id })
    this.inputs = { ...this.reserveDetail }
  },
  computed: {
    ...mapGetters({
      categoryOptions: 'master/categoryOptions',
      reserveDetail: 'localStorage/expertReservation',
    }),
  },
  methods: {
    handleNext() {
      this.$store.commit('localStorage/setExpertReservation', this.inputs)
      this.$router.push(this.localeRoute({ name: 'expert-reserve-confirm' }))
    },
  },
}
</script>

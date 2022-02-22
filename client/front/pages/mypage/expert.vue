<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8">
          <div class="text-xl">{{ $t('mypage.expert.title') }}</div>
        </div>
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form @submit.prevent="handleSubmit(handleSave)">
            <div>
              <label for="skill_title">
                タイトル <span class="text-tertiary">*</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                name="タイトル"
                rules="required"
              >
                <input
                  id="skill_title"
                  v-model="inputs.skillTitle"
                  type="text"
                  name="skill_title"
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
              <label for="description" class="block text-gray-700 mb-2"
                >説明</label
              >
              <QuillEditor v-model="inputs.description" />
            </div>
            <div class="mt-8">
              <label for="price" class="block text-gray-700 mb-2"
                >スキル
              </label>
              <AutoCompleteList
                :list="inputs.skills"
                :choose-options="skillData"
                @add="addSkill"
                @chosen="handleChosenSkill"
                @remove="removeSkill"
              />
            </div>
            <div class="mt-8">
              <label for="price" class="block text-gray-700 mb-2"
                >価格 <span class="text-tertiary">*</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                name="価格"
                rules="required"
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
                      円
                    </span>
                  </div>
                </div>
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="mt-8">
              <label for="price" class="block text-gray-700 mb-2"
                >キャンセル時間
                <span class="text-tertiary text-xs">(必須)</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                name="キャンセル時間"
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
                      時間
                    </span>
                  </div>
                </div>
                <span class="text-xs"
                  >* ユーザーが予約した時からキャンセルできる許容時間
                  (デフォルト: 48時間)</span
                >
                <span class="input-invalid-message text-tertiary">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>
            <div class="mt-8 w-80">
              <label for="" class="block text-gray-700 mb-2"
                >カテゴリー <span class="text-tertiary">*</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                name="カテゴリー"
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
            <div class="mt-8 w-80">
              <label for="" class="block text-gray-700 mb-2">言語</label>
              <SelectInput
                v-model="inputs.languageId"
                :options="languageOptions"
                :input-class="'block w-full pl-3 pr-10 py-1.5 text-base border-gray-300 active:border-gray-300 focus:border-orange focus:ring-orange outline-none sm:text-sm rounded-md bg-light'"
                :unselect-option="{
                  name: '言語を選択してください。',
                  code: null,
                }"
              />
            </div>
            <div class="mt-8 w-80">
              <label for="url" class="block text-gray-700 mb-2"
                >サイトURL</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="サイトURL"
                rules="url"
              >
                <input
                  id="url"
                  v-model="inputs.url"
                  type="text"
                  name="url"
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
            <div class="flex items-center justify-end space-x-8 mt-12">
              <button
                :class="[
                  'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none hover:opacity-80 cursor-pointer',
                ]"
              >
                {{ $t('form.save') }}
              </button>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </mypage-layout>
    <Notification
      v-if="showAlert"
      :title="$t('mypage.expert.notification')"
      @hide="showAlert = false"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import QuillEditor from '@/components/molecules/form/QuillEditor'
import SelectInput from '@/components/atoms/input/SelectInput'
import Notification from '@/components/molecules/overlay/Notification'
import AutoCompleteList from '@/components/molecules/form/AutoCompleteList'

export default {
  components: {
    MypageLayout,
    Breadcrumb,
    QuillEditor,
    SelectInput,
    Notification,
    AutoCompleteList,
  },
  middleware: ['auth', 'expert'],
  data() {
    return {
      inputs: {
        cancellationDeadline: 48,
      },
      showAlert: false,
    }
  },
  async fetch() {
    const { expert } = this.user
    await Promise.all([
      this.$store.dispatch('expert/fetchDetail', { id: expert.id }),
      this.$store.dispatch('skill/fetch'),
    ])

    this.inputs = { ...this.expert }
  },
  computed: {
    ...mapGetters({
      user: 'user',
      expert: 'expert/detail',
      categoryOptions: 'master/categoryOptions',
      languageOptions: 'master/languageOptions',
      skills: 'skill/data',
    }),
    skillData() {
      return this.skills.map((v) => ({ ...v, code: v.id }))
    },
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: 'ホーム',
          url: { name: 'index___jp', query: {} },
        },
        {
          id: 2,
          name: 'マイページ',
          url: {
            name: 'mypage___jp',
            query: {},
          },
        },
        {
          id: 3,
          name: 'マイスキル',
        },
      ]
      return items
    },
  },
  methods: {
    addSkill(value) {
      const skill = {
        name: value,
      }
      this.$store.commit('expert/addSkill', skill)
    },
    handleChosenSkill(item) {
      const skill = this.skills.find((o) => o.id === item.id)
      this.$store.commit('expert/addSkill', skill)
    },
    removeSkill(value) {
      this.$store.commit('expert/removeSkill', value)
    },
    async handleSave() {
      const params = { ...this.inputs }
      const { id } = this.expert
      await this.$store.dispatch('expert/update', [id, params])
      this.showAlert = true
    },
  },
}
</script>

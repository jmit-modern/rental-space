import { createDict } from '@/utils/dataStructure'

export const state = () => ({
  prefs: [],
  categories: [],
  languages: [],
  facilityCategories: [],
})

export const mutations = {
  setPrefs(state, data) {
    state.prefs = [...data]
  },
  setCategories(state, data) {
    state.categories = [...data]
  },
  setLanguages(state, data) {
    state.languages = [...data]
  },
  setFacilityCategories(state, data) {
    state.facilityCategories = [...data]
  },
}

export const actions = {
  async fetchPrefs({ commit }, { useCache = false }) {
    if (useCache) {
      const cache = this.$cache.get('prefs')
      if (cache) {
        commit('setPrefs', cache)
        return
      }
    }
    const { prefectures } = await this.$api.fetch('prefectures')
    if (useCache) this.$cache.set('prefs', prefectures)
    commit('setPrefs', prefectures)
  },

  async fetchCategories({ commit, state }, { useCache = false }) {
    if (useCache) {
      const cache = this.$cache.get('categories')
      if (cache) {
        commit('setCategories', cache)
        return
      }
    }
    const { categories } = await this.$api.fetch('categories')
    if (useCache) this.$cache.set('categories', categories)
    commit('setCategories', categories)
  },
  async fetchLanguages({ commit, state }, { useCache = false }) {
    if (useCache) {
      const cache = this.$cache.get('languages')
      if (cache) {
        commit('setLanguages', cache)
        return
      }
    }
    const { languages } = await this.$api.fetch('languages')
    if (useCache) this.$cache.set('languages', languages)
    commit('setLanguages', languages)
  },

  async fetchFacilityCategories({ commit, state }, { useCache = false }) {
    if (useCache) {
      const cache = this.$cache.get('facility_categories')
      if (cache) {
        commit('setFacilityCategories', cache)
        return
      }

      const { facilityCategories } = await this.$api.fetch(
        'facility_categories'
      )
      if (useCache) this.$cache.set('facility_categories', facilityCategories)
      commit('setFacilityCategories', facilityCategories)
    }
  },
}

export const getters = {
  categories: ({ categories }) => categories,
  languages: ({ languages }) => languages,
  facilityCategories: ({ facilityCategories }) => facilityCategories,
  prefOptions: ({ prefs }) =>
    prefs.map(({ id, name }) => ({
      code: id,
      name,
    })),
  categoryOptions: ({ categories }) =>
    categories.map(({ id, name }) => ({
      code: id,
      name,
    })),
  languageOptions: ({ languages }) =>
    languages.map(({ id, name }) => ({
      code: id,
      name,
    })),
  facilityCategoryOptions: ({ facilityCategories }) =>
    facilityCategories.map(({ id, name }) => ({
      code: id,
      name,
    })),

  prefDict: ({ prefs }) => createDict(prefs),
  categoryDict: ({ categories }) => createDict(categories),
  languageDict: ({ languages }) => createDict(languages),
}

export const state = () => ({
  data: [],
  detail: {},
})

export const mutations = {
  set(state, data) {
    state.data = [...data]
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { languages } = await this.$api.fetch('languages', { params })

    commit('set', languages)
  },

  async create({ commit, state }, params = {}) {
    await this.$api.store('languages', params)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { language } = await this.$api.update(`languages/${id}`, params)

    commit('setDetail', language)
  },

  async fetchDetail({ commit }, { id }) {
    const { language } = await this.$api.fetch(`languages/${id}`)

    commit('setDetail', language)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
}

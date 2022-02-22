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
    const { categories } = await this.$api.fetch('categories', { params })

    commit('set', categories)
  },

  async create({ commit, state }, params = {}) {
    await this.$api.store('categories', params)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { catetory } = await this.$api.update(`categories/${id}`, params)

    commit('setDetail', catetory)
  },

  async fetchDetail({ commit }, { id }) {
    const { catetory } = await this.$api.fetch(`categories/${id}`)

    commit('setDetail', catetory)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
}

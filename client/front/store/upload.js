export const state = () => ({
  data: [],
})

export const mutations = {
  set(state, data) {
    state.data = [...data]
  },
}

export const actions = {
  async create({ commit, state }, params = {}) {
    await this.$api.store('languages', params)
  },

  async delete({ commit, state }, [id, params = {}]) {
    await this.$api.update(`languages/${id}`, params)
  },
}

export const getters = {
  data: ({ data }) => data,
}

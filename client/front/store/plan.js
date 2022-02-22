export const state = () => ({
  data: [],
  detail: {},
})

export const mutations = {
  set(state, data) {
    state.data = [...data]
  },

  reset(state, data) {
    state.data = []
  },

  add(state, data) {
    state.data.push(...data)
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  delete(state, data) {
    // Remove plan from the plan list
    const index = state.data.findIndex(function (space) {
      return space.id === data.id
    })
    state.data.splice(index, 1)
  },
}

export const actions = {
  async fetch({ commit, state }, [id, params]) {
    const { spacePlans } = await this.$api.fetch(`spaces/${id}/plan`, {
      params,
    })
    commit('set', spacePlans)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
}

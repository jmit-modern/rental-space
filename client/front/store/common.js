import Vue from 'vue'

export const state = () => ({
  pending: false,
  loading: false,
  initialLoad: false,
  sessionData: {},
})

export const getters = {
  pending(state) {
    return state.pending
  },
  loading(state) {
    return state.loading
  },
  onlyPending(state) {
    return state.pending && !state.loading
  },
  initialLoad(state) {
    return state.initialLoad
  },
  sessionData: ({ sessionData }) => sessionData,
}

export const mutations = {
  pending(state, value) {
    state.pending = value
  },
  loading(state, value) {
    state.pending = value
    state.loading = value
  },
  initialLoaded(state) {
    state.initialLoad = true
  },
  setSessionData(state, data) {
    Object.keys(data).forEach((key) => {
      Vue.set(state.sessionData, key, data[key])
    })
  },
  clearSessionData(state, key) {
    Vue.delete(state.sessionData, key)
  },
}

export const actions = {
  async fetchInitialLoad({ commit, dispatch }) {
    await Promise.all([
      dispatch('master/fetchPrefs', { useCache: true }, { root: true }),
      dispatch('master/fetchCategories', { useCache: true }, { root: true }),
      dispatch('master/fetchLanguages', { useCache: true }, { root: true }),
      dispatch(
        'master/fetchFacilityCategories',
        { useCache: true },
        { root: true }
      ),
    ])

    commit('initialLoaded')
  },
}

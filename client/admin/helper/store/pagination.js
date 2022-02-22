import Vue from 'vue'

export const createState = () => ({
  pagination: {
    currentPage: null,
    nextPage: null,
    perPage: null,
    totalPages: null,
    total: null,
  },
})

export const mutations = {
  setPagination(state, params) {
    Object.keys(state.pagination).forEach((key) => {
      const value =
        params[key] !== null && params[key] !== undefined
          ? Number(params[key])
          : null
      Vue.set(state.pagination, key, value)
    })
  },
}

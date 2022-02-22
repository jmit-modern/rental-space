export const state = () => ({
  reservation: {
    userId: null,
    spaceId: null,
    planId: null,
    reserveFrom: null,
    reserveTo: null,
    people: null,
    children: null,
    categoryId: null,
    description: null,
    expire: 1, // hours unit working automatically by storage-vuex-app
  },
  expertReservation: {
    userId: null,
    expertId: null,
    location: null,
    categoryId: null,
    reserveFrom: null,
    reserveTo: null,
    people: null,
    children: null,
    description: null,
    expire: 1, // hours unit working automatically by storage-vuex-app
  },
})

export const mutations = {
  setReservation(state, data) {
    state.reservation = { ...state.reservation, ...data }
  },
  clearReservation(state, data) {
    Object.keys(state.reservation).forEach((key) => {
      if (key !== 'expire') {
        state.reservation[key] = null
      }
    })
  },
  setExpertReservation(state, data) {
    state.expertReservation = { ...state.expertReservation, ...data }
  },
  clearExpertReservation(state, data) {
    Object.keys(state.expertReservation).forEach((key) => {
      if (key !== 'expire') {
        state.expertReservation[key] = null
      }
    })
  },
}

export const actions = {}

export const getters = {
  reservation: ({ reservation }) => reservation,
  expertReservation: ({ expertReservation }) => expertReservation,
}

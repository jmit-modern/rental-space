import Vue from "vue";
import { camelizeKeys } from "@/utils";

export const state = () => ({
  sessionData: {}
});

export const mutations = {
  countUp(state) {
    state.counter++;
  },
  setSessionData: (state, data) => {
    Object.keys(data).forEach(key => {
      Vue.set(state.sessionData, key, data[key]);
    });
  },
  clearSessionData: (state, key = null) => {
    if (key !== null) {
      Vue.delete(state.sessionData, key);
    } else {
      state.sessionData = {};
    }
  }
};

export const actions = {
  async nuxtServerInit({ dispatch, getters }) {
    const initialLoad = getters["common/initialLoad"];
    if (initialLoad) return;

    console.log("initialLoad...");
    await dispatch("common/fetchInitialLoad");
  },
  async fetchUser() {
    await this.$auth.fetchUser();
  },

  async updateUser(context, { params }) {
    const { data } = await this.$api.update(
      `member/${this.$auth.user.id}`,
      params
    );

    this.$auth.setUser(data);
  }
};

export const getters = {
  isAuthenticated: (state, getters, rootState) => {
    return rootState.auth.loggedIn;
  },

  user: (state, getters, rootState) => {
    const { user } = rootState.auth.user;
    return camelizeKeys(user);
  },

  isAdmin: (state, getters, rootState) => {
    const { user } = rootState.auth.user;
    return camelizeKeys(user).userType === "admin";
  },

  sessionData: ({ sessionData }) => sessionData
};

<template>
  <div class="hidden md:flex md:flex-shrink-0">
    <div class="flex flex-col w-64">
      <!-- Sidebar component, swap this element with another sidebar if you like -->
      <div class="flex-1 flex flex-col min-h-0">
        <div class="flex items-center h-16 flex-shrink-0 px-4 bg-gray-900">
          <img
            class="h-8 w-auto sm:h-10"
            src="~/assets/image/logo-transparent.png"
            alt=""
          />
        </div>
        <div class="flex-1 flex flex-col overflow-y-auto">
          <nav class="flex-1 px-2 py-4 bg-gray-800 space-y-1">
            <nuxt-link
              v-for="item in navigations"
              :key="item.name"
              :to="item.url"
              :class="[
                item.url.name === $route.name
                  ? 'bg-gray-900 text-white'
                  : 'text-gray-300 hover:bg-gray-700 hover:text-white',
                'group flex items-center px-2 py-2 text-sm font-medium rounded-md',
              ]"
            >
              <component
                :is="item.icon"
                :class="[
                  item.url.name === $route.name
                    ? 'text-gray-300'
                    : 'text-gray-400 group-hover:text-gray-300',
                  'mr-3 flex-shrink-0 h-6 w-6',
                ]"
                aria-hidden="true"
              />
              {{ item.name }}
            </nuxt-link>
          </nav>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      navigations: [
        {
          name: 'Dashboard',
          url: { name: 'dashboard' },
          icon: 'OutlineHomeIcon',
          current: true,
        },
        {
          name: 'Users',
          url: { name: 'user' },
          icon: 'OutlineUsersIcon',
          current: false,
        },
        {
          name: 'Spaces',
          url: { name: 'space' },
          icon: 'OutlineFolderIcon',
          current: false,
        },
        {
          name: 'Events',
          url: { name: 'event' },
          icon: 'OutlineCalendarIcon',
          current: false,
        },
        {
          name: 'Experts',
          url: { name: 'expert' },
          icon: 'OutlineInboxIcon',
          current: false,
        },
        {
          name: 'Reservations',
          url: '#',
          icon: 'OutlineChartBarIcon',
          current: false,
        },
      ],
    }
  },
}
</script>

<template>
  <nav aria-label="Sidebar" class="sticky top-4 divide-y divide-gray-300">
    <div class="pb-4">
      <p
        class="
          px-3
          text-sm
          font-semibold
          text-gray-500
          uppercase
          tracking-wider
        "
      >
        {{ $t('mypage.sidenav.management') }}
      </p>
      <div class="mt-3 space-y-2">
        <nuxt-link
          v-if="isSpaceOwner"
          :to="localeRoute({ name: 'mypage-myspace' })"
          :class="[
            localeRoute({ name: 'mypage-myspace' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium',
          ]"
        >
          <span class="truncate">
            {{ $t('mypage.sidenav.mySpace') }}
          </span></nuxt-link
        >
        <nuxt-link
          v-if="isExpert"
          :to="localeRoute({ name: 'mypage-expert' })"
          :class="[
            localeRoute({ name: 'mypage-expert' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
        >
          <span class="truncate">
            {{ $t('mypage.sidenav.mySkill') }}
          </span></nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-myevent' })"
          :class="[
            localeRoute({ name: 'mypage-myevent' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
        >
          <span class="truncate">
            {{ $t('mypage.sidenav.myEvent') }}</span
          ></nuxt-link
        >
      </div>
    </div>

    <!-- Reserve Management -->
    <div class="pt-8 pb-4">
      <p
        class="
          px-3
          text-sm
          font-semibold
          text-gray-500
          uppercase
          tracking-wider
        "
      >
        {{ $t('mypage.sidenav.myReservations') }}
      </p>
      <div class="mt-3 space-y-2">
        <nuxt-link
          :to="localeRoute({ name: 'mypage-space_reservation' })"
          :class="[
            localeRoute({ name: 'mypage-space_reservation' }).name ===
            $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          >{{ $t('mypage.sidenav.myReserveSpace') }}</nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-event_reservation' })"
          :class="[
            localeRoute({ name: 'mypage-event_reservation' }).name ===
            $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          >{{ $t('mypage.sidenav.myReserveEvent') }}</nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-expert_reservation' })"
          :class="[
            localeRoute({ name: 'mypage-expert_reservation' }).name ===
            $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          >{{ $t('mypage.sidenav.myReserveExpert') }}</nuxt-link
        >
      </div>
    </div>
    <!-- End Reservation Management -->

    <!-- Reservation Management -->
    <div class="pt-8 pb-4">
      <p
        class="
          px-3
          text-sm
          font-semibold
          text-gray-500
          uppercase
          tracking-wider
        "
      >
        {{ $t('mypage.sidenav.orderManagement') }}
      </p>
      <div class="mt-3 space-y-2">
        <nuxt-link
          v-if="isSpaceOwner"
          :to="localeRoute({ name: 'mypage-space_order' })"
          :class="[
            localeRoute({ name: 'mypage-space_order' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          >{{ $t('mypage.sidenav.spaceOrders') }}</nuxt-link
        >
        <nuxt-link
          v-if="isExpert"
          :to="localeRoute({ name: 'mypage-expert_order' })"
          :class="[
            localeRoute({ name: 'mypage-expert_order' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          >{{ $t('mypage.sidenav.expertOrders') }}</nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-event_order' })"
          :class="[
            localeRoute({ name: 'mypage-event_order' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          >{{ $t('mypage.sidenav.eventOrders') }}</nuxt-link
        >
      </div>
    </div>
    <div class="pt-8">
      <p
        id="communities-headline"
        class="
          px-3
          text-sm
          font-semibold
          text-gray-500
          uppercase
          tracking-wider
        "
      >
        {{ $t('mypage.sidenav.information') }}
      </p>
      <div class="mt-3 space-y-2">
        <nuxt-link
          :to="localeRoute({ name: 'mypage-profile' })"
          :class="[
            localeRoute({ name: 'mypage-profile' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          ><span class="truncate">
            {{ $t('mypage.sidenav.profile') }}</span
          ></nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-userinfo' })"
          :class="[
            localeRoute({ name: 'mypage-userinfo' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          ><span class="truncate">
            {{ $t('mypage.sidenav.setting') }}</span
          ></nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-report' })"
          :class="[
            localeRoute({ name: 'mypage-report' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          ><span class="truncate">
            {{ $t('mypage.sidenav.report') }}</span
          ></nuxt-link
        >
        <nuxt-link
          :to="localeRoute({ name: 'mypage-payment_method' })"
          :class="[
            localeRoute({ name: 'mypage-payment_method' }).name === $route.name
              ? 'bg-gray-200 text-gray-900'
              : 'text-gray-600 hover:bg-gray-50',
            'group flex items-center px-3 py-2 text-sm font-medium rounded-md',
          ]"
          ><span class="truncate">
            {{ $t('mypage.sidenav.paymentMethod') }}</span
          ></nuxt-link
        >
      </div>
    </div>
  </nav>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['user', 'isExpert', 'isSpaceOwner']),
  },
}
</script>

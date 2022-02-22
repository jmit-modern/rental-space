<template>
  <div class="max-w-7xl mx-auto">
    <div class="w-1/2 mt-8 mx-auto px-4 py-8 bg-light text-lg">
      Thank you for your reservation. <br />
      You can find your reservation details in
      <nuxt-link :to="localePath({ name: 'mypage-event_reservation' })"
        >マイページ / 予約イベント</nuxt-link
      >
      <div class="mt-4">
        Find More Events here.
        <nuxt-link :to="localePath({ name: 'event' })">Here.</nuxt-link>
      </div>
      <div class="mt-4">
        Are you looking for spaces? you can find the spaces
        <nuxt-link :to="localePath({ name: 'space' })">Here.</nuxt-link>
      </div>
      <div class="mt-4">
        Are you looking for experts? you can find the experts
        <nuxt-link :to="localePath({ name: 'expert' })">Here.</nuxt-link>
      </div>
    </div>
  </div>
</template>

<template>
  <div class="max-w-7xl mx-auto">
    <div class="w-1/2 mt-8 mx-auto px-4 py-8 bg-light text-lg">
      <div class="mb-4">{{ $t('space.reserveStep.complete.desc') }}</div>
      <div>
        <span>{{ $t('space.reserveStep.complete.desc2') }}</span>
        <nuxt-link :to="localePath({ name: 'mypage-space_reservation' })">{{
          $t('space.reserveStep.complete.resevationPath')
        }}</nuxt-link>
      </div>
      <div class="mt-4">
        {{ $t('space.reserveStep.complete.moreSpaces') }}
        <nuxt-link :to="localePath({ name: 'space' })">{{
          $t('space.reserveStep.complete.here')
        }}</nuxt-link>
      </div>
      <div class="mt-4">
        {{ $t('space.reserveStep.complete.moreExperts') }}
        <nuxt-link :to="localePath({ name: 'expert' })">{{
          $t('space.reserveStep.complete.here')
        }}</nuxt-link>
      </div>
    </div>
  </div>
</template>

<template>
  <div class="max-w-7xl mx-auto">
    <div class="w-1/2 mt-8 mx-auto px-4 py-8 bg-light text-lg">
      <div class="mb-4">{{ $t('expert.reserveStep.complete.desc') }}</div>
      <div>
        {{ $t('expert.reserveStep.complete.desc2') }}
        <nuxt-link :to="localePath({ name: 'mypage-expert_reservation' })">{{
          $t('expert.reserveStep.complete.resevationPath')
        }}</nuxt-link>
      </div>
      <div class="mt-4">
        {{ $t('expert.reserveStep.complete.moreExperts') }}
        <nuxt-link :to="localePath({ name: 'expert' })">{{
          $t('expert.reserveStep.complete.here')
        }}</nuxt-link>
      </div>
      <div class="mt-4">
        {{ $t('expert.reserveStep.complete.moreSpaces') }}
        <nuxt-link :to="localePath({ name: 'space' })">{{
          $t('expert.reserveStep.complete.here')
        }}</nuxt-link>
      </div>
    </div>
  </div>
</template>
